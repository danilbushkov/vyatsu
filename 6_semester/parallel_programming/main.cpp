#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <ctime>

using namespace std;

void print_time(string task, clock_t time) {
    clock_t sec = time / CLOCKS_PER_SEC;
    clock_t min = sec / 60;
    cout << "Task: " << task << "\n";
    cout << "    Time in sec: " << sec << "\n";
    cout << "    Time in min:sec: " << min << ":" << sec - min*60 <<"\n";
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

    clock_t start = clock();

    for(int i = 0; i < n; i++) {
        for(int j = 0; j < m; j++) {
            result[i+j] = result[i+j] + poly1[i] * poly2[j];
        }
    }

    clock_t end = clock();

    print_time("polynomial_multiplication", end-start);

}




void print_poly(vector<double> &poly) {
    for(auto item: poly) {
        cout << round(item) << " ";
    }
    cout << endl;
}



int main() {

    cout << "Hello, world" << endl;
    vector<double> result;
    vector<double> poly1 = {1, 2, 3, 4, 7};
    vector<double> poly2 = {6, 4, 2};
    polynomial_multiplication(poly1, poly2, result);

    print_poly(result);

    return 0;
}





