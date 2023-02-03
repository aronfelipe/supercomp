#include<iostream>
#include<vector>

using namespace std;

struct Item {
    int weight;
    int value;
};

int main() {
    int n = 0;
    cout << "Digite o valor de n: " << endl;
    cin >> n;
    vector<Item> values;
    int input = 0;

    for (int i = 0; i < n*2; i++) {
        cin >> input;
        Item item;
        item.weight = i;
        values.push_back(input);
    }

    cout << *max_element(values.begin(), values.end()) << endl;

    // cout << values << endl;

    return 0;
}