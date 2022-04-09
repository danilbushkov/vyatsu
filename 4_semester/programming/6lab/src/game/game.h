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
        Player *player;
        void drawObjects(List<MovingObject>*);
        void eventHandling();
        void actionObjects(List<MovingObject>*);
        void generateEnemy();
};


#endif