#include <iter_pfft.h>



static int threads_num = thread::hardware_concurrency()-1; 
static mutex mtx;


// void transformation(vector<complex<double>> &p, int start, int end, int d, complex<double> w, complex<double> wn) {

//     for (int i = start; i < end; i++) {
//         complex<double> t = w * p[i + d];
//         p[i + d] = p[i] - t;
//         p[i] = p[i] + t;
//         w *= wn;

//     }
// }

void sequence_transformation(vector<complex<double>> &poly, int start, int end, int num_items, complex<double> wn) {
    
    for(int j = start; j < end; j++) {

            
            
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


void iter_pfft(vector<complex<double>> &poly, double s) {
    int n = poly.size();
    if (n == 1)
        return;
    
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

        if(threads_num > 0 && num_seq/2!=0) {
            mtx.lock();
            if(threads_num > 0) {
                threads_num--;
                mtx.unlock();
                int tmp = num_seq / 2;
                thread seq_thread(sequence_transformation, ref(poly), 0, tmp, num_items, wn);

                sequence_transformation(poly, tmp, num_seq, num_items, wn);
                seq_thread.join();

                mtx.lock();
                threads_num++;
                mtx.unlock();
            } else {
                mtx.unlock();
                sequence_transformation(poly, 0, num_seq, num_items, wn);
            }
            
        } else {
            sequence_transformation(poly, 0, num_seq, num_items, wn);
        }
        
        
    }

    
}


void iter_pfft_mult(
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

    
    if(threads_num > 0) {
        threads_num--;
        thread fft_thread(fft, ref(cpoly1), 1);

        fft(cpoly2, 1);

        fft_thread.join();
        threads_num++;
    } else {
        fft(cpoly1, 1);
        fft(cpoly2, 1);
    }
    

    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / complex<double>(size, 0);
    }

    
    fft(cresult, -1);

    cpoly_to_dpoly(cresult, result);

    
}


void stub_iter_fft(
    void fft(vector<complex<double>> &, double),
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
    
    fft(cpoly1, 1);
}

void iter_pfft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    iter_pfft_mult(iter_pfft, poly1, poly2, result);
}

void test_iter_pfft(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    stub_iter_fft(iter_pfft, poly1, poly2, result);
}

void test_iter_fft(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    stub_iter_fft(fft_iterative_, poly1, poly2, result);
}