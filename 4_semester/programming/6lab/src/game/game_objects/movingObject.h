#ifndef MOVING_OBJECT_H
#define MOVING_OBJECT_H


class MovingObject : public Object{
    public:
        virtual int move() = 0;
        virtual int action(List<MovingObject>*,List<MovingObject>*) = 0;
        void injury(int damage){
            lives -= damage;
        };
        int checkKill(){
            return lives<=0;
        }
        int getLives(){
            return lives;
        }

        virtual ~MovingObject(){};
        MovingObject(int lives = 1, float speed = 0.f){
            this->speed = speed;
            this->lives = lives;
        };
        int checkCollision(sf::FloatRect bigRect, sf::FloatRect smallRect){
            return ((smallRect.left+smallRect.width-smallRect.width/6) > bigRect.left ) &&
            (smallRect.left+smallRect.width/6 < (bigRect.left + bigRect.width)) &&
            (smallRect.top+smallRect.height) > bigRect.top &&
            (smallRect.top+smallRect.height/2) < bigRect.top+bigRect.height;
        }
        int getDamage(){
            return damage;
        }
        int getSpeed(){
            return speed;
        }
        void setLives(int lives){
            this->lives=lives;
        }
        void setDamage(int damage){
            this->damage=damage;
        }
        
    private:
        int lives;
        float speed;
        int damage;
        
};


#endif