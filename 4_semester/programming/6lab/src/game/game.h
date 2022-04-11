#ifndef GAME_H
#define GAME_H


class Game{
    public:
        sf::RenderWindow window;
        Object background;
        List<MovingObject> listEnemy;
        List<MovingObject> listPlayer;

        Game();
        int initObjects();
        void run();

        
    private:
        sf::Font font;
        sf::Text textLives;
        sf::Text textScore;
        sf::Text textStart;
        sf::Text textEnd;
        int start;
        int end;
        Player *player;
        void game();
        void waitingStart(sf::Text text);
        void drawObjects(List<MovingObject>*);
        void eventHandling();
        void actionObjects(List<MovingObject>*);
        void generateEnemy();
        void createEnemy();
        void createMagicainEnemy();
        void createCleverEnemy();
        void viewText();
        std::wstring getEndText();
};


#endif