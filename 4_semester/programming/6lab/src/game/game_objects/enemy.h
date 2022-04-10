#ifndef ENEMY_H
#define ENEMY_H




class Enemy : public MovingObject {
    public:
        Enemy(int lives, float speed):MovingObject(lives,speed){
            delay = 0;
            damage = Settings::damageEnemy;
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        void setPosition(float x);
        void setImage(std::string,
                      sf::Vector2f);
        void shot(List<MovingObject>* listEnemy);
        
    protected:
        int collision(List<MovingObject>*);
        const int DELAY = Settings::delayEnemy;
        int delay;

};


#endif