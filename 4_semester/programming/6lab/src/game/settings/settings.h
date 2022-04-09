#ifndef SETTINGS_H
#define SETTINGS_H

#include <SFML/Graphics.hpp>
#include <string>

class Settings{
    public:
        static const int NOTHING = 0;
        static const int DAMAGE = 1;


        std::string backgroundImage;
        std::string playerImage;
        sf::Vector2f playerScale;
        sf::Vector2f playerPosition;
        float speedPlayer;
        int livesPlayer;

        void getSettings();
};


#endif