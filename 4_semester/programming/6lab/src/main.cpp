#include <iostream>
#include <SFML/Graphics.hpp>
#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "player.h"
#include "game.h"


int main()
{
    Settings::getSettings();

    Game game;

    if(!game.initObjects()){
        std::cout<<"Error init"<<std::endl;
        return 1;
    }
    game.run();
    
    return 0;
}