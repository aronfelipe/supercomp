#include <thrust/transform.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/iterator/counting_iterator.h>
#include <iostream>
#include <thrust/copy.h>

using namespace std;
using namespace thrust;

// struct saxpy
// {
//     // int a;    
//     // saxpy(int a_) : a(a_) {};
//     __host__ __device__
//     char operator()(const char& x, const char& y) {
//         printf("X : %s\n", x);
//         printf("Y : %s\n", y);

//         return x;

//         //    return a * x + y;
//     }
// };


// struct calculate_diagonal_insertion
// {
//     char letter;
//     char *data_subsequence;
//     int *last_line_calculation;

//     calculate_diagonal_insertion(char *_data_subsequence, char _letter, int *_last_line_calculation) : data_subsequence(_data_subsequence), letter(_letter), last_line_calculation(_last_line_calculation) {};

//     // thrust::device_vector<char> data_subsequence_final(data_subsequence.begin(), data_subsequence.end());

//     __host__ __device__
//     int operator()(const int& counting_i) {

//         // thrust::device_vector<double> v3(data_subsequence, data_subsequence + 10);
//         int i = counting_i;

//         // printf("v3[i]: %d\n", v3[i]);

//         int diagonal = 0;

//         if (data_subsequence[i] == letter) {
//             diagonal = last_line_calculation[i-1] + 2;
//         } else {
//             diagonal = last_line_calculation[i-1] - 1;
//         }

//         int insertion = last_line_calculation[i] - 1;
//         printf("last line : %d\n", last_line_calculation[i-1]);
//         // printf("last line : %d\n", data_subsequence[i]);

//         // printf("insertion : %d\n", insertion);

//         if (diagonal > insertion) {
//             if (diagonal > 0) {
//                 return diagonal;
//             } else {
//                 return 0;
//             }
//         } else {
//             if (insertion > 0) {
//                 // printf("PASSOU : %d\n", insertion);

//                 return insertion;
//             } else {
//                 return 0;
//             }
//         }

//     }
// };

struct calculate_diagonal_insertion
{
    char letter;
    char *data_subsequence;
    // int *last_line_calculation;

    calculate_diagonal_insertion(char *_data_subsequence, char _letter) : data_subsequence(_data_subsequence), letter(_letter){};

    // thrust::device_vector<char> data_subsequence_final(data_subsequence.begin(), data_subsequence.end());

    __host__ __device__
    int operator()(const int& counting_i) {

        // thrust::device_vector<double> v3(data_subsequence, data_subsequence + 10);
        int i = counting_i;

        // printf("v3[i]: %d\n", v3[i]);

        printf("data subsequence[i]: %d\n", data_subsequence[i]);

        int diagonal = 0;
        return diagonal;
        // if (data_subsequence[i] == letter) {
        //     diagonal = last_line_calculation[i-1] + 2;
        // } else {
        //     diagonal = last_line_calculation[i-1] - 1;
        // }

        // int insertion = last_line_calculation[i] - 1;
        // printf("last line : %d\n", last_line_calculation[i-1]);
        // printf("last line : %d\n", data_subsequence[i]);

        // printf("insertion : %d\n", insertion);

        // if (diagonal > insertion) {
        //     if (diagonal > 0) {
        //         return diagonal;
        //     } else {
        //         return 0;
        //     }
        // } else {
        //     if (insertion > 0) {
        //         // printf("PASSOU : %d\n", insertion);

        //         return insertion;
        //     } else {
        //         return 0;
        //     }
        // }

    }
};


// struct calculate_deletion
// {


//     // calculate_deletion() : data_subsequence(_data_subsequence), letter(_letter), last_line_calculation(_last_line_calculation) {};

//     __host__ __device__
//     int operator()(const int& i_1, const int& i) {
//         printf("I : %d\n", i);
//         printf("I - 1 : %d\n", i_1);

//         return i;
//         // // printf("J : %d\n", j);

//         // return i_1;

//         // if (i_1 - 1 > i)

//         // printf(counting_i);
//         // printf("Call for value : %d\n", counting_i);
//         // int i = counting_i;
//         // // int j = position_letter;
//         // int diagonal = 0;
//         // if (data_subsequence[i] == letter) {
//         //     diagonal = last_line_calculation[i-1] + 2;
//         // } else {
//         //     diagonal = last_line_calculation[i-1] - 1;
//         // }
//         // printf("Call for value : %d\n", diagonal);
//         // int insertion = last_line_calculation[i] - 1;
        
//         // int max_between_diagonal_insertion = std::max(diagonal, insertion);
//         // int max_between_diagonal_insertion_zero = std::max(max_between_diagonal_insertion, 0);

