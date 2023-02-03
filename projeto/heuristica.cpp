#include<iostream>
#include<string>
#include<vector>
#include<stdio.h>
#include<sstream>

using namespace std;


int main () {

    string line;

    int n = 0;
    int m = 0;

    cin >> n >> m;

    vector<string> input(n);

    vector<string> substations_added;

    vector<string> subsets;

    vector<int> count_substations_not_added;

    for (int i = 0; i < m+1; i++) {
        getline(cin, input[i]);
    }

    while (true) {

        int found = 0;

        for (auto& el: input) {
            // cout << el << endl;

            istringstream ss(el);
            string token;

            int count_substation_not_added = 0;

            while(getline(ss, token, ' ')) {
                // cout << token << '\n';
                if (count(substations_added.begin(), substations_added.end(), token)) {
                    // cout << "Element found" << endl;
                }
                else {
                    // cout << "Element not found" << endl;
                    count_substation_not_added = count_substation_not_added + 1;
                    found = 1;
                }
            }

            // cout << count_substation_not_added << endl;

            count_substations_not_added.push_back(count_substation_not_added);
        }

        if (found == 0) {
            break;
        }

        // for(auto& el: count_substations_not_added) {
        //     cout << el << endl;
        // }
        
        // int count_max_substations_not_added = *max_element(count_substations_not_added.begin(), count_substations_not_added.end() - count_substations_not_added.begin());
        int index_count_max_substations_not_added = max_element(count_substations_not_added.begin(),count_substations_not_added.end()) - count_substations_not_added.begin();
        cout << index_count_max_substations_not_added << endl;

        int i = 0;

        for (auto& el: input) {
            // cout << el << endl;

            istringstream ss(el);
            string token;

            // cout << i << endl;

            // cout << index_count_max_substations_not_added << endl;

            if (index_count_max_substations_not_added == i) {
                // cout << "Entrei1" << endl;

                while (getline(ss, token, ' ')) {
                    // cout << "Entrei2" << endl;
                    // cout << token << endl;
                    if (count(substations_added.begin(), substations_added.end(), token)) {
                        cout << "Element found" << endl;
                    }
                    else {
                        substations_added.push_back(token);

                    }
                }
            }
            i = i + 1;
        }

        // for (auto& el: input) {
        //     // cout << el << endl;

        //     istringstream ss(el);
        //     string token;

        //     if (i == index_count_max_substations_not_added) {
        //         cout << "Entrei" << endl;
        //         cout << token << endl;
        //         while(getline(ss, token, ' ')) {
        //             cout << token << '\n';
        //             cout << "Entrei2" << endl;
        //             substations_added.push_back(token);
        //         }
        //     }
        //     i = i + 1;
        // }

        subsets.push_back(to_string(index_count_max_substations_not_added));

        cout << "AQUI" << endl;

        for (auto& el: subsets) {
            cout << el << endl;
        }

        // cout << "AQUI" << endl;
        // for(auto& el: substations_added) {
        //     cout << el << endl;
        // }

        count_substations_not_added.clear();
    }
}