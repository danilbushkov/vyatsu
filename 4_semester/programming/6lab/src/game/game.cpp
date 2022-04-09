#include <SFML/Graphics.hpp>
#include <cstdlib>
#include <ctime>
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
        generateEnemy();
        eventHandling();
        actionObjects(&listPlayer);
        actionObjects(&listEnemy);
        

        window.clear();
        window.draw(background.sprite);
        
        
        drawObjects(&listEnemy);
        drawObjects(&listPlayer);

        window.display();
    }
}


void Game::actionObjects(List<MovingObject>* list){
    
    Node<MovingObject> *node;
    Node<MovingObject> *tmpNode;

    int codeMove;

    node = list->begin;
    while(node!=nullptr){
        tmpNode = node;
        node = node->next;
        
        codeMove=tmpNode->obj->move();
        tmpNode->obj->action(&listPlayer,&listPlayer);
        if(codeMove == Settings::BORDER || tmpNode->obj->lives <= 0){
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
    window.create(sf::VideoMode(800, 600), "Game",sf::Style::Close);
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