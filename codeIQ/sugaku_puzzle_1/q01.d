import std.stdio;
import std.string;
import std.conv;

// Description
//   10進数、2進数、8進数のいずれで表現しても回文数となる数のうち、
//   10進数の10以上で最小の値を求めてください。

int main(string[] args)
{
    for (int i = 10; true; ++i) {
        if (isPerfectPalindrome(i)) {
            writeln("answer=%s".format(i));
            break;
        }
    }
    return 0;
}

bool isPerfectPalindrome(int number)
{
    return isPalindromeInBase(number, 10)
        && isPalindromeInBase(number, 8)
        && isPalindromeInBase(number, 2);
}

bool isPalindrome(string word)
{
    for (int i = 0; i < word.length / 2; ++i) {
        if (word[i] != word[word.length - 1 - i])
            return false;
    }
    return true;
}

bool isPalindromeInBase(int number, int base)
{
    return number
        .to!string(base)
        .isPalindrome();
}

unittest {
}

