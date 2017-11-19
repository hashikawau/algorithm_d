#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/** uniform random number of range [0 <= rnd() < 1] */
#define rnd() (1.0 / (RAND_MAX + 1.0)) * rand()

int main(int argc, char** argv)
{
    unsigned seed;
    unsigned long i, n;
    double r, s1, s2, x, x0, xprev;

    printf("What is seed of random number?: "); scanf("%u", &seed);
    srand(seed);
    printf("What is a number of printing random numbers?: "); scanf("%lu", &n);

    s1 = x0 = xprev = rnd() - 0.5; s2 = x0 * x0; r = 0;
    for(i = 1; i < n; i++){
        x = rnd() - 0.5;
        s1 += x; s2 += x * x; r+= xprev * x; xprev = x;
    }
    r = (n * (r + x * x0) - s1 * s1) / (n * s2 - s1 * s1);

    printf("mean value: %6.3f\n", s1 * sqrt(12.0 / n));
    return EXIT_SUCCESS;
}
