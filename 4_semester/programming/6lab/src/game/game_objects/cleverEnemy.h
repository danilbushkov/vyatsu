#ifndef CLEVER_ENEMY_H
#define CLEVER_ENEMY_H




class CleverEnemy : public Enemy {
    public:
        CleverEnemy(int lives, float speed,int damage):Enemy(lives, speed, damage){
            waitingTurn=0;
            movement = sf::Vector2f(0.f,speed);
            appearance=1;
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        
        
    protected:
        void turn();
        void calculationTrajectory(float x, float y);
        void expectationRotation();
        void shot(MovingObject *player,
                  List<MovingObject>* listEnemy);
        const int DELAY = Settings::delayCleverEnemy;
        int waitingTurn;
        sf::Vector2f movement;
        int appearance;
};


#endif