import std.stdio;
import std.string;
import std.conv;
import std.range;
import std.algorithm;

// Title
//   いまだに現金払い?
// Description
//   1000 円を10円玉, 50円玉, 100円玉, 500円玉に両替するときの組み合わせはいくつか。
//   ただし、最大枚数は15枚までとする。

int main(string[] args) {
    const int[] coins = [500, 100, 50, 10];
    writeln(countCombinations(coins, 15, 1000));
    return 0;
}

int countCombinations(const int[] coins, int limit, int remains, const int[] accum = []) {
    if (remains == 0) {
        return 1;
    }
    if (remains < 0)
        return 0;
    if (accum.length >= limit)
        return 0;

    auto last = accum.length == 0
        ? coins[0]
        : accum[$-1];
    int index = coins.countUntil(last);
    return iota(index, coins.length - index)
        .map!(i => countCombinations(
            coins[i..$],
            limit,
            remains - coins[i],
            accum ~ coins[i]))
        .sum;
}

unittest {
}


