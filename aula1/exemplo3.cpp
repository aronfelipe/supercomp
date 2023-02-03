#include<iostream>
#include<vector>
using namespace std;
int main() {
    int x;
    int w[] = {1,2,3};
    cout << w[0] << endl;
    vector<int> v;
    cout << "Entre quantos números desejar" << endl;

    while (cin >> x) {
        v.push_back(x);
    }

    // int max;
    // int min;

    // for (auto& e: v) {
    //     cout << e << endl;
    //     if (e > max) {
    //         max = e;
    //     } else if (e < min) {
    //         min = e;
    //     }
    // }

    // cout << "Mínimo" << min << "Máximo" << max;

    size_t i = 0;
    size_t greatest_index = 0;
    size_t least_index = 0;

    while (i < v.size()) {
        if (v[1] > v[greatest_index]) 
        greatest_index = i;
        if(v[1] < v[least_index])
        least_index = i;
        i += 1;
    }

    if (v.empty()) {
        cout << "O vetor é vazio" << endl;
    } 
    else {
        cout << "Maior elemento " << v[greatest_index] << endl;
        cout << "Menor elemento " << v[least_index] << endl;
    }


    return 0;
}