#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "enemy.h"
#include "bullet.h"
#include "bulletEnemy.h"



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
    shot(listEnemy);
    int code = collision(listPlayer);
    return code;
}


void Enemy::shot(List<MovingObject>* listEnemy){
    if(!delay){
        sf::FloatRect rect = sprite.getGlobalBounds();
        
        BulletEnemy *bullet = new BulletEnemy(
            sf::Vector2f(0.f,Settings::enemyBulletSpeed),
            Settings::enemyBulletDamage
        );
        bullet->setImage(
            Settings::enemyBulletImage,
            Settings::enemyBulletScale
        );
        bullet->setPosition(rect);

        MovingObject *obj = bullet;
        listEnemy->AddNode(obj);
        delay=DELAY;
    }else{
        delay--;
    }
    
}


int Enemy::collision(List<MovingObject>* listPlayer){
    int code = Settings::NOTHING;
    sf::FloatRect rectPlayer = listPlayer->begin->obj->sprite.getGlobalBounds();
    sf::FloatRect rectEnemy = sprite.getGlobalBounds();
    if(checkCollision(rectPlayer,rectEnemy)){
        listPlayer->begin->obj->injury(damage);
        lives = 0;
        return Settings::KILL_ENEMY;
    }


    Node<MovingObject> *node;
    Node<MovingObject> *tmpNode;
    node = listPlayer->begin->next;
    sf::FloatRect bulletRect; 

    while(node!=nullptr){
        tmpNode = node;
        node = node->next;

        bulletRect = tmpNode->obj->sprite.getGlobalBounds();
        if(checkCollision(rectEnemy,bulletRect)){
            injury(1);
            code = Settings::INJURY;
            listPlayer->DeleteNode(tmpNode);
            if(checkKill()){
                return Settings::KILL_ENEMY;
            }
        }
        
        
    }
    return code;
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