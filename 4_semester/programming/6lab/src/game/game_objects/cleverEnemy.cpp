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
    if(waitingTurn>0){

        sprite.move(movement);
        waitingTurn--;
        
    }else{
        waitingTurn = 100 + rand() % 50;

    }
    
    expectationRotation();
    return Settings::NOTHING;
}

void CleverEnemy::expectationRotation(){
    sf::FloatRect rect = sprite.getGlobalBounds();
    if((rect.top + rect.height) > 375.f ||
        (rect.top < 0 && !appearance)  ){
        movement = sf::Vector2f(movement.x,-movement.y);
        appearance = 0;
    }
    
}



int CleverEnemy::action(List<MovingObject>* listPlayer, 
                   List<MovingObject>* listEnemy){
    shot(listPlayer->begin->obj, listEnemy);
    int code = collision(listPlayer);
    if(code == Settings::INJURY){
        
    }

    return code;
}






void CleverEnemy::shot(MovingObject *player,
                         List<MovingObject>* listEnemy){
    if(!delay){
        sf::FloatRect rect = sprite.getGlobalBounds();
        sf::FloatRect PlayerRect = player->sprite.getGlobalBounds();
        
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