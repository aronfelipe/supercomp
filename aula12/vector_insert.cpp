#include <vector>
#include <iostream>
#include <unistd.h>
#include <omp.h>

double conta(int i);

int main() {
	int N = 10000; 
	std::vector<double> vec;
    #pragma omp parallel for shared(vec)
	for (int i = 0; i < N; i++) {
    #pragma omp critical 
		vec.push_back(conta(i));
	}
	
	for (int i = 0; i < N; i++) {
		std::cout << i << " ";
	}
	
	return 0;
}

double conta(int i) {
	return 2 * i;
}