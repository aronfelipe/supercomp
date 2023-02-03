#include <thrust/transform.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/iterator/counting_iterator.h>
#include <iostream>
#include <thrust/copy.h>

using namespace std;
using namespace thrust;

struct calculate_score
{
    char letter;
    int position_letter;
    device_vector<char> data_subsequence;
    device_vector<int> last_line_calculation;

    calculate_score(thrust::device_vector<char> data_subsequence, char letter, thrust::device_vector<int> last_line_calculation, int position_letter) : data_subsequence(data_subsequence), letter(letter), last_line_calculation(last_line_calculation), position_letter(position_letter) {};

    __host__ __device__
    int operator()(const int& counting_i) {
        
        int i = counting_i;
        // int j = position_letter;
        int diagonal = 2;
        if (data_subsequence[i] == letter) {
            int diagonal = last_line_calculation[i-1] + 2;
        } else {
            int diagonal = last_line_calculation[i-1] - 1;
        }

        return diagonal;
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

    for (int i = 0; i < subsequences_a.size(); i++) {
        // char *subsequence_from_sequence_a = subsequences_a[i].data();
        device_vector<char> subsequence_a_gpu = subsequences_a[i];
        // int length_of_subsequence_a = strlen(subsequence_from_sequence_a);
        cout << subsequences_a[i].size() << endl;

        // cout << length_of_subsequence_a << endl;
        device_vector<int> calculation_temp;
        device_vector<int> calculation_score;

        // cout << calculation[0][0];

        // calculation[0].resize(subsequences_a[i].size()+1);
        // calculation[1].resize(subsequences_a[i].size()+1);
        thrust::fill(calculation_temp.begin(), calculation_temp.end(), 0);

        for (int j = 0; j < subsequences_b.size(); j++) {
            // char *subsequence_from_sequence_b = subsequences_b[j].data();
            // int length_of_subsequence_b = strlen(subsequence_from_sequence_b);

            // device_vector<char> data_subsequence_a;
            // thrust::copy(subsequences_a[i].begin(), subsequences_a[i].end(), data_subsequence_a);
            for (int t = 0; t < subsequences_b[j].size(); t++) {
                // cout << subsequence_from_sequence_b;
                // cout << endl;
                char letter_from_subsequence_b = subsequences_b[j][t];
                cout << letter_from_subsequence_b;
                cout << endl;
                for(int i = 0; i < subsequence_a_gpu.size(); i++) {
                    if (subsequence_a_gpu[i] == letter_from_subsequence_b) {
                        cout << "MATCH";
                    }
                    cout << subsequence_a_gpu[i];
                }
                cout << endl;

                // for(int i = 0; i < calculation[0].size(); i++) {
                //     cout << calculation[0][i];
                // }

                thrust::counting_iterator<int> counting(1);
                
                thrust::transform(counting, counting, calculation_score.begin() + 1, calculate_score(subsequence_a_gpu, letter_from_subsequence_b, calculation_temp, t));
            }

            // cout << "AQUI";
            // cout << calculation[1].begin();
            // cout << "AQUI";

            cout << calculation_score.size();

            for(int i = 0; i < calculation_score.size(); i++) {
                cout << calculation_score[i];
            }
            cout << endl;
        }
    }

    // cout << subsequences_a.size();
    // cout << endl;
    // cout << subsequences_b.size();



    // for (int i = 0; i < subsequences_a.size(); i++) {
    //     device_vector<int> s_temp(subsequences_a[i].size());
    //     device_vector<int> s_temp_final(subsequences_a[i].size());
    //     for (int j = 0; j < subsequences_b.size(); j++) {
    //         for (int t = 0; )
            
    //         if (i == 0) {
    //             for (int t = 0; t < subsequences_a[i].size(); t++) {
    //                 s_temp[t] = 0;
    //             }
    //         }
    //         if (j == 0) {
    //             s_temp[0] = 0;
    //         }
    //         // for (auto& el: s_temp) {
    //         //     cout << el;
    //         // }
    //         for(int t = 0; t < s_temp.size(); t++) {
    //             cout << s_temp[t];
    //         }
    //         cout << endl;
    //     }
    // }

    // if (subsequences_a.size() >= subsequences_b.size()) {
    //     for(int i = 0; i < subsequences_a.size(); i++) {
    //         for (int j = 0; j < subsequences_b.size(); j++) {
    //             for (int t = 0; t < subsequences_a[i].size(); t++) {
    //                 cout << subsequences_b[i][t];
    //                 for (int y = 0; y < subsequences_b[j].size(); y++) {
    //                     cout << subsequences_b[j][y];
    //                     cout << endl;

    //                     break;

    //                 }
    //             }
    //             // cout << endl;


    //             // cout << endl;
    //         }
    //     }
    // }

    // for (int i = 0; i < subsequences_a.size(); i++) {

    // }


    // for (auto& el: subsequences_a) {
    //     for (auto& element : el) {
    //         cout << element;
    //     }
    //     cout << endl;
    // }

    // for (auto& el: subsequences_b) {
    //     for (auto& element : el) {
    //         cout << element;
    //     }
    //     cout << endl;
    // }

    // device_vector<device_vector<char> > subsequences_a_gpu = subsequences_a;
    // device_vector<device_vector<char> > subsequences_b_gpu = subsequences_b;


    // for (int i = 0; i){
    //     host_vector<char> next_subsequence;

    // }



    // for (int i = 0; i < (1 << n); ++i) {
    //     string item;
    //     for (j = 0; j < n; ++j) {
    //         if (i & (1 << j)) {
    //             item += sequence[j];
    //         }
    //     }
    //     result.push_back(item);
    // }


    // int sum = 0;

    // host_vector<host_vector<char> > subsequences_a;

    // host_vector<char> dnas_first_seq_cpu_flexible = dnas_first_seq_cpu;

    // int k = dnas_first_seq_cpu.size();

    // while(dnas_first_seq_cpu_flexible.size() > 0) {
    //     host_vector<char> next_subsequence;
    //     for (int i = 0; i < k; i++) {
    //         next_subsequence.push_back(dnas_first_seq_cpu_flexible[i]);
    //     }
    //     subsequences_a.push_back(next_subsequence);
    //     k = dnas_first_seq_cpu_flexible.size() - 1;
    //     dnas_first_seq_cpu_flexible.erase(dnas_first_seq_cpu_flexible.begin());
    // }

    // for (auto& el: subsequences_a) {
    //     for (auto& element : el) {
    //         cout << element;

    //     }
    //     cout << endl;
    // }

    // for(int i = 0; i < dnas_first_seq_cpu.size(); i++) {
    //     host_vector<char> next_subsequence;
    //     next_subsequence.push_back(dnas_first_seq_cpu[])

    // }

    // while(dnas_first_seq_cpu_flexible.size() > 0) {
    //     for (int i = 0; i < dnas_first_seq_cpu_flexible.size(); i++) {
    //         for (int j = 0; j <= i; j++) {
    //             cout << dnas_first_seq_cpu[j];
    //         }
    //         // cout << endl;
    //     }
    //     dnas_first_seq_cpu_flexible.erase(dnas_first_seq_cpu_flexible.begin());
    // }

    // for (int i = 0; i < dnas_first_seq_cpu.size(); i++) {
    //     cout << dnas_first_seq_cpu[i];
    // }

    // for(int i = 0; i < dnas_first_seq_cpu_flexible.size(); i++) {
    //     for()
    // }




    // for(int i = 0; i < dnas_first_seq_cpu.size(); i++) {
    //     for(int j = i; j < dnas_first_seq_cpu.size(); j++) {
    //         next_subsequence.push_back(dnas_first_seq_cpu[j]);
    //     }
    //     subsequences_a.push_back(next_subsequence);
    //     next_subsequence.clear();
    // }

    // for(auto& el: subsequences_a) {
    //     for(auto& element: el) {
    //         cout << element;
    //     }
    //     cout << endl;
    // }

    // while(dnas_first_seq_flexible.size() - k + 1 > 0) {
    //     for (int i = 0; i < k; i++) {
    //         subsequences_a[counter].push_back(dnas_first_seq_flexible[i].dna_value);
    //     }
    //     counter++;
    //     dnas_first_seq_flexible.erase(dnas_first_seq_flexible.begin());
    // }

    // device_vector<device_vector<char> > subsequences_a_gpu = subsequences_a;

    // for(auto& el: subsequences_a_gpu) {
    //     for(auto& element: el) {
    //         cout << element;
    //     }
    //     cout << endl;
    // }

    // cout << sum;


    // int subsequence_size = 1;

    // for (int i = dnas_first_seq_cpu.size(); i > 1; i--) {
    //     for (int j = 0; j < subsequence_size; j++) {
    //         subsequences_a.push_back()
    //         // sum += 1;
    //     }
    // }


    // for (int i = 0; i < dnas_first_seq_cpu.size(); i++) {
    //     while(subsequence_size < dnas_first_seq_cpu.size()) {
    //         next_subsequence.push_back(i)
    //     }
    // }


    // while (counter < dnas_first_seq_cpu.size()) {
    //     for (int i = 0; i < counter; i++) {
    //         next_subsequence.push_back(dnas_first_seq_cpu[i]);
    //     }
    // }
    
    // device_vector<char> subsequences_a(sum);

    // cout << sum;

    // for (int i = dnas_first_seq_cpu.size(); i > 1; i--) {
    //     for (int j = 0; j < dnas_first_seq_cpu.size(); j++) {
    //         sum += 1;
    //     }
    // } 




    // for (int i = 0; i < n; i++) {
    //     cout << dnas_first_seq_cpu[i] << endl;
    // }

    // for (auto& el : dnas_first_seq_cpu) {
    //     cout << el;
    // }

    // dnas_first_seq_gpu = dnas_first_seq_cpu;
    // dnas_second_seq_gpu = dnas_second_seq_cpu;

    // device_vector<char> dnas_first_seq_gpu_flexible = dnas_first_seq_gpu;
    // device_vector<char> dnas_second_seq_gpu_flexible = dnas_second_seq_gpu;

    // int counter = 0;

    // int counter_outside = dnas_first_seq_gpu_flexible.size();

    // while(counter_outside > 0) {
    //     for (int j = 0; j < dnas_first_seq_gpu_flexible.size(); j++) {
    //         for (int i = 0; i < dnas_first_seq_gpu_flexible.size(); i++) {
    //             // subsequences_a[counter].push_back(dnas_first_seq_gpu[i]);
    //         }
    //         counter++;
    //         dnas_first_seq_gpu_flexible.erase(dnas_first_seq_gpu_flexible.begin());
    //     }
    //     dnas_first_seq_gpu_flexible = dnas_first_seq_gpu;
    //     counter_outside--;
    // }

    // double sum = 0;

    // cout << n << endl;

    // for(double i = 1; i < n + 1; i++) {

    //     cout << i << endl;
        
    //     cout << n / i << endl;

    //     sum += n / i;
    // }

    // cout << sum;


    
    


    // Como tratar s1 e s2 de tamanho diferente?

    // Como gerar simultaneamente N pares?


    return 0;
}