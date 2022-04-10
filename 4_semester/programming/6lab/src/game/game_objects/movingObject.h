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
            return lives==0;
        }
        int getLives(){
            return lives;
        }

        virtual ~MovingObject(){};
        MovingObject(int lives = 1, float speed = 0.f){
            this->speed = speed;
            this->lives = lives;
        };
    protected:
        int lives;
        float speed;
        
};


#endif