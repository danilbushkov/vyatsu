#include <SFML/Graphics.hpp>
#include <cstdlib>
#include <ctime>
#include <sstream>
#include <string>
#include "settings.h"
#include "object.h"
#include "list.h"
#include "movingObject.h"
#include "player.h"
#include "enemy.h"
#include "magicianEnemy.h"
#include "cleverEnemy.h"
#include "game.h"

using namespace std;


Game::Game(){
    srand(time(NULL));
    start = 1;
    end = 0;
}


void Game::run(){
     while (window.isOpen())
     {
        
        if(start){
            waitingStart(textStart);
        }else if(end){
            textEnd.setString(getEndText());
            waitingStart(textEnd);
        }else{
            game();
        }
    }
}

void Game::waitingStart(sf::Text text){
    eventHandling();
    window.clear();

    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter))
    {
        start=0;
        end=0;
        player->setLives(Settings::livesPlayer);
        player->nullScore();
    }
    window.draw(text);
    
    window.display();
}

void Game::game(){
    if(player->getLives()>0){
        generateEnemy();
        eventHandling();
        actionObjects(&listPlayer);
        actionObjects(&listEnemy);
        

        window.clear();
        window.draw(*background.getSprite());
        
        
        drawObjects(&listEnemy);
        drawObjects(&listPlayer);


        viewText();

        window.draw(textLives);
        window.draw(textScore);
        window.display();
    }else{
        listEnemy.Clear();
        listPlayer.ClearExceptFirst();
        end=1;
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
        if(tmpNode->obj!=player){
            if(code == Settings::BORDER || tmpNode->obj->getLives() <= 0 ){
                list->DeleteNode(tmpNode);
            }
        }
        


    }
}   




void Game::drawObjects(List<MovingObject>* list){
    Node<MovingObject> *node;
    node = list->begin;
    while(node!=nullptr){
        window.draw(*node->obj->getSprite());
        node = node->next;
    }
}


void Game::generateEnemy(){
    
    int probabilityCreate = rand() % 1001; //0..1000
    if(probabilityCreate < 5){
        createEnemy();
    }else if(probabilityCreate >= 20 && probabilityCreate <=22){
        createMagicainEnemy();
    }else if(probabilityCreate >= 23 && probabilityCreate <=24){
        createCleverEnemy();
    }

}


void Game::createCleverEnemy(){
    int x = 25 + rand() % 651;
    CleverEnemy *enemy = new CleverEnemy(
        Settings::livesCleverEnemy,
        Settings::speedCleverEnemy,
        Settings::damageCleverEnemy);
    enemy->setImage(
        Settings::cleverEnemyImage,
        Settings::cleverEnemyScale
    );
    enemy->setPosition(x);
    MovingObject *obj = enemy;
    listEnemy.AddNode(obj);
}

void Game::createMagicainEnemy(){
    int x = 25 + rand() % 651;
    MagicianEnemy *enemy = new MagicianEnemy(
        Settings::livesMagicainEnemy,
        Settings::speedMagicainEnemy,
        Settings::damageMagicainEnemy);
    enemy->setImage(
        Settings::magicainEnemyImage,
        Settings::magicainEnemyScale
    );
    enemy->setPosition(x);
    MovingObject *obj = enemy;
    listEnemy.AddNode(obj);
}

void Game::createEnemy(){
    int x = 25 + rand() % 651;
    Enemy *enemy = new Enemy(Settings::livesEnemy,
        Settings::speedEnemy,
        Settings::damageEnemy);
    enemy->setImage(
        Settings::enemyImage,
        Settings::enemyScale
    );
    enemy->setPosition(x);
    MovingObject *obj = enemy;
    listEnemy.AddNode(obj);
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
    
    textStart.setFont(font);
    textStart.setCharacterSize(24);
    textStart.setFillColor(sf::Color::Red);
    textStart.setString(L"Нажмите Enter, чтобы начать.\n\n\
Управление - стрелки, z - стрельба");
    sf::FloatRect rect = textStart.getGlobalBounds();
    textStart.setPosition(800.f/2-rect.width/2,
                          600.f/2-rect.height/2);

    textEnd.setFont(font);
    textEnd.setCharacterSize(24);
    textEnd.setFillColor(sf::Color::Red);
    textEnd.setString(L"Конец игры!\n\n\
Нажмите Enter, чтобы начать сначала");
    rect = textEnd.getGlobalBounds();
    textEnd.setPosition(800.f/2-rect.width/2,
                        600.f/2-rect.height/2);
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

void Game::viewText(){
    wostringstream ws;
    ws << player->getLives();
    wstring s = L"Жизни: "+ws.str();
    textLives.setString(s);
    ws.str(L"");
    ws << player->getScore();
    s = L"Очки: "+ws.str();
    textScore.setString(s);
}

wstring Game::getEndText(){
    wostringstream ws;
    ws << player->getScore();
    wstring text = L"Конец игры!\n\n\
Нажмите Enter, чтобы начать сначала\n\nОчки: "+ws.str();
    return text;
}