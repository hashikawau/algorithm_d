import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;

// Title
//   棒の切り分け
// Description
//

int main(string[] args) {
    writeln(countSeparation(8, 3));
    writeln(countSeparation(20, 3));
    writeln(countSeparation(100, 5));
    return 0;
}

int countSeparation(int lengthStick, int numDeviders) {
    return countSeparation_recursive(numDeviders, [lengthStick]);
}

unittest {
    assert(countSeparation(8, 3) == 4);
}

int countSeparation_recursive(int numDeviders, int[] remains, int accum = 0) {
    writeln("i=%s, %s".format(accum, remains));
    if (remains.empty)
        return accum;
    return countSeparation_recursive(
        numDeviders,
        sort!("a>b")(remains[0..min(numDeviders, $)]
            .map!(remain => [remain / 2, remain - remain / 2])
            .join
            .filter!(remain => remain > 1)
            .array
            ~ remains[min(numDeviders, $)..$]
        ).array,
        accum + 1
    );
}

