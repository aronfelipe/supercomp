#include<iostream>
#include<string>
#include<vector>
#include<stdio.h>
#include<sstream>

using namespace std;


int main () {

    // Lê da entrada o número de subconjuntos existentes e o número de casas.
    int n = 0;
    int m = 0;
    cin >> n >> m;

    // Cria um vetor input que vai receber a entrada.
    vector<string> input(n);

    // Cria um vetor substations_added que vai conter todas as casas abrangidas pelas substações.
    vector<string> substations_added;

    // Cria um vetor subsets que vai conter as substações criadas.
    vector<string> subsets;

    // Cria um vetor count_substations_not_added que vai conter todas as substações e seus respectivos valores de quantas ainda não foram abrangidas.
    vector<int> count_substations_not_added;

    // Lê todos as substações.
    for (int i = 0; i < m+1; i++) {
        getline(cin, input[i]);
    }

    // Entra em loop infinito.
    while (true) {

        int found = 0;

        for (auto& el: input) {

            // Faz um split e lê cada linha da entrada.
            istringstream ss(el);
            string token;

            int count_substation_not_added = 0;

            // Verifica se todas as casas já foram abrangidas.
            while(getline(ss, token, ' ')) {
                if (count(substations_added.begin(), substations_added.end(), token)) {
                    ;
                }
                else {
                    // Senão foram abrangidas adiciona um no counter count_substation_not_added.
                    count_substation_not_added = count_substation_not_added + 1;
                    found = 1;
                }
            }

            // Adiciona esse counter no vetor de counters para depois commparar e pegar a maior substação que atinge o maior número de casas.
            count_substations_not_added.push_back(count_substation_not_added);
        }

        // Se todas as casas já foram abrangidas sai do loop infinito.
        if (found == 0) {
            break;
        }
        
        // Pega o máximo da lista count_substations_not_added que vai ter o maior número de casas ainda não cobertas.
        int index_count_max_substations_not_added = max_element(count_substations_not_added.begin(),count_substations_not_added.end()) - count_substations_not_added.begin();

        int i = 0;

        // Faz um for nos elementos de input para colocar as casas dentro do vetor substations_added.
        for (auto& el: input) {

            istringstream ss(el);
            string token;

            // If index_count_max_substations_not_added for igual ao i entra e coloca as casas dentro da substations_added.
            if (index_count_max_substations_not_added == i) {
                while (getline(ss, token, ' ')) {
                    if (count(substations_added.begin(), substations_added.end(), token)) {
                        ;
                    }
                    else {
                        substations_added.push_back(token);
                    }
                }
            }
            i = i + 1;
        }

        // Adiciona aos subconjuntos o index_count_max_substations_not_added.
        subsets.push_back(to_string(index_count_max_substations_not_added));

        count_substations_not_added.clear();
    }

    for (auto& el: subsets) {
            cout << el << ' ';
    }
}