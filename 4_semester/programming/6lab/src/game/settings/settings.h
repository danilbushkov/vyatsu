#ifndef SETTINGS_H
#define SETTINGS_H

#include <SFML/Graphics.hpp>
#include <string>

class Settings{
    public:
        static const int NOTHING = 0;
        static const int DAMAGE = 1;
        static const int BORDER = 2;

        static std::string backgroundImage;

        //player
        static std::string playerImage;
        static sf::Vector2f playerScale;
        static sf::Vector2f playerPosition;
        static float speedPlayer;
        static int livesPlayer;
        static int delayPlayer;


        //playerBullet
        static std::string playerBulletImage;
        static sf::Vector2f playerBulletScale;
        static float BulletPlayerSpeed;
        static int BulletPlayerDamage;

        static void getSettings();
};


#endif