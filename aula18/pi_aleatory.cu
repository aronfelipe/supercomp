#include <thrust/random.h>
#include <thrust/device_vector.h>
#include <thrust/iterator/counting_iterator.h>
#include <thrust/transform.h>
#include <iostream>
#include <vector>
#include <thrust/transform_reduce.h>
#include <thrust/fill.h>

using namespace std;

struct calculate_pi
{
    __host__ __device__
    double operator()(const int& a) {
        thrust::default_random_engine eng(a);
        thrust::uniform_real_distribution<double> d(0.0, 1.0);
        double x, y;
      
        x = d(eng);
        y = d(eng);

        if (x*x + y*y <= 1) {
            return 1;
        } else {
            return 0;
        }
    }
};

int main() {

    long n = 100000000L;
    long sum = 0;

    // calculate_pi unary_op;
    // thrust::plus<double> binary_op;
    thrust::device_vector<double> vec (n);
    // float init = 0;

    // thrust::fill(vec.begin(), vec.end(), 0);

    // thrust::transform_reduce(vec.begin(), vec.end(), unary_op, init, binary_op);
    thrust::transform(vec.begin(), vec.end(), vec.begin(),  calculate_pi());

    // for (int i = 0; i < n; i++) {
    //     cout << vec[i] << endl;
    // }

    sum = thrust::reduce(vec.begin(), vec.end());

    double pi = 4.0 * sum / n;

    cout << sum << endl;

    cout << pi;

    return 0;
}