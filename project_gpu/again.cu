#include <thrust/transform.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/iterator/counting_iterator.h>
#include <iostream>
#include <thrust/copy.h>

struct meu_functor
{
    char letter;
    thrust::device_ptr<int> data_subsequence;
    thrust::device_ptr<int> last_line_calculation;

    meu_functor(thrust::device_ptr<int> _data_subsequence, char _letter, thrust::device_ptr<int>_last_line_calculation) : data_subsequence(_data_subsequence), letter(_letter), last_line_calculation(_last_line_calculation) {};

    __host__ __device__
    int operator()(const int& i) {

        int diagonal = 0;
        int insertion = last_line_calculation[i] - 1;

        if (data_subsequence[i-1] == letter) {
            diagonal = last_line_calculation[i-1] + 2;
        } else {
            diagonal = last_line_calculation[i-1] - 1;
        }

        if (diagonal > insertion) {
            if (diagonal > 0) {
                return diagonal;
            } else {
                return 0;
            }
        } else {
            if (insertion > 0) {
                return insertion;
            } else {
                return 0;
            }
        }
    }
};

int main() {
    char *S = "-T--TG-GTT";
    char *T = "T-TTGCCCT-";

    int N = strlen(S);
    int M = strlen(T);

    thrust::device_vector<int> S_vector;

    for (int i = 0; i < N; i++) {
        S_vector.push_back(S[i]);
        std::cout << S[i];
    }

    thrust::device_vector<int> T_vector;

    for (int i = 0; i < N; i++) {
        T_vector.push_back(T[i]);
        std::cout << T[i];
    }

    thrust::device_vector<int> calculation_temp(S_vector.size() + 1);
    thrust::device_vector<int> calculation_score(S_vector.size() + 1);

    thrust::fill(calculation_temp.begin(), calculation_temp.end(), 0);

    for (int j = 0; j < M; j++) {
        char letradeT = T_vector[j];
        thrust::device_vector<int> counting(N + 1);
        
        for (int q = 0; q < N + 1; q++) {
            counting[q] = q;
        }

        thrust::transform(counting.begin(), counting.end(), calculation_score.begin(), meu_functor(S_vector.data(), letradeT, calculation_temp.data()));
        thrust::inclusive_scan(calculation_score.begin()+1, calculation_score.end(), calculation_temp.begin() + 1, thrust::maximum<int>());

        for (int i = 0; i < calculation_temp.size(); i++) {
            std::cout << calculation_temp[i];
            std::cout << std::endl;

        }
        std::cout << std::endl;
    }


}
