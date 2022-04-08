#ifndef MOVING_OBJECT_H
#define MOVING_OBJECT_H

#include <SFML/Graphics.hpp>
#include "object.h"


class MovingObject : public Object{
    public:
        virtual void move() = 0;
        virtual void shot() = 0;
        virtual ~MovingObject(){};
    private:
        float speed;
        int lives;
};


#endif