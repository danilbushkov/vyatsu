#ifndef BULLET_ENEMY_H
#define BULLET_ENEMY_H


class BulletEnemy : public Bullet {
    public:
        BulletEnemy(float speed, int damage):Bullet(speed, damage){};
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        
        
        void setPosition(sf::FloatRect);
        
    protected:
        
        
};


#endif