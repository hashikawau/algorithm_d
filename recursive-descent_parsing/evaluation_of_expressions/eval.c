#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int ch;

void error(char *s)
{
    printf("%s\n", s); exit(EXIT_FAILURE);
}

void readch(void)
{
    do {
        if ((ch = getchar()) == EOF) return;
    } while (ch == ' ' || ch == '\t');
}

double number(void)
{
    double x, a;
    int sign = '+';

    if (ch == '+' || ch == '-') {
        sign = ch; readch();
    }
    if (! isdigit(ch)) error("not a number or '('");
    x = ch - '0';
    while (readch(), isdigit(ch))
        x = 10 * x + ch - '0';
    if (ch == '.') {
        a = 1;
        while (readch(), isdigit(ch))
            x += (a /= 10) * (ch - '0');
    }
    if (sign == '-') return -x; else return x;
}

double expression(void);

double factor(void)
{
    double x;

    if (ch != '(') return number();
    readch(); x = expression();
    if (ch != ')') error("not a ')'");
    readch(); return x;
}

double term(void)
{
    double x, y;

    x = factor();
    for ( ; ; )
        if (ch == '*') {
            readch(); x *= factor();
        } else if (ch == '/') {
            readch(); y = factor();
            if (y == 0) error("cannot divide by 0");
            x /= y;
        } else break;
    return x;
}

double expression(void)
{
    double x;

    x = term();
    for ( ; ; )
        if (ch == '+') {
            readch(); x += term();
        } else if (ch == '-') {
            readch(); x -= term();
        } else break;
    return x;
}

int main()
{
    double x;

    readch(); x = expression();
    if (ch != '\n') error("not correct in syntax");
    printf("%g\n", x);
    return EXIT_SUCCESS;
}
