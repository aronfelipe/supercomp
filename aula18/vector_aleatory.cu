#include <thrust/random.h>
#include <thrust/device_vector.h>
#include <thrust/iterator/counting_iterator.h>
#include <thrust/transform.h>
#include <thrust/transform_reduce.h>
#include <vector>

struct rng
{
    __host__ __device__
    double operator()(const int& x) {
        thrust::default_random_engine eng(x);
        thrust::uniform_real_distribution<double> d(25, 40);
        return d(eng);
    }
};

int main() {

    int n = 1000000;

    thrust::device_vector<double> vec (n);

    thrust::transform(thrust::make_counting_iterator(0), thrust::make_counting_iterator(n), vec.begin(), rng());

    for (int i = 0; i < n; i++) {
        std::cout << vec[i] << "\n";
    }

    return 0;
}