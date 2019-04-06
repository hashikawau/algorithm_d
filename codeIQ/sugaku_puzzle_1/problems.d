import std.stdio;
import std.file;
import std.algorithm;
import std.string;
import std.array;
import std.conv;
import std.range;
import std.random;

// Description
//   select next problem randomly, from not solved problems
// Specification
//   read problems.txt
//   group problems by solved or not solved
//   select problem randomly from not solved group

int main(string[] args)
{
    const allProblems = iota(1, 70 + 1).array;
    auto file = File("C:/Users/hashikawa/work/git/codeiq/sugaku_pazzle/problems.txt");
    const solvedProblems = file
        .byLine()
        .map!extractQuestionNumber
        .array
        ;
    writeln("solved_problems=%s".format(solvedProblems));
    auto notSolvedProblems = setDifference(allProblems, solvedProblems)
        .toarray;
    writeln("not_solved_problems=%s".format(notSolvedProblems));

    auto rnd = Random(unpredictableSeed);
    auto index = uniform(0, notSolvedProblems.length, rnd);
    writeln("next_problem=%s".format(notSolvedProblems[index]));

    return 0;
}

int extractQuestionNumber(const char[] line)
{
    const splits = line.split(":");
    if (splits.length == 0)
        return 0;

    const word = splits[0];
    if (!word.isNumeric)
        return 0;

    return word.to!int();
}

const(int)[] toarray(SetDifference!("a < b", const(int)[], const(int)[]) diff) {
    const(int)[] result = [];
    while (!diff.empty) {
        result ~= diff.front;
        diff.popFront();
    }
    return result;
}

unittest
{
    void test_extractQuestionNumber(string word, int expected) {
        assert(extractQuestionNumber(word) == expected);
    }
    test_extractQuestionNumber("01", 1);
    test_extractQuestionNumber("a", 0);
}

