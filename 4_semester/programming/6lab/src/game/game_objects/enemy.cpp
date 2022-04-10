#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "enemy.h"



int Enemy::move(){
    sprite.move(sf::Vector2f(0.f,speed));
    sf::FloatRect rect = sprite.getGlobalBounds();
    if(rect.top>=600.f){
        return Settings::BORDER;
    }
    return Settings::NOTHING;
}
int Enemy::action(List<MovingObject>* listPlayer, 
                   List<MovingObject>* listEnemy){
    int code = collision(listPlayer);
    return code;
}

int Enemy::collision(List<MovingObject>* listPlayer){
    sf::FloatRect rectPlayer = listPlayer->begin->obj->sprite.getGlobalBounds();
    sf::FloatRect rectEnemy = sprite.getGlobalBounds();
    if(checkCollision(rectPlayer,rectEnemy)){
        listPlayer->begin->obj->injury(damage);
        lives = 0;
        return Settings::KILL_ENEMY;
    }


    Node<MovingObject> *node;
    node = listPlayer->begin->next;
    sf::FloatRect bulletRect; 
    while(node!=nullptr){
        bulletRect = node->obj->sprite.getGlobalBounds();
        if(checkCollision(rectEnemy,bulletRect)){
            injury(1);
            listPlayer->DeleteNode(node);
            if(checkKill()){
                return Settings::KILL_ENEMY;
            }
        }
        
        node = node->next;
    }
    return Settings::NOTHING;
}

int Enemy::checkCollision(sf::FloatRect bigRect, sf::FloatRect smallRect){
    return ((smallRect.left+smallRect.width-smallRect.width/6) > bigRect.left ) &&
        (smallRect.left+smallRect.width/6 < (bigRect.left + bigRect.width)) &&
        (smallRect.top+smallRect.height) > bigRect.top &&
        (smallRect.top+smallRect.height/2) < bigRect.top+bigRect.height;
}


void Enemy::setImage(std::string image, sf::Vector2f scale){

    texture.loadFromFile(image);
    sprite.setTexture(texture);
    sprite.scale(scale);
}
void Enemy::setPosition(float x){
    sf::FloatRect rect = sprite.getGlobalBounds();
    sprite.setPosition(sf::Vector2f(x,-rect.height));
}