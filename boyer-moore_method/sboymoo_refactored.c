#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

int position(unsigned char text[], unsigned char pattern[])
{
    static int skip[UCHAR_MAX + 1];

    // length of string
    int len = strlen((char *)pattern);

    // error: length is 0
    if (len == 0)
        return -1;
    // error: length is longer than text
    if (len > strlen((char *)text))
        return -1;

    // last character
    unsigned char tail = pattern[len -1];
    if (len == 1) {
        // length is 1
        for (int i = 0; text[i] != '\0'; i++)
            if (text[i] == tail) return i;
    } else {
        // length is greater than 1
        for (int i = 0; i <= UCHAR_MAX; i++)
            skip[i] = len;
        for (int i = 0; i < len - 1; i++)
            skip[pattern[i]] = len - 1 - i;
        int i = len - 1;
        unsigned char c;
        while ((c = text[i]) != '\0') {
            if (c == tail) {
                int j = len - 1;
                int k = i;
                while (pattern[--j] == text[--k])
                    if (j == 0) return k; // find match
            }
            i += skip[c];
        }
    }
    // find no match
    return -1;
}
