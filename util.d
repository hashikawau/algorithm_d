
// ------------------------------------
// const, in, out, ref
// ------------------------------------
void aaa(int[] a)
//void aaa(in int[] a)
{
    a[0] = 3;
}

struct AA
{
    public int id;
    public string name;
    public BB bb;
    public this(int id, string name, string message)
    {
        this.id = id;
        this.name = name;
        this.bb = BB(message);
    }
}
struct BB
{
    public string message;
    public this(string message)
    {
        this.message = message;
    }
}

unittest
{
    int[] b = [1, 2, 3];
    //const int[] b = [1, 2, 3];
    aaa(b);
    // b[0] = 3;

    AA aa = AA(3, "aaaaa", "hello, world");
    aa.bb.message = "heeeeelo";
}

// ------------------------------------
// reduce
// ------------------------------------
V reduce(alias fun, V, R)(V x, R range)
    if(is(typeof(x = fun(x, range.front)))
        && is(typeof(range.empty) == bool)
        && is(typeof(range.popFront())))
{
    for(; !range.empty(); range.popFront())
    {
        x = fun(x, range.front);
    }
    return x;
}
unittest
{
    //auto f = (int a, int b){ return a + b; };
    int[] r = [10, 14, 3, 5, 23];
    // sum
    int sum = reduce!((a, b){ return a + b; })(0, r);
    assert(sum == 55);
    // min
    int min = reduce!((a, b){ return a < b? a: b; })(r[0], r);
    assert(min == 3);
}

// ------------------------------------
// UFCS(Uniform Function Call Syntax)
// ------------------------------------
@property bool empty(T)(T[] arr) { return arr.length == 0; }
@property ref T front(T)(T[] arr) { return arr[0]; }
void popFront(T)(ref T[] arr){ arr = arr[1 .. $]; }

// ------------------------------------
// find
// ------------------------------------
import std.conv: to;
T[] find(T, E)(T[] haystack, E needle)
    if(is(typeof(needle.to!(T)) == T))
{
    return find_helper(haystack, needle);
}

private T[] find_helper(T, E)(T[] haystack, E needle)
    if(is(typeof(needle.to!(T)) == T))
{
    if(haystack.length == 0)
        return null;
    else if(haystack[0] == needle.to!(T))
        return haystack[1..$];
    else
        return find_helper(haystack[1..$], needle);
}

unittest
{
    int[] a = [];
    assert(find(a, 5) == null);
    a = [1, 2, 3];
    assert(find(a, -1) == null);
    assert(find(a, 1) == [2, 3]);
    assert(find(a, 2) == [3]);
    import std.range;
    int numOfElems = 10000;
    a = iota(numOfElems).array;
    assert(find(a, -1) == null);
    assert(find(a, 0) == iota(1, numOfElems).array);
    assert(find(a, 1) == iota(2, numOfElems).array);
    assert(find(a, numOfElems - 1) == []);

    string[] b = [];
    assert(find!(string, string)(b, "-1") == null);
    b = ["1", "2", "3"];
    assert(find!(string, string)(b, "0") == null);
    assert(find!(string, string)(b, "1") == ["2", "3"]);
    assert(find!(string, string)(b, "2") == ["3"]);
    assert(find(b, 0) == null);
    assert(find(b, 1) == ["2", "3"]);
    assert(find(b, 2) == ["3"]);
}

// ------------------------------------
// swap
// ------------------------------------
void swap(ref int a, ref int b)
{
    int tmp = a;
    a = b;
    b = tmp;
}

unittest
{
    {
        int a = 1;
        int b = 2;
        util.swap(a, b);
        assert(a == 2);
        assert(b == 1);
    }
    {
        int a = -1000;
        int b = -2000;
        util.swap(a, b);
        assert(a == -2000);
        assert(b == -1000);
    }
}

