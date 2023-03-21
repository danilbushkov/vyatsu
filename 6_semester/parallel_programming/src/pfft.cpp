#include <pfft.h>


void recursive_pfft(vector<complex<double>> &p, int start, int end, complex<double> wn) {
    int d = end - start;
    
    if (d > 1) {
        
        int k = (start + end) >> 1;
        recursive_pfft(p, start, k, wn * wn);
        recursive_pfft(p, k, end, wn * wn);
        complex<double> w = 1;
        for (int i = start; i < end - d/2; i++) {
            complex<double> t = w * p[i + d/2];
            p[i + d/2] = p[i] - t;
            p[i] = p[i] + t;
            w *= wn;

        }
        
    }
    
}


void pfft(vector<complex<double>> &poly, complex<double> wn) {
    int n = poly.size();
    if (n == 1)
        return;
    
    for(int i = 0; i < n; i++) {
        int rev_i = reverse_int(i, floor_power2(n-1));
        
        if(i < rev_i) {
            swap(poly[i], poly[rev_i]);
        }
        
    }
    
    recursive_pfft(poly, 0, n, wn);
}


void pfft_mult(
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

    size *= 2;

    vector<complex<double>> cpoly1;
    vector<complex<double>> cpoly2;
    vector<complex<double>> cresult;

    dpoly_to_cpoly(poly1, cpoly1);
    dpoly_to_cpoly(poly2, cpoly2);

    cpoly1.resize(size, complex<double>(0, 0));
    cpoly2.resize(size, complex<double>(0, 0));
    cresult.resize(size, complex<double>(0, 0));

    
    double f = 2 * M_PI / (size);
    complex<double> w = complex<double>(cos(f), sin(f));

    thread fft1(fft, ref(cpoly1), w);
    fft(cpoly2, w);

    fft1.join();

    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / complex<double>(size, 0);
    }

    f = - 2 * M_PI / (size);
    w = complex<double>(cos(f), sin(f));
    fft(cresult, w);

    cpoly_to_dpoly(cresult, result);

    
}


void pfft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    pfft_mult(pfft, poly1, poly2, result);
}