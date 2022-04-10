#ifndef MAGIC_ENEMY_H
#define MAGIC_ENEMY_H




class MagicianEnemy : public Enemy {
    public:
        MagicianEnemy(int lives, float speed,int damage):Enemy(lives, speed, damage){};
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        void setPosition(float x); 
        void shot(List<MovingObject>* listEnemy);
        
    protected:
        const int DELAY = Settings::delayMagicainEnemy;
        int expectation;
};


#endif