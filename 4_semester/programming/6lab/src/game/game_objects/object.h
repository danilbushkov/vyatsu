#ifndef OBJECT_H
#define OBJECT_H

#include <SFML/Graphics.hpp>
#include <string>

class Object{
    public:
        int setImage(std::string,
                     sf::Vector2f = sf::Vector2f(1.f,1.f),
                     sf::Vector2f = sf::Vector2f(0.f,0.f));
        
        virtual ~Object(){};
        sf::Texture* getTexture(){
            return &texture;
        }
        sf::Sprite* getSprite(){
            return &sprite;
        }
    private:
        sf::Texture texture;
        sf::Sprite sprite;
};


#endif