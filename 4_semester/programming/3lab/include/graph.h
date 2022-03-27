#ifndef GRAPH_H
#define GRAPH_H


class Graph{
    public:
        int mass[25][25];
        int size;
        int visitedGraph[25];

        Graph();
        Graph(int mass[25][25],int size);
        int DFS(int a, int b);
        void SetGraph(int mass[25][25],int size);
        int checkPathGraph(int a, int b);
        void visitedGraphNull();
};



#endif