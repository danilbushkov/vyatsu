#include "lib.h"


int main() {

    int msgtag = 1;
    int ptid;
    int n;
    double s;
    ptid = pvm_parent();
    

    pvm_recv(ptid, msgtag);
    pvm_upkint(&n, 1, 1);
    
    double *poly = new double[n*2];

    pvm_recv(ptid, msgtag);
    pvm_upkdcplx(poly, n, 1);

    pvm_recv(ptid, msgtag);
    pvm_upkdouble(&s, 1, 1);


    std::complex<double> *cdata = (std::complex<double> *) poly;
    
    
    fft_iterative(cdata, n, s);
    
    
    
    pvm_initsend(PvmDataDefault);
    pvm_pkdcplx(poly, n, 1);
    pvm_send(ptid, msgtag);


    pvm_exit();
    
    delete[] poly;

    return 0;
}