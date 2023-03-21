#ifndef TEST_H
#define TEST_H

#include <lib.h>
#include <iostream>
#include <multiply.h>
#include <dft.h>
#include <fft.h>
#include <print.h>
#include <poly.h>
#include <pfft.h>

void test();
void test_multiplication(char *name, int poly1_size, int poly2_size, int code);
void test_parallel_multiplication(char *name, int poly1_size, int poly2_size);

#endif