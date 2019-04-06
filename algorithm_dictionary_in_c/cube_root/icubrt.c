unsigned int icubrt(unsigned int x)
{
    unsigned int s, t;

    if(x == 0) return 0;
    s = 1; t = x;
    while(s < t){ s <<= 1; t >>= 2; }
    do{
        t = s; s = (x / (s * s) + 2 * s) / 3;
    }while(s < t);
    return t;
}
