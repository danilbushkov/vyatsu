
#include "settings.h"

std::string Settings::playerBulletImage;
sf::Vector2f Settings::playerBulletScale;
float Settings::BulletPlayerSpeed;
int Settings::BulletPlayerDamage;

std::string Settings::backgroundImage;

std::string Settings::playerImage;
sf::Vector2f Settings::playerScale;
sf::Vector2f Settings::playerPosition;
float Settings::speedPlayer;
int Settings::livesPlayer;
int Settings::delayPlayer;

int Settings::delayEnemy;
int Settings::livesEnemy;
float Settings::speedEnemy;
std::string Settings::enemyImage;
sf::Vector2f Settings::enemyScale;
int Settings::damageEnemy;

std::string Settings::fontPath;

void Settings::getSettings(){
    std::string basePath = "bin/";
    backgroundImage = basePath + "image/fon.jpg";
    
    //player
    playerImage = basePath + "image/player.png";
    playerScale = sf::Vector2f(0.2f,0.2f);
    playerPosition = sf::Vector2f(350.f,500.f);
    speedPlayer = 7.f;
    livesPlayer = 1000;
    delayPlayer = 10;


    playerBulletImage = basePath + "image/playerBullet.png";
    playerBulletScale = sf::Vector2f(0.1f,0.1f);
    BulletPlayerSpeed = 7.f;
    BulletPlayerDamage = 1;


    enemyImage = basePath + "image/nlo.png";
    enemyScale = sf::Vector2f(0.15f,0.15f);
    delayEnemy = 15;
    livesEnemy = 1;
    speedEnemy = 1.f;
    damageEnemy = 2;
    
    fontPath = basePath + "font/Arial.ttf";

}