// ------------------------------------
// crypt
// ------------------------------------
string encrypt(string target, uint key)
{
    // std.random is not suitable for this kind of purpose.
    import std.random;
    import std.algorithm;
    import std.conv;
    auto generator = Random(key);
    return target
        .map!(ch => (cast(uint)(ch) ^ uniform(0, 255, generator)).to!char())
        .to!string();
}
string decrypt(string target, uint key)
{
    import std.random;
    import std.algorithm;
    import std.conv;
    auto generator = Random(key);
    return target
        .map!(ch => (cast(uint)(ch) ^ uniform(0, 255, generator)).to!char())
        .to!string();
}

unittest
{
    string target1 = "hello, world";
    string target2 = "goodbye, world";
    uint key1 = 12345;
    uint key2 = 12354;
    //import std.stdio;
    //target1.encrypt(key1).writeln();
    //target1.encrypt(key1).decrypt(key1).writeln();
    //assert(target1.encrypt(key1) != target1);
    //assert(target1.encrypt(key1) != target1.encrypt(key2));
    //assert(target1.encrypt(key1) == target1.encrypt(key1));
    //assert(target1.encrypt(key1).decrypt(key1) == target1);
    //assert(target1.encrypt(key2).decrypt(key2) == target1);
    //assert(target1.encrypt(key1).decrypt(key2) != target1);
}

// ------------------------------------
// Permutation
// ------------------------------------
T[][] permutation(T)(T[] list, int num)
{
    import std.exception;
    enforce(list.length >= num, "list.length must be longer than num");

    return permutation_helper(list, num);
}

private T[][] permutation_helper(T)(T[] list, int num)
{
    if(list.length < num)
        return [];

    if(num <= 0 || list.length == 0)
        return [[]];

    import std.algorithm;
    import std.range;
    return iota(list.length)
        .map!(i => permutation_helper(list.dup().remove(i), num - 1)
            .map!(arr => [list[i]] ~ arr)
        )
        .joiner()
        .array();
}

unittest
{
    assert(permutation([1, 2, 3], 3) == [
        [1, 2, 3],
        [1, 3, 2],
        [2, 1, 3],
        [2, 3, 1],
        [3, 1, 2],
        [3, 2, 1]
    ]);
    assert(permutation([1, 2, 3], 2) == [
        [1, 2],
        [1, 3],
        [2, 1],
        [2, 3],
        [3, 1],
        [3, 2]
    ]);
    assert(permutation([1, 2, 3], 1) == [
        [1],
        [2],
        [3]
    ]);
    assert(permutation([1, 2, 3], 0) == [
        []
    ]);
    assert(permutation(["a", "b", "c"], 3) == [
        ["a", "b", "c"],
        ["a", "c", "b"],
        ["b", "a", "c"],
        ["b", "c", "a"],
        ["c", "a", "b"],
        ["c", "b", "a"]
    ]);
    assert(permutation(["a", "b", "c"], 2) == [
        ["a", "b"],
        ["a", "c"],
        ["b", "a"],
        ["b", "c"],
        ["c", "a"],
        ["c", "b"]
    ]);
    assert(permutation(["a", "b", "c"], 1) == [
        ["a"],
        ["b"],
        ["c"]
    ]);
    assert(permutation(["a", "b", "c"], 0) == [
        []
    ]);
    assert(permutation([1, 2, 3, 4], 4) == [
        [1, 2, 3, 4],
        [1, 2, 4, 3],
        [1, 3, 2, 4],
        [1, 3, 4, 2],
        [1, 4, 2, 3],
        [1, 4, 3, 2],

        [2, 1, 3, 4],
        [2, 1, 4, 3],
        [2, 3, 1, 4],
        [2, 3, 4, 1],
        [2, 4, 1, 3],
        [2, 4, 3, 1],

        [3, 1, 2, 4],
        [3, 1, 4, 2],
        [3, 2, 1, 4],
        [3, 2, 4, 1],
        [3, 4, 1, 2],
        [3, 4, 2, 1],

        [4, 1, 2, 3],
        [4, 1, 3, 2],
        [4, 2, 1, 3],
        [4, 2, 3, 1],
        [4, 3, 1, 2],
        [4, 3, 2, 1]
    ]);
    assert(permutation([1, 2, 3, 4], 3) == [
        [1, 2, 3],
        [1, 2, 4],
        [1, 3, 2],
        [1, 3, 4],
        [1, 4, 2],
        [1, 4, 3],

        [2, 1, 3],
        [2, 1, 4],
        [2, 3, 1],
        [2, 3, 4],
        [2, 4, 1],
        [2, 4, 3],

        [3, 1, 2],
        [3, 1, 4],
        [3, 2, 1],
        [3, 2, 4],
        [3, 4, 1],
        [3, 4, 2],

        [4, 1, 2],
        [4, 1, 3],
        [4, 2, 1],
        [4, 2, 3],
        [4, 3, 1],
        [4, 3, 2]
    ]);
    assert(permutation([1, 2, 3, 4], 2) == [
        [1, 2],
        [1, 3],
        [1, 4],

        [2, 1],
        [2, 3],
        [2, 4],

        [3, 1],
        [3, 2],
        [3, 4],

        [4, 1],
        [4, 2],
        [4, 3]
    ]);
    assert(permutation([1, 2, 3, 4], 1) == [
        [1],
        [2],
        [3],
        [4]
    ]);
    assert(permutation([1, 2, 3, 4], 0) == [
        []
    ]);
}

