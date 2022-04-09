#ifndef GAME_H
#define GAME_H


class Game{
    public:
        sf::RenderWindow window;
        Object background;
        List<MovingObject> listObj;

        Game();
        Game(Settings*);
        int initObjects();
        void run();

        
    private:
        Settings *settings;
        void drawObjects();
        void eventHandling();
        void moveObjects();
};


#endif