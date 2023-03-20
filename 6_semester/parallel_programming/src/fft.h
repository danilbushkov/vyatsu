#ifndef FFT_H
#define FFT_H

#include <vector>
#include <complex>
#include <lib.h>
#include <poly.h>
#include <print.h>

using namespace std;

void fft_alloc(vector<complex<double>> &poly, complex<double> wn);
void fft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void fft_mult_alloc(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void fft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);

#endif