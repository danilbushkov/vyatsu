#ifndef ENEMY_H
#define ENEMY_H




class Enemy : public MovingObject {
    public:
        Enemy(int lives, float speed, int damage):MovingObject(lives,speed){
            delay = 0;
            this->setDamage(damage);
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        void setPosition(float x);
        void setImage(std::string,
                      sf::Vector2f);
        void shot(List<MovingObject>* listEnemy);
        void setDelay(int delay){
            this->delay = delay;
        }
        int getDelay(){
            return delay;
        }
        void delayMinus(){
            delay--;
        }
    protected:
        int collision(List<MovingObject>*);

    private:
        const int DELAY = Settings::delayEnemy;
        int delay;

};


#endif