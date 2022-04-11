#include <math.h>
#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "bullet.h"
#include "bulletEnemy.h"
#include "enemy.h"
#include "cleverEnemy.h"


int CleverEnemy::move(){
    if(fuel>0 || newlyCreated){

        sprite.move(movement);
        fuel--;
        
    }else if(refill>0){
        refill--;
    }else{
        turn();
        fuel = 100 + rand() % 51;
        refill = 20;
    }
    
    expectationRotation();
    return Settings::NOTHING;
}

void CleverEnemy::expectationRotation(){
    sf::FloatRect rect = sprite.getGlobalBounds();
    if(newlyCreated){
        if(rect.top>0){
            newlyCreated=0;
        }
    }else{
        if((rect.top + rect.height) > 375.f ||
        (rect.top < 0 && !newlyCreated)  ){
            movement = sf::Vector2f(movement.x,-movement.y);
        }
    }
    
    
    if((rect.left) <= 0.f ||
        rect.left+rect.width >=800){
        movement = sf::Vector2f(-movement.x,movement.y);
    }
}



int CleverEnemy::action(List<MovingObject>* listPlayer, 
                   List<MovingObject>* listEnemy){
    shot(listEnemy);
    int code = collision(listPlayer);
    if(code == Settings::INJURY){
        refill=0;
    }

    return code;
}


void CleverEnemy::turn(){
    int sign[2]={1,-1};
    int indexX = rand() % 2;
    int indexY = rand() % 2;
    int a = rand() % 315; //0..314 
    float tg = a/100;

    float speedX=cos(atan(tg))*speed*sign[indexX];
    float speedY=sin(atan(tg))*speed*sign[indexY];
    

    movement = sf::Vector2f(speedX,speedY);
}



void CleverEnemy::shot(List<MovingObject>* listEnemy){
    if(!delay){
        sf::FloatRect rect = sprite.getGlobalBounds();
        
        BulletEnemy *bullet = new BulletEnemy(
            sf::Vector2f(0.f,Settings::roundBulletSpeed),
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