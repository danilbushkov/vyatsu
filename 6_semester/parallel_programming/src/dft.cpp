#include <dft.h>


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

   

    dft(poly1, 1, 1, dft_poly1);
    dft(poly2, 1, 1, dft_poly2);

    for(int i = 0; i < n+m-1; i++) {
        dft_poly[i] = dft_poly1[i] * dft_poly2[i];
    }

    dft(dft_poly, result.size(), -1, result);

    

}