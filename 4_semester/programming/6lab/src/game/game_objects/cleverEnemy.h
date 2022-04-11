#ifndef CLEVER_ENEMY_H
#define CLEVER_ENEMY_H




class CleverEnemy : public Enemy {
    public:
        CleverEnemy(int lives, float speed,int damage):Enemy(lives, speed, damage){
            fuel=0;
            refill=0;
            movement = sf::Vector2f(0.f,speed);
            newlyCreated=1;
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        
        
    protected:
        void turn();
        void calculationTrajectory(float x, float y);
        void expectationRotation();
        void shot(List<MovingObject>* listEnemy);
        const int DELAY = Settings::delayCleverEnemy;
        int fuel;
        sf::Vector2f movement;
        int newlyCreated;
        int refill;
};


#endif