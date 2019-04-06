#include <assert.h>
#include "strmatch.h"

#include <stdio.h>
int main()
{
//    char text[] = "abcabcaba";
//    char pattern[] = "abcaba";
//    printf("text=%s, pattern=%s, position=%d\n",
//        text,
//        pattern,
//        position(text, pattern));
//    printf("text=%s, pattern=%s, position=%d\n",
//        text,
//        pattern,
//        position_2(text, pattern));
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
    return 0;
}
