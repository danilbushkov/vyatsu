#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "bullet.h"
#include "bulletEnemy.h"

int BulletEnemy::move(){
    
    getSprite()->move(direction);
    sf::FloatRect rect = getSprite()->getGlobalBounds();
    if(rect.top>=600.f){
        return Settings::BORDER;
    }
    return Settings::NOTHING;
}

int BulletEnemy::action(List<MovingObject>* listPlayer,List<MovingObject>* listEnemy){
    
    MovingObject *player = listPlayer->begin->obj;
    sf::FloatRect rectPlayer = player->getSprite()->getGlobalBounds();
    sf::FloatRect rectBullet = getSprite()->getGlobalBounds();
    if(checkCollision(rectPlayer, rectBullet)){
        player->injury(getDamage());
        setLives(0);
    }


    return Settings::NOTHING;
}




void BulletEnemy::setPosition(sf::FloatRect parentRect){
    sf::FloatRect rect = getSprite()->getGlobalBounds();

    float x = parentRect.left + parentRect.width/2 - rect.width/2;
    float y = parentRect.top + parentRect.height;


    getSprite()->setPosition(sf::Vector2f(x,y));

}