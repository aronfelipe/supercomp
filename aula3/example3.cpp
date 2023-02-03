#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

typedef vector<vector<double> > matriz;

void calcula_distancias(matriz& mat, vector<double>& x, vector<double>& y) {
    int s = x.size();

    for (int i = 0; i < s; i++) {
        vector<double> linha;
        for (int j = 0; j < s; j++) {
            if (i > j) {
                double dx = x[i] - x[j];
                double dy = y[i] - y[j];
                linha.push_back(sqrt(dx*dx + dy*dy));
            }
        }
        mat.push_back(linha);
    }
}

int main() {

    matriz mat;

    vector <double> x, y;

    int n;
    cin >> n;
    x.reserve(n);
    y.reserve(n);

    for (int i = 0; i < n; i++) {
        double xt, yt;
        cin >> xt >> yt;
        x.push_back(xt);
        y.push_back(yt);
    }

    // int s = x.size();

    // for (int i = 0; i < s; i++) {
    //     vector<double> linha;
    //     for (int j = 0; j < s; j++) {
    //         double dx = x[i] - x[j];
    //         double dy = y[i] - y[j];
    //         linha.push_back(sqrt(dx*dx + dy*dy));
    //     }
    //     mat.push_back(linha);
    // }

    calcula_distancias(mat, x, y);

    for (auto linha: mat) {
        for (double el: linha) {
            cout << el << " ";
        }
        cout << endl;
    }

    return 0;
}