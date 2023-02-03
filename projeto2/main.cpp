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
    int x_last;
    int y_last;
    int x_current;
    int y_current;
    char x_value;
    char y_value;
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

    // Creating the matrix that will be used to Smith-Waterman algorithm.
    vector<vector<dna_matrix> > matrix;

    vector<dna_matrix> line;

    dna_matrix line_matrix;

    // Creating the first line of zeros of the matrix.
    for (int i = 0; i <= n; i++) {
        line_matrix.id = i;
        line_matrix.value = 0;
        line_matrix.x_last = 0;
        line_matrix.y_last = 0;
        line.push_back(line_matrix);
    }
    matrix.push_back(line);

    // Creating the first column with zeros of the matrix.
    for (int i = 1; i <= n; i++) {
        vector<dna_matrix> line_loop;
        for (int j = 0; j <= m; j++) {
            if (j == 0){
                line_loop.push_back(line_matrix);
            } else {
                line_loop.push_back(line_matrix);
            }
        }
        matrix.push_back(line_loop);
    }

    // Loop over the matrix
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            int diagonal = 0;

            matrix[i][j].x_value = dnas_first_seq[i-1].dna_value;
            matrix[i][j].y_value = dnas_second_seq[j-1].dna_value;

            // Calculate the diagonal. Seeing if its a mismatch, a gap or a match.
            if (dnas_first_seq[i-1].dna_value == dnas_second_seq[j-1].dna_value) {
                diagonal = matrix[i-1][j-1].value + 2;
            } else {
                diagonal = matrix[i-1][j-1].value - 1;
            }

            // Calculate the delection.
            int delection = matrix[i-1][j].value - 1;
            // Calculate the insertion.
            int insertion = matrix[i][j-1].value - 1;
            // Get the maximum between diagonal, delection, insertion and 0.
            int max_between_diagonal_delection = max(diagonal,delection);
            int max_between_diagonal_delection_insertion = max(max_between_diagonal_delection, insertion);
            int max_between_diagonal_delection_insertion_zero = max(max_between_diagonal_delection_insertion, 0);
            matrix[i][j].value = max_between_diagonal_delection_insertion_zero;

            if (max_between_diagonal_delection_insertion_zero == diagonal) {
                matrix[i][j].x_last = i - 1;
                matrix[i][j].y_last = j - 1;
                matrix[i][j].x_current = i;
                matrix[i][j].y_current = j;
            } else if (max_between_diagonal_delection_insertion_zero == delection) {
                matrix[i][j].x_last = i - 1;
                matrix[i][j].y_last = j;
                matrix[i][j].x_current = i;
                matrix[i][j].y_current = j;
            } else if (max_between_diagonal_delection_insertion_zero == insertion) {
                matrix[i][j].x_last = i;
                matrix[i][j].y_last = j - 1;
                matrix[i][j].x_current = i;
                matrix[i][j].y_current = j;
            } else {
                matrix[i][j].x_last = i - 1;
                matrix[i][j].y_last = j - 1;
                matrix[i][j].x_current = i;
                matrix[i][j].y_current = j;
            }
        }
    }

    // for(auto& el: matrix) {
    //     for(auto& element: el) {
    //         cout << element.value;
    //     }
    //     cout << endl;
    // }

    // Get the max element of the matrix.
    dna_matrix max_element;
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            if (matrix[i][j].value > max_element.value) {
                max_element = matrix[i][j];
            }
        }
    }

    int i = max_element.x_current;
    int j = max_element.y_current;
    int value_max_element = max_element.value;

    vector<char> first_seq_answer;
    vector<char> second_seq_answer;

    // Get the best sequence.
    while (matrix[i][j].x_current != 0 || matrix[i][j].y_current != 0) {

        first_seq_answer.push_back(matrix[i][j].x_value);
        second_seq_answer.push_back(matrix[i][j].y_value);

        i = matrix[i][j].x_last;
        j = matrix[i][j].y_last;

        if (matrix[i][j].x_current == 0 || matrix[i][j].y_current == 0) {
            first_seq_answer.push_back(matrix[i][j].x_value);
            second_seq_answer.push_back(matrix[i][j].y_value);
            break;
        }
    }

    cout << value_max_element;

    cout << endl;

    for (auto& el: first_seq_answer) {
        cout << el;
    }

    cout << endl;

    for (auto& el: second_seq_answer) {
        cout << el;
    }

    return 0;
}
