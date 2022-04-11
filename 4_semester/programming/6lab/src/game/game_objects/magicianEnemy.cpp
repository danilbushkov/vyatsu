#include <math.h>
#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "bullet.h"
#include "bulletEnemy.h"
#include "enemy.h"
#include "magicianEnemy.h"


int MagicianEnemy::move(){
    if(movement){
        sprite.move(sf::Vector2f(0.f,speed));
        sf::FloatRect rect = sprite.getGlobalBounds();
        if(rect.top>=300.f){
            movement = 0;
        }
    }else{
        if(expectation>0){
            expectation--;
        }else{
            sprite.setPosition(teleportation());
            expectation = 150 + rand() % 25;
        }
    }
    
    return Settings::NOTHING;
}




int MagicianEnemy::action(List<MovingObject>* listPlayer, 
                   List<MovingObject>* listEnemy){
    shot(listPlayer->begin->obj, listEnemy);
    int code = collision(listPlayer);
    if(code == Settings::INJURY){
        sprite.setPosition(teleportation());
    }

    return code;
}

sf::Vector2f MagicianEnemy::teleportation(){
    float x =  25 + rand() % 651;
    float y = 25 + rand() % 300;
    return sf::Vector2f(x,y);
}

sf::Vector2f MagicianEnemy::getTrajectory(sf::FloatRect playerRect, 
                                          sf::FloatRect enemyRect){
    
    sf::Vector2f pointEnemy(
        enemyRect.left+enemyRect.width/2,
        enemyRect.top+enemyRect.height
        );
    sf::Vector2f pointPlayer(
        playerRect.left+playerRect.width/2,
        playerRect.top
        );
    
    float cathetX = pointPlayer.x - pointEnemy.x;
    float cathetY = pointPlayer.y - pointEnemy.y;

    float tg = cathetX/cathetY;

    float x = sin(atan(tg)) * Settings::roundBulletSpeed;
    float y = cos(atan(tg)) * Settings::roundBulletSpeed;
    return sf::Vector2f(x,y);
}


void MagicianEnemy::shot(MovingObject *player,
                         List<MovingObject>* listEnemy){

    if(!delay){
        sf::FloatRect rect = sprite.getGlobalBounds();
        sf::FloatRect PlayerRect = player->sprite.getGlobalBounds();
        
        BulletEnemy *bullet = new BulletEnemy(
            getTrajectory(PlayerRect,rect),
            damage
        );
        bullet->setImage(
            Settings::roundBulletImage,
            Settings::roundBulletScale
        );
        bullet->setPosition(rect);

        MovingObject *obj = bullet;
        listEnemy->AddNode(obj);
        delay=DELAY;
    }else{
        delay--;
    }
    
}



