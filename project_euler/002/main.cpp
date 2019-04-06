#! /bin/env runcpp.sh

#include <iostream>
#include <vector>
#include <stdexcept>

int calculateNewFibonacciNumber(const std::vector<int>& fibonacciSequence);

int main(int argc, char* argv[])
{
    //----------------------------------
    // generate Fibonacci Sequence
    //----------------------------------
    const int limit = 4000000;
    std::vector<int> fibonacciSequence =
    { 1, 2 };
    while (true)
    {
        const int num = calculateNewFibonacciNumber(fibonacciSequence);
        fibonacciSequence.push_back(num);

        if (num > limit)
            break;
    }
    // show sequence
    std::cout << "sequence: " << std::endl;
    for (int num : fibonacciSequence)
    {
        std::cout << num << ", ";
    }
    std::cout << std::endl;

    //----------------------------------
    // calculate summation of Fibonacci Sequence
    //----------------------------------
    int sum = 0;
    for (int e : fibonacciSequence)
    {
        if (e % 2 == 0)
            sum += e;
    }
    std::cout << "result: " << sum << std::endl;

    return 0;
}

int calculateNewFibonacciNumber(const std::vector<int>& fibonacciSequence)
{
    const size_t size = fibonacciSequence.size();
    if (size < 2)
        throw std::runtime_error(
                "input fibonacci sequence's size must be greater than 2");
    return fibonacciSequence[size - 2] + fibonacciSequence[size - 1];
}

