struct Point(T)
{
    private T _x;
    private T _y;
    public this(T x, T y){ _x = x; _y = y; }
    @property public T x(){ return _x; }
    @property public T y(){ return _y; }
}
struct Triangle(T)
{
    private Point!T _a;
    private Point!T _b;
    private Point!T _c;
    public this(Point!T a, Point!T b, Point!T c){ _a = a; _b = b; _c = c; }
    public bool contains(Point!T p)
    {
        auto vectorA = Point!T(
            _b.x - _a.x,
            _b.y - _a.y);
        auto vectorB = Point!T(
            _c.x - _a.x,
            _c.y - _a.y);
        auto vectorP = Point!T(
            p.x - _a.x,
            p.y - _a.y);
        // vectorP = s vectorA + t vectorB
        //         = [vectorA vectorB] * [s, t]
        // [s, t] = [vectorA vectorB]^-1 * vectorP
        //        = [vectorA.x vectorB.x]^-1 * [vectorP.x]
        //           vectorA.y vectorB.y        vectorP.y
        //        = 1/(A.x B.y - A.y B.x)[ B.y -B.x] * [vectorP.x]
        //                                -A.y  A.x     vectorP.y
        double determinant = vectorA.x * vectorB.y - vectorA.y * vectorB.x;
        double s = ( vectorB.y * vectorP.x - vectorB.x * vectorP.y) / determinant;
        double t = (-vectorA.y * vectorP.x + vectorA.x * vectorP.y) / determinant;
        return
            s >= 0
            && t >= 0
            && s + t <= 1;
    }
}
struct IsNotContained(T)
{
    public Point!T point;
    public bool notContained;
}
Point!T[] extractNotContained(T)(Point!T[] points)
{
    IsNotContained!T[] result = [];
    foreach(point; points) {
        result ~= IsNotContained!T(point, true);
    }

    import std.array;
    import std.algorithm;
    for(int i = 0; i < points.length; ++i) {
        for(int j = i + 1; j < points.length; ++j) {
            for(int k = j + 1; k < points.length; ++k) {
                for(int p = 0; p < points.length; ++p) {
                    if(p == i
                    || p == j
                    || p == k
                    || !result[p].notContained)
                        continue;
                    if(Triangle!T(points[i], points[j], points[k]).contains(result[p].point))
                        result[p].notContained = false;
                }
            }
        }
    }
    return result
        .filter!(r => r.notContained)
        .map!(r => r.point)
        .array;
}
struct Theta(T)
{
    public Point!T point;
    public double innerDot;
}
Point!T[] sortResult(T)(Point!T[] points)
{
    import std.array;
    import std.algorithm;
    Point!T minX = points
        .sort!((l, r) => l.x < r.x)
        .front;

    import std.math;
    Theta!T[] result = [];
    foreach(point; points[1..$]) {
        Point!double moved = Point!double(point.x - minX.x, point.y - minX.y);
        result ~= Theta!T(
            point,
            moved.y / sqrt(moved.x * moved.x + moved.y * moved.y));
    }

    return points[0] ~ result
        .sort!((l, r) => l.innerDot > r.innerDot)
        .map!(r => r.point)
        .array;
}
Point!T[] slowHull(T)(Point!T[] points)
{
    Point!T[] notContained = extractNotContained(points);
    Point!T[] sorted = sortResult(notContained);
    return sorted;
}
unittest
{
    assert(
        Triangle!int(
            Point!int(0, 0),
            Point!int(0, 3),
            Point!int(3, 3))
        .contains(
            Point!int(1, 2)) == true);
    assert(
        Triangle!int(
            Point!int(0, 0),
            Point!int(0, 3),
            Point!int(3, 3))
        .contains(
            Point!int(-1, 2)) == false);
    assert(
        slowHull([
            Point!int(0, 0),
            Point!int(0, 3),
            Point!int(1, 2),
            Point!int(2, 0),
            Point!int(3, 3),
            Point!int(3, 0)
            ])
        == [
            Point!int(0, 0),
            Point!int(0, 3),
            Point!int(3, 3),
            Point!int(3, 0)
            ]);
    assert(
        slowHull([
            Point!int(0, 0),
            Point!int(3, 0),
            Point!int(1, 2),
            Point!int(2, 0),
            Point!int(0, 3),
            Point!int(3, 3)
            ])
        == [
            Point!int(0, 0),
            Point!int(0, 3),
            Point!int(3, 3),
            Point!int(3, 0)
            ]);
    assert(
        slowHull([
            Point!int( 0,  0),
            Point!int( 3,  0),
            Point!int( 1,  2),
            Point!int( 2,  0),
            Point!int( 0,  3),
            Point!int(-1, -2),
            Point!int( 3,  3)
            ])
        == [
            Point!int(-1, -2),
            Point!int( 0,  3),
            Point!int( 3,  3),
            Point!int( 3,  0)
            ]);
}
