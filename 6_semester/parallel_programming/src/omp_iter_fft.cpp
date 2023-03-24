#include <omp_iter_fft.h>





void omp_iter_pfft(vector<complex<double>> &poly, double s) {
    int n = poly.size();
    if (n == 1)
        return;
    
    #pragma omp parallel for
    for(int i = 0; i < n; i++) {
        int rev_i = reverse_int(i, floor_power2(n-1));
        
        if(i < rev_i) {
            swap(poly[i], poly[rev_i]);
        }
        
    }
    

    for(int i = floor_power2(n)-1; i >= 0; i--) {
        int num_seq = pow(2, i);
        
        double f = s*2 * M_PI / (n) * num_seq;
        complex<double> wn = complex<double>(cos(f), sin(f));
        
        int num_items = n / num_seq;

        
        
        #pragma omp parallel for
        for(int j = 0; j < num_seq; j++) {

        
        
            complex<double> w = 1;
            
            int s = num_items*j;
            int e = s + num_items/2;
            
            for(int k = s; k < e; k++) {
                
                complex<double> t = w * poly[k + num_items/2];
                poly[k+num_items/2] = poly[k] - t;
                poly[k] = poly[k] + t;
                w *= wn;
            }
        }
        
        
        
        
        
    }

    
}


void omp_iter_pfft_mult(
    void fft(vector<complex<double>> &, double s),
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

    
    #pragma omp parallel
    {
        #pragma omp single 
        {

        
            #pragma omp task
            {
                    fft(cpoly1, 1);
            }
            #pragma omp task
            {
                    fft(cpoly2, 1);
            }
            #pragma omp taskwait
        }
        
    }
    
    
    
    #pragma omp parallel for
    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / complex<double>(size, 0);
    }

    
    
    fft(cresult, -1);
    
    cpoly_to_dpoly(cresult, result);
    

    
}




void omp_iter_fft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    omp_iter_pfft_mult(omp_iter_pfft, poly1, poly2, result);
}

