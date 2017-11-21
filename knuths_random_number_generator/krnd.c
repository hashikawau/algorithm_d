#define MRND 100000000L
static int jrand;
static long ia[56];

static void irn55(void)
{
    int i;
    long j;

    for (i = 1; i <= 24; i++) {
        j = ia[i] - ia[i + 31];
        if (j < 0) j += MRND;
        ia[i] = j;
    }
    for (i = 25; i <= 55; i++) {
        j = ia[i] - ia[i - 24];
        if (j < 0) j += MRND;
        ia[i] = j;
    }
}

void init_rnd(unsigned long seed)
{
    int i, ii;
    long k;

    ia[55] = seed;
    k = 1;
    for (i = 1; i <= 54; i++) {
        ii = (21 * i) % 55;
        ia[ii] = k;
        k = seed - k;
        if (k < 0) k += MRND;
        seed = ia[ii];
    }
    irn55(); irn55(); irn55();
    jrand = 55;
}

/**
 * 0 <= irnd() < MRND
 */
long irnd(void)
{
    if (++jrand > 55) { irn55(); jrand = 1; }
    return ia[jrand];
}

/**
 * 0 <= irnd() < 1
 */
double rnd(void)
{
    return (1.0 / MRND) * irnd();
}

