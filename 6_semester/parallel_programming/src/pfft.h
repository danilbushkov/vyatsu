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

using namespace std;

void pfft_mult(vector<double> &poly1, vector<double> &poly2, vector<double> &result);

#endif