//         // return diagonal;
//     }
// };


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
    
    int max_score_global = 0;

    for (int i = 0; i < subsequences_a.size(); i++) {
        char *subsequence_from_sequence_a = subsequences_a[i].data();
        device_vector<char> subsequence_a_gpu = subsequences_a[i];
        // int length_of_subsequence_a = strlen(subsequence_from_sequence_a);
        device_vector<int> calculation_temp(subsequences_a[i].size() + 1);
        device_vector<int> calculation_score(subsequences_a[i].size() + 1);

        // int * calculation_temp_data = calculation_temp.data();

        // calculation[0].resize(subsequences_a[i].size()+1);
        // calculation[1].resize(subsequences_a[i].size()+1);
        thrust::fill(calculation_temp.begin(), calculation_temp.end(), 0);

        int max_score_subsequences = 0;

        for (int j = 0; j < subsequences_b.size(); j++) {
            char *subsequence_from_sequence_b = subsequences_a[j].data();
            // int length_of_subsequence_b = strlen(subsequence_from_sequence_b);
            device_vector<char> subsequence_b_gpu = subsequences_b[j];

            // device_vector<char> data_subsequence_a;
            // thrust::copy(subsequences_a[i].begin(), subsequences_a[i].end(), data_subsequence_a);
            for (int t = 0; t < subsequences_b[j].size(); t++) {
                // cout << subsequence_from_sequence_b;
                // cout << endl;

                char letter_from_subsequence_b = subsequences_b[j][t];
                // cout << letter_from_subsequence_b;
                // cout << endl;
                // for(int i = 0; i < subsequence_a_gpu.size(); i++) {
                //     cout << subsequence_a_gpu[i];
                // }
                // cout << endl;

                // for(int i = 0; i < calculation[0].size(); i++) {
                //     cout << calculation[0][i];
                // }
                thrust::host_vector<int> a(10);
                thrust::host_vector<int> b(10);
                thrust::host_vector<int> c(10);
                thrust::generate(a.begin(), a.end(), rand);
                thrust::generate(b.begin(), b.end(), rand);

                //transferimos para a GPU
                // thrust::device_vector<int> d_a = a;
                // thrust::device_vector<int> d_b = b;
                thrust::device_vector<int> counting(subsequence_a_gpu.size() + 1);
                
                for (int q = 1; q < subsequence_a_gpu.size() + 1; q++) {
                    counting[q] = q;
                }

                // thrust::transform(subsequence_a_gpu.begin(), subsequence_a_gpu.end(),
                //                 subsequence_b_gpu.begin(), subsequence_b_gpu.end(),
                //                 saxpy());

                // thrust::transform(d_a.begin(), d_a.end(),
                //     d_b.begin(), d_b.end(),
                //     saxpy());

                // thrust::transform(counting.begin(), counting.end(), calculation_temp.begin() + 1, calculate_diagonal_insertion(&thrust::raw_pointer_cast(subsequence_a_gpu.data()), letter_from_subsequence_b, &thrust::raw_pointer_cast(calculation_temp.data())));
                // thrust::transform(counting.begin(), counting.end(), calculation_temp.begin() + 1, calculate_diagonal_insertion(subsequence_from_sequence_a, letter_from_subsequence_b, calculation_temp.data()));
                thrust::transform(counting.begin(), counting.end(), calculation_temp.begin() + 1, calculate_diagonal_insertion(subsequence_from_sequence_a, letter_from_subsequence_b));

                // thrust::transform(calculation_score.begin() + 1, calculation_score.end(), calculation_temp.begin() + 1, calculation_temp.end(), calculate_deletion());
                // thrust::transform(calculation_score.begin() + 1, calculation_score.end(), calculation_temp.begin() + 1, calculate_deletion());
                // thrust::inclusive_scan(calculation_score.begin() + 1, calculation_score.end(), calculation_temp.begin() + 1, thrust::maximum<int>());

                // cout << calculation[1].size();
                // cout << endl;
                // for(int i = 0; i < calculation_score.size(); i++) {
                //     cout << calculation_score[i];
                //     cout << endl;
                // }

                int max = *max_element(calculation_temp.begin(), calculation_temp.end());

                if (max > max_score_global) {
                    for (auto& element: subsequences_a[i]) {
                        cout << element;
                    }
                    cout << endl;
                    for (auto& element: subsequences_b[j]) {
                        cout << element;
                    }
                    cout << endl;

                    max_score_global = max;
                }


                // cout << endl;
            }

            // cout << max_score_global;
            // if (max_score_subsequences > max_score_global) {
            //     max_score_global = max_score_subsequences;
            // }


        }
    }

    cout << max_score_global;
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