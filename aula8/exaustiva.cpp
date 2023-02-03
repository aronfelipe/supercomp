#include <iostream>
#include <random>
#include <vector>

struct item {
    int id;
    int weight;
    int value;
};

using namespace std;

int recursion(int backpack_value, int W, vector<items> items) {

    if (backpack_value <= W) {
        recursion(backpack_value + )
    }

}

int main() {

    struct item i;
    int N = 0;
    int W = 0;

    vector<item> items_added;

    int backpack_value = 0;
    int backpack_weight = 0;

    vector<item> items;

    cin >> N >> W;

    for (int j = 0; j< N; j++) {
        i.id = j;
        cin >> i.weight >> i.value;
        items.push_back(i);
    }

    for(auto& el: items) {
        cout << el.value;
    }

    recursion(backpack_value, W, items)
    

}