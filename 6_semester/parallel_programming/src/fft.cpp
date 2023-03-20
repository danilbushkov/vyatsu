#include <fft.h>
#include <iostream>


// void fft(vector<complex<double>> &poly, int k, double s, vector<complex<double>> &result) {
//     //преобразовать к n^2
//     //


// }

void fft_alloc(vector<complex<double>> &poly, complex<double> wn) {
    int n = poly.size();
    if (n == 1)
        return;
    
    vector<complex<double>> a(n / 2), b(n / 2);
    for (int i = 0; i < n / 2; i++) {
        a[i] = poly[2 * i];
        b[i] = poly[2 * i + 1];
    }
    

    fft_alloc(a, wn * wn);
    fft_alloc(b, wn * wn);
    
    complex<double> w = 1;
    for (int i = 0; i < n / 2; i++) {
        
        poly[i] = a[i] + w * b[i];
        poly[i + n / 2] = a[i] - w * b[i]; 
        w *= wn;
    }
}


void fft(vector<complex<double>> &poly, complex<double> wn) {
    int n = poly.size();
    if (n == 1)
        return;
    
    vector<complex<double>> a(n / 2), b(n / 2);
    for (int i = 0; i < n / 2; i++) {
        a[i] = poly[2 * i];
        b[i] = poly[2 * i + 1];
    }
    

    fft_alloc(a, wn * wn);
    fft_alloc(b, wn * wn);
    
    complex<double> w = 1;
    for (int i = 0; i < n / 2; i++) {
        
        poly[i] = a[i] + w * b[i];
        poly[i + n / 2] = a[i] - w * b[i]; 
        w *= wn;
    }
}




void fft_mult(
    void fft(vector<complex<double>> &, complex<double>),
    vector<double> &poly1, vector<double> &poly2, vector<double> &result
) {
    int n = poly1.size();
    int m = poly2.size();

    if(n == 0 || m == 0) {
        return;
    }

    int size = max(n, m);

    while(!has_one_bit(size)) {
        size++;
    }


    vector<complex<double>> cpoly1;
    vector<complex<double>> cpoly2;
    vector<complex<double>> cresult;

    dpoly_to_cpoly(poly1, cpoly1);
    dpoly_to_cpoly(poly2, cpoly2);

    cpoly1.resize(size*2, complex<double>(0, 0));
    cpoly2.resize(size*2, complex<double>(0, 0));
    cresult.resize(size*2, complex<double>(0, 0));

    
    double f = 2 * M_PI / (size*2);
    complex<double> w = complex<double>(cos(f), sin(f));

    fft(cpoly1, w);
    fft(cpoly2, w);

    for(int i = 0; i < size*2; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / complex<double>(size*2, 0);
    }

    f = - 2 * M_PI / (size*2);
    w = complex<double>(cos(f), sin(f));
    fft(cresult, w);

    cpoly_to_dpoly(cresult, result);

    
}



void fft_mult_alloc(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    fft_mult(fft_alloc, poly1, poly2, result);
}

void fft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    fft_mult(fft, poly1, poly2, result);
}