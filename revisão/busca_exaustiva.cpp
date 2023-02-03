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

int num_leaf=0, num_copy=0;

bool value_of_batch_function (stock i,stock j) { return (i.value_of_batch>j.value_of_batch); }

double knapSack(int value_of_portfolio, vector<stock> stocks, vector<stock>& used, vector<stock>& best) {
    double value = 0.0;
    double value_of_batch = 0.0;
    double sem_i = 0.0, com_i = 0.0;
    vector<stock> stocks2 = stocks;

    if(stocks.empty() || value_of_portfolio == 0)
        return 0;

    if(stocks[0].value_of_batch <= value_of_portfolio){
        used.push_back(stocks[0]);
        value_of_batch = stocks[0].value_of_batch;
        value = stocks[0].return_of_batch - stocks[0].tax_of_batch;
        stocks.erase(stocks.begin());
        com_i = knapSack(value_of_portfolio - value_of_batch, stocks, used, best);
    }
    stocks2.erase(stocks2.begin());
    sem_i = knapSack(value_of_portfolio, stocks2, used, best);
    double actual_value = 0.0, best_value = 0.0;
    for(auto& el : used){
        actual_value = actual_value + el.return_of_batch - el.tax_of_batch;
    }
    for(auto& el : best){
        best_value = best_value + el.return_of_batch - el.tax_of_batch;
    }
    num_leaf++;
    if(actual_value > best_value)
        best = used;
        for (auto& el: best) {
            cout << el.id;
        }
        cout << endl;
        num_copy++;

    used.clear();
    return max(sem_i, value + com_i);
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

    // sort(stocks.begin(), stocks.end(), value_of_batch_function);

    for(auto& el: stocks) {
        cout << el.id;
    }

    cout << endl;

    vector<stock> used;
    vector<stock> best;

    double result = knapSack(value_of_portfolio, stocks, used, best);

    cout << result;

    cout << endl;

    for(auto& el: best) {
        cout << el.id;
    }

    cout << endl;

    cout << num_copy;

    cout << endl;

    cout << num_leaf;

    return 0;
}