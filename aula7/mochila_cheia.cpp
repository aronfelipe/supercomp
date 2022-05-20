#include <iostream>
#include <random>

struct item {
    int id;
    int weight;
    int value;
};

using namespace std;

int main() {

    struct item i;
    int N = 0;
    int W = 0;

    vector<item> items_added;

    int backpack_value = 0;
    int backpack_weight = 0;

    vector<item> items;

    cin >> N >> W;

    for (int j =0; j< N; j++) {
        i.id = j;
        cin >> i.weight >> i.value;
        items.push_back(i);
    }
    
    default_random_engine generator;

    for (int i =0; i < 10; i++) {
        for(auto& e: items) {
            // cout << e.weight << e.value << endl;
            backpack_weight = backpack_weight + e.weight;
            // cout << backpack_weight << endl;
            uniform_real_distribution<double> distribution(0,1);
            // cout << distribution(generator);
            if (distribution(generator) >= 0.5) {
                if (backpack_weight <= W) {
                    items_added.push_back(e);
                    // cout << e.id << endl;
                    backpack_value = backpack_value + e.value;
                } else {
                    backpack_weight = backpack_weight - e.weight;
                }
            } else {
                backpack_weight = backpack_weight - e.weight;
            }
        }
        for (auto& e: items) {
            if (backpack_weight + e.weight <= W) {
                items_added.push_back(e);
            }
        }

        for (auto& e: items_added) {
            cout << e.value;
        }

        cout << endl;
    }



    return 0;

}