

#include <print.h>




void print_multiplication_time(
    void multiply(vector<double> &, vector<double> &, vector<double> &),
    vector<double> &poly1, 
    vector<double> &poly2, 
    vector<double> &result,
    string func_name
) {

    auto start = chrono::steady_clock::now();

    multiply(poly1, poly2, result);

    auto end = chrono::steady_clock::now();

    print_time(func_name, start, end);

}



void print_time(string task, 
                chrono::steady_clock::time_point start, 
                chrono::steady_clock::time_point end) {
    auto ms = chrono::duration_cast<chrono::milliseconds>(end - start).count();
    auto sec = chrono::duration_cast<chrono::seconds>(end - start).count();
    auto min = chrono::duration_cast<chrono::minutes>(end - start).count();
    cout << "Task: " << task << "\n";
    cout << "    Time in sec: " << ms / 1000 << "\n";
    cout << "    Time in min:sec:ms: " << min << ":" << sec - min*60 << ":" << ms % 1000 << "\n";
    cout << "\n";
}


void print_poly(vector<double> &poly) {
    for(auto item: poly) {
        cout << round(item) << " ";
    }
    cout << endl;
}

void print_complex_poly(vector<complex<double>> &poly) {
    for(auto item: poly) {
        cout << round(real(item)) << " ";
    }
    cout << endl;
}