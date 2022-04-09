#ifndef PLAYER_H
#define PLAYER_H

#include <SFML/Graphics.hpp>
#include "movingObject.h"


class Player : public MovingObject {
    public:
        Player(int lives, float speed):MovingObject(lives,speed){};
        virtual void move() override;
        virtual void shot() override;
        void test();
};


#endif