#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct stock {
    int id;
    int value_of_batch;
    int return_of_batch;
    int tax_of_batch;
};

bool value_of_batch_function (stock i,stock j) { return (i.value_of_batch<j.value_of_batch); }

int main() {

    int number_of_stocks = 0;

    int value_of_portfolio = 0;

    cin >> number_of_stocks >> value_of_portfolio;

    vector<stock> stocks;

    stock next_stock;

    for (int i = 0; i < number_of_stocks; i++) {
        cin >> next_stock.id;
        cin >> next_stock.value_of_batch;
        cin >> next_stock.return_of_batch;
        cin >> next_stock.tax_of_batch;
        stocks.push_back(next_stock);
    }

    sort(stocks.begin(), stocks.end(), [](auto& i , auto& j){return i.value_of_batch < j.value_of_batch;});

    for (auto& el: stocks) {
        cout << el.id;
    }
}