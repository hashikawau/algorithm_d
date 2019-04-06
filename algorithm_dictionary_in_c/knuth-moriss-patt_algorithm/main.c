#include <stdio.h>
#include "kmp.h"

int main()
{
    char text[] = "abcabcaba";
    char pattern[] = "abcaba";
    printf("text=%s, pattern=%s, position=%d\n",
        text,
        pattern,
        position(text, pattern));
    return 0;
}
