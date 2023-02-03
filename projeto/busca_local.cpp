#include<iostream>
#include<vector>
#include<algorithm>
#include<random>
#include<string>
#include<stdio.h>
#include<sstream>

using namespace std;

int main() {

    int n = 0;
    int m = 0;

    cin >> n >> m;

    vector<int> best_solution;
    vector<int> solution;

    // Cria um vetor subsets que vai conter as substações criadas.
    vector<string> subsets;

    // Cria um vetor input que vai receber a entrada.
    vector<string> input(n);

    default_random_engine generator(10);
    uniform_real_distribution<double> distribution(0.0, 1.0);

    // Lê todos as substações.
    for (int i = 0; i < m+1; i++) {
        getline(cin, input[i]);
    }

    for (auto& el: input) {
        // Faz um split e lê cada linha da entrada.
        istringstream ss(el);
        string token;
        while (getline(ss, token, ' ')) {
            if (count(subsets.begin(), subsets.end(), token)) {
                ;
            }
            else {
                if (distribution(generator) > 0.99) {
                    subsets.push_back(token);
                }
            }
        }
    }

    for (auto& el: subsets) {
            cout << el << ' ';
    }




    return 0;
}