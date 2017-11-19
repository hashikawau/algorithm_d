#include <stdio.h>
#include "cuberoot.h"
#include "icubrt.h"

int main()
{
    printf("cuberoot(%6.3f) = %6.3f\n", 5.0, cuberoot(5.0));
    printf("lcuberoot(%6.3f) = %6.3f\n", 5.0, lcuberoot(5.0));
    printf("icubrt(%d) = %d\n", 9, icubrt(9));
    return 0;
}
