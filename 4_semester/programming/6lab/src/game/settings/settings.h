#ifndef SETTINGS_H
#define SETTINGS_H

#include <SFML/Graphics.hpp>
#include <string>

class Settings{
    public:
        std::string backgroundImage;
        std::string playerImage;
        sf::Vector2f playerScale;
        sf::Vector2f playerPosition;

        void getSettings();
};


#endif