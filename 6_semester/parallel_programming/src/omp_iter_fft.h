#ifndef OMP_ITER_FFT_H
#define OMP_ITER_FFT_H

#include <vector>
#include <complex>
#include <omp.h>


#include "lib.h"
#include "poly.h"
#include "print.h"

#include "fft.h"
#include "pfft.h"



using namespace std;

void omp_iter_fft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);



#endif