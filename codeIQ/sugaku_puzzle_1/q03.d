import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.array;

// Title
//   カードを裏返せ
// Description
//

int main(string[] args) {
    int n = 100;
    bool[] cards = new bool[n];
    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; j += i + 2) {
            cards[j] = !cards[j];
        }
    }
    for (int i = 0; i < n; ++i) {
        if (!cards[i])
            write(i+1, ", ");
    }
    writeln();
    return 0;
}

