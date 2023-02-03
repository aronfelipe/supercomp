#include <iostream>
#include <vector>
#include <numeric>

using namespace std;

bool time_of_job_function (int i ,int j) { return (i>j); }

int main() {

    int number_of_jobs = 0;
    int number_of_machines = 0;

    cin >> number_of_jobs >> number_of_machines;

    vector<int> jobs;

    for(int i = 0; i < number_of_jobs; i++) {
        int time_of_job;
        cin >> time_of_job;
        jobs.push_back(time_of_job);
    }

    sort(jobs.begin(), jobs.end(), time_of_job_function);

    vector<vector<int> > matrix_of_machines;
    
    for(int i = 0; i < number_of_machines; i++) {
        vector<int> next_machine;
        matrix_of_machines.push_back(next_machine);
    }

    while(jobs.size() > 0) {
        vector<int> charges_of_machines;
        for (int j = 0; j < number_of_machines; j++) {
            int charge_of_machine = accumulate(matrix_of_machines[j].begin(), matrix_of_machines[j].end(), 0.0);
            charges_of_machines.push_back(charge_of_machine);
        }
        int min_position = 0;
        for (int i = 0; i < charges_of_machines.size(); i++)
        {
            if (charges_of_machines[i] < charges_of_machines[min_position])
                min_position = i;
        }
        int machine_to_be_used = min_position;
        matrix_of_machines[machine_to_be_used].push_back(jobs.front());
        jobs.erase(jobs.begin());
    }

    vector<int> values_of_charges_of_machines;

    for (auto& el: matrix_of_machines) {
        int sum = 0;
        for(auto& element: el){
            sum = sum + element;
        }
        values_of_charges_of_machines.push_back(sum);
    }

    int max_position = 0;
    for (int i = 0; i < values_of_charges_of_machines.size(); ++i)
    {
        if (values_of_charges_of_machines[i] > values_of_charges_of_machines[max_position])
            max_position = i;
    }

    cout << values_of_charges_of_machines[max_position];
}