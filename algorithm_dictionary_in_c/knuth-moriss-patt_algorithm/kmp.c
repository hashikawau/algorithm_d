#include <stdio.h>
#include <stdlib.h>
/** M >= strlen(pattern) */
#define M 100

int position(char text[], char pattern[])
{
    int i, j;
    static int next[M + 1];

    if (pattern[0] == '\0')
        return 0;

    i = 1;
    j = 0;
    next[1] = 0;
    while (pattern[i] != '\0') {
        if (i >= M)
            return -1;

        if (pattern[i] == pattern[j]) {
            i++;
            j++;
            next[i] = j;
        } else if (j == 0){
            i++;
            next[i] = j;
        } else {
            j = next[j];
        }
    }

    i = 0;
    j = 0;
    while (text[i] != '\0' && pattern[j] != '\0') {
        if (text[i] == pattern[j]) { i++; j++; }
        else if (j == 0) i++;
        else j = next[j];
    }

    if (pattern[j] == '\0')
        return i - j;
    else
        return -1;
}
