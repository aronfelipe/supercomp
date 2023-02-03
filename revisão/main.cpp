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

double knapSack(int value_of_portfolio, vector<stock> stocks, vector<stock> best, vector<stock> used) {

    if(stocks.empty() || value_of_portfolio == 0) {
        return 0;
    } else {

        if (stocks[0].value_of_batch <= value_of_portfolio) {
            used.push_back(stocks[0]);
            knapSack(value_of_portfolio - stocks)
            stocks.erase(stocks.begin());

        }



    }




}

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

    for (auto& el: stocks) {
        cout << el.id;
    }

    vector<stock> best;
    vector<stock> used;

    double result = knapSack(value_of_portfolio, stocks, best, used);

}