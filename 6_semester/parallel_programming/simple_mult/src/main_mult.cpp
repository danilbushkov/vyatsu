#include <vector>
#include <iostream>
#include <string>
#include <fstream>
#include <vector>


void poly_mult(std::vector<double> &poly1, std::vector<double> &poly2, std::vector<double> &result) {
    int n = poly1.size();
    int m = poly2.size();

    if(n == 0 || m == 0) {
        return;
    }
    result.resize(n+m-1, 0);

    for(int i = 0; i < n; i++) {
        if(poly1[i] != 0) {
            for(int j = 0; j < m; j++) {
                result[i+j] = result[i+j] + poly1[i] * poly2[j];
            }
        }
        
    }


}

void get_polys(std::ifstream &in, std::vector<double> &poly1, std::vector<double> &poly2) {
    int n = 0;
    in >> n;
    poly1.resize(n);
    poly2.resize(n);
    for(int i = 0; i < n; i++) {
        in >> poly1[i];
    }
    for(int i = 0; i < n; i++) {
        in >> poly2[i];
    }
}

void set_result(std::ofstream &out, std::vector<double> &poly) {
    out << poly.size() << '\n';
    
    for(int i = 0; i < poly.size(); i++) {
        out << poly[i] << ' ';
    }
}


int main(int argc, char *argv[]) {
    const std::string path = std::string(getenv("HOME")) + "/tmp/test";
    
    
    std::ifstream in(path+"/input.txt");
    std::ofstream out(path+"/mult_output.txt");

    std::vector<double> poly1;
    std::vector<double> poly2;
    std::vector<double> result;

    if (in.is_open()) {
        get_polys(in, poly1, poly2);
    }
    in.close();
    
    poly_mult(poly1, poly2, result);

    if (out.is_open()) {
        set_result(out, result);
    }
    out.close();



    return 0;
}







