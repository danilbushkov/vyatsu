#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "enemy.h"
#include "bullet.h"
#include "bulletEnemy.h"



int Enemy::move(){
    getSprite()->move(sf::Vector2f(0.f,getSpeed()));
    sf::FloatRect rect = getSprite()->getGlobalBounds();
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
        sf::FloatRect rect = getSprite()->getGlobalBounds();
        
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
    sf::FloatRect rectPlayer = listPlayer->begin->obj->getSprite()->getGlobalBounds();
    sf::FloatRect rectEnemy = getSprite()->getGlobalBounds();
    if(checkCollision(rectPlayer,rectEnemy)){
        listPlayer->begin->obj->injury(getDamage());
        setLives(0);
        return Settings::KILL_ENEMY;
    }


    Node<MovingObject> *node;
    Node<MovingObject> *tmpNode;
    node = listPlayer->begin->next;
    sf::FloatRect bulletRect; 

    while(node!=nullptr){
        tmpNode = node;
        node = node->next;

        bulletRect = tmpNode->obj->getSprite()->getGlobalBounds();
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

    getTexture()->loadFromFile(image);
    getSprite()->setTexture(*getTexture());
    getSprite()->scale(scale);
}
void Enemy::setPosition(float x){
    sf::FloatRect rect = getSprite()->getGlobalBounds();
    getSprite()->setPosition(sf::Vector2f(x,-rect.height));
}