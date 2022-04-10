#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "bullet.h"
#include "bulletEnemy.h"
#include "enemy.h"
#include "magicianEnemy.h"


int MagicianEnemy::move(){
    sprite.move(sf::Vector2f(0.f,speed));
    sf::FloatRect rect = sprite.getGlobalBounds();
    if(rect.top>=600.f){
        return Settings::BORDER;
    }
    return Settings::NOTHING;
}



int MagicianEnemy::action(List<MovingObject>* listPlayer, 
                   List<MovingObject>* listEnemy){
    shot(listEnemy);
    int code = collision(listPlayer);
    return code;
}


void MagicianEnemy::shot(List<MovingObject>* listEnemy){
    
    if(!delay){
        sf::FloatRect rect = sprite.getGlobalBounds();
        
        BulletEnemy *bullet = new BulletEnemy(
            0.f,
            Settings::enemyBulletSpeed,
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



void MagicianEnemy::setPosition(float x){
    sf::FloatRect rect = sprite.getGlobalBounds();
    sprite.setPosition(sf::Vector2f(x,-rect.height));
}