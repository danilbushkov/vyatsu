#include <pvm3.h>
#include <iostream>
#include <unistd.h>
#include <cstring>
#include <complex>

int floor_power2(int num) {
    int result = 0;
    for(; num > 1; num=num>>1, result++);
    return result;
}


int reverse_int(int num, int p) {
    int result = 0;
    for(int i = 0; i <= p; i++) {
        result |= ( (num >> i) & 1) << (p - i);
    }
    return result;
}

bool has_one_bit(int num) {
    int count = 0;
    while(num > 0) {
        count = count + (num & 1);
        num = num >> 1;
    }

    return count == 1;
}

void fft_iterative(std::complex<double> *poly, int n, double s) {
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
        std::complex<double> wn = std::complex<double>(cos(f), sin(f));
        
        int num_items = n / num_seq;
        for(int j = 0; j < num_seq; j++) {

            
            
            std::complex<double> w = 1;
            
            int s = num_items*j;
            int e = s + num_items/2;
            
            for(int k = s; k < e; k++) {
                
                std::complex<double> t = w * poly[k + num_items/2];
                poly[k+num_items/2] = poly[k] - t;
                poly[k] = poly[k] + t;
                w *= wn;
            }
        }
    }

    
}


int main() {

    int msgtag = 1;
    int ptid;
    int n;
    int s;
    ptid = pvm_parent();
    

    pvm_recv(ptid, msgtag);
    pvm_upkint(&n, 1, 1);
    
    double *poly = new double[n*2];

    pvm_recv(ptid, msgtag);
    pvm_upkdcplx(poly, n, 1);

    pvm_recv(ptid, msgtag);
    pvm_upkint(&s, 1, 1);

    std::complex<double> *cdata = (std::complex<double> *) poly;
    for(int i = 0; i < n; i++) {
        std::cout << cdata[i] << std::endl;
    }
    
    fft_iterative(cdata, n, s);
    
    std::cout << "After:" << std::endl;
    for(int i = 0; i < n; i++) {
        std::cout << cdata[i] << std::endl;
    }
    
    pvm_initsend(PvmDataDefault);
    pvm_pkdcplx(poly, n, 1);
    pvm_send(ptid, msgtag);


    pvm_exit();
    
    delete[] poly;

    return 0;
}