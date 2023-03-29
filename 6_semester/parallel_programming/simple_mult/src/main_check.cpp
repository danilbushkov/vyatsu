#include <vector>
#include <iostream>
#include <string>
#include <fstream>
#include <vector>


void get_poly(std::ifstream &in, std::vector<double> &p) {
    int n;
    in >> n;
    p.resize(n);
    for(int i = 0; i < n; i++) {
        in >> p[i];
    }
}



int main(int argc, char *argv[]) {
    const std::string path = std::string(getenv("HOME")) + "/tmp/test";
    

    std::ifstream in1(path+"/output.txt");
    std::ifstream in2(path+"/mult_output.txt");

    std::vector<double> p1;
    std::vector<double> p2;
    

    if (in1.is_open()) {
        get_poly(in1, p1);
    }
    in1.close();
    
    if (in2.is_open()) {
        get_poly(in2, p2);
    }
    in2.close();

    for(int i = 0; i < p2.size(); i++) {
        if(p1[i] != p2[i]) {
            std::cout << "Not equal" << std::endl;
            return 0;
        }
    }

    return 0;
}