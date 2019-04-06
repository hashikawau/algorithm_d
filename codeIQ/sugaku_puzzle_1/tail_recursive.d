import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import std.string;
import std.datetime;

int main(string[] args) {
    int n = 100000;
    count_time(() => writeln(sum_by_loop(n)));
    count_time(() => writeln(sum_recursively(n)));
    return 0;
}

void count_time (Runner) (Runner runner) {
    auto sw = StopWatch();
    auto r = benchmark!(runner)(1);
    writeln(r[0].msecs, "[ms]");
}

double sum_by_loop (int count) {
    double sum = 0;
    for (int i = 0; i <= count; ++i) {
        sum += i;
    }
    return sum;
}

double sum_recursively(int remains, double accum = 0) {
    if (remains <= 0) return accum;
    else              return sum_recursively(remains - 1, accum + remains);
}

