#include <SFML/Graphics.hpp>
#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "player.h"
#include "game.h"

Game::Game(){
}


void Game::run(){
     while (window.isOpen())
     {
        eventHandling();
        actionObjects();
        

        window.clear();
        window.draw(background.sprite);
        drawObjects();

        window.display();
    }
}


void Game::actionObjects(){
    
    Node<MovingObject> *node;
    Node<MovingObject> *tmpNode;

    int codeMove;

    node = listObj.begin;
    while(node!=nullptr){
        tmpNode = node;
        node = node->next;
        

        
        codeMove=tmpNode->obj->move();
        tmpNode->obj->shot(&listObj);
        if(codeMove == Settings::BORDER){
            listObj.DeleteNode(tmpNode);
        }
        


    }
}   




void Game::drawObjects(){
    Node<MovingObject> *node;
    node = listObj.begin;
    while(node!=nullptr){
        window.draw(node->obj->sprite);
        node = node->next;
    }
}



int Game::initObjects(){
    window.create(sf::VideoMode(800, 600), "Game",sf::Style::Close);
    window.setFramerateLimit(60);

    

    if(!background.setImage(Settings::backgroundImage)){
        return 0;
    }

    Player *player = new Player(Settings::livesPlayer, 
                                Settings::speedPlayer);
    if(!player->setImage(Settings::playerImage,
                        Settings::playerScale,
                        Settings::playerPosition)){
        return 0;
    }
    listObj.AddNode(player);


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