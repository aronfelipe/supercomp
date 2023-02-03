#include <iostream>
#include <string>
#include <cmath>
#include <iomanip>

using namespace std;

int main() {
    int n;
    cout << "Digite um número: " << endl;
    cin >> n;

    float sum = 0;

    for (int i = 0; i < n; i++) {
        sum += 1/pow(2, i);
    }

    cout << "A resposta é " << fixed << setprecision(15) << sum << endl;

    return 0;
}