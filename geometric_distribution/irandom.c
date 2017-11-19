#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/** uniform random number of 0 <= rnd() < 1 */
#define rnd() (1.0 / (RAND_MAX + 1.0)) * rand()

int geometric_rnd(double p)
{
    int n;

    n = 1;
    while(rnd() > p) n++;
    return n;
}

/**
 * high speed if p is small.
 */
int geometric_rnd_(double p)
{
    return ceil(log(1 - rnd()) / log(1 - p));;
}

int main(int argc, char** argv)
{
    int n;
    double p;

    p = 0.01;
    n = geometric_rnd(p);
    printf("p = %f, n = %d\n", p, n);
    return 0;
}
