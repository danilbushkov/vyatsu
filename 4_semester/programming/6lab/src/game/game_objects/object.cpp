#include "object.h"

int Object::setImage(std::string imagePath,
                    sf::Vector2f scale,
                    sf::Vector2f position){
    
    if (!texture.loadFromFile(imagePath))
    {
        return 0;
    }
    sprite.setTexture(texture);
    sprite.scale(scale);
    sprite.setPosition(position);
    return 1;
}