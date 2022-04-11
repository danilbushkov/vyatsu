
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

std::string Settings::enemyBulletImage;
sf::Vector2f Settings::enemyBulletScale;
float Settings::enemyBulletSpeed;
int Settings::enemyBulletDamage;

std::string Settings::magicainEnemyImage;
sf::Vector2f Settings::magicainEnemyScale;
int Settings::delayMagicainEnemy;
int Settings::livesMagicainEnemy;
float Settings::speedMagicainEnemy;
int Settings::damageMagicainEnemy;

std::string Settings::cleverEnemyImage;
sf::Vector2f Settings::cleverEnemyScale;
int Settings::delayCleverEnemy;
int Settings::livesCleverEnemy;
float Settings::speedCleverEnemy;
int Settings::damageCleverEnemy;

std::string Settings::roundBulletImage;
sf::Vector2f Settings::roundBulletScale;
float Settings::roundBulletSpeed;
int Settings::roundBulletDamage;

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


    enemyImage = basePath + "image/pizza.png";
    enemyScale = sf::Vector2f(0.15f,0.15f);
    delayEnemy = 150;
    livesEnemy = 1;
    speedEnemy = 1.f;
    damageEnemy = 2;

    magicainEnemyImage = basePath + "image/fox.png";
    magicainEnemyScale = sf::Vector2f(0.12f,0.12f);
    delayMagicainEnemy = 150;
    livesMagicainEnemy = 3;
    speedMagicainEnemy = 1.f;
    damageMagicainEnemy = 2;

    cleverEnemyImage = basePath + "image/nlo.png";
    cleverEnemyScale = sf::Vector2f(0.17f,0.17f);
    delayCleverEnemy = 100;
    livesCleverEnemy = 3;
    speedCleverEnemy = 1.5f;
    damageCleverEnemy = 2;


    enemyBulletImage = basePath + "image/enemyBullet.png";
    enemyBulletScale = sf::Vector2f(0.05f,0.05f);
    enemyBulletSpeed = 3.f;
    enemyBulletDamage = 1;

    roundBulletImage = basePath + "image/roundBullet.png";
    roundBulletScale = sf::Vector2f(0.15f,0.15f);
    roundBulletSpeed = 2.f;
    roundBulletDamage = 1;
    
    fontPath = basePath + "font/Arial.ttf";

}