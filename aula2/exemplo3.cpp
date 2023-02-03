#include<iostream>
#include<vector>

using namespace std;
int main() {

    float n = 0;
    float x_value;
    float y_value;

    cin >> n;

    vector<vector> nums;

    vector<float> x;
    vector<float> y;

    for (int i = 0; i < n; i++) {
        cin >> x_value;
        x.push_back(x_value);
        cin >> y_value;
        y.push_back(y_value);
    }

    nums.push_back(x);
    nums.push_back(y);

    return 0;
}