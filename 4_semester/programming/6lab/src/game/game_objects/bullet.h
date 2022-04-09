#ifndef BULLET_H
#define BULLET_H


class Bullet : public MovingObject {
    public:
        Bullet(float speed, int damage):MovingObject(1,speed){
            this->damage = damage;
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        //virtual int collision() override;
        void setImage(std::string,
                      sf::Vector2f,
                      sf::FloatRect);
        
    protected:
        int damage;

        
};


#endif