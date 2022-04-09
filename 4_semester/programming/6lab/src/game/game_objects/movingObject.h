#ifndef MOVING_OBJECT_H
#define MOVING_OBJECT_H

#include <SFML/Graphics.hpp>
#include "object.h"


class MovingObject : public Object{
    public:
        virtual void move() = 0;
        virtual void shot() = 0;




        
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