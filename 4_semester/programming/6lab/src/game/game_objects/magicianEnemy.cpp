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

    }
    
    return Settings::NOTHING;
}




int MagicianEnemy::action(List<MovingObject>* listPlayer, 
                   List<MovingObject>* listEnemy){
    shot(listEnemy);
    int code = collision(listPlayer);
    if(code == Settings::INJURY){
        teleportation();
    }

    return code;
}

sf::Vector2f MagicianEnemy::teleportation(){
    float x =  25 + rand() % 651;
    float y = 25 + rand() % 300;
    return sf::Vector2f(x,y);
}


// void MagicianEnemy::shot(List<MovingObject>* listEnemy){

//     if(!delay){
//         sf::FloatRect rect = sprite.getGlobalBounds();
        
//         BulletEnemy *bullet = new BulletEnemy(
//             0.f,
//             Settings::enemyBulletSpeed,
//             Settings::enemyBulletDamage
//         );
//         bullet->setImage(
//             Settings::enemyBulletImage,
//             Settings::enemyBulletScale
//         );
//         bullet->setPosition(rect);

//         MovingObject *obj = bullet;
//         listEnemy->AddNode(obj);
//         delay=DELAY;
//     }else{
//         delay--;
//     }
    
// }



