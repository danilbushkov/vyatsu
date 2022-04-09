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
void Bullet::action(List<MovingObject>* Player,List<MovingObject>* listEnemy){
    
}



void Bullet::setImage(std::string imagePath,
                    sf::Vector2f scale,
                    sf::FloatRect parentRect){
    
    texture.loadFromFile(imagePath);
    sprite.setTexture(texture);
    sprite.scale(scale);
    sf::FloatRect rect = sprite.getGlobalBounds();

    float x = parentRect.left + parentRect.width/2 - rect.width/2;
    float y = parentRect.top - rect.height + 10.f;


    sprite.setPosition(sf::Vector2f(x,y));

}
