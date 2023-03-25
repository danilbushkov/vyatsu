#ifndef ITER_PFFT_H
#define ITER_PFFT_H

#include <vector>
#include <complex>
#include <stack>
#include <thread>
#include <functional>

#include "lib.h"
#include "poly.h"
#include "print.h"
#include "fft.h"
#include "pfft.h"

using namespace std;

void iter_pfft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);

#endif