#ifndef BULLET_ENEMY_H
#define BULLET_ENEMY_H


class BulletEnemy : public Bullet {
    public:
        BulletEnemy(sf::Vector2f direction, int damage):Bullet(direction.y, damage){
            this->direction = direction;
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        
        
        void setPosition(sf::FloatRect);
        
    protected:
        sf::Vector2f direction;
        
};


#endif