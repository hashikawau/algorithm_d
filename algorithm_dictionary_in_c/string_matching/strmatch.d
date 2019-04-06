int position(string text, string pattern)
{
    // error
    if (text.length == 0
    || pattern.length == 0
    || text.length < pattern.length)
        return -1;

    for (int i = 0; i < text.length - pattern.length + 1; ++i) {
        if(text[i .. i + pattern.length] == pattern)
            // find match
            return i;
    }

    // find no match
    return -1;
}
unittest
{
    assert(position("", "") == -1);
    assert(position("", "a") == -1);
    assert(position("", "abc") == -1);

    assert(position("a", "") == -1);
    assert(position("a", "a") == 0);
    assert(position("a", "b") == -1);
    assert(position("a", "abc") == -1);
    assert(position("a", "bcd") == -1);

    assert(position("abc", "a") == 0);
    assert(position("abc", "b") == 1);
    assert(position("abc", "c") == 2);
    assert(position("abc", "ab") == 0);
    assert(position("abc", "bc") == 1);
    assert(position("abc", "ac") == -1);
    assert(position("abc", "abc") == 0);
    assert(position("abcabc", "a") == 0);
    assert(position("abcabc", "b") == 1);
    assert(position("abcabc", "c") == 2);
    assert(position("abcabc", "ab") == 0);
    assert(position("abcabc", "bc") == 1);
    assert(position("abcabc", "ac") == -1);
    assert(position("abcabc", "abc") == 0);

    assert(position("abcabcaba", "abcaba") == 3);
}
