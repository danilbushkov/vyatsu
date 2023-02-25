#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <chrono>

using namespace std;

void print_time(string task, 
                chrono::steady_clock::time_point start, 
                chrono::steady_clock::time_point end) {
    auto ms = chrono::duration_cast<chrono::milliseconds>(end - start).count();
    auto sec = chrono::duration_cast<chrono::seconds>(end - start).count();
    auto min = chrono::duration_cast<chrono::minutes>(end - start).count();
    cout << "Task: " << task << "\n";
    cout << "    Time in sec: " << ms / 1000 << "\n";
    cout << "    Time in min:sec:ms: " << min << ":" << sec - min*60 << ":" << ms % 1000 << "\n";
    cout << "\n";
}


// a0x^0 + a1x^1 + ... + an-1^n-1 
void polynomial_multiplication(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    int n = poly1.size();
    int m = poly2.size();

    if(n == 0 || m == 0) {
        return;
    }
    result.resize(n+m-1, 0);

    auto start = chrono::steady_clock::now();

    for(int i = 0; i < n; i++) {
        for(int j = 0; j < m; j++) {
            result[i+j] = result[i+j] + poly1[i] * poly2[j];
        }
    }

    auto end = chrono::steady_clock::now();

    print_time("polynomial_multiplication", start, end);

}




void print_poly(vector<double> &poly) {
    for(auto item: poly) {
        cout << round(item) << " ";
    }
    cout << endl;
}

void getRandomPoly(vector<double> &poly, int size, int min = -100, int max = 100) {
    poly.reserve(size);
    for(int i = 0; i < size; i++) {
        int item = min + rand() % ((max + 1) - min);
        poly.push_back((double) item);
    }
    
}


int main() {

    vector<double> result;
    vector<double> poly1;
    vector<double> poly2;
    getRandomPoly(poly1, 60000);
    getRandomPoly(poly2, 60000);
    polynomial_multiplication(poly1, poly2, result);

    //print_poly(result);

    return 0;
}





