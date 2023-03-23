#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <chrono>
#include <complex>
#include <cstring>
#include <thread>

#include <print.h>
#include <multiply.h>
#include <test.h>




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
        } else if(strcmp("test1", argv[1]) == 0) {
            //test_multiplication("1", 2, 2, 15);
            int code = mult_code | fft_recursive_code | fft_iterative_code ;
            test_multiplication("1", 3, 3, code);
            test_multiplication("1", 1000, 1000, code);

            code = fft_recursive_code | fft_iterative_code ;
            //test_multiplication("1", 400000, 400000, code);
            test_multiplication("1", 1000000, 1000000, code);
            // test_multiplication("2", 1000, 1000, code);
            // test_multiplication("3", 6000, 6000, code);
            // test_multiplication("4", 10000, 10000, code);

            // code = fft_alloc_code | fft_recursive_code | fft_stack_code;
            // test_multiplication("5", 30000, 30000, code);
            // test_multiplication("6", 100000, 100000, code);
            // test_multiplication("7", 700000, 700000, code);
            return 0;
        } else if(strcmp("test2", argv[1]) == 0) {
            
            test_parallel_multiplication("1", 100000, 100000);
            test_parallel_multiplication("2", 300000, 300000);
            return 0;
        } else if(strcmp("test3", argv[1]) == 0) {
            omp_set_nested(0);
            test_omp_multiplication("1", 100000, 100000);
            test_omp_multiplication("2", 300000, 300000);
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





