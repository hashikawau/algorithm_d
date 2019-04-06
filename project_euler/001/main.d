#! /bin/env rdmd -unittest

import std.stdio;
import std.algorithm;
import std.range;

int main(string[] args)
{
    int[] factors = [3, 5];
    int[] naturalNumbers = iota(1, 1000).array;

    naturalNumbers
        .filter!(x => x.isMultipleOfAnyFactorOf(factors))
        .sum
        .writeln;

    return 0;
}

bool isMultipleOfAnyFactorOf(int x, int[] factors)
{
    return factors
        .any!(factor => x % factor == 0);
}

unittest {
}

