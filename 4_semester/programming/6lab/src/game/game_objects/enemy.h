#ifndef ENEMY_H
#define ENEMY_H




class Enemy : public MovingObject {
    public:
        Enemy(int lives, float speed):MovingObject(lives,speed){
            delay = 0;
        };
        virtual int move() override;
        virtual void action(List<MovingObject>*,List<MovingObject>*) override;
        //virtual int collision() override;
        void setPosition(float x);
        void setImage(std::string,
                      sf::Vector2f);
        
        
    protected:
        void collision(List<MovingObject>*);
        const int DELAY = Settings::delayEnemy;
        int delay;
        int damage = Settings::damageEnemy;

};


#endif