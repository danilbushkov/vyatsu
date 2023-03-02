#ifndef PRINT_H
#define PRINT_H

#include <chrono>
#include <iostream>
#include <vector>
#include <complex>

using namespace std;

void print_time(string task, 
                chrono::steady_clock::time_point start, 
                chrono::steady_clock::time_point end);


void print_poly(vector<double> &poly);
void print_complex_poly(vector<complex<double>> &poly);


#endif