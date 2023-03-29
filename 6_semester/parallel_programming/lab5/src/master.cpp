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
        out << round(poly[i]) << ' ';
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


void fft(int tid, int msgtag, int n, std::complex<double> *poly, double s) {


    double *data = (double *) poly;

    

    pvm_initsend(PvmDataDefault);
    pvm_pkint(&n, 1, 1);
    pvm_send(tid, msgtag);

    pvm_initsend(PvmDataDefault);
    pvm_pkdcplx(data, n, 1);
    pvm_send(tid, msgtag);

    pvm_initsend(PvmDataDefault);
    pvm_pkdouble(&s, 1, 1);
    pvm_send(tid, msgtag);
    

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



    dpoly_to_cpoly(poly1, size, cpoly1);
    dpoly_to_cpoly(poly2, size, cpoly2);

    double *data = (double *) cpoly1;
    
    
    int msgtag = 1;
    fft(tids[0], msgtag, size, cpoly1, 1);
    fft(tids[1], msgtag, size, cpoly2, 1);


    

    
    pvm_recv(tids[0], msgtag);
    pvm_upkdcplx(data, n, 1);

    data = (double *) cpoly2;
    pvm_recv(tids[1], msgtag);
    pvm_upkdcplx(data, n, 1);

    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / std::complex<double>(size, 0);
    }

    
    fft(tids[2], msgtag, size, cresult, -1);

    data = (double *) cresult;
    pvm_recv(tids[2], msgtag);
    pvm_upkdcplx(data, n, 1);

    

    cpoly_to_dpoly(size, cresult, result);

    delete[] cpoly1;
    delete[] cpoly2;
    delete[] cresult;
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
    

    


    if (out.is_open()) {
        set_result(out, result);
    }
    out.close();
    

    pvm_exit();
    
    
    return 0;
}