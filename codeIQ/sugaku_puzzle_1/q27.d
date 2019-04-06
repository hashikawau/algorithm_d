import std.algorithm;
import std.stdio;
import std.string;
import std.conv;
import std.array;

// Title
//   右折を禁止されても大丈夫？
// Description
//   直進か左折のみで目的地に到達する方法を考える。
//   6マスx4マスの場合、何通りの道順があるかを求める。

int main(string[] args) {
    writeln(calculate(6, 4));
    return 0;
}

int calculate(int x, int y) {
    assert(x > 0 && y > 0);

    Path[] paths = [Path()];
    while(!paths.all!(path => path.isFinished(x, y))) {
        paths = paths
            .map!(path => path.calcNext(x, y))
            .join()
            .filter!(path => path.isValid(x, y))
            .array;
        //writeln(paths);
    }
    foreach (path; paths)
        writeln(path);

    return paths.length;
}

struct Path {
    Point[] _points = [Point(0, 0), Point(1, 0)];
    @property Point[] points() { return _points; }

    this(Point[] points) {
        _points = points.dup;
    }

    @property Point curr() { return _points[_points.length - 1]; }
    @property Point prev() { return _points[_points.length - 2]; }

    Path[] calcNext(int maxX, int maxY) {
        if (isFinished(maxX, maxY))
            return [this];
        return [goStraight(), goLeft()];
    }

    bool isFinished(int maxX, int maxY) {
        return curr.x == maxX && curr.y == maxY;
    }

    Path goStraight() {
        assert(curr.x == prev.x || curr.y == prev.y);

        if (curr.x == prev.x)
            if (curr.y > prev.y)
                return Path(_points ~ Point(curr.x + 0, curr.y + 1));
            else
                return Path(_points ~ Point(curr.x + 0, curr.y - 1));
        else
            if (curr.x > prev.x)
                return Path(_points ~ Point(curr.x + 1, curr.y + 0));
            else
                return Path(_points ~ Point(curr.x - 1, curr.y + 0));
    }

    Path goLeft() {
        assert(curr.x == prev.x || curr.y == prev.y);

        if (curr.x == prev.x)
            if (curr.y > prev.y)
                return Path(_points ~ Point(curr.x - 1, curr.y + 0));
            else
                return Path(_points ~ Point(curr.x + 1, curr.y + 0));
        else
            if (curr.x > prev.x)
                return Path(_points ~ Point(curr.x + 0, curr.y + 1));
            else
                return Path(_points ~ Point(curr.x + 0, curr.y - 1));
    }

    bool isValid(int maxX, int maxY) {
        if (curr. x < 0 || curr.x > maxX || curr.y < 0 || curr.y > maxY)
            return false;
        for (int i = 1; i < _points.length - 1; ++i)
            if (_points[i] == curr && (_points[i - 1] == prev || _points[i + 1] == prev))
                return false;
        return true;
    }
}

unittest {
    void test_goStraight(Point[] path, Point expected) {
        Path before = Path(path);
        Path after = before.goStraight();
        writeln("test_goStraight: %s -> %s".format(before.curr, after.curr));
        assert(after.curr == expected);
    }
    test_goStraight([Point(0, 0), Point(1, 0)], Point(2, 0));
    test_goStraight([Point(0, 0), Point(0, 1)], Point(0, 2));
    test_goStraight([Point(0, 0), Point(-1, 0)], Point(-2, 0));
    test_goStraight([Point(0, 0), Point(0, -1)], Point(0, -2));
}

unittest {
    void test_goLeft(Point[] path, Point expected) {
        Path before = Path(path);
        Path after = before.goLeft();
        writeln("test_goLeft: %s -> %s".format(before.curr, after.curr));
        assert(after.curr == expected);
    }
    test_goLeft([Point(0, 0), Point(1, 0)], Point(1, 1));
    test_goLeft([Point(0, 0), Point(0, 1)], Point(-1, 1));
    test_goLeft([Point(0, 0), Point(-1, 0)], Point(-1, -1));
    test_goLeft([Point(0, 0), Point(0, -1)], Point(1, -1));
}

unittest {
    void test_isValid_1() {
        Path p;
        for (int i = 0; i < 3; ++i) {
            p = p.goStraight();
            writeln("p=%s, valid=%s".format(p, p.isValid(3, 2)));
        }
    }
    test_isValid_1();

    void test_isValid_2() {
        Path p;
        p = p.goLeft();
        for (int i = 0; i < 2; ++i) {
            p = p.goStraight();
            writeln("p=%s, valid=%s".format(p, p.isValid(3, 2)));
        }
    }
    test_isValid_2();

    void test_isValid_3() {
        Path p;
        p = p.goLeft();
        writeln("p=%s, valid=%s".format(p, p.isValid(3, 2)));
        p = p.goLeft();
        writeln("p=%s, valid=%s".format(p, p.isValid(3, 2)));
        p = p.goLeft();
        writeln("p=%s, valid=%s".format(p, p.isValid(3, 2)));
        p = p.goLeft();
        writeln("p=%s, valid=%s".format(p, p.isValid(3, 2)));
    }
    test_isValid_3();
}
struct Point {
    int _x;
    int _y;
    this(int x, int y) {
        _x = x;
        _y = y;
    }
    @property int x() { return _x; }
    @property int y() { return _y; }
}

unittest {
    assert(calculate(3, 2) == 4);
}

