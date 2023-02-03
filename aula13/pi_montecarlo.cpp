#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
#include <cstdlib>
#include <cmath>
#include <iomanip>
#include <omp.h>
 
using namespace std;

int main() {
    double itime, ftime, exec_time;

    itime = omp_get_wtime();

    double sum = 0.0;

    int N = 100000;

    random_device random;
    mt19937 generator(random());
    uniform_real_distribution<double> distribution(0.0,1.0);
    #pragma omp parallel for reduction(+:sum)
    for(int i = 0; i < N; i++) {
        double x = distribution(generator);
        double y = distribution(generator);

        if ((pow(x, 2)) + (pow(y, 2)) <= 1) {
            sum++;
        }
    }

    double pi = 4 * sum / N;

    cout << sum << endl;

    cout << fixed << setprecision(3) << pi;

    ftime = omp_get_wtime();
    exec_time = ftime - itime;

    cout << endl << exec_time;
    return 0;


}