#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <sstream>
#include <iterator>
using namespace std;
typedef vector<vector<int> > data;
bool check_element_in_array(int x, vector<int> v)
{
    if (find(v.begin(), v.end(), x) != v.end())
    {
        return true;
    }
    else
    {
        return false;
    }
}
bool comparaItens(int &a, int &b)
{
    return a < b;
}
int main()
{
    // Declarando variáveis necessárias
    int n_elementos, subconjuntos;
    vector<int> elementos_individuais;
    vector<int> elementos_cobertos;
    data dados;
    // Recebendo dados necessários
    cin >> n_elementos >> subconjuntos;
    for (int i = 0; i < n_elementos; i++)
    {
        elementos_individuais.push_back(i);
    }
    for (string line; getline(cin, line);)
    {
        vector<int> line_data;
        string s = line;
        stringstream ss(s);
        istream_iterator<string> begin(ss);
        istream_iterator<string> end;
        vector<string> splited_line(begin, end);
        for (string el : splited_line)
        {
            int i = stoi(el);
            line_data.push_back(i);
        }
        dados.push_back(line_data);
    }
    for (int conjunto : dados[dados.size() - 1])
    {
        for (int el : dados[conjunto])
        {
            if (!check_element_in_array(el, elementos_cobertos))
            {
                elementos_cobertos.push_back(el);
            }
        }
    }
    // Seção de Output
    // Ordenando vetor
    sort(elementos_cobertos.begin(), elementos_cobertos.end(), comparaItens);
    double size = elementos_cobertos.size();
    double cobertura = size / n_elementos;
    if (cobertura == 1)
    {
        cout << "\n\033[1;32m" << cobertura * 100 << "% dos elementos cobertos \033[0m" << endl;
    }
    else if (cobertura < 1 && cobertura > 0.75)
    {
        cout << "\n\033[1;36m" << cobertura * 100 << "% dos elementos cobertos \033[0m" << endl;
    }
    else if (cobertura < 0.75 && cobertura > 0.5)
    {
        cout << "\n\033[1;33m" << cobertura * 100 << "% dos elementos cobertos \033[0m" << endl;
    }
    else if (cobertura < 0.5 && cobertura > 0.25)
    {
        cout << "\n\033[1;35m" << cobertura * 100 << "% dos elementos cobertos \033[0m" << endl;
    }
    else
    {
        cout << "\n\033[1;31m" << cobertura * 100 << "% dos elementos cobertos \033[0m" << endl;
    }
    return 0;
}