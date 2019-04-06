import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.range;

// Title
//   (改造版) コラッツの予想
// Description
//

int main(string[] args) {
    writeln(countTargetNumbers(10000));
    return 0;
}

int countTargetNumbers(int limit) {
    return iota(2, limit + 1)
        .filter!(i => isTargetNumber(i))
        .count;
}

bool isTargetNumber(int number) {
    int[] history = [];
    for (int n = number * 3 + 1; n != number; n = collatz(n)) {
        if (history.find(n).count > 0)
            return false;
        history ~= n;
    }
    return true;
}

int collatz(int number) {
    if (number % 2 == 0)
        return number / 2;
    else
        return 3 * number + 1;
}

