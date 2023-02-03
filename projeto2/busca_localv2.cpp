#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
#include <cmath>
#include <cstdlib>
#include <iomanip>

using namespace std;

int main(int argc, char* argv[]) {
    if (argc != 4) {
        cerr <<
        "***Numero incorreto de argumentos ***\n";
        return 1;
    }

    int n = atoi(argv[1]);
    int m = atoi(argv[2]);
    int seed = atoi(argv[3]);


    vector<int> data_a(n);
    vector<int> data_b(n);
    vector<int> data_c(n);

    default_random_engine generator;
    generator.seed(seed);
    uniform_int_distribution<int> distribution(1, 999999);

    #pragma omp parallel num_threads(8)
    {
        #pragma omp master
        {
            #pragma omp task
            {
                for (int i = 0; i < n; i++) {
                    data_a[i] = distribution(generator);
                }            
            }   
            #pragma omp task
            {
                for (int i = 0; i < n; i++) {
                    data_b[i] = distribution(generator);
                }            
            }
            
        }
    }

    #pragma omp parallel for
    for(int i = 0; i < n; i++) {
        data_c[i] = m * data_a[i] + data_b[i];
    }
    // for (int i = 0; i < n; i++ )
    // cout << data_c[i] << "= "<< m << "*" << data_a[i] <<"+"<< data_b[i] <<endl;

    for (int i = 0; i < n; i++ )
       cout << setw(6) << data_c[i] << " = " 
       << setw(2) << m
       << "*" << setw(5) << data_a[i]
       << "+" << setw(5) << data_b[i]
       << endl;
}