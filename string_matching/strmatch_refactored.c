#include <string.h>

int position_1(char text[], char pattern[])
{
    int i, j;

    // length of string
    int len = strlen((char *)pattern);

    // error: length is 0
    if (len == 0)
        return -1;
    // error: length is longer than text
    if (len > strlen((char *)text))
        return -1;

    i = j = 0;
    while (text[i] != '\0' && pattern[j] != '\0') {
        if (text[i] == pattern[j]) {
            i++;
            j++;
        } else {
            i = i - j + 1;
            j = 0;
        }
    }
    // find match
    if (pattern[j] == '\0')
        return i - j;
    // find no match
    return -1;
}

int position(char text[], char pattern[])
{
    // length of string
    int len = strlen((char *)pattern);

    // error: length is 0
    if (len == 0)
        return -1;
    // error: length is longer than text
    if (len > strlen((char *)text))
        return -1;

    int c = pattern[0];
    for (int i = 0; text[i] != '\0'; ++i) {
        int k = i;
        int j = 0;
        while (text[k] == pattern[j] && pattern[j] != 0) {
            k++;
            j++;
        }
        // find match
        if (pattern[j] == '\0')
            return k - j;
    }
    // find no match
    return -1;
}
int isEqual(char substring[], char pattern[])
{
    int len = strlen(substring);
    if (len != strlen(pattern))
        return -1;
}
