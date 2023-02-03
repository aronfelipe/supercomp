#include<iostream>
#include<cmath>
#include<vector>
#include<iomanip>

using namespace std;

int main() {
    float n;
    float x;
    float sum1 = 0.0;
    float sum2 = 0.0;

    cin >> n;

    vector<float> nums;

    for (int i =0; i < n; i++) {
        cin >> x;
        nums.push_back(x);
    }
    for (auto& e: nums) {
        sum1 += e;
    }

    cout << sum1 << endl;

    float u = float(1/n) * float(sum1);

    for (auto& e: nums) {
        sum2 += pow(e - u, 2);
    }

    float theta = 1/n * sum2;

    cout << "u = " << setprecision(10) << u << " theta = " << theta << endl;

}