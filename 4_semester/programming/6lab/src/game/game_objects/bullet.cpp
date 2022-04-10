#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "bullet.h"

int Bullet::move(){
    
    sprite.move(sf::Vector2f(0.f,-speed));
    sf::FloatRect rect = sprite.getGlobalBounds();
    if(rect.top<=0.f){
        return Settings::BORDER;
    }
    return Settings::NOTHING;
}
int Bullet::action(List<MovingObject>* Player,List<MovingObject>* listEnemy){
    
    return Settings::NOTHING;
}



void Bullet::setImage(std::string imagePath,
                    sf::Vector2f scale){
    
    texture.loadFromFile(imagePath);
    sprite.setTexture(texture);
    sprite.scale(scale);
}

void Bullet::setPosition(sf::FloatRect parentRect){
    sf::FloatRect rect = sprite.getGlobalBounds();

    float x = parentRect.left + parentRect.width/2 - rect.width/2;
    float y = parentRect.top - rect.height + 10.f;


    sprite.setPosition(sf::Vector2f(x,y));

}
