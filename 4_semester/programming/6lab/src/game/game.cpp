#include <SFML/Graphics.hpp>
#include "settings.h"
#include "object.h"
#include "movingObject.h"
#include "player.h"
#include "list.h"
#include "game.h"

Game::Game(){
}

Game::Game(Settings *settings){
    this->settings = settings;
}

void Game::run(){
     while (window.isOpen())
     {
        eventHandling();
        moveObjects();
        

        window.clear();
        window.draw(background.sprite);
        drawObjects();

        window.display();
    }
}


void Game::moveObjects(){
    Node<MovingObject> *node;
    node = listObj.begin;
    while(node!=nullptr){
        node->obj->move();
        node = node->next;
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

    

    if(!background.setImage(settings->backgroundImage)){
        return 0;
    }

    Player *player = new Player(settings->livesPlayer, 
                                settings->speedPlayer);
    if(!player->setImage(settings->playerImage,
                        settings->playerScale,
                        settings->playerPosition)){
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