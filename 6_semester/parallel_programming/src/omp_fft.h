#ifndef OMP_FFT_H
#define OMP_FFT_H

#include <vector>
#include <complex>
#include <stack>
#include <lib.h>
#include <poly.h>
#include <print.h>
#include <thread>
#include <functional>
#include <mutex>
#include <fft.h>
#include <pfft.h>

using namespace std;

void omp_fft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);

void test_omp_fft(vector<double> &poly1, vector<double> &poly2, vector<double> &result);

#endif