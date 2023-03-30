#ifndef SLAVE_H
#define SLAVE_H

#include <mpi.h>
#include <iostream>
#include <unistd.h>
#include <cstring>
#include <complex>


void fft_iterative(std::complex<double> *poly, int n, double s);
bool has_one_bit(int num);
void slave();

#endif