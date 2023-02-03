#include <iostream>
#include <string>
#include <cmath>
#include <vector>

using namespace std;

int main() {
    int n = 0;
    double media = 0.0;
    double desvpad = 0.0;

    cout << "Digite o valor de n: " << endl;
    cin >> n;
    vector<double> values;
    double input = 0.0;

    for (int i = 0; i < n; i++) {
        cin >> input;
        values.push_back(input);
        media = media + input;
    }

    media = media / n;

    for (auto valor: values) {
        desvpad = desvpad + ((valor - media) * (valor - media));
    }

    desvpad = desvpad / n;

    cout << media << "\t" << desvpad << endl;
}

// echo 40 | python3 ../insumos/aulas/02-03-implementacao-c++/t4.py | ./aula02_p2