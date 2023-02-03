#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
#include <cstdlib>

using namespace std;
struct dna
{
    int id;
    char dna_value;
};

int main() {

    // Defining n and m. Value of n is the length of the first sequence. Value of m is the length of the second sequence.
    int n; int m;

    // Reads n and m. 
    cin >> n >> m;

    // Defining the two vectors that receive the sequences.
    vector<dna> dnas_first_seq;
    vector<dna> dnas_second_seq;

    // Reserving n and m length on the vectors.
    dnas_first_seq.reserve(n);
    dnas_second_seq.reserve(m);

    dna dna_next;

    // Reads the first sequence and completes the dna_first_seq vector with the sequence.
    for(int i = 0; i < n; i++) {
        cin >> dna_next.dna_value;
        dna_next.id = i;
        dnas_first_seq.push_back(dna_next);
    }

    // Reads the second sequence and completes the dna_second_seq vector with the sequence.
    for(int i = 0; i < m; i++) {
        cin >> dna_next.dna_value;
        dna_next.id = i;
        dnas_second_seq.push_back(dna_next);
    }

    default_random_engine generator;
    uniform_int_distribution<int> distribution(1,m);
    int k = distribution(generator);
    vector<char> subsequence_b;

    for (int i = 0; i <= k; i++) {
        subsequence_b.push_back(dnas_second_seq[i].dna_value);
    }

    // for(auto& el: subsequence_b) {
    //     cout << el;
    // }

    int p = rand();

    vector<vector<char> > subsequences_a;

    for (int i = 0; i <= p; i++) {
        vector<char> subsequence_a;

        for (int j = 0; j <= k; j++) {
            uniform_int_distribution<int> distribution(1,n);
            int dna_to_select = distribution(generator);

            subsequence_a.push_back(dnas_first_seq[dna_to_select].dna_value);
        }
        subsequences_a.push_back(subsequence_a);
    }

    // for (auto& el: subsequence_b) {

    //     cout << el;

    // }

    vector<int> scores;

    int sum_score_pair = 0;

    for (int i = 0; i < subsequences_a.size(); i++) {
        for (int j = 0; j < subsequence_b.size(); j++) {
            if (subsequence_b[j] == subsequences_a[i][j]) {
                // cout << "AQUI";
                // cout << subsequence_b[j] << subsequences_a[i][j];
                sum_score_pair += 2;
            } else {
                sum_score_pair -= 1;
            }
        }
        cout << sum_score_pair;
        scores.push_back(sum_score_pair);

        sum_score_pair = 0;
    }

    // for (auto& el: subsequences_a) {
    //     for (auto& element: el) {
    //         for (auto& subseq : subsequence_b) {
    //             // cout << element;
    //             if (subseq == element) {
    //                 sum_score_pair += 2;
    //             } else {
    //                 sum_score_pair -= 1;
    //             }
    //         }
    //         scores.push_back(sum_score_pair);
    //         sum_score_pair = 0;
    //     }
    // }
    int score_max_index = max_element(scores.begin(),scores.end()) - scores.begin();

    cout << score_max_index;

    int counter = 0;

    // for (auto& el: subsequences_a) {
    //     for(auto& element: el) {
    //         cout << element;
    //     }
    // }
    
    for(auto& el: subsequences_a) {
        counter += 1;
        for(auto& element: el) {
            // cout << element;
            if (counter == score_max_index) {
                cout << element;
            }
        }
        cout << endl;
        if (counter == score_max_index) {
            break;
        }
    }

    for (auto& el: subsequence_b) {
        cout << el;
    }

    // cout << *max_element(scores.begin(), scores.end());
}