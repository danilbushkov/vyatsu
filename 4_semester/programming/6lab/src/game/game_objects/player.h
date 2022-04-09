#ifndef PLAYER_H
#define PLAYER_H




class Player : public MovingObject {
    public:
        Player(int lives, float speed):MovingObject(lives,speed){
            delay = 0;
        };
        virtual int move() override;
        virtual void shot(List<MovingObject>*) override;
        virtual int collision() override;

        
    private:
        const int DELAY = Settings::delayPlayer;
        int delay;

};


#endif