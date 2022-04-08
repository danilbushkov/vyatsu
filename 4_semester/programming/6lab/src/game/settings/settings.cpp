
#include "settings.h"



void Settings::getSettings(){
    std::string basePath = "bin/";
    backgroundImage = basePath + "image/fon.jpg";
    
    playerImage = basePath + "image/player.png";
    playerScale = sf::Vector2f(0.2f,0.2f);
    playerPosition = sf::Vector2f(350.f,500.f);
}