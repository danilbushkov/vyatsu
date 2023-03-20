
#include <test.h>







void test_multiplication(char *name, int poly1_size, int poly2_size, int code) {
    bool mult_code = code & 1;
    bool dft_code = (code >> 1) & 1;
    bool fft_alloc_code = (code >> 2) & 1;
    bool fft_code = (code >> 3) & 1;
    
    std::cout << "Test: " << name << std::endl;

    vector<double> result1;
    vector<double> result2;
    vector<double> result3;
    vector<double> result4;
    vector<double> dft_mult_result;
    vector<double> poly1;
    vector<double> poly2;
    get_random_poly(poly1, poly1_size);
    get_random_poly(poly2, poly2_size);
    
    if(mult_code) {
        print_multiplication_time(
            polynomial_multiplication,
            poly1,
            poly2,
            result1,
            "polynomial_multiplication"
        );
    }
    
    if(dft_code) {
        print_multiplication_time(
            dft_mult,
            poly1,
            poly2,
            result2,
            "dft_mult"
        );
    }
    
    if(fft_alloc_code) {
        print_multiplication_time(
            fft_mult_alloc,
            poly1,
            poly2,
            result3,
            "fft_mult_alloc"
        );
    }
    if(fft_code) {
        print_multiplication_time(
            fft_mult,
            poly1,
            poly2,
            result4,
            "fft_mult"
        );
    }

    if(mult_code && dft_code) {
        if(!check_equal(result1, result2)) {
            cout << "Error: dft_result and multiply_result are not equal" << endl;
            print_poly(result2);
            print_poly(result1);
        }
    }
    
    if(mult_code && fft_alloc_code) {
        if(!check_equal(result1, result3)) {
            cout << "Error: fft_alloc_result and multiply_result are not equal" << endl;
            
            print_poly(result3);
            print_poly(result1);
        }
    }

    if(mult_code && fft_code) {
        if(!check_equal(result1, result4)) {
            cout << "Error: fft_result and multiply_result are not equal" << endl;

            print_poly(result4);
            print_poly(result1);
        }
    }
    
    cout << endl;
}









void test() {

    if(floor_power2(0) != 0) {
        std::cout << "Error: floor_power2(0)" << std::endl;
    }

    if(floor_power2(1) != 0) {
        std::cout << "Error: floor_power2(1)" << std::endl;
    }

    if(floor_power2(8) != 3) {
        std::cout << "Error: floor_power2(8)" << std::endl;
    }
    if(floor_power2(2) != 1) {
        std::cout << "Error: floor_power2(2)" << std::endl;
    }
    if(floor_power2(4) != 2) {
        std::cout << "Error: floor_power2(4)" << std::endl;
    }
    if(floor_power2(1024) != 10) {
        std::cout << "Error: floor_power2(1024)" << std::endl;
    }
    if(floor_power2(1060) != 10) {
        std::cout << "Error: floor_power2(1060)" << std::endl;
    }

    if(reverse_int(1, floor_power2(1)) != 1) {
        std::cout << "Error: reverse_int(1)" << std::endl;
    }

    if(reverse_int(0, floor_power2(0)) != 0) {
        std::cout << "Error: reverse_int(0)" << std::endl;
    }

    if(reverse_int(12, floor_power2(12)) != 3) {
        std::cout << "Error: reverse_int(12)" << std::endl;
    }

    if(reverse_int(25, floor_power2(25)) != 19) {
        std::cout << "Error: reverse_int(25)" << std::endl;
    }
    if(reverse_int(3, floor_power2(4)) != 6) {
        std::cout << "Error: reverse_int(3)" << std::endl;
    }
    if(reverse_int(12, 5) != 12) {
        std::cout << "Error: reverse_int(12)" << std::endl;
    }


}