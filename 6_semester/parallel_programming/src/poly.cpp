#include <poly.h>


void dpoly_to_cpoly(vector<double> &poly, vector<complex<double>> &result) {
    int n = poly.size();
    result.resize(n);
    for(int i = 0; i < n; i++) {
        result[i] = complex<double>(poly[i], 0);
    }
}

void cpoly_to_dpoly(vector<complex<double>> &poly, vector<double> &result) {
    int n = poly.size();
    result.resize(n);
    for(int i = 0; i < n; i++) {
        result[i] = real(poly[i]);
    }
}






void get_random_poly(vector<double> &poly, int size, int min, int max) {
    srand (time(NULL));
    poly.reserve(size);
    for(int i = 0; i < size; i++) {
        int item = min + rand() % ((max + 1) - min);
        poly.push_back((double) item);
    }
    
}

bool check_equal(vector<double> &poly1, vector<double> &poly2) {
    for(int i = 0; i < poly1.size(); i++) {
        if(round(poly1[i]) != round(poly2[i])) {
            return false;
        }
    }
    return true;
}
