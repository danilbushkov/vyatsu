#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <chrono>
#include <complex>

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
        if(poly1[i] != 0) {
            for(int j = 0; j < m; j++) {
                result[i+j] = result[i+j] + poly1[i] * poly2[j];
            }
        }
        
    }

    auto end = chrono::steady_clock::now();

    print_time("polynomial_multiplication", start, end);

}

void dft(vector<complex<double>> &poly, int k, double s, vector<complex<double>> &result) {
    int n = poly.size();
    result.resize(n, complex<double>(0, 0));

    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            double f = s * 2 * M_PI * j * i / n;
            result[i] = result[i] + poly[j] * complex<double>(cos(f), sin(f));
        }   
        result[i] = result[i] / complex<double>(k, 0);
        
    }
}

void dft_mult(vector<complex<double>> &poly1, vector<complex<double>> &poly2, vector<complex<double>> &result) {
    int n = poly1.size();
    int m = poly2.size();

    if(n == 0 || m == 0) {
        return;
    }

    poly1.resize(n+m-1, complex<double>(0, 0));
    poly2.resize(n+m-1, complex<double>(0, 0));
    result.resize(n+m-1, complex<double>(0, 0));

    vector<complex<double>> dft_poly1;
    vector<complex<double>> dft_poly2;
    vector<complex<double>> dft_poly(n+m-1, 0);

    auto start = chrono::steady_clock::now();

    dft(poly1, 1, 1, dft_poly1);
    dft(poly2, 1, 1, dft_poly2);

    for(int i = 0; i < n+m-1; i++) {
        dft_poly[i] = dft_poly1[i] * dft_poly2[i];
    }

    dft(dft_poly, result.size(), -1, result);

    auto end = chrono::steady_clock::now();

    print_time("dft_mult", start, end);

}

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




void print_poly(vector<double> &poly) {
    for(auto item: poly) {
        cout << round(item) << " ";
    }
    cout << endl;
}

void print_complex_poly(vector<complex<double>> &poly) {
    for(auto item: poly) {
        cout << round(real(item)) << " ";
    }
    cout << endl;
}

void get_random_poly(vector<double> &poly, int size, int min = -100, int max = 100) {
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


int main() {

    vector<double> result;
    vector<double> dft_mult_result;
    //vector<double> poly1 = {10, 2, 3, 10, 21};
    //vector<double> poly2 = {4, 3, 3, 4};
    vector<double> poly1;
    vector<double> poly2;
    get_random_poly(poly1, 10000);
    get_random_poly(poly2, 10000);
    polynomial_multiplication(poly1, poly2, result);
    //print_poly(result);

    vector<complex<double>> cpoly1;
    vector<complex<double>> cpoly2;
    vector<complex<double>> cresult;
    dpoly_to_cpoly(poly1, cpoly1);
    dpoly_to_cpoly(poly2, cpoly2);
    dft_mult(cpoly1, cpoly2, cresult);
    cpoly_to_dpoly(cresult, dft_mult_result);

    if(!check_equal(result, dft_mult_result)) {
        cout << "Error: dft_mult and simple_mult are not equal" << endl;
    }






    //print_complex_poly(cresult);


    // vector<double> poly1 = {4, 3, 2, 1, 0, 0, 0, 0};
    // vector<complex<double>> cpoly1;
    // vector<complex<double>> result;
    // dpoly_to_cpoly(poly1, cpoly1);
    // dft(cpoly1, result);
    // print_complex_poly(result);


    return 0;
}





