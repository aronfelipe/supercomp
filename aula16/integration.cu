#include <thrust/device_vector.h>
#include <thrust/transform.h>
#include <thrust/sequence.h>

using namespace std;

int main() {

    int n = 100000 + 1;

    thrust::device_vector<float> x (n);
    thrust::device_vector<float> height (n);
    thrust::device_vector<float> width (n, 0.00001);
    thrust::device_vector<float> area (n);

    thrust::sequence(x.begin(), x.end(), 0.0f, 0.1f);

    thrust::transform(x.begin(), x.end(), height.begin(),  thrust::square<float>());

    thrust::transform(width.begin(), width.end(), height.begin(), area.begin(), thrust::multiplies<float>());
    
    float total_area = thrust::reduce(area.begin(), area.end());

    cout << total_area;

    return 0;


}