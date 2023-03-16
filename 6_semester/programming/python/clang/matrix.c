#include <stdlib.h>

int** multiply(int **m1, int m1_row_size, int m1_col_size, int **m2, int m2_row_size, int m2_col_size) {

    int **m = (int **) malloc(m1_row_size * sizeof(int *));
    if(m != NULL)
    {
        for(int i = 0; i < m1_row_size; i++)
        {
            m[i] = (int *) malloc(m2_col_size * sizeof(int));
        }

    }

    for(int i = 0; i < m1_row_size; i++) {
        for(int j = 0; j < m2_col_size; j++) {
            int sum = 0;
            for(int l = 0; l < m1_col_size; l++) {
                sum = sum + m1[i][l] * m2[l][j];
            }
            m[i][j] = sum;
        }
    }

    return m;
}