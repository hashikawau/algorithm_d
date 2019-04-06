#! /bin/env runcpp.sh

#include <iostream>
#include <vector>

int addMultiplesOfPrimes(int maxNumber);
bool isMultipleOfPrimes(int x, const std::vector<int>& primeNumbers = { 3, 5 });

int main(int argc, char* argv[])
{
    const int maxNumber = 1000;
    const int sum = addMultiplesOfPrimes(maxNumber);
    std::cout << "result: " << sum << std::endl;

    return 0;
}

int addMultiplesOfPrimes(int maxNumber)
{
    int sum = 0;
    for (int i = 0; i < maxNumber; ++i)
        if (isMultipleOfPrimes(i))
            sum += i;

    return sum;
}

bool isMultipleOfPrimes(int x, const std::vector<int>& primeNumbers)
{
    for (int primeNumber : primeNumbers)
        if (x % primeNumber == 0)
            return true;

    return false;
}

