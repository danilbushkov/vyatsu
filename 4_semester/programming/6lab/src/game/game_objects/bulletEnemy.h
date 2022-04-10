#ifndef BULLET_ENEMY_H
#define BULLET_ENEMY_H


class BulletEnemy : public Bullet {
    public:
        BulletEnemy(float speedX,float speedY, int damage):Bullet(speedY, damage){
            this->direction = sf::Vector2f(speedX, speedY);
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        
        
        void setPosition(sf::FloatRect);
        
    protected:
        sf::Vector2f direction;
        
};


#endif