#include <stdio.h>

int main(int argc, char** argv)
{
    float e, w;
    //double e, w;
    //long double e, w;

    e = 1;
    w = 1 + e;
    while(w > 1){
        printf("% -14g % -14g % 14g\n", e, w, w - 1);
        e /= 2;
        w = 1 + e;
    }

    return 0;
}
