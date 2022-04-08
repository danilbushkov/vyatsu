#include "player.h"

void Player::move(){
    test();
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
    {
        sf::FloatRect r = sprite.getGlobalBounds();
        if(r.left>0){
            sprite.move(sf::Vector2f(-4.f, 0.f));
        }
        
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
    {
        sprite.move(sf::Vector2f(4.f, 0.f));
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
    {
        sprite.move(sf::Vector2f(0.f, 4.f));
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
    {
        sf::FloatRect r = sprite.getGlobalBounds();
        if(r.top>400.0){
            sprite.move(sf::Vector2f(0.f, -4.f));
        }

        
    }
}

void Player::shot(){
    
}

void Player::test(){

}

