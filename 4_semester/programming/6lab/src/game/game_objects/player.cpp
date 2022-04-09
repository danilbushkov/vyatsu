#include "player.h"




void Player::move(){
    test();
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
    {
        sf::FloatRect r = sprite.getGlobalBounds();
        if(r.left>0){
            sprite.move(sf::Vector2f(-speed, 0.f));
        }
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
    {
        sf::FloatRect r = sprite.getGlobalBounds();
        if((r.left+r.width)<800){
            sprite.move(sf::Vector2f(speed, 0.f));
        }
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
    {
        sf::FloatRect r = sprite.getGlobalBounds();
        if(r.top+r.height<600){
            sprite.move(sf::Vector2f(0.f, speed));
        }
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
    {
        sf::FloatRect r = sprite.getGlobalBounds();
        if(r.top>400.0){
            sprite.move(sf::Vector2f(0.f, -speed));
        }

    }
}

void Player::shot(){
    
}

void Player::test(){

}

