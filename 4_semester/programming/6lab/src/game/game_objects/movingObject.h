#ifndef MOVING_OBJECT_H
#define MOVING_OBJECT_H


class MovingObject : public Object{
    public:
        virtual int move() = 0;
        virtual void shot(List<MovingObject>*) = 0;
        virtual int collision() = 0;


        MovingObject(int lives = 1, float speed = 0.f){
            this->speed = speed;
            this->lives = lives;
        };
        virtual ~MovingObject(){};
    protected:
        float speed;
        int lives;
};


#endif