#ifndef BULLET_H
#define BULLET_H


class Bullet : public MovingObject {
    public:
        Bullet(float speed, int damage):MovingObject(1,speed){
            this->setDamage(damage);
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        
        void setImage(std::string,
                      sf::Vector2f);
        void setPosition(sf::FloatRect parentRect);
        
   
        
        
};


#endif