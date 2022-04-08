#ifndef PLAYER_H
#define PLAYER_H

#include <SFML/Graphics.hpp>
#include "movingObject.h"


class Player : public MovingObject {
    public:
        void move() override;
        void shot() override;
        void test();
};


#endif