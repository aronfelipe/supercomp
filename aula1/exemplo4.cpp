#include <iostream>

using namespace std;

int sqr_int(int x);

int main () {
    int t = 10;
    cout << sqr_int(t) << endl;
    return 0;
}

int sqr_int(int x) {
    return x*x;
}