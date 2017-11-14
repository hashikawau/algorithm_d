#include <limits.h>
#define CRCPOLY1 0x1021U
#define CRCPOLY2 0x8408U
typedef unsigned char byte;
unsigned int crctable[UCHAR_MAX + 1];

void makecrctable1(void)
{
    unsigned int i, j, r;

    for(i = 0; i <= UCHAR_MAX; i++){
        r = i << (16 -CHAR_BIT);
        for(j = 0; j < CHAR_BIT; j++)
            if(r & 0x8000U) r = (r << 1) ^ CRCPOLY1;
            else            r <<= 1;
        crctable[i] = r & 0xFFFFU;
    }
}

unsigned int crc1(int n, byte c[])
{
    unsigned int r;

    r = 0xFFFFU;
    while(--n >= 0)
        r = (r << CHAR_BIT) ^ crctable[(byte)(r >> (16 - CHAR_BIT)) ^ *c++];
    return ~r & 0xFFFFU;
}

void makecrctable2(void)
{
    unsigned int i, j, r;

    for(i = 0; i <= UCHAR_MAX; i++){
        r = i;
        for(j = 0; j < CHAR_BIT; j++)
            if(r & 1) r = (r >> 1)^ CRCPOLY2;
            else      r >>= 1;
        crctable[i] = r;
    }
}

unsigned int crc2(int n, byte c[])
{
    unsigned int r;

    r = 0xFFFFU;
    while(--n >= 0)
        r = (r >> CHAR_BIT) ^ crctable[(byte)r ^ *c++];
    return r ^ 0xFFFFU;
}
