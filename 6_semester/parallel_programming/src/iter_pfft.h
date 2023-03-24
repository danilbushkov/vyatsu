#ifndef ITER_PFFT_H
#define ITER_FFT_H

#include <vector>
#include <complex>
#include <stack>
#include <lib.h>
#include <poly.h>
#include <print.h>
#include <fft.h>

using namespace std;

void iter_pfft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);

#endif