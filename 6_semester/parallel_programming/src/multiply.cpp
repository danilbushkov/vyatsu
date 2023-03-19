#include <multiply.h>

// a0x^0 + a1x^1 + ... + an-1^n-1 
void polynomial_multiplication(vector<double> &poly1, vector<double> &poly2, vector<double> &result) {
    int n = poly1.size();
    int m = poly2.size();

    if(n == 0 || m == 0) {
        return;
    }
    result.resize(n+m-1, 0);

    for(int i = 0; i < n; i++) {
        if(poly1[i] != 0) {
            for(int j = 0; j < m; j++) {
                result[i+j] = result[i+j] + poly1[i] * poly2[j];
            }
        }
        
    }


}