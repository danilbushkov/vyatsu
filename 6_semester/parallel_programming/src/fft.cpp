#include <fft.h>
#include <iostream>



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
        complex<double> t = w * b[i];
        poly[i] = a[i] + t;
        poly[i + n / 2] = a[i] - t; 
        w *= wn;
    }
}

void recursive_fft(vector<complex<double>> &p, int start, int end, complex<double> wn) {
    int d = end - start;
    
    if (d > 1) {
        
        int k = (start + end) >> 1;
        recursive_fft(p, start, k, wn * wn);
        recursive_fft(p, k, end, wn * wn);
        complex<double> w = 1;
        for (int i = start; i < end - d/2; i++) {
            complex<double> t = w * p[i + d/2];
            p[i + d/2] = p[i] - t;
            p[i] = p[i] + t;
            w *= wn;

        }
        
    }
    
}


void fft(vector<complex<double>> &poly, complex<double> wn) {
    int n = poly.size();
    if (n == 1)
        return;
    
    for(int i = 0; i < n; i++) {
        int rev_i = reverse_int(i, floor_power2(n-1));
        
        if(i < rev_i) {
            swap(poly[i], poly[rev_i]);
        }
        
    }
    
    recursive_fft(poly, 0, n, wn);
}

struct fft_data {
    int start;
    int end;
    complex<double> w;
    bool v;
};

void fft_stack(vector<complex<double>> &poly, complex<double> wn) {
    int n = poly.size();
    if (n == 1)
        return;
    
    for(int i = 0; i < n; i++) {
        int rev_i = reverse_int(i, floor_power2(n-1));
        
        if(i < rev_i) {
            swap(poly[i], poly[rev_i]);
        }
        
    }
    
    stack<fft_data> s;
    fft_data data = {0, n, wn, false};
    s.push(data);

    while(!s.empty()) {
        data = s.top();
        s.pop();
        if(data.v) {
            complex<double> w = 1;
            int d = data.end - data.start;
            for (int i = data.start; i < data.end - d/2; i++) {
                complex<double> t = w * poly[i + d/2];
                poly[i + d/2] = poly[i] - t;
                poly[i] = poly[i] + t;
                w *= wn;
            }
        } else {
            data.v = true;
            s.push(data);
            int d = data.end - data.start;
            if (d > 1) {
                int k = (data.start + data.end) >> 1;
                s.push({data.start, k, wn * wn, false});
                s.push({k, data.end, wn * wn, false});
            }
        }
        
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

    fft(cpoly1, w);
    fft(cpoly2, w);

    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / complex<double>(size, 0);
    }

    f = - 2 * M_PI / (size);
    w = complex<double>(cos(f), sin(f));
    fft(cresult, w);

    cpoly_to_dpoly(cresult, result);

    
}



void fft_mult_alloc(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    fft_mult(fft_alloc, poly1, poly2, result);
}

void fft_mult_stack(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    fft_mult(fft_stack, poly1, poly2, result);
}

void fft_mult_recursive(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    fft_mult(fft, poly1, poly2, result);
}