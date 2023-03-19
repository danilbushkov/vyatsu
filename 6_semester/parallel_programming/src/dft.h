#ifndef DFT_H
#define DFT_H

#include <complex>
#include <vector>
#include <poly.h>

using namespace std;

void dft(vector<complex<double>> &poly, int k, double s, vector<complex<double>> &result);
void dft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);


#endif