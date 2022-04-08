#include "object.h"

int Object::setImage(std::string imagePath,
                    sf::Vector2f vector,
                    sf::Vector2f position){
    
    if (!texture.loadFromFile(imagePath))
    {
        return 0;
    }
    sprite.setTexture(texture);
    sprite.scale(vector);
    sprite.setPosition(position);
    return 1;
}