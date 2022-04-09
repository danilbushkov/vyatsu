#ifndef SETTINGS_H
#define SETTINGS_H

#include <SFML/Graphics.hpp>
#include <string>

class Settings{
    public:
        static const int NOTHING = 0;
        static const int DAMAGE = 1;
        static const int BORDER = 2;
        static const int KILL_ENEMY = 3;

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


        //Enemy
        static int delayEnemy;
        static float speedEnemy;
        static std::string enemyImage;
        static sf::Vector2f enemyScale;
        static int livesEnemy;
        static int damageEnemy;

        static std::string fontPath;

        static void getSettings();

        
};


#endif