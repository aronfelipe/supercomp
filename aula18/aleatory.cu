#include <thrust/random.h>
#include <thrust/device_vector.h>
#include <thrust/transform.h>
#include <thrust/iterator/counting_iterator.h>
#include <vector>

int main() {
    thrust::default_random_engine eng(10);
    thrust::uniform_real_distribution<double> d(20, 30);

    for (int i = 0; i < 10; i++) {
        std::cout << d(eng) << "\n";
    }
}