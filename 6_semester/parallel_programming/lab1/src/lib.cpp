#include <lib.h>


int floor_power2(int num) {
    int result = 0;
    for(; num > 1; num=num>>1, result++);
    return result;
}


int reverse_int(int num, int log2n) {
    int result = 0;
    for(int i = 0; i <= log2n; i++) {
        result |= ( (num >> i) & 1) << (log2n - i);
    }
    return result;
}