#include <SFML/Graphics.hpp>
#include <cstdlib>
#include <ctime>
#include <sstream>
#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "player.h"
#include "enemy.h"
#include "game.h"

using namespace std;


Game::Game(){
    srand(time(NULL));
}


void Game::run(){
     while (window.isOpen())
     {
        //todo: checkLives;
        generateEnemy();
        eventHandling();
        actionObjects(&listPlayer);
        actionObjects(&listEnemy);
        

        window.clear();
        window.draw(background.sprite);
        
        
        drawObjects(&listEnemy);
        drawObjects(&listPlayer);


        wostringstream ws;
        ws << player->lives;
        wstring s = L"Жизни: "+ws.str();
        textLives.setString(s);
        ws.str(L"");
        ws << player->getScore();
        s = L"Очки: "+ws.str();
        textScore.setString(s);

        window.draw(textLives);
        window.draw(textScore);
        window.display();
    }
}


void Game::actionObjects(List<MovingObject>* list){
    
    Node<MovingObject> *node;
    Node<MovingObject> *tmpNode;

    int code;

    node = list->begin;
    while(node!=nullptr){
        tmpNode = node;
        node = node->next;
        
        code = tmpNode->obj->action(&listPlayer,&listEnemy);
        if(code == Settings::KILL_ENEMY){
            player->addScore(1);
        }
        code = tmpNode->obj->move();
        if(code == Settings::BORDER || tmpNode->obj->lives <= 0){
            list->DeleteNode(tmpNode);
        }
        
        


    }
}   




void Game::drawObjects(List<MovingObject>* list){
    Node<MovingObject> *node;
    node = list->begin;
    while(node!=nullptr){
        window.draw(node->obj->sprite);
        node = node->next;
    }
}


void Game::generateEnemy(){
    
    int probabilityCreate = rand() % 1001; //0..1000
    if(probabilityCreate > 990){
        int x = 25 + rand() % 651;
        Enemy *enemy = new Enemy(Settings::livesEnemy,Settings::speedEnemy);
        enemy->setImage(
            Settings::enemyImage,
            Settings::enemyScale
        );
        enemy->setPosition(x);
        MovingObject *obj = enemy;
        listEnemy.AddNode(obj);
    }

}



int Game::initObjects(){
    window.create(sf::VideoMode(800, 600), L"Игра",sf::Style::Close);
    window.setFramerateLimit(60);

    

    if(!background.setImage(Settings::backgroundImage)){
        return 0;
    }

    player = new Player(Settings::livesPlayer, 
                                Settings::speedPlayer);
    if(!player->setImage(Settings::playerImage,
                        Settings::playerScale,
                        Settings::playerPosition)){
        return 0;
    }
    MovingObject *obj = player;
    listPlayer.AddNode(obj);

    if(!font.loadFromFile(Settings::fontPath)){
        return 0;
    }
    textLives.setFont(font); 
    textLives.setCharacterSize(24); 
    textLives.setFillColor(sf::Color::Red);
    textLives.setPosition(10.f,10.f);


    textScore.setFont(font); 
    textScore.setCharacterSize(24); 
    textScore.setFillColor(sf::Color::Red);
    textScore.setPosition(640.f,10.f);
    


    return 1;
}

void Game::eventHandling(){
    sf::Event event;
    while (window.pollEvent(event))
    {
        if (event.type == sf::Event::Closed)
            window.close();
    }
}