#ifndef DFT_H
#define DFT_H

#include <complex>
#include <vector>

using namespace std;

void dft(vector<complex<double>> &poly, int k, double s, vector<complex<double>> &result);
void dft_mult(vector<complex<double>> &poly1, vector<complex<double>> &poly2, vector<complex<double>> &result);


#endif