#include<iostream>
#include<vector>
#include<algorithm>

using namespace std;

struct item {
    int id;
    int weight;
    int value;
};

bool myfunction (item i,item j) { return (i.value>j.value); }

int main() {
    struct item i;
    int N = 0;
    int W = 0;

    int backpack_value = 0;
    int backpack_weight = 0;

    vector<item> items;

    cin >> N >> W;

    for (int j =0; j< N; j++) {
        i.id = j;
        cin >> i.weight >> i.value;
        items.push_back(i);
    }

    // for(auto& e: items) {
    //     cout << e.weight << endl;
    // }

    sort(items.begin(), items.end(), myfunction);

    vector<item> items_added;

    cout << W << endl;
    
    for(auto& e: items) {
        cout << e.weight << e.value << endl;
        backpack_weight = backpack_weight + e.weight;
        cout << backpack_weight << endl;

        if (backpack_weight <= W) {
            items_added.push_back(e);
            cout << e.id << endl;
            backpack_value = backpack_value + e.value;
        } else {
            backpack_weight = backpack_weight - e.weight;
        }
    }

    int sum = 0;
    for (auto& e: items_added) {
        
        cout << e.id << endl;
        sum = sum + e.value;
    }

    cout << sum;

    return 0;

}