#include "graph.h"

void Graph::visitedGraphNull(){
    for(int i=0;i<25;i++){
        this->visitedGraph[i]=0;
    }
}

Graph::Graph(){
    for(int i=0;i<25;i++){
        for(int j=0;j<25;j++){
            this->mass[i][j]=0;
        }
    }
    visitedGraphNull();
}


Graph::Graph(int mass[25][25],int size){

    Graph();


    for(int i=0;i<size;i++){
        for(int j=0;j<size;j++){
            this->mass[i][j]=mass[i][j];
        }
    }
    this->size = size;
}
void Graph::SetGraph(int mass[25][25], int size){
    for(int i=0;i<size;i++){
        for(int j=0;j<size;j++){
            this->mass[i][j]=mass[i][j];
        }
    }
    this->size = size;
}

int Graph::checkPathGraph(int a, int b){
    visitedGraphNull();
    if(a == b){
        return 1;
    }
    int c = DFS(a, b);

    return c;
}

int Graph::DFS(int a, int b){
    int r;
    visitedGraph[a]=1;
    for(int i = 0;i<size;i++){
        if(i!=a && mass[a][i]==1 && visitedGraph[i]==0){
            if(i == b){
                return 1;
            }else{
                if(DFS(i,b)){
                    return 1;
                }
            }
        }
    }

    return 0;
}