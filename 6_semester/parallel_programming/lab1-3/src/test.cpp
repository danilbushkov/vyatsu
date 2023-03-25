
#include "test.h"



void test_parallel_multiplication(char *name, int poly1_size, int poly2_size) {
    std::cout << "Test: " << name << std::endl;

    vector<double> result1;
    vector<double> result2;
    vector<double> dft_mult_result;
    vector<double> poly1;
    vector<double> poly2;
    get_random_poly(poly1, poly1_size);
    get_random_poly(poly2, poly2_size);

    print_multiplication_time(
        fft_mult_iterative_,
        poly1,
        poly2,
        result1,
        "iter_fft_mult"
    );

    print_multiplication_time(
        iter_pfft_mult,
        poly1,
        poly2,
        result2,
        "iter_pfft_mult"
    );
    
    if(!check_equal(result1, result2)) {
        cout << "Error: iter_pfft_result and iter_fft_result are not equal" << endl;
        print_poly(result2);
        print_poly(result1);
    }
    
}

void test_parallel_fft(char *name, int poly1_size) {

    vector<double> poly1;
    vector<double> poly2;
    get_random_poly(poly1, poly1_size);
    get_random_poly(poly2, poly1_size);
    vector<double> result1;
    vector<double> result2;
    print_multiplication_time(
        test_fft,
        poly1,
        poly2,
        result1,
        "test_fft"
    );

    print_multiplication_time(
        test_pfft,
        poly1,
        poly2,
        result2,
        "test_pfft"
    );
}

void test_omp_multiplication(char *name, int poly1_size, int poly2_size) {
    std::cout << "Test: " << name << std::endl;

    vector<double> result1;
    vector<double> result2;
    vector<double> dft_mult_result;
    vector<double> poly1;
    vector<double> poly2;
    get_random_poly(poly1, poly1_size);
    get_random_poly(poly2, poly2_size);

    print_multiplication_time(
        fft_mult_iterative_,
        poly1,
        poly2,
        result1,
        "fft_mult"
    );

    print_multiplication_time(
        omp_iter_fft_mult,
        poly1,
        poly2,
        result2,
        "omp_fft_mult"
    );
    
    if(!check_equal(result1, result2)) {
        cout << "Error: omp_result and fft_result are not equal" << endl;
        print_poly(result2);
        print_poly(result1);
    }
    
}



void test_multiplication(char *name, int poly1_size, int poly2_size, int code) {
    bool mult_code = code & 1;
    bool dft_code = (code >> 1) & 1;
    bool fft_alloc_code = (code >> 2) & 1;
    bool fft_recursive_code = (code >> 3) & 1;
    bool fft_stack_code = (code >> 4) & 1;
    bool fft_iterative_code = (code >> 5) & 1;
    
    std::cout << "Test: " << name << std::endl;

    vector<double> result1;
    vector<double> result2;
    vector<double> result3;
    vector<double> result4;
    vector<double> result5;
    vector<double> result6;
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
    if(fft_recursive_code) {
        print_multiplication_time(
            fft_mult_recursive,
            poly1,
            poly2,
            result4,
            "fft_recursive"
        );
    }

    if(fft_stack_code) {
        print_multiplication_time(
            fft_mult_stack,
            poly1,
            poly2,
            result5,
            "fft_stack"
        );
    }

    if(fft_iterative_code) {
        print_multiplication_time(
            fft_mult_iterative_,
            poly1,
            poly2,
            result6,
            "fft_iterative"
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

    if(mult_code && fft_recursive_code) {
        if(!check_equal(result1, result4)) {
            cout << "Error: fft_recursive_result and multiply_result are not equal" << endl;

            print_poly(result4);
            print_poly(result1);
        }
    }

    if(mult_code && fft_stack_code) {
        if(!check_equal(result1, result5)) {
            cout << "Error: fft_stack_result and multiply_result are not equal" << endl;

            print_poly(result5);
            print_poly(result1);
        }
    }

    if(mult_code && fft_iterative_code) {
        if(!check_equal(result1, result6)) {
            cout << "Error: fft_iterative_result and multiply_result are not equal" << endl;

            print_poly(result6);
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