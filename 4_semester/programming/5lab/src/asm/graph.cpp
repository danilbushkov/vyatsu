#include <windows.h>
#include "graph.h"

using FUNC = int(*)(int,int,int[25][25],int) ;

int Graph::checkPathGraph(int a, int b){
    HINSTANCE hDLL;
    FUNC func;
    int res = 0;
    hDLL = LoadLibrary("graph.dll");
    if(hDLL != NULL){
        func = (FUNC)GetProcAddress(hDLL,"DFS"); 
        if(func!= NULL) 
        {      
            res=(*func)(a,b,mass,size);
        }  
        FreeLibrary(hDLL);
    }else{
        MessageBoxExW(0, L"Не найдена библиотека graph.dll", L"Ошибка", 0, MB_APPLMODAL);
        return 2;
    }

    return res;

}



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

// int Graph::checkPathGraph(int a, int b){
//     // visitedGraphNull();
//     // if((a == b) && (mass[a][b]==1) ){
//     //     return 1;
//     // }
//     // int c = DFS(a, b);

//    // return DFS();

// }

// int Graph::DFS(int a, int b){
//     visitedGraph[a]=1;
//     for(int i = 0;i<size;i++){
//         if(mass[a][i]==1){
//             if(i == b){
//                 return 1;
//             }else{
//                 if(visitedGraph[i]==0){
//                     if(DFS(i,b)){
//                         return 1;
//                     }
//                 }
//             }
//         }
//     }

//     return 0;
// }