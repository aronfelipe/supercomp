#include<iostream>
#include<vector>
#include<algorithm>
#include<random>
using namespace std;

int main() {
    struct item
    {
        int id;
        double peso;
        double valor;
        
    };

    int n = 0;
    int W = 0;

    vector<item> mochila;

    cin >> n >> W; //numero de elementos e peso
    // cout << "Numero de elementos = " << n << "\n";
    // cout << "Capacidade da mochila = " << W << "\n";

    //CRIAR O GERADOR E A SEMENTE

    default_random_engine generator;
    generator.seed(10);

    uniform_real_distribution<double> distribution(0.0, 1.0);


    vector<item> items;
    items.reserve(n);
    double peso, valor;
    for(int i = 0; i < n; i++) {
        cin >> peso;
        cin >> valor;
        items.push_back({i, peso, valor});
    }
    //ordenacao dos itens
    sort(items.begin(), items.end(), [](auto& i, auto& j){return i.valor > j.valor;});
    peso = 0;
    valor = 0;
    int i = 1; //controla a posicao para selecionar item ainda nao obtido
    for(auto& el : items){


       if (el.peso + peso <= W) {
           mochila.push_back(el);
           peso = peso + el.peso;
           valor = valor + el.valor;
       }

       if (distribution(generator) > 0.75 && i < n) {
           uniform_int_distribution<int> distributionInt(i, n-1);
           int p = distributionInt(generator);

           if(items[p].peso + peso <=W ) {
               mochila.push_back(items[p]);
               peso = peso + items[p].peso;
               valor = valor + items[p].valor;
               items.erase(items.begin()+p-1); //remove o p-esimo elemento
               n = n - 1;
           }
       }

        i = i + 1;


    }
    //essa ordenacao é necessaria para atender apenas o solicitado. 
    sort(mochila.begin(), mochila.end(), [](auto& i , auto& j){return i.id < j.id;});
    cout << peso << " " << valor << " 0" << "\n";

    for(auto& el: mochila) {
        cout << el.id << " ";
    }
    return 0;
}