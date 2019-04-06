int position(char text[], char pattern[])
{
    int i, j;

    i = j = 0;
    while (text[i] != '\0' && pattern[j] != '\0')
        if (text[i] == pattern[j]) { i++; j++; }
        else { i = i - j + 1; j = 0; }
    // find match
    if (pattern[j] == '\0') return i - j;
    // find no match
    return -1;
}

int position_2(char text[], char pattern[])
{
    int i, j, k, c;

    c = pattern[0]; i = 0;
    while (text[i] != 0) {
        if (text[i++] == c) {
            k = i; j = 1;
            while (text[k] == pattern[j] && pattern[j] != 0) {
                k++; j++;
            }
            // find match
            if (pattern[j] == '\0') return k - j;
        }
    }
    // find no match
    return -1;
}
