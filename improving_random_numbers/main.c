#include <stdio.h>
#include "improve.h"

void show(int num)
{
    int i;
    for(i = 0; i < num; ++i){
        printf("%03d: %6.3f\n", i, better_rnd());
    }
}

int main(int argc, char** argv)
{
    init_better_rnd();
    show(10);
    return 0;
}
