#include <iostream>
#include "graph.h"

int main(){
    Graph g = Graph();
    g.mass[0][1]=1;
    g.mass[1][6]=1;
    g.mass[6][8]=1;
    g.mass[8][4]=1;
    g.mass[2][4]=1;
    g.mass[3][4]=1;
    g.mass[2][3]=1;
    g.mass[2][5]=1;
    g.mass[5][2]=1;
    g.mass[7][3]=1;
    g.mass[8][0]=1;
    g.size = 9;

    if(g.checkPathGraph(1,3)){
        std::cout<<"Error"<<std::endl;
    }
    if(!g.checkPathGraph(1,6)){
        std::cout<<"Error"<<std::endl;
    }
    if(g.checkPathGraph(1,7)){
        std::cout<<"Error"<<std::endl;
    }
    if(g.checkPathGraph(7,1)){
        std::cout<<"Error"<<std::endl;
    }
    if(g.checkPathGraph(2,7)){
        std::cout<<"Error"<<std::endl;
    }
    if(!g.checkPathGraph(2,5)){
        std::cout<<"Error"<<std::endl;
    }
    if(!g.checkPathGraph(5,2)){
        std::cout<<"Error"<<std::endl;
    }
    if(!g.checkPathGraph(0,4)){
        std::cout<<"Error"<<std::endl;
    }
    if(!g.checkPathGraph(0,8)){
        std::cout<<"Error"<<std::endl;
    }

    if(!g.checkPathGraph(0,0)){
        std::cout<<"Error"<<std::endl;
    }


    return 0;
}