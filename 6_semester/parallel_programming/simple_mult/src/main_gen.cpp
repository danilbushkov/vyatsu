#include <vector>
#include <iostream>
#include <string>
#include <fstream>
#include <vector>


void get_random_poly(std::vector<double> &poly, int size, int min, int max) {
    
    poly.reserve(size);
    for(int i = 0; i < size; i++) {
        int item = min + rand() % ((max + 1) - min);
        poly.push_back((double) item);
    }
    
}


int main(int argc, char *argv[]) {
    const std::string path = std::string(getenv("HOME")) + "/tmp/test";
    

    if(argc != 2) {
        std::cout << "Need one arg: number of elements" << std::endl;
    } else {

        int n = atoi(argv[1]);
        std::ofstream out(path+"/input.txt");
        std::vector<double> v1;
        std::vector<double> v2;
        get_random_poly(v1, n, -100, 100);
        get_random_poly(v2, n, -100, 100);

        if (out.is_open()) {
            out << n << '\n';
            for(int i = 0; i < n; i++) {
                out << v1[i] << " ";
            }
            out << '\n';
            for(int i = 0; i < n; i++) {
                out << v2[i] << " ";
            }
        }
        out.close();
    }



    return 0;
}