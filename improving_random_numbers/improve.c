#include <stdlib.h>

/** uniform random number of range [0 <= rnd() < 1] */
#define rnd() (1.0 / (RAND_MAX + 1.0)) * rand()

#define POOLSIZE 97
static double pool[POOLSIZE];

void init_better_rnd(void)
{
    int i;

    for(i = 0; i < POOLSIZE; i++) pool[i] = rnd();
}

double better_rnd(void)
{
    static int i = POOLSIZE - 1;
    double r;

    i = (int)(POOLSIZE * pool[i]);
    r = pool[i]; pool[i] = rnd();
    return r;
}
