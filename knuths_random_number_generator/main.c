#include <stdio.h>
#include "krnd.h"

int main()
{
    init_rnd(0);
    for (int i = 0; i < 10; ++i) {
        printf("%d: %d, %f\n", i, irnd(), rnd());
    }
}
