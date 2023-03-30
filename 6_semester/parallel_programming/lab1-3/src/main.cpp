#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <chrono>
#include <complex>
#include <cstring>
#include <thread>

#include "print.h"
#include "multiply.h"
#include "test.h"




using namespace std;

const int mult_code = 1;
const int dft_code = 2;
const int fft_alloc_code = 4;
const int fft_recursive_code = 8;
const int fft_stack_code = 16;
const int fft_iterative_code = 32;

const int pfft_code = 128;


char *name_app = "app";

void help() {
    cout << "Usage: " << name_app << " <command> [args]" << endl;
    cout << "Commands:" << endl;
    cout << "   help - Print usage info." << endl;
    cout << "   test - Test funtions." << endl;

    
    cout << endl;

}




int main(int argc, char *argv[]) {
    //srand (time(NULL));

    if(argc == 1) {
        help();
        return 0;
    }

    if(argc == 2) {
        if(strcmp("test-lib", argv[1]) == 0) {
            test();
            return 0;
        } if(strcmp("omp_get_nested", argv[1]) == 0) {
            cout << omp_get_nested() << endl;
        } else if(strcmp("threads_num", argv[1]) == 0) {
            cout << thread::hardware_concurrency() << endl;
        } else if(strcmp("test0", argv[1]) == 0) {
            int code = mult_code;
            int size = pow(2, 10);
            test_multiplication("1", size, size, code);

            size = pow(2, 11);
            test_multiplication("1", size, size, code);


            size = pow(2, 18);
            test_multiplication("1", size, size, code);
            
            return 0;
        } else if(strcmp("test1", argv[1]) == 0) {
            int code = fft_iterative_code ;
            int size = pow(2, 13);
            test_multiplication("1", size, size, code);
            size = pow(2, 14);
            test_multiplication("2", size, size, code);
            size = pow(2, 15);
            test_multiplication("3", size, size, code);
            size = pow(2, 16);
            test_multiplication("4", size, size, code);
            size = pow(2, 17);
            test_multiplication("5", size, size, code);
            size = pow(2, 18);
            test_multiplication("6", size, size, code);
            size = pow(2, 19);
            test_multiplication("7", size, size, code);
            size = pow(2, 20);
            test_multiplication("8", size, size, code);
            size = pow(2, 21);
            test_multiplication("9", size, size, code);
            size = pow(2, 22);
            test_multiplication("10", size, size, code);
            size = pow(2, 23);
            test_multiplication("12", size, size, code);
            return 0;
        } else if(strcmp("test2", argv[1]) == 0) {
            int size;

            size = pow(2,13);
            test_parallel_multiplication("1", size, size);
            size = pow(2,14);
            test_parallel_multiplication("2", size, size);
            size = pow(2,15);
            test_parallel_multiplication("3", size, size);
            size = pow(2,16);
            test_parallel_multiplication("4", size, size);
            size = pow(2,17);
            test_parallel_multiplication("5", size, size);
            size = pow(2,18);
            test_parallel_multiplication("6", size, size);
            size = pow(2,19);
            test_parallel_multiplication("7", size, size);
            size = pow(2,20);
            test_parallel_multiplication("8", size, size);
            size = pow(2,21);
            test_parallel_multiplication("9", size, size);
            size = pow(2,22);
            test_parallel_multiplication("10", size, size);
            size = pow(2,23);
            test_parallel_multiplication("11", size, size);
            size = pow(2,24);
            test_parallel_multiplication("12", size, size);
            
            return 0;
        } else if(strcmp("test3", argv[1]) == 0) {
            omp_set_nested(0);
            int size;
            size = pow(2,13);
            test_omp_multiplication("1", size, size);

            size = pow(2,14);
            test_omp_multiplication("2", size, size);

            size = pow(2,15);
            test_omp_multiplication("3", size, size);

            size = pow(2,16);
            test_omp_multiplication("4", size, size);

            size = pow(2,17);
            test_omp_multiplication("5", size, size);

            size = pow(2,18);
            test_omp_multiplication("6", size, size);

            size = pow(2,19);
            test_omp_multiplication("7", size, size);

            size = pow(2,20);
            test_omp_multiplication("8", size, size);

            size = pow(2,21);
            test_omp_multiplication("9", size, size);

            size = pow(2,22);
            test_omp_multiplication("10", size, size);

            size = pow(2,23);
            test_omp_multiplication("11", size, size);

            size = pow(2,24);
            test_omp_multiplication("12", size, size);
            return 0;
        } else if(strcmp("test_pfft", argv[1]) == 0) {
            test_parallel_fft("1", 100000);
            test_parallel_fft("2", 500000);
            test_parallel_fft("3", 1000000);
        } else {
            cout << "Command: " << argv[1] << endl;
            cout << "No such command" << endl;
        }
    }

    return 0;
}





