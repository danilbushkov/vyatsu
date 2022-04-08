#ifndef GAME_H
#define GAME_H

#include <SFML/Graphics.hpp>
#include "settings.h"
#include "object.h"
#include "player.h"
#include "list.h"


class Game{
    public:
        sf::RenderWindow window;
        Object background;
        List listObj;

        Game();
        Game(Settings*);
        int initObjects();
        void run();

        
    private:
        Settings *settings;
        void drawObjects();
        void eventHandling();
        void moveObjects();
};


#endif