#include <thrust/device_vector.h>
#include <thrust/fill.h>
#include <thrust/iterator/constant_iterator.h>

using namespace std;
using namespace thrust;

int main() {

    int n = 1000

    device_vector<float> media (n);

    // fill(media.begin(), media.end(), 10);
    
    constant_iterator<int> iter(10);

    



    return 0;

}