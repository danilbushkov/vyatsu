#ifndef GAME_H
#define GAME_H





class Game{
    public:
        sf::RenderWindow window;
        Object background;
        List<MovingObject> listObj;

        Game();
        int initObjects();
        void run();

        
    private:
        void drawObjects();
        void eventHandling();
        void actionObjects();
        void shotObjects();
};


#endif