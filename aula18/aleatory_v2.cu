#include <thrust/random.h>
#include <thrust/device_vector.h>
#include <thrust/transform.h>
#include <thrust/iterator/counting_iterator.h>
#include <vector>
#include <stdio.h>

int main() {

    int seed = 0;

    std::cout << "Digite a sua seed: " << std::endl;

    scanf ("%d", &seed);

    thrust::default_random_engine eng(seed);
    thrust::uniform_real_distribution<double> d(25, 40);

    for (int i = 0; i < 10; i++) {
        std::cout << d(eng) << "\n";
    }

}