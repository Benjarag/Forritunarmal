#include <iostream>
#include <chrono>

using namespace std;
using namespace chrono;

int main() {
    auto start = high_resolution_clock::now();
    
    volatile int counter = 0;
    for (int i = 0; i < 100'000'000; ++i) {
        counter++;
    }
    
    auto end = high_resolution_clock::now();
    auto duration = duration_cast<milliseconds>(end - start);
    
    cout << "Time in C++: " << duration.count() << " milliseconds\n";
    return 0;
}