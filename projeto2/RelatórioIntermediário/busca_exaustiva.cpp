#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

void create_subsequences(vector<char>& dnas, vector<vector<char> >& subsequences, vector<char>& subsequence, int index, int n){
    if (index == n){
        // Compares if subsequence string is in dnas string. If its in add it to the matrix.
        string subsequence_string(subsequence.begin(), subsequence.end());
        string dnas_string(dnas.begin(), dnas.end());
        if (dnas_string.find(subsequence_string) != string::npos) {
            subsequences.push_back(subsequence);
        }
    } else {
        subsequence.push_back(dnas[index]);
        create_subsequences(dnas, subsequences, subsequence, index + 1, n);
        subsequence.pop_back();
        create_subsequences(dnas, subsequences, subsequence, index + 1, n);

    }
}



int main() {

    // Defining n and m. Value of n is the length of the first sequence. Value of m is the length of the second sequence.
    int n; int m;

    // Reads n and m. 
    cin >> n >> m;

    // Defining the two vectors that receive the sequences.
    vector<char> dnas_first_seq;
    vector<char> dnas_second_seq;

    // Reserving n and m length on the vectors.
    dnas_first_seq.reserve(n);
    dnas_second_seq.reserve(m);

    char dna_next;

    // Reads the first sequence and completes the dna_first_seq vector with the sequence.
    for(int i = 0; i < n; i++) {
        cin >> dna_next;
        dnas_first_seq.push_back(dna_next);
    }

    // Reads the second sequence and completes the dna_second_seq vector with the sequence.
    for(int i = 0; i < m; i++) {
        cin >> dna_next;
        dnas_second_seq.push_back(dna_next);
    }
    
    // Creating matrixes that will contain the subsequences of a and b.
    vector<vector<char> > subsequences_a;
    vector<vector<char> > subsequences_b;

    vector<char> subsequence_a;
    vector<char> subsequence_b;

    // Creating subsequences recursively.
    create_subsequences(dnas_first_seq, subsequences_a, subsequence_a, 0, n);
    create_subsequences(dnas_second_seq, subsequences_b, subsequence_b, 0, m);

    // Erase duplicates.
    subsequences_a.erase(unique(subsequences_a.begin(), subsequences_a.end()), subsequences_a.end());
    subsequences_b.erase(unique(subsequences_b.begin(), subsequences_b.end()), subsequences_b.end());

    // Create matrix that will contain the scores.
    vector<vector<int> > scores;

    vector<int> scores_next;

    for (int i = 0; i < subsequences_a.size(); i++) {
        scores.push_back(scores_next);
    }

    int sum_score_pair = 0;

    // Calculate scores. If subsequence of a bigger than subsequence of b calculate
    // for all elements of b and the first elements of a that has the same size of 
    // b subsequence. Else the inverse.
    for (int i = 0; i < subsequences_a.size(); i++) {
        for (int j = 0; j < subsequences_b.size(); j++) {
            if (subsequences_a[i].size() > subsequences_b[j].size()) {
                for (int k = 0; k < subsequences_b[j].size(); k++) {
                    if (subsequences_a[i][k] == subsequences_b[j][k]) {
                        sum_score_pair+=2;
                    } else {
                        sum_score_pair-=1;
                    }
                }
            } else {
                for (int k = 0; k < subsequences_a[i].size(); k++) {
                    if (subsequences_a[i][k] == subsequences_b[j][k]) {
                        sum_score_pair+=2;
                    } else {
                        sum_score_pair-=1;
                    }
                }
            }
            scores[i].push_back(sum_score_pair);
            sum_score_pair = 0;
        }
    }

    int max_score = 0;

    int max_x = 0;
    int max_y = 0;


    // Get the max score and the subsequences correlated to the max score.
    for (int i = 0; i < scores.size(); i++) {
        for (int j = 0; j < scores[0].size(); j++) {
            if (scores[i][j] > max_score) {
                max_x = i;
                max_y = j;
                max_score = scores[i][j];
            }
        }
    }

    cout << max_score;
    cout << endl;

    for(auto& subsequence_a: subsequences_a[max_x]) {
        cout << subsequence_a;
    }

    cout << endl;

    for(auto& subsequence_b: subsequences_b[max_y]) {
        cout << subsequence_b;
    }


}