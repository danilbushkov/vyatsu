#ifndef MAGIC_ENEMY_H
#define MAGIC_ENEMY_H




class MagicianEnemy : public Enemy {
    public:
        MagicianEnemy(int lives, float speed,int damage):Enemy(lives, speed, damage){
            movement = 1;
            expectation = 0;
        };
        virtual int move() override;
        virtual int action(List<MovingObject>*,List<MovingObject>*) override;
        
        
    protected:
        sf::Vector2f teleportation();
        sf::Vector2f getTrajectory(sf::FloatRect playerRect, 
                                   sf::FloatRect enemyRect);
        void shot(MovingObject *player,
                  List<MovingObject>* listEnemy);
        const int DELAY = Settings::delayMagicainEnemy;
        int expectation;
        int movement;
};


#endif