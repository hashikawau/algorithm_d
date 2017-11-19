#include <stdlib.h>

/** uniform random number of range [0 <= rnd() < 1] */
#define rnd() (1.0 / (RAND_MAX + 1.0)) * rand()

void shuffle(int n, int v[])
{
    int i, j, t;

    for(i = n - 1; i > 0; i--){
        j = (int)((i + 1) * rnd());
        t = v[i]; v[i] = v[j]; v[j] = t;
    }
}

void randperm(int n, int v[])
{
    int i;

    for(i = 0; i < n; i++) v[i] = i + 1;
    shuffle(n, v);
}
