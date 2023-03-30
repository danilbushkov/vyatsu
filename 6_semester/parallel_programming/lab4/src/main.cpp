#include <iostream>
#include <vector>
#include <complex>
#include <fstream>
#include <mpi.h>
#include "slave.h"

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



void fft(int tid, int msgtag, int n, std::complex<double> *poly, double s) {


    double *data = (double *) poly;

    

    // pvm_initsend(PvmDataDefault);
    // pvm_pkint(&n, 1, 1);
    // pvm_send(tid, msgtag);

    // pvm_initsend(PvmDataDefault);
    // pvm_pkdcplx(data, n, 1);
    // pvm_send(tid, msgtag);

    // pvm_initsend(PvmDataDefault);
    // pvm_pkdouble(&s, 1, 1);
    // pvm_send(tid, msgtag);
    

}



void fft_mult(
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
    
    
    MPI_Status status;
    double s = 1;
    MPI_Send(&size, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
    MPI_Send(cpoly1, size, MPI_DOUBLE_COMPLEX, 1, 0, MPI_COMM_WORLD);
    MPI_Send(&s, 1, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD);

    //fft_iterative(cpoly1, size, 1);
    fft_iterative(cpoly2, size, 1);

    MPI_Recv(cpoly1, size, MPI_DOUBLE_COMPLEX, 1, 0, MPI_COMM_WORLD, &status);




    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / std::complex<double>(size, 0);
    }
    

    
    fft_iterative(cresult, size, -1);
    

    cpoly_to_dpoly(size, cresult, result);

    delete[] cpoly1;
    delete[] cpoly2;
    delete[] cresult;
}


void master() {
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
    
    

    
    fft_mult(poly1, poly2, result);

    
    

    if (out.is_open()) {
        set_result(out, result);
    }
    out.close();
}




int main(int argc, char** argv) {
    int rank;
    MPI_Init(&argc, &argv);


    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    if(rank == 0) {
        master();
    } else {
        slave();
    }
    
    

    MPI_Finalize();
    
    
    return 0;
}