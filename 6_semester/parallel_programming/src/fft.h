#ifndef FFT_H
#define FFT_H

#include <vector>
#include <complex>
#include <stack>
#include <lib.h>
#include <poly.h>
#include <print.h>

using namespace std;

void fft_alloc(vector<complex<double>> &poly, complex<double> wn);
void fft_mult_alloc(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void fft_mult_recursive(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void fft_mult_stack(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void fft(vector<complex<double>> &poly, complex<double> wn);
void fft_mult_iterative(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void fft_mult_iterative_(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void fft_iterative_(vector<complex<double>> &poly, double s);


#endif