#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "bullet.h"
#include "bulletEnemy.h"

int BulletEnemy::move(){
    
    sprite.move(sf::Vector2f(0.f,speed));
    sf::FloatRect rect = sprite.getGlobalBounds();
    if(rect.top>=600.f){
        return Settings::BORDER;
    }
    return Settings::NOTHING;
}

int BulletEnemy::action(List<MovingObject>* listPlayer,List<MovingObject>* listEnemy){
    
    MovingObject *player = listPlayer->begin->obj;
    sf::FloatRect rectPlayer = player->sprite.getGlobalBounds();
    sf::FloatRect rectBullet = sprite.getGlobalBounds();
    if(checkCollision(rectPlayer, rectBullet)){
        player->injury(damage);
        lives = 0;
    }


    return Settings::NOTHING;
}




void BulletEnemy::setPosition(sf::FloatRect parentRect){
    sf::FloatRect rect = sprite.getGlobalBounds();

    float x = parentRect.left + parentRect.width/2 - rect.width/2;
    float y = parentRect.top + parentRect.height;


    sprite.setPosition(sf::Vector2f(x,y));

}