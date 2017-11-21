#include <stdio.h>
#include "strmatch.h"

int main()
{
    char text[] = "abcabcaba";
    char pattern[] = "abcaba";
    printf("text=%s, pattern=%s, position=%d\n",
        text,
        pattern,
        position(text, pattern));
    printf("text=%s, pattern=%s, position=%d\n",
        text,
        pattern,
        position_2(text, pattern));
    return 0;
}
