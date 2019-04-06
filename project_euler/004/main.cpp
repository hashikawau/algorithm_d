#! /bin/env runcpp.sh

#include <iostream>
#include <vector>
#include <string>
#include <cmath>

bool isPalindrome(int x);
struct TwoPrimes{
    int first;
    int second;
};
/**
 *
 * @param integer number
 * @return two prime numbers of consisting the parameter.
 *         two prime numbers range is [100 ~ 999].
 *         if the parameter does not compose of two prime numbers,
 *         or if prime numbers range is out of [100 ~ 999],
 *         then return no values.
 */
std::vector<TwoPrimes> decomposeTwoPrimes(int x);

int main(int argc, char* argv[])
{
    int maxNum = 999 * 999;
    std::cout << "max number: " << maxNum << std::endl;
    for (int i = maxNum; i >= 0; --i)
    {
        if (!isPalindrome(i))
            continue;

        std::cout << "palindrome: " << i << std::endl;

        std::vector<TwoPrimes> primeFactors = decomposeTwoPrimes(i);
        if(primeFactors.size() > 0)
        {
            std::cout << "result: " << i << std::endl;
            std::cout << "prime factors: "<< primeFactors[0].first << " * " << primeFactors[0].second << " = " << primeFactors[0].first * primeFactors[0].second << std::endl;
            break;
        }

    }

    return 0;
}

std::vector<TwoPrimes> decomposeTwoPrimes(int x)
{
    const int min = 100;
    const int max = 999;

    std::vector<TwoPrimes> primeFactors;
    for(int i= min; i< max && i < std::sqrt(x); ++i)
    {
        if(x % i != 0)
            continue;

        int quotient = x / i;
        if(quotient >= 100 && quotient <= 999)
            primeFactors.push_back(TwoPrimes{i, quotient});
    }

    return primeFactors;
}

bool isPalindrome(int x)
{
    std::string str = std::to_string(x);
    for (size_t i = 0; i < str.size() / 2; ++i)
    {
        size_t headIndex = i;
        size_t tailIndex = str.size() - 1 - i;
//        std::cout << "head: " << str[headIndex] << ", tail: " << str[tailIndex] << std::endl;
        if (str[headIndex] != str[tailIndex])
            return false;
    }

    return true;
}

