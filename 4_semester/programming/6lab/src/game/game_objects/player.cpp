#include <SFML/Graphics.hpp>
#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "bullet.h"
#include "player.h"

int Player::move(){
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
    {
        sf::FloatRect r = getSprite()->getGlobalBounds();
        if(r.left>0.f){
            getSprite()->move(sf::Vector2f(-getSpeed(), 0.f));
        }
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
    {
        sf::FloatRect r = getSprite()->getGlobalBounds();
        if((r.left+r.width)<800.f){
            getSprite()->move(sf::Vector2f(getSpeed(), 0.f));
        }
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
    {
        sf::FloatRect r = getSprite()->getGlobalBounds();
        if(r.top+r.height<600.f){
            getSprite()->move(sf::Vector2f(0.f, getSpeed()));
        }
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
    {
        sf::FloatRect r = getSprite()->getGlobalBounds();
        if(r.top>400.f){
            getSprite()->move(sf::Vector2f(0.f, -getSpeed()));
        }

    }
    return Settings::NOTHING;
}

int Player::action(List<MovingObject> *listPlayer, List<MovingObject> *listEnemy){

    if(delay>0){
        delay--;
    }else if(sf::Keyboard::isKeyPressed(sf::Keyboard::Z)){
        sf::FloatRect rect = getSprite()->getGlobalBounds();
        
        Bullet *bullet = new Bullet(
            Settings::BulletPlayerSpeed,
            Settings::BulletPlayerDamage
        );
        bullet->setImage(
            Settings::playerBulletImage,
            Settings::playerBulletScale
        );
        bullet->setPosition(rect);

        MovingObject *obj = bullet;
        listPlayer->AddNode(obj);
        delay=DELAY;
    }
    return Settings::NOTHING;
}

// int Player::collision(){

//     return Settings::NOTHING;
// }

