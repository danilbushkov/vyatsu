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
    if( ((rectEnemy.left+rectEnemy.width-rectEnemy.width/6) > rectPlayer.left ) &&
        (rectEnemy.left+rectEnemy.width/6 < (rectPlayer.left + rectPlayer.width)) &&
        (rectEnemy.top+rectEnemy.height) > rectPlayer.top &&
        (rectEnemy.top+rectEnemy.height/2) < rectPlayer.top+rectPlayer.height
       ){
        listPlayer->begin->obj->getDamage(damage);
        lives = 0;
        return Settings::KILL_ENEMY;
    }


    Node<MovingObject> *node;
    node = listPlayer->begin->next;
    while(node!=nullptr){
        
        node = node->next;
    }
    return Settings::NOTHING;
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