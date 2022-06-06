#include <thrust/transform.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/iterator/counting_iterator.h>
#include <iostream>
#include <thrust/copy.h>
#include <omp.h>


using namespace std;
using namespace thrust;

struct calculate_score
{
    char letter;
    thrust::device_ptr<char> data_subsequence;
    thrust::device_ptr<int> last_line_calculation;

    calculate_score(thrust::device_ptr<char> _data_subsequence, char _letter, thrust::device_ptr<int>_last_line_calculation) : data_subsequence(_data_subsequence), letter(_letter), last_line_calculation(_last_line_calculation) {};

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

    double n = 0;
    double m = 0;

    cin >> n >> m;

    host_vector<char> dnas_first_seq_cpu;
    host_vector<char> dnas_second_seq_cpu;

    dnas_first_seq_cpu.reserve(n);
    dnas_second_seq_cpu.reserve(m);

    char dna_next;

    // Reads the first sequence and completes the dna_first_seq vector with the sequence.
    for(int i = 0; i < n; i++) {
        cin >> dna_next;
        dnas_first_seq_cpu.push_back(dna_next);
    }

    // Reads the second sequence and completes the dna_second_seq vector with the sequence.
    for(int i = 0; i < m; i++) {
        cin >> dna_next;
        dnas_second_seq_cpu.push_back(dna_next);
    }
    
    int k = n;
    int l = m;

    host_vector<char> dnas_first_seq_cpu_flexible = dnas_first_seq_cpu;
    host_vector<char> dnas_second_seq_cpu_flexible = dnas_second_seq_cpu;

    host_vector<host_vector<char> > subsequences_a;
    host_vector<host_vector<char> > subsequences_b;

    while (dnas_first_seq_cpu_flexible.size() > 0) {
        while(k > 0) {
            host_vector<char> next_subsequence;
            for (int j = 0; j < k; j++) {
                next_subsequence.push_back(dnas_first_seq_cpu_flexible[j]);
            }
            k = k - 1;

            subsequences_a.push_back(next_subsequence);
            next_subsequence.clear();
        }
        dnas_first_seq_cpu_flexible.erase(dnas_first_seq_cpu_flexible.begin());
        k = dnas_first_seq_cpu_flexible.size();
    }

    while (dnas_second_seq_cpu_flexible.size() > 0) {
        while(l > 0) {
            host_vector<char> next_subsequence;
            for (int j = 0; j < l; j++) {
                next_subsequence.push_back(dnas_second_seq_cpu_flexible[j]);
            }
            l = l - 1;

            subsequences_b.push_back(next_subsequence);
            next_subsequence.clear();
        }
        dnas_second_seq_cpu_flexible.erase(dnas_second_seq_cpu_flexible.begin());
        l = dnas_second_seq_cpu_flexible.size();
    }

    int max_score = 0;


    for (int i = 0; i < subsequences_a.size(); i++) {
        char *subsequence_from_sequence_a = subsequences_a[i].data();
        device_vector<char> subsequence_a_gpu = subsequences_a[i];

        for (int j = 0; j < subsequences_b.size(); j++) {
            char *subsequence_from_sequence_b = subsequences_a[j].data();
            device_vector<char> subsequence_b_gpu = subsequences_b[j];
            device_vector<int> calculation_temp(subsequences_a[i].size() + 1);
            device_vector<int> calculation_score(subsequences_a[i].size() + 1);

            thrust::fill(calculation_temp.begin(), calculation_temp.end(), 0);

            #pragma omp parallel
            {
                // Creating tasks for each sequence to create subsequences.
                #pragma omp master
                {
                    #pragma omp task
                    {
                        for (int t = 0; t < subsequences_b[j].size(); t++) {

                            char letter_from_subsequence_b = subsequences_b[j][t];

                            thrust::device_vector<int> counting(subsequence_a_gpu.size() + 1);

                            for (int q = 0; q < subsequences_a[i].size() + 1; q++) {
                                counting[q] = q;
                            }

                            thrust::transform(counting.begin(), counting.end(), calculation_score.begin(), calculate_score(subsequence_a_gpu.data(), letter_from_subsequence_b, calculation_temp.data()));
                            thrust::inclusive_scan(calculation_score.begin()+1, calculation_score.end(), calculation_temp.begin() + 1, thrust::maximum<int>());

                            int max = *max_element(calculation_temp.begin(), calculation_temp.end());

                            cout << max;
                            cout << endl;
                            cout << max_score;

                            if (max > max_score) {
                                max_score = max;
                                cout << max_score;

                            }
                        }                    
                    }
                }
            }
        }
    }

    cout << max_score;
}