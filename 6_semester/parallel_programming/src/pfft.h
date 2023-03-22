#ifndef PFFT_H
#define PFFT_H

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

using namespace std;

void pfft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);

void test_pfft(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void test_fft(vector<double> &poly1, vector<double> &poly2, vector<double> &result);
void transformation(vector<complex<double>> &p, int start, int end, int d, complex<double> w, complex<double> wn);

void stub_fft(
    void fft(vector<complex<double>> &, complex<double>),
    vector<double> &poly1, vector<double> &poly2, vector<double> &result
);



#endif