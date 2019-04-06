import std.stdio;
import std.datetime;
import std.conv;
import std.algorithm;
import std.string;

// Title
//   日付の2進数変換
// Description
//   年月日をYYYYMMDDの8桁の整数で表したとき、これを2進数に変換して逆から並べ、
//   さらに10進数に戻したとき、元の日付と同じ日付になるものを探してください。
//   期間は、前回の東京オリンピック(1964年10月10日) から、
//   次回の東京オリンピック(2020年7年24日 予定) とします。

int main(string[] args) {
    auto end = DateTime(2020, 7, 24);
    //auto end = DateTime(1964, 10, 31);
    for (auto dt = DateTime(1964, 10, 10); dt < end; dt += 1.days) {
        auto yyyymmdd = dt
            .toISOString()[0..8];
        auto from_reverse_binary = yyyymmdd
            .to!int()
            .to!string(2)
            .reverse_()
            .toDecimal()
            .to!string()
            ;
        //writeln(from_reverse_binary);
        if (yyyymmdd == from_reverse_binary)
            writeln(yyyymmdd);
    }
    return 0;
}

T[] reverse_(T)(const T[] array) {
    T[] result = [];
    for (int i = array.length - 1; i >= 0; --i)
        result ~= array[i];
    return result;
}

int toDecimal(string binaryArray) {
    int result = 0;
    int base = 1;
    for (int i = binaryArray.length - 1; i >= 0; --i) {
        if (binaryArray[i] == '1')
            result += base;
        base *= 2;
    }
    return result;
}

unittest {
    void test_toDecimal(string target, int expected) {
        auto result = toDecimal(target);
        writeln("target=%s, -> %s".format(target, result));
        assert(result == expected);
    }
    test_toDecimal("0000", 0);
    test_toDecimal("0001", 1);
    test_toDecimal("0010", 2);
    test_toDecimal("0011", 3);
}

