#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
#include <cmath>

using namespace std;

int main() {

    int n = 0;

    cin >> n;

    vector<int> numbers;

	for (int i = 0; i < n; i++) {
        random_device random;
        mt19937 generator(random());
        uniform_int_distribution<int> distribution(1,999);
        int number = distribution(generator);
        numbers.push_back(number);
        cout << number << endl;
    }

    int sum = 0;
    float mean = 0;
    float standard_deviation = 0;
    #pragma omp parallel for reduction(+:sum) num_threads(2)
    for(int i = 0; i < n; i++) {
        sum += numbers[i];
    }
    mean = sum / n;
    cout << mean << endl;

    #pragma omp parallel for reduction(+:standard_deviation) num_threads(2)
    for(int i = 0; i < n; i++) {
        standard_deviation += pow(numbers[i] - mean, 2);
    }

    standard_deviation = sqrt(standard_deviation / n);

}