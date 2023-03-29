#include <vector>
#include <iostream>
#include <string>
#include <fstream>
#include <complex>

using namespace std;

void dpoly_to_cpoly(vector<double> &poly, vector<complex<double>> &result) {
    int n = poly.size();
    result.resize(n);
    for(int i = 0; i < n; i++) {
        result[i] = complex<double>(poly[i], 0);
    }
}

void cpoly_to_dpoly(vector<complex<double>> &poly, vector<double> &result) {
    int n = poly.size();
    result.resize(n);
    for(int i = 0; i < n; i++) {
        result[i] = real(poly[i]);
    }
}


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




void get_polys(std::ifstream &in, std::vector<double> &poly1, std::vector<double> &poly2) {
    int n = 0;
    in >> n;
    poly1.resize(n);
    poly2.resize(n);
    for(int i = 0; i < n; i++) {
        in >> poly1[i];
    }
    for(int i = 0; i < n; i++) {
        in >> poly2[i];
    }
}

void set_result(std::ofstream &out, std::vector<double> &poly) {
    out << poly.size() << '\n';
    
    for(int i = 0; i < poly.size(); i++) {
        out << poly[i] << ' ';
    }
}

void fft_iterative_(vector<complex<double>> &poly, double s) {
    int n = poly.size();
    if (n == 1)
        return;
    
    for(int i = 0; i < n; i++) {
        int rev_i = reverse_int(i, floor_power2(n-1));
        
        if(i < rev_i) {
            swap(poly[i], poly[rev_i]);
        }
        
    }
    // double f = s*2 * M_PI / (n);
    // complex<double> w1 = complex<double>(cos(f), sin(f));
    for(int i = floor_power2(n)-1; i >= 0; i--) {
        int num_seq = pow(2, i);
        
        double f = s*2 * M_PI / (n) * num_seq;
        complex<double> wn = complex<double>(cos(f), sin(f));
        
        //complex<double> wn = pow(w1, num_seq);
        int num_items = n / num_seq;
        for(int j = 0; j < num_seq; j++) {

            
            
            complex<double> w = 1;
            //pow(w1, num_seq);
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



void fft_mult_(
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

    
    

    fft(cpoly1, 1);
    fft(cpoly2, 1);

    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / complex<double>(size, 0);
    }

    
    fft(cresult, -1);

    cpoly_to_dpoly(cresult, result);

    
}











int main(int argc, char *argv[]) {
    const std::string path = std::string(getenv("HOME")) + "/tmp/test";
    
    
    std::ifstream in(path+"/input.txt");
    std::ofstream out(path+"/fft_output.txt");

    std::vector<double> poly1;
    std::vector<double> poly2;
    std::vector<double> result;

    if (in.is_open()) {
        get_polys(in, poly1, poly2);
    }
    in.close();
    
    fft_mult_(fft_iterative_ ,poly1, poly2, result);

    if (out.is_open()) {
        set_result(out, result);
    }
    out.close();



    return 0;
}







