#include "dft.h"


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

void dft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    
    
    int n = poly1.size();
    int m = poly2.size();

    if(n == 0 || m == 0) {
        return;
    }

    vector<complex<double>> cpoly1;
    vector<complex<double>> cpoly2;
    vector<complex<double>> cresult;

    dpoly_to_cpoly(poly1, cpoly1);
    dpoly_to_cpoly(poly2, cpoly2);

    cpoly1.resize(n+m-1, complex<double>(0, 0));
    cpoly2.resize(n+m-1, complex<double>(0, 0));
    cresult.resize(n+m-1, complex<double>(0, 0));

    

    vector<complex<double>> dft_poly1;
    vector<complex<double>> dft_poly2;
    vector<complex<double>> dft_poly(n+m-1, 0);

   

    dft(cpoly1, 1, 1, dft_poly1);
    dft(cpoly2, 1, 1, dft_poly2);

    for(int i = 0; i < n+m-1; i++) {
        dft_poly[i] = dft_poly1[i] * dft_poly2[i];
    }

    dft(dft_poly, cresult.size(), -1, cresult);

    
    cpoly_to_dpoly(cresult, result);
}