import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.range;

// Title
//   ルーレットの最大値
// Description
//

int main(string[] args) {
    writeln(countEuropeanIsLessThanAmerican(2, 36));
    return 0;
}

int countEuropeanIsLessThanAmerican(int min, int max) {
    int[] european = [0, 32, 15, 19,  4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30,  8, 23, 10,  5, 24, 16, 33,  1, 20, 14, 31,  9, 22, 18, 29,  7, 28, 12, 35,  3, 26];
    int[] american = [0, 28,  9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15,  3, 24, 36, 13,  1, 00, 27, 10, 25, 29, 12,  8, 19, 31, 18,  6, 21, 33, 16,  4, 23, 35, 14, 2];
    return iota(min, max + 1)
        .filter!(i => calcMaxN(european, i) < calcMaxN(american, i))
        .count;
}

int calcMaxN(int[] roulet, int n) {
    return iota(0, roulet.length)
        .map!(i => iota(0, n)
            .map!(j => roulet[(i + j) % $])
            .sum)
        .maxElement;
}


