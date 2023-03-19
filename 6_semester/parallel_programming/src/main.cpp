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










// int _main() {

//     vector<double> result;
//     vector<double> dft_mult_result;
//     //vector<double> poly1 = {10, 2, 3, 10, 21};
//     //vector<double> poly2 = {4, 3, 3, 4};
//     vector<double> poly1;
//     vector<double> poly2;
//     get_random_poly(poly1, 10000);
//     get_random_poly(poly2, 10000);
//     polynomial_multiplication(poly1, poly2, result);
//     //print_poly(result);

//     vector<complex<double>> cpoly1;
//     vector<complex<double>> cpoly2;
//     vector<complex<double>> cresult;
//     dpoly_to_cpoly(poly1, cpoly1);
//     dpoly_to_cpoly(poly2, cpoly2);
//     dft_mult(cpoly1, cpoly2, cresult);
//     cpoly_to_dpoly(cresult, dft_mult_result);

//     if(!check_equal(result, dft_mult_result)) {
//         cout << "Error: dft_mult and simple_mult are not equal" << endl;
//     }






//     //print_complex_poly(cresult);


//     // vector<double> poly1 = {4, 3, 2, 1, 0, 0, 0, 0};
//     // vector<complex<double>> cpoly1;
//     // vector<complex<double>> result;
//     // dpoly_to_cpoly(poly1, cpoly1);
//     // dft(cpoly1, result);
//     // print_complex_poly(result);


//     return 0;
// }


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
            test_multiplication(1000, 1000);
            return 0;
        } else {
            cout << "Command: " << argv[1] << endl;
            cout << "No such command" << endl;
        }
    }

    return 0;
}





