import std.stdio;
import std.string;
import std.conv;
import std.range;
import std.algorithm;

// Title
//   数列の四則演算
// Description
//   並んでいる数字の各桁の間に四則演算の演算子を入れて計算することにします。
//   (演算子を入れない場所があっても構いませんが、最低でも1つは入れるものとします)
//   出来上がった式を計算した結果、「元の数の桁を逆から並べた数字」と同じになるものを考えます。
//   1000 ～ 9999 のうち、上記の条件を満たす数を求めてください。

int main(string[] args) {
    int begin = 1000;
    int end = 9999;
    Ops[] opsList = makeComb(3);
    for (int i = begin; i <= end; ++i) {
        string number = i.to!string;
        auto reverseNumber = number.dup;
        reverse(reverseNumber);
        foreach(expression; makeExpressions(opsList, number)) {
            try {
                string evaled = evaluate(expression).to!string;
                //writeln("%s=%s ?= %s: %s".format(expression, evaled, reverseNumber, evaled == reverseNumber));
                if (evaled == reverseNumber)
                    writeln("%s = %s ?= %s".format(expression, evaled, reverseNumber));
            } catch (Error e) {
                //writeln("%s=%s ?= %s: %s".format(expression, "Nan", reverseNumber, false));
            }
        }
    }
    return 0;
}

string[] makeExpressions(Ops[] opsList, string number) {
    return opsList
        .map!(ops => ops.interleave(number))
        .array;
}

unittest {
    //writeln(makeExpressions("1234"));
}

struct Ops {
    const(char)[] _ops = [];

    this(const(char[]) ops) {
        _ops = ops;
    }
    Ops add(const char op) const {
        return Ops(_ops ~ op);
    }
    bool isAll(const char op) const {
        return _ops.all!(o => o == op);
    }
    string interleave(string number) const {
        assert(number.length - 1 == _ops.length);
        string result = "";
        for (int i = 0; i < _ops.length; ++i) {
            if (i > 0 && number[i] == 0 && _ops[i-1] == '/')
                return "";
            result ~= number[i];
            if (_ops[i] != ' ')
                result ~= _ops[i];
        }
        result ~= number[_ops.length];
        return result;
    }
}

Ops[] makeComb(int remains, Ops[] opsList = [Ops()]) {
    //const(char[]) possibles = [' ', '+', '-', '*', '/'];
    const(char[]) possibles = [' ', '*'];
    if (remains == 0)
        return opsList.filter!(ops => !ops.isAll(' ')).array;
    //writeln("i=%s, ops=%s".format(remains, opsList));
    return makeComb(
        remains - 1,
        possibles
            .map!(p => opsList
                .map!(ops => ops.add(p.to!char)))
            .join());
}

unittest {
    //writeln(makeComb(3));
}

int evaluate(string expression) {
    return calculate_1(expression.replace(" ", ""));
}

int calculate_1(string expression) {
    for (int i = 0; i < expression.length; ++i) {
        if (expression[i] == '+')
            return calculate_2(expression[0..i])
                + calculate_1(expression[i+1..$]);
        if (expression[i] == '-')
            return calculate_2(expression[0..i])
                - calculate_1(expression[i+1..$]);
    }
    return calculate_2(expression);
}

int calculate_2(string expression) {
    for (int i = 0; i < expression.length; ++i) {
        if (expression[i] == '*')
            return expression[0..i].to!int
                * calculate_2(expression[i+1..$]);
        if (expression[i] == '/')
            return expression[0..i].to!int
                / calculate_2(expression[i+1..$]);
    }
    return expression.to!int;
}

unittest {
    void test_evaluate(string expression, int expected) {
        auto result = evaluate(expression);
        writeln("expression: %s = %s".format(expression, result));
        assert(result == expected);
    }
    test_evaluate("1 - 1", 0);
    test_evaluate("1 + 1", 2);
    test_evaluate("1 * 3", 3);
    test_evaluate("4 / 2", 2);
    test_evaluate("2 * 3 + 2 * 4 - 4 * 3", 2);
    test_evaluate("1 2 - 1", 11);
}

