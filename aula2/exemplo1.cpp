#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

int main() {

    int n;
    cin >> n;
    cout << n << endl;
    float sum = 0.0;

    for (int i = 0; i < n; i++) {
        sum += 1/pow(2, i);
    }

    cout << setprecision(15) << sum;

    return 0;
}