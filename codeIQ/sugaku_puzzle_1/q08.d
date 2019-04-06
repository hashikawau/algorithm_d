import std.stdio;
import std.string;
import std.conv;
import std.algorithm;

// Title
//   優秀な掃除ロボット
// Description
//   

int main(string[] args) {
    writeln(countPaths(12));
    return 0;
}

int countPaths(int number) {
    if (number <= 0)
        return 0;
    return countPaths_recursive(new Point(0, 0), number);
}

int countPaths_recursive(Point curr, int remains) {
    if (remains <= 0)
        return 1;
    return [curr.move(1, 0), curr.move(-1, 0), curr.move(0, 1), curr.move(0, -1)]
        .filter!(p => p.isNew())
        .map!(p => countPaths_recursive(p, remains - 1))
        .sum;
}

class Point {
    int _x;
    int _y;
    Point _parent;
    //Point[] _children;

    this(int x, int y, Point parent = null) {
        _x = x;
        _y = y;
        _parent = parent;
    }
    Point move(int dx, int dy) {
        return new Point(_x + dx, _y + dy, this);
    }
    //@property int x() const { return _x; }
    //@property int y() const { return _y; }
    bool isNew() {
        for (Point p = _parent; p !is null; p = p._parent) {
            if (_x == p._x && _y == p._y)
                return false;
        }
        return true;
    }
}

unittest {
    void test_countPaths(int number, int expected) {
        assert(countPaths(number) == expected);
    }
    test_countPaths(-1, 0);
    test_countPaths(0, 0);
    test_countPaths(1, 4);
    test_countPaths(2, 12);
    test_countPaths(3, 36);
}

