#include <limits.h>
#define CRCPOLY1 0x04C11DB7UL
#define CRCPOLY2 0xEDB88320UL
typedef unsigned char byte;
unsigned long crctable[UCHAR_MAX + 1];

void makecrctable1(void)
{
    unsigned int i, j;
    unsigned long r;

    for(i = 0; i <= UCHAR_MAX; i++){
        r = (unsigned long)i << (32 - CHAR_BIT);
        for(j = 0; j < CHAR_BIT; j++)
            if(r & 0x80000000UL) r = (r << 1) ^ CRCPOLY1;
            else                 r <<= 1;
        crctable[i] = r & 0xFFFFFFFFUL;
    }
}

unsigned long crc1(int n, byte c[])
{
    unsigned long r;

    r = 0xFFFFFFFFUL;
    while(--n >= 0)
        r = (r << CHAR_BIT) ^ crctable[(byte)(r >> (32 - CHAR_BIT)) ^ *c++];
    return ~r & 0xFFFFFFFFUL;
}

void makecrctable2(void)
{
    unsigned int i, j;
    unsigned long r;

    for(i = 0; i <= UCHAR_MAX; i++){
        r = i;
        for(j = 0; j < CHAR_BIT; j++)
            if(r & 1) r = (r >> 1) ^ CRCPOLY2;
            else      r >>= 1;
        crctable[i] = r;
    }
}

unsigned long crc2(int n, byte c[])
{
    unsigned long r;

    r = 0xFFFFFFFFUL;
    while(--n >= 0)
        r = (r >> CHAR_BIT) ^ crctable[(byte)r ^ *c++];
    return r ^ 0xFFFFFFFFUL;
}
