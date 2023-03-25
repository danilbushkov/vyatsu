#ifndef POLY_H
#define POLY_H

#include <complex>
#include <vector>


using namespace std;


void dpoly_to_cpoly(vector<double> &poly, vector<complex<double>> &result);
void cpoly_to_dpoly(vector<complex<double>> &poly, vector<double> &result);
void get_random_poly(vector<double> &poly, int size, int min = -100, int max = 100);
bool check_equal(vector<double> &poly1, vector<double> &poly2);


#endif