// ------------------------------------
// Combination
// ------------------------------------
T[][] combination(T)(T[] list, int num)
{
    import std.exception;
    enforce(list.length >= num, "list.length must be longer than num");

    return combination_helper(list, num);
}

private T[][] combination_helper(T)(T[] list, int num)
{
    if(list.length < num)
        return [];

    if(num <= 0)
        return [[]];

    import std.algorithm;
    import std.range;
    return iota(list.length)
        .map!(i => combination_helper(list[i+1 .. $], num - 1)
            .map!(arr => [list[i]] ~ arr)
        )
        .joiner
        .array;
}

unittest
{
    assert(combination([1, 2, 3], 3) == [
        [1, 2, 3]
    ]);
    assert(combination([1, 2, 3], 2) == [
        [1, 2],
        [1, 3],
        [2, 3]
    ]);
    assert(combination([1, 2, 3], 1) == [
        [1],
        [2],
        [3]
    ]);
    assert(combination([1, 2, 3], 0) == [
        []
    ]);
    assert(combination(["a", "b", "c"], 3) == [
        ["a", "b", "c"]
    ]);
    assert(combination(["a", "b", "c"], 2) == [
        ["a", "b"],
        ["a", "c"],
        ["b", "c"]
    ]);
    assert(combination(["a", "b", "c"], 1) == [
        ["a"],
        ["b"],
        ["c"]
    ]);
    assert(combination(["a", "b", "c"], 0) == [
        []
    ]);
    assert(combination([1, 2, 3, 4], 4) == [
        [1, 2, 3, 4]
    ]);
    assert(combination([1, 2, 3, 4], 3) == [
        [1, 2, 3],
        [1, 2, 4],
        [1, 3, 4],
        [2, 3, 4]
    ]);
    assert(combination([1, 2, 3, 4], 2) == [
        [1, 2],
        [1, 3],
        [1, 4],
        [2, 3],
        [2, 4],
        [3, 4]
    ]);
    assert(combination([1, 2, 3, 4], 1) == [
        [1],
        [2],
        [3],
        [4]
    ]);
    assert(combination([1, 2, 3, 4], 0) == [
        []
    ]);
}

// ------------------------------------
// marriage
// ------------------------------------
class Decision
{
    public static Decision create()
    {
        return new Decision();
    }

    private string[] girls;
    private string[] boys;
    private string[][string] girlsBoyRanking;
    private string[][string] boysGirlRanking;

