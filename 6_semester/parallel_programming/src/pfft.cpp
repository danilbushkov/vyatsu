#include <pfft.h>

static int threads_num = thread::hardware_concurrency()-1; 
static mutex mtx;


void transformation(vector<complex<double>> &p, int start, int end, int d, complex<double> w, complex<double> wn) {

    for (int i = start; i < end; i++) {
        complex<double> t = w * p[i + d];
        p[i + d] = p[i] - t;
        p[i] = p[i] + t;
        w *= wn;

    }
}


void recursive_pfft(vector<complex<double>> &p, int start, int end, complex<double> wn) {
    int d = end - start;
    
    if (d > 1) {
        
        int k = (start + end) >> 1;

        
        if(threads_num > 0) {
            mtx.lock();
            if(threads_num > 0) {
                threads_num -= 1;
                mtx.unlock();
                thread pfft_thread(recursive_pfft, ref(p), start, k, wn*wn);
                recursive_pfft(p, k, end, wn * wn);

                pfft_thread.join();
                mtx.lock();
                threads_num += 1;
                mtx.unlock();
            } else {
                mtx.unlock();
                recursive_pfft(p, start, k, wn * wn);
                recursive_pfft(p, k, end, wn * wn);
            }
        } else {
            recursive_pfft(p, start, k, wn * wn);
            recursive_pfft(p, k, end, wn * wn);
        }
        


        if(d >= 4) {
            int df = d / 4;
            int s = start;
            int e = end - d/2 - df;
            complex<double> w = 1;
            for(int i = 0; i < 2; i++) {
                
                w = pow(wn, df*i);
                transformation(p, start + i*df, e + i*df, d/2, w, wn);
                
                
            }
            //transformation(p, s, e, d/2, w, wn);

        } else {
            transformation(p, start, end-d/2, d/2, 1, wn);
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

    if(threads_num > 0) {

        threads_num -= 1;
        thread fft1(fft, ref(cpoly1), w);

        fft(cpoly2, w);

        fft1.join();
        threads_num += 1;
    } else {
        fft(cpoly1, w);
        fft(cpoly2, w);
    }

    
    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / complex<double>(size, 0);
    }

    f = - 2 * M_PI / (size);
    w = complex<double>(cos(f), sin(f));
    fft(cresult, w);

    cpoly_to_dpoly(cresult, result);

    
}

void stub_fft(
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

    dpoly_to_cpoly(poly1, cpoly1);
    cpoly1.resize(size, complex<double>(0, 0));
    
    double f = 2 * M_PI;
    complex<double> w = complex<double>(cos(f), sin(f));
    fft(cpoly1, w);
}

void pfft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    pfft_mult(pfft, poly1, poly2, result);
}

void test_pfft(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    stub_fft(pfft, poly1, poly2, result);
}

void test_fft(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    stub_fft(fft, poly1, poly2, result);
}