/**
 * return Cube root by Newton method
 */
double cuberoot(double x)
{
    double s, prev;
    int positive;

    if(x == 0) return 0;
    if(x > 0){ positive = 1; }else{ positive = 0; x = -x; }
    if(x > 1) s = x; else s = 1;
    do {
        prev = s;
        s = (x / (s * s) + 2 * s) / 3;
    } while (s < prev);
    if (positive) return prev; else return -prev;
}

long double lcuberoot(long double x)
{
    long double s;

    if (x == 0) return 0;
    s = cuberoot(x);
    return (x / (s * s) + 2 * s) / 3;
}
