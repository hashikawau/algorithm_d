#include <stdio.h>
#include "randperm.h"

int main(int argc, char** argv)
{
    int SIZE = 100;
    int array[SIZE];
    for(int i = 0; i < SIZE; ++i){
        array[i] = i;
    }

    randperm(SIZE, array);
    for(int i = 0; i < SIZE; ++i){
        printf("%03d: %d\n", i, array[i]);
    }
    return 0;
}
