#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/sequence.h>
#include <thrust/fill.h>
#include <thrust/transform.h>

using namespace std;

int main() {

    long n = 1000000000;

    thrust::device_vector<int> x_gpu (n);
    thrust::device_vector<int> y_gpu (n);
    thrust::device_vector<int> z_gpu (n);

    thrust::sequence(x_gpu.begin(), x_gpu.end());

    thrust::transform(x_gpu.begin(), x_gpu.end(), y_gpu.begin(),
                  thrust::negate<int>());

    thrust::fill(z_gpu.begin(), z_gpu.end(), 2);

    thrust::transform(x_gpu.begin(), x_gpu.end(), z_gpu.begin(), y_gpu.begin(),
                  thrust::modulus<int>());

    return 0;


}