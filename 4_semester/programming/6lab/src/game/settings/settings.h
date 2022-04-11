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
        static const int INJURY = 4;

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

        //EnemyBullet
        static std::string enemyBulletImage;
        static sf::Vector2f enemyBulletScale;
        static float enemyBulletSpeed;
        static int enemyBulletDamage;

        static std::string magicainEnemyImage;
        static sf::Vector2f magicainEnemyScale;
        static int delayMagicainEnemy;
        static int livesMagicainEnemy;
        static float speedMagicainEnemy;
        static int damageMagicainEnemy;


        static std::string cleverEnemyImage;
        static sf::Vector2f cleverEnemyScale;
        static int delayCleverEnemy;
        static int livesCleverEnemy;
        static float speedCleverEnemy;
        static int damageCleverEnemy;

        static std::string roundBulletImage;
        static sf::Vector2f roundBulletScale;
        static float roundBulletSpeed;
        static int roundBulletDamage;

        static std::string fontPath;

        static void getSettings();

        
};


#endif