    public Decision addGirl(string name)
    {
        girls ~= name;
        return this;
    }
    public Decision addBoy(string name)
    {
        boys ~= name;
        return this;
    }

    public Decision setGirlsBoyRanking(string name, string[] rankList)
    {
        girlsBoyRanking[name] = rankList;
        return this;
    }
    public Decision setBoysGirlRanking(string name, string[] rankList)
    {
        boysGirlRanking[name] = rankList;
        return this;
    }

    public ResultTable execute()
    {
        int[Pair] pairScore = createPairScore();

        import std.algorithm;
        import std.range;
        import std.typecons;
        CombinationScore highest = permutation(boys, girls.length)
            .map!(boyList => zip(girls, boyList)
                .map!(t => Pair(t[0], t[1])))
            .map!(pairs => CombinationScore(
                pairs.array,
                reduce!((score, pair) => score * pairScore[pair])(1, pairs)))
            .array
            .sort!((l, r) => l.combinationScore < r.combinationScore)
            [0]
            ;

        string[string] dictionary;
        foreach(pair; highest.pairs)
        {
            dictionary[pair.girl] = pair.boy;
            dictionary[pair.boy] = pair.girl;
        }
        return ResultTable(dictionary);
    }
    private int[Pair] createPairScore()
    {
        int[Pair] girlToBoyRank;
        foreach(girlName, boyRanking; girlsBoyRanking){
            foreach(i, boyName; boyRanking){
                girlToBoyRank[Pair(girlName, boyName)] = i + 1;
            }
        }
        int[Pair] boyToGirlRanking;
        foreach(boyName, girlRanking; boysGirlRanking){
            foreach(i, girlName; girlRanking){
                boyToGirlRanking[Pair(girlName, boyName)] = i + 1;
            }
        }
        int[Pair] pairScore;
        foreach(girlName; girls){
            foreach(boyName; boys){
                Pair p = Pair(girlName, boyName);
                pairScore[p] = girlToBoyRank[p] * boyToGirlRanking[p];
            }
        }
        return pairScore;
    }
    struct Pair
    {
        private string _girl;
        private string _boy;
        public this(string girl, string boy)
        {
            this._girl = girl;
            this._boy = boy;
        }
        @property
        public string girl(){ return _girl; }
        @property
        public string boy(){ return _boy; }
    }
    struct CombinationScore
    {
        private Pair[] _pairs;
        private int _combinationScore;
        public this(Pair[] pairs, int combinationScore)
        {
            this._pairs = pairs;
            this._combinationScore = combinationScore;
        }

        @property
        public Pair[] pairs(){ return _pairs; }
        @property
        public int combinationScore(){ return _combinationScore; }
    }
}

struct ResultTable
{
    private string[string] dictionary;

    public this(string[string] dictionary)
    {
        this.dictionary = dictionary;
    }

    public string partnerOf(string name)
    {
        return dictionary.get(name, "none");
    }
}

unittest
{
    Decision d = Decision.create()
        .addGirl("a")
        .addGirl("b")
        .addGirl("c")
        .addBoy("x")
        .addBoy("y")
        .addBoy("z")
        .setGirlsBoyRanking("a", ["x", "y", "z"])
        .setGirlsBoyRanking("b", ["x", "z", "y"])
        .setGirlsBoyRanking("c", ["y", "x", "z"])
        .setBoysGirlRanking("x", ["b", "c", "a"])
        .setBoysGirlRanking("y", ["c", "b", "a"])
        .setBoysGirlRanking("z", ["a", "b", "c"]);
    ResultTable result = d.execute();
    assert(result.partnerOf("a") == "z");
    assert(result.partnerOf("b") == "x");
    assert(result.partnerOf("c") == "y");
    assert(result.partnerOf("x") == "b");
    assert(result.partnerOf("y") == "c");
    assert(result.partnerOf("z") == "a");
}






