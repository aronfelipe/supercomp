
#include <iostream>
#include <thrust/random.h>
#include <thrust/device_vector.h>
#include <thrust/iterator/counting_iterator.h>
#include <thrust/transform.h>
#include <thrust/transform_reduce.h>

using namespace std;

struct calculate_pi
{
    __host__ __device__
    double operator()(const int& x) {
        thrust::default_random_engine eng(x);
        thrust::uniform_real_distribution<double> d(0.0, 1.0);

        double x_ = d(eng);
        double y = d(eng);
        
        if (x_*x_ + y*y <= 1) {
            return 1;
        } else {
            return 0;
        }
    }
};

int main() {

    int n = 10000000;

    calculate_pi unary_op;
    thrust::device_vector<double> vec (n);
    thrust::plus<double> binary_op;
    float init = 0;

    int sum = thrust::transform_reduce(thrust::make_counting_iterator(0), thrust::make_counting_iterator(n), unary_op, init, binary_op);

    double pi = 4.0 * sum / n;

    cout << pi;

    return 0;
}
