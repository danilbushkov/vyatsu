#ifndef PLAYER_H
#define PLAYER_H




class Player : public MovingObject {
    public:
        Player(int lives, float speed):MovingObject(lives,speed){};
        virtual void move() override;
        virtual void shot(List<MovingObject>*) override;
        virtual void collision() override;

        
    private:
};


#endif