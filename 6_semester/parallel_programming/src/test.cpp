
#include <test.h>

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