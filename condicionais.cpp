#include <iostream>
#include <string>

using namespace std;

int main() {
    int x;
    cout << "Digite um número: " << endl;
    cin >> x;
    if (!cin) {
        cout << "Você não digitou um número" << endl;
        return 1;
    }

    int y;
    cout << "Digite um número: " << endl;
    cin >> y;
    if (!cin) {
        cout << "Você não digitou um número" << endl;
        return 1;
    }

    if (x > y) {
        cout << "O primeiro é maior que o segundo" << endl;
    } else if (x == y) {
        cout << "O primeiro é igual ao segundo" << endl;
    } else {
        cout << "O segundo é maior que o primeiro" << endl;
    }

    cout << "Digite dois números: " << endl;

    cin >> x >> y;
    cout << x << endl;
    cout << y << endl;

    return 0;
}