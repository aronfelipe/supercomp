#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
#include <cstdlib>
#include <cmath>
#include <omp.h>

using namespace std;

int main() {

    int n = 100000;
    vector<int> vector_of_numbers(n);

    for (int i = 0; i < n; i++) {
        random_device random;
        mt19937 generator(random());
        uniform_int_distribution<int> distribution(1,999);
        vector_of_numbers[i] = distribution(generator);
    }

    int sum = 0;
    int average = 0;
    int standard_deviation = 0;

    #pragma omp parallel for reduction(+:sum) num_threads(9)
    for (int i = 0; i < n; i++) {
        sum+= vector_of_numbers[i];
    }

    average = sum / n;

    cout << average << endl;

    #pragma omp parallel for reduction(+:standard_deviation) num_threads(9)
    for (int i = 0; i < n; i++) {
        standard_deviation+= pow(vector_of_numbers[i] - average, 2);
    }

    standard_deviation = standard_deviation / n;
    standard_deviation = sqrt(standard_deviation);
    cout << standard_deviation << endl;

}