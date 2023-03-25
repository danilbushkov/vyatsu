#ifndef TEST_H
#define TEST_H


#include <iostream>

#include "multiply.h"
#include "dft.h"
#include "fft.h"
#include "print.h"
#include "poly.h"
#include "pfft.h"
#include "omp_fft.h"
#include "iter_pfft.h"
#include "omp_iter_fft.h"
#include "lib.h"

void test();
void test_multiplication(char *name, int poly1_size, int poly2_size, int code);
void test_parallel_multiplication(char *name, int poly1_size, int poly2_size);
void test_parallel_fft(char *name, int poly1_size);
void test_omp_multiplication(char *name, int poly1_size, int poly2_size);

#endif