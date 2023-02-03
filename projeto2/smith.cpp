#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct dna
{
    int id;
    char dna_value;
};

struct dna_matrix
{
    int id;
    int value;
};

int main() {

    // Defining n and m. Value of n is the length of the first sequence. Value of m is the length of the second sequence.
    int n = 0; int m = 0;

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

    vector

    for(int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            
        }
    }

    return 0;

}