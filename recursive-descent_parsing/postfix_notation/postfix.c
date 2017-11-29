#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int ch;

/**
 * read 1 character.skip space character
 */
void readch(void)
{
    do {
        if ((ch = getchar()) == EOF) return;
    } while (ch == ' ' || ch == '\t');
}

void expression(void);

void factor(void)
{
    if (ch == '(') {
        readch(); expression();
        if (ch == ')') readch(); else putchar('?');
    } else if (isgraph(ch)) {
        putchar(ch); readch();
    } else putchar('?');
}

void term(void)
{
    factor();
    for ( ; ; )
        if (ch == '*') {
            readch(); factor(); putchar('*');
        } else if (ch == '/') {
            readch(); factor(); putchar('/');
        } else break;
}

void expression(void)
{
    term();
    for( ; ; )
        if (ch == '+') {
            readch(); term(); putchar('+');
        } else if (ch == '-') {
            readch(); term(); putchar('-');
        } else break;
}

int main()
{
    do {
        readch(); expression();
        while (ch != '\n' && ch != EOF) {
            putchar('?'); readch();
        }
    } while (ch != EOF);
    return EXIT_SUCCESS;
    return 0;
}
