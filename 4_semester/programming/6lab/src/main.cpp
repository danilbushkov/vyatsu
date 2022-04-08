#include <iostream>
#include <SFML/Graphics.hpp>
#include "game.h"
#include "settings.h"

int main()
{
    Settings settings;
    settings.getSettings();

    Game game(&settings);

    if(!game.initObjects()){
        std::cout<<"Error init"<<std::endl;
        return 1;
    }
    game.run();
    
    return 0;
}