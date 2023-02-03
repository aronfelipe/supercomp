#include <iostream>
#include <vector>

using namespace std;

int main() {
    int x;
    vector<int> v;
    cout << "Entre quantos números quiser: " << endl;

    while (cin >> x) {
        v.push_back(x);
    }

    int maior_index;
    int menor_index;

    for (int n = 0; n <= v.size(); n++)
        if (v[n] > v[maior_index] {
            maior_index = n;
        }
        if (v[n] < v[menor_index]) {
            menor_index = n;
        }
    }
    if(v.empty()) {
        cout << "O vetor é vazio!" << endl;
    } else {
        cout << "O maior elemento é o " << v[greatest_index] << " e está na posição " << greatest_index << endl;
        cout << "O menor elemento é o " << v[least_index] << " e está na posição " << least_index << endl;]

        for (auto& e: v ) {
            cout << e << "\t";
        }
        cout << "\n";
    }

    //TODO: Percorra o vetor v e me devolva o maior elemento, menor elemento, e seus índices. 
    //DICA: para saber o tamanho de v, use v.size() 
    // v[0], v[1]....funciona 
    return 0;
}