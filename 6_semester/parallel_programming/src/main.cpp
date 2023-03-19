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
            test_multiplication("1", 10, 10);
            return 0;
        } else {
            cout << "Command: " << argv[1] << endl;
            cout << "No such command" << endl;
        }
    }

    return 0;
}





