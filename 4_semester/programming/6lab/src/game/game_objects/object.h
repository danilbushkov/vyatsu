#ifndef OBJECT_H
#define OBJECT_H

#include <SFML/Graphics.hpp>
#include <string>

class Object{
    public:
        int setImage(std::string,
                     sf::Vector2f = sf::Vector2f(1.f,1.f),
                     sf::Vector2f = sf::Vector2f(0.f,0.f));
        sf::Sprite sprite;
        virtual ~Object(){};
    protected:
        sf::Texture texture;
};


#endif