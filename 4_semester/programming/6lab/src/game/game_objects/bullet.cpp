#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "bullet.h"

int Bullet::move(){
    
    getSprite()->move(sf::Vector2f(0.f,-getSpeed()));
    sf::FloatRect rect = getSprite()->getGlobalBounds();
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
    
    getTexture()->loadFromFile(imagePath);
    getSprite()->setTexture(*getTexture());
    getSprite()->scale(scale);
}

void Bullet::setPosition(sf::FloatRect parentRect){
    sf::FloatRect rect = getSprite()->getGlobalBounds();

    float x = parentRect.left + parentRect.width/2 - rect.width/2;
    float y = parentRect.top - rect.height + 10.f;


    getSprite()->setPosition(sf::Vector2f(x,y));

}
