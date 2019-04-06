import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.string;

// Title
//   公平に分けられたケーキ
// Description
//   

int main(string[] args) {
    writeln(countCutLengthWhereEquqllyDevided(4, 4));
    writeln(countCutLengthWhereEquqllyDevided(16, 12));
    //writeln(countCutLengthWhereEquqllyDevided(30, 30));
    return 0;
}

int countCutLengthWhereEquqllyDevided(int m, int n) {
    return cut(m, n)
        .filter!(cutResult => cutResult.diff == 0)
        .array
        .sort!("a<b")
        .front
        .length;
}

struct CutResult {
    int length;
    int diff;
    this(int length, int diff) {
        this.length = length;
        this.diff = diff;
    }
    int opCmp(ref const CutResult s) const {
        if (length < s.length) return -1;
        if (length > s.length) return 1;
        if (diff < s.diff) return -1;
        if (diff > s.diff) return 1;
        return 0;
    }
}

CutResult[][string] cache;
CutResult[] cut(int m, int n) {
    if (m < n)
        return cut(n, m);
    if (m == 2 && n == 1)
        return [CutResult(1, 0)];

    string key = "%s,%s".format(m, n);
    if (key in cache)
        return cache[key];

    auto cutHorizontallyArray = iota(1, m/2+1)
        .map!(i => cut(m - i, n)
            .map!(r => CutResult(
                n + r.length,
                i * n - r.diff)))
        .join
        ;
    //writeln("---- 1: ", cutHorizontallyArray);
    auto cutVerticallyArray = iota(1, n/2+1)
        .map!(i => cut(m, n - i)
            .map!(r => CutResult(
                m + r.length,
                m * i - r.diff)))
        .join
        ;
    //writeln("---- 2: ", cutHorizontallyArray);
    auto arr = (cutHorizontallyArray ~ cutVerticallyArray)
        .sort!("a<b")
        .uniq
        .array
        ;
    writeln("---- 3: ", arr);
    cache[key] = arr;
    return arr;
}

unittest {
    void test_cut(int m, int n, CutResult[] expected) {
        auto actual = cut(m, n);
        assert(actual == expected, "m=%s, n=%s: actual=%s, expected=%s".format(m, n, actual, expected));
    }
    test_cut(2, 1, [
        CutResult(1, 0)
    ]);
    test_cut(2, 2, [
        CutResult(3, 2)
    ]);
    test_cut(3, 1, [
        CutResult(2, 1)
    ]);
    test_cut(3, 2, [
        CutResult(5, 0),
        CutResult(5, 2)
    ]);
    test_cut(4, 1, [
        CutResult(2, 2),
        CutResult(3, 0),
    ]);
    test_cut(4, 2, [
        CutResult(5, 2),
        CutResult(6, 2),
        CutResult(7, 0),
        CutResult(7, 2),
        CutResult(7, 4),
    ]);
}

