#include <omp_fft.h>





void recursive_omp_fft(vector<complex<double>> &p, int start, int end, complex<double> wn) {
    int d = end - start;
    
    if (d > 1) {
        
        int k = (start + end) >> 1;

        
        
        #pragma omp task shared(p)
        {
            recursive_omp_fft(p, start, k, wn * wn);
        }
        #pragma omp task shared(p)
        {
            recursive_omp_fft(p, k, end, wn * wn);
        }
        
        #pragma omp taskwait
           
        
        //int n = 8;
        //if(d >= n*2) {
        
        
        //if(d >= n*2) {
            
            
        int n = 8;
        if(d >= n*2) {
            vector<thread> threads;
            int df = d / (2*n);
            int e = end - d/2 - df*(n-1);
            complex<double> w = 1;
            
            #pragma omp parallel shared(p)
            {
                #pragma omp for 
                for(int i = 0; i < n; i++) {
                    
                    transformation(p, start + i*df, e + i*df, d/2, pow(wn, df*i), wn);
                
                
                }
            }
            

        } else {
            
            transformation(p, start, end-d/2, d/2, 1, wn);
        }
            
        
            
        
        
    }
    
}


void omp_fft(vector<complex<double>> &poly, complex<double> wn) {
    int n = poly.size();
    if (n == 1)
        return;
    
    for(int i = 0; i < n; i++) {
        int rev_i = reverse_int(i, floor_power2(n-1));
        
        if(i < rev_i) {
            swap(poly[i], poly[rev_i]);
        }
        
    }
    
    
    
    recursive_omp_fft(poly, 0, n, wn);
    
    
    
}


void omp_fft_mult(
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

    #pragma omp parallel shared(cpoly1, cpoly2)
    {
        #pragma omp single
        {
            #pragma omp task 
            {
                fft(cpoly1, w);
            }
            
            #pragma omp task 
            {
               fft(cpoly2, w);
            }
            
            
        
        }
        
    }
    
    // fft(cpoly1, w);
    // fft(cpoly2, w);

    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / complex<double>(size, 0);
    }

    f = - 2 * M_PI / (size);
    w = complex<double>(cos(f), sin(f));
    #pragma omp parallel shared(cresult)
    {
        #pragma omp single
        {
            fft(cresult, w);
        }
    }

    cpoly_to_dpoly(cresult, result);

    
}



void omp_fft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    omp_fft_mult(omp_fft, poly1, poly2, result);
}

void test_omp_fft(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    stub_fft(omp_fft, poly1, poly2, result);
}

