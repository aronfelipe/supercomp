#include <thrust/transform.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <iostream>

using namespace std;
using namespace thrust;

// __device__ int fact(int f)
// {
//   if (f == 0)
//     return 1;
//   else
//     return f * fact(f - 1);
// }


// struct generate_subsequences
// {
//     __host__ __device__
//     double operator()(const int& x) {

//     }
// };


int main() {

    double n = 0;
    double m = 0;

    cin >> n >> m;

    host_vector<char> dnas_first_seq_cpu;
    host_vector<char> dnas_second_seq_cpu;
    // device_vector<char> dnas_first_seq_gpu(n);
    // device_vector<char> dnas_second_seq_gpu(m);

    // device_vector<device_vector<char> > subsequences_b;

    dnas_first_seq_cpu.reserve(n);
    dnas_second_seq_cpu.reserve(m);
    // dnas_first_seq_gpu.reserve(n);
    // dnas_second_seq_gpu.reserve(m);

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

    // host_vector<host_vector<char> > subsequences_a;
    // host_vector<host_vector<char> > subsequences_b;

    host_vector<char> subsequences_a;
    host_vector<char> subsequences_b;
    host_vector<int> subsequences_a_length;
    host_vector<int> subsequences_b_length;


    while (dnas_first_seq_cpu_flexible.size() > 0) {
        while(k > 0) {
            // host_vector<char> next_subsequence;
            for (int j = 0; j < k; j++) {
                subsequences_a.push_back(dnas_first_seq_cpu_flexible[j]);
            }
            subsequences_a_length.push_back(k - 1);
            k = k - 1;
            // subsequences_a.push_back(next_subsequence);
            // next_subsequence.clear();
        }
        dnas_first_seq_cpu_flexible.erase(dnas_first_seq_cpu_flexible.begin());
        k = dnas_first_seq_cpu_flexible.size();
    }

    // while (dnas_second_seq_cpu_flexible.size() > 0) {
    //     while(l > 0) {
    //         host_vector<char> next_subsequence;
    //         for (int j = 0; j < l; j++) {
    //             next_subsequence.push_back(dnas_second_seq_cpu_flexible[j]);
    //         }
    //         l = l - 1;

    //         subsequences_a.push_back(next_subsequence);
    //         next_subsequence.clear();
    //     }
    //     dnas_second_seq_cpu_flexible.erase(dnas_second_seq_cpu_flexible.begin());
    //     l = dnas_second_seq_cpu_flexible.size();
    // }

    int iterator = 0;

    int counter = subsequences_a_length[iterator];

    // cout << counter;

    for (int i = 0; i < subsequences_a.size(); i++) {
        if (counter < 0) {
            iterator++;
            counter = subsequences_a_length[iterator];
            cout << endl;
        } else {
            cout << subsequences_a[i];
            counter--;
        }


    }

    // for (int i = 0; i < subsequences_a_length.size(); i++) {
    //     for (int j = 0; j < subsequences_a_length[i]; j++) {
    //         cout << subsequences_a[j];
    //     }
    //     cout << endl;
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