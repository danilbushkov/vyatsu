#include <pvm3.h>
#include <iostream>
#include <vector>
#include <complex>
#include <fstream>

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



void dpoly_to_cpoly(std::vector<double> poly, int rn, std::complex<double> *result) {
    int n = poly.size();
    for(int i = 0; i < n; i++) {
        result[i] = std::complex<double>(poly[i], 0);
    }
}

void cpoly_to_dpoly(int n, std::complex<double> *poly, std::vector<double> &result) {
    
    result.resize(n);
    for(int i = 0; i < n; i++) {
        result[i] = real(poly[i]);
    }
}


bool has_one_bit(int num) {
    int count = 0;
    while(num > 0) {
        count = count + (num & 1);
        num = num >> 1;
    }

    return count == 1;
}


void fft(int tid, int n, std::complex<double> *poly, double s) {

    int msgtag = 1;

    double *data = (double *) poly;

    

    pvm_initsend(PvmDataDefault);
    pvm_pkint(&n, 1, 1);
    pvm_send(tid, msgtag);
    pvm_pkdcplx(data, n, 1);
    pvm_send(tid, msgtag);
    pvm_pkdouble(&s, 1, 1);
    pvm_send(tid, msgtag);

    pvm_recv(tid, msgtag);
    pvm_upkdcplx(data, n, 1);
    

}



void fft_mult(
    int ntids, int *tids,
    std::vector<double> &poly1, std::vector<double> &poly2, std::vector<double> &result) {
    int n = poly1.size();
    int m = poly2.size();

    if(n == 0 || m == 0) {
        return;
    }

    int size = 0;
    if(n > m) {
        size = n;
    } else {
        size = m;
    }

    while(!has_one_bit(size)) {
        size++;
    }

    size *= 2;

    std::complex<double> *cpoly1 = new std::complex<double>[size];
    std::complex<double> *cpoly2 = new std::complex<double>[size];
    std::complex<double> *cresult = new std::complex<double>[size];


    for(int i = 0; i < size; i++) {
        std::cout << cpoly1[i] << std::endl;
    }

    dpoly_to_cpoly(poly1, size, cpoly1);
    dpoly_to_cpoly(poly2, size, cpoly2);


    
    

    fft(tids[0], size, cpoly1, 1);
    fft(tids[1], size, cpoly2, 1);

    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / std::complex<double>(size, 0);
    }

    
    fft(tids[2], size, cresult, -1);

    cpoly_to_dpoly(size, cresult, result);


}




int main(int argc, char** argv) {
    int cc;
    int tids[3];
    const std::string path = std::string(getenv("HOME")) + "/tmp/test";
    
    std::ifstream in(path+"/input.txt");
    std::ofstream out(path+"/output.txt");

    std::vector<double> poly1;
    std::vector<double> poly2;
    std::vector<double> result;

    if (in.is_open()) {
        get_polys(in, poly1, poly2);
    }
    in.close();
    
    

    cc = pvm_spawn("slave", (char**)0, 0, "", 3, tids);
    
    if(cc == 3) {

        fft_mult(3, tids, poly1, poly2, result);


        
    } else {
       std::cout << "Error" << std::endl;
    }
    

    std::cout << "sssssssssssss" << std::endl;


    if (out.is_open()) {
        set_result(out, result);
    }
    out.close();
    

    pvm_exit();
    
    
    return 0;
}