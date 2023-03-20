#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <chrono>
#include <complex>
#include <cstring>

#include <print.h>
#include <multiply.h>
#include <test.h>




using namespace std;

const int mult_code = 1;
const int dft_code = 2;
const int fft_alloc_code = 4;
const int fft_code = 8;


char *name_app = "app";

void help() {
    cout << "Usage: " << name_app << " <command> [args]" << endl;
    cout << "Commands:" << endl;
    cout << "   help - Print usage info." << endl;
    cout << "   test - Test funtions." << endl;

    
    cout << endl;

}




int main(int argc, char *argv[]) {
    

    if(argc == 1) {
        help();
        return 0;
    }

    if(argc == 2) {
        if(strcmp("test-lib", argv[1]) == 0) {
            test();
            return 0;
        } else if(strcmp("test1", argv[1]) == 0) {
            test_multiplication("1", 2, 2, 15);
            //test_multiplication("1", 3, 3, 15);
            int code = mult_code | fft_alloc_code | fft_code;

            // test_multiplication("2", 1000, 1000, code);
            // test_multiplication("3", 6000, 6000, code);
            // test_multiplication("3", 10000, 10000, code);
            return 0;
        } else {
            cout << "Command: " << argv[1] << endl;
            cout << "No such command" << endl;
        }
    }

    return 0;
}





