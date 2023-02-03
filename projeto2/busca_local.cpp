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

    int score_max_global = 0;
    vector<char> subsequence_a_max_score_global;
    vector<char> subsequence_b_max_score_global;

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
    
    // Generate one thousand values for k in random form.
    for (int z = 0; z < 10000; z++) {
        random_device random;
        mt19937 generator(random());
        uniform_int_distribution<int> distribution(1,m);
        int k = distribution(generator);
        vector<char> subsequence_b;

        for (int i = 0; i < n; i++) {
            random_device random;
            mt19937 generator(random());
            uniform_int_distribution<int> distribution(1,999);
        }

        // Creates subsequence b with the first k elements of sequence b.
        for (int i = 0; i < k; i++) {
            subsequence_b.push_back(dnas_second_seq[i].dna_value);
        }

        // Creates matrix that will receive the subsequences of a.
        vector<vector<char> > subsequences_a;

        int counter = 0;
        vector<dna> dnas_first_seq_flexible = dnas_first_seq;

        // Create empty vectors inside the matrix.
        while(dnas_first_seq_flexible.size() - k + 1 > 0) {
            vector<char> subsequence_a;
            subsequences_a.push_back(subsequence_a);
            dnas_first_seq_flexible.erase(dnas_first_seq_flexible.begin());
        }
        
        dnas_first_seq_flexible = dnas_first_seq;

        // Create the subsequences of a.
        while(dnas_first_seq_flexible.size() - k + 1 > 0) {
            for (int i = 0; i < k; i++) {
                subsequences_a[counter].push_back(dnas_first_seq_flexible[i].dna_value);
            }
            counter++;
            dnas_first_seq_flexible.erase(dnas_first_seq_flexible.begin());
        }

        // Create vector of scores.
        vector<int> scores;

        int sum_score_pair = 0;
        // Generate scores.
        for (int i = 0; i < subsequences_a.size(); i++) {
            for (int j = 0; j < subsequences_a[0].size(); j++) {
                if (subsequences_a[i][j] == subsequence_b[j]) {
                    sum_score_pair += 2;
                } else {
                    sum_score_pair -= 1;
                }
            }
            scores.push_back(sum_score_pair);
            sum_score_pair = 0;
        }

        // Gets the index of the max score and the value.
        int score_max_index = max_element(scores.begin(),scores.end()) - scores.begin();
        int score_max = *max_element(scores.begin(), scores.end());

        // Compares max score global with actual max score. If max score global equals
        // to actual max score and if actual max score has subsequence bigger than 
        // max score global change max score global to actual max score and change subsequences.
        if (score_max == score_max_global) {
            if(subsequences_a[score_max_index].size() > subsequence_a_max_score_global.size()) {
                subsequence_a_max_score_global = subsequences_a[score_max_index];
                subsequence_b_max_score_global = subsequence_b;
            }
        }

        // If actual max score bigger than max score global change max score global and its subsequences.
        if (score_max > score_max_global) {
            score_max_global = score_max;
            subsequence_a_max_score_global = subsequences_a[score_max_index];
            subsequence_b_max_score_global = subsequence_b;
        }
    }

    cout << score_max_global << endl;

    for (auto& el: subsequence_a_max_score_global) {
        cout << el;
    }

    cout << endl;

    for (auto& el: subsequence_b_max_score_global) {
        cout << el;
    }
}