#include <stdlib.h>
#include <stdio.h>

int* multiply(int *m1, int m1_n, int m1_m, int *m2, int m2_n, int m2_m) {

    int *m = (int *) malloc(m1_n * m2_m * sizeof(int));


    for(int i = 0; i < m1_n; i++) {
        for(int j = 0; j < m2_m; j++) {
            int sum = 0;
            for(int l = 0; l < m1_m; l++) {
                sum = sum + m1[i*m1_m+l] * m2[l*m2_m+j];
            }
            m[i*m2_m+j] = sum;
        }
    }

    return m;
}