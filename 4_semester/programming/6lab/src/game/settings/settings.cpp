
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


void Settings::getSettings(){
    std::string basePath = "bin/";
    backgroundImage = basePath + "image/fon.jpg";
    
    //player
    playerImage = basePath + "image/player.png";
    playerScale = sf::Vector2f(0.2f,0.2f);
    playerPosition = sf::Vector2f(350.f,500.f);
    speedPlayer = 7.f;
    livesPlayer = 5;
    delayPlayer = 10;


    playerBulletImage = basePath + "image/playerBullet.png";
    playerBulletScale = sf::Vector2f(0.1f,0.1f);
    BulletPlayerSpeed = 7.f;
    BulletPlayerDamage = 1;
}