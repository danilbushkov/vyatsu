#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <complex.h>
#include <math.h>


struct array {
    int size;
    double *arr;
};


void free_array(struct array *arr) {
    free(arr->arr);
}


struct array simple_mult(struct array *poly1, struct array *poly2) {
    int n = poly1->size + poly2->size - 1;
    double *arr = calloc(n, sizeof(double));
    struct array result = {n, arr};
    for(int i = 0; i < poly1->size; i++) {
        if(poly1->arr[i] != 0) {
            for(int j = 0; j < poly2->size; j++) {
                result.arr[i+j] = result.arr[i+j] + poly1->arr[i] * poly2->arr[j];
            }
        }
        
    }
    return result;

}

struct array get_random_poly(int size, int min, int max) {
    struct array poly;
    poly.size = size;
    poly.arr = calloc(size, sizeof(double));
    for(int i = 0; i < size; i++) {
        poly.arr[i] = min + rand() % ((max + 1) - min);
    }
    return poly;
}

void print_poly(struct array *poly) {

    for(int i = 0; i < poly->size; i++) {
        printf("%f ", poly->arr[i]);
    }
    printf("\n");

}

bool check(struct array *poly1, struct array *poly2) {
    int n = poly1->size;
    if(n > poly2->size) {
        n = poly2->size;
    }
    for(int i = 0; i < n; i++) {
        if(round(poly1->arr[i]) != round(poly2->arr[i])) {
            return false;
        }
    }


    return true;
}

void dpoly_to_cpoly(struct array *poly, double complex *result) {
    int n = poly->size;
    for(int i = 0; i < n; i++) {
        result[i] = poly->arr[i];
    }
}

void cpoly_to_dpoly(int n, double complex *poly, struct array *result) {
    for(int i = 0; i < n; i++) {
        result->arr[i] = round((double) poly[i]);
    }
}

//fft
int number_of_characters2(int num) {
    int result = 0;
    for(; num > 1; num=num>>1, result++);
    return result;
}


int reverse_int(int num, int p) {
    int result = 0;
    for(int i = 0; i <= p; i++) {
        result |= ( (num >> i) & 1) << (p - i);
    }
    return result;
}

bool has_one_bit(int num) {
    int count = 0;
    while(num > 0) {
        count = count + (num & 1);
        num = num >> 1;
    }

    return count == 1;
}

void swap(double complex *a, double complex *b) {
    double complex c = *a;
    *a = *b;
    *b = c;
}

void fft(double complex *poly, int n, double s) {
    if (n == 1)
        return;
    
    for(int i = 0; i < n; i++) {
        int rev_i = reverse_int(i, number_of_characters2(n-1));
        
        if(i < rev_i) {
            swap(&poly[i], &poly[rev_i]);
        }
        
    }
    
    for(int i = number_of_characters2(n)-1; i >= 0; i--) {
        int num_seq = pow(2, i);
        
        double f = s*2 * M_PI / (n) * num_seq;
        double complex wn = cos(f) + sin(f) * I;
        
        int num_items = n / num_seq;
        for(int j = 0; j < num_seq; j++) {

            
            
            double complex w = 1;
            
            int s = num_items*j;
            int e = s + num_items/2;
            
            for(int k = s; k < e; k++) {
                
                double complex t = w * poly[k + num_items/2];
                poly[k+num_items/2] = poly[k] - t;
                poly[k] = poly[k] + t;
                w *= wn;
            }
        }
    }

    
}

struct array mult(struct array *poly1, struct array *poly2) {
    int n = poly1->size;
    int m = poly2->size;

    

    int size = 0;
    if(n > m) {
        size = n;
    } else {
        size = m;
    }

    while(!has_one_bit(size)) {
        size++;
    }

    size *= 2;

    complex double *cpoly1 = calloc(size, sizeof(complex double));
    complex double *cpoly2 = calloc(size, sizeof(complex double));
    complex double *cresult = calloc(size, sizeof(complex double));
    struct array result;
    result.size = m+n-1;
    result.arr = calloc(size, sizeof(double));



    dpoly_to_cpoly(poly1, cpoly1);
    dpoly_to_cpoly(poly2, cpoly2);
    
    

    fft(cpoly1, size, 1);
    fft(cpoly2, size, 1);





    for(int i = 0; i < size; i++) {
        cresult[i] = (cpoly1[i] * cpoly2[i]) / size;
    }
    

    
    fft(cresult, size, -1);
    

    cpoly_to_dpoly(result.size, cresult, &result);

    free(cpoly1);
    free(cpoly2);
    free(cresult);

    return result;
}

struct array smult(int n, struct array *poly_arr) {
    struct array poly;
    if(n == 0) {
        return poly;
    } else if (n == 1) {
        return poly_arr[0];
    }
    poly = simple_mult(&poly_arr[0], &poly_arr[1]);
    for(int i = 2; i < n; i++) {
        struct array tmp = simple_mult(&poly, &poly_arr[i]);
        free_array(&poly);
        poly = tmp;
    }
    return poly;
}

struct array fmult(int n, struct array *poly_arr) {
    struct array poly;
    if(n == 0) {
        return poly;
    } else if (n == 1) {
        return poly_arr[0];
    }


    int m = n/2;
    struct array *tpoly = calloc(m, sizeof(struct array));
    for(int i = 0, j = 0; i < m; i++, j += 2) {
        tpoly[i] = mult(&poly_arr[j], &poly_arr[j+1]);
    }
    while(m > 1) {
        struct array *tmp = calloc(m/2, sizeof(struct array));
        for(int i = 0, j = 0; i < m/2; i++, j += 2) {
            tmp[i] = mult(&tpoly[j], &tpoly[j+1]);
        }
        for(int j = 0; j < m; j++) {
            free_array(&tpoly[j]);
        }
        free(tpoly);
        tpoly = tmp;
        m /= 2;
    }

//    poly = mult(&poly_arr[0], &poly_arr[1]);
//    for(int i = 2; i < n; i++) {
//        struct array tmp = mult(&poly, &poly_arr[i]);
//        free_array(&poly);
//        poly = tmp;
//    }
    struct array p = tpoly[0];
    free(tpoly);
    return p;
}


int main() {

    srand(time(NULL));
    int n = 4;
    struct array *poly_arr = calloc(n, sizeof(struct array));
    for(int i = 0; i < n; i++) {
        poly_arr[i] = get_random_poly(10000, -10, 10);
    }

    struct array poly = smult(n, poly_arr);
    //struct array poly = simple_mult(&poly1, &poly2);
    struct array fpoly = fmult(n, poly_arr);

    
    //print_poly(&poly);
    if(!check(&poly, &fpoly)) {
        printf("not equal\n");
    }
    printf("\n");
    //print_poly(&fpoly);

    for(int i = 0; i < n; i++) {
        free_array(&poly_arr[i]);
    }
    free(poly_arr);
    free_array(&poly);
    free_array(&fpoly);
    return 0;
}
