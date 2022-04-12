#ifndef PLAYER_H
#define PLAYER_H




class Player : public MovingObject {
    public:
        Player(int lives, float speed):MovingObject(lives,speed){
            delay = 0;
            score = 0;
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*, List<MovingObject>*) override;
        
        void nullScore(){score=0;}
        int getScore(){ return score; }
        void addScore(int score){ this->score+=score; }
    private:
        const int DELAY = Settings::delayPlayer;
        int delay;
        int score;
        

};


#endif