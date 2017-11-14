#include <limits.h>
#define CRCPOLY1 0x1021U
#define CRCPOLY2 0x8408U
typedef unsigned char byte;

unsigned int crc1(int n, byte c[])
{
    unsigned int i, j, r;

    r = 0xFFFFU;
    for(i = 0; i < n; i++){
        r ^= (unsigned int)c[i] << (16 - CHAR_BIT);
        for(j = 0; j < CHAR_BIT; j++)
            if(r & 0x8000U) r = (r << 1) ^ CRCPOLY1;
            else            r <<= 1;
    }
    return ~r & 0xFFFFU;
}

unsigned int crc2(int n, byte c[])
{
    unsigned int i, j, r;

    r = 0xFFFFU;
    for(i = 0; i < n; i++){
        r ^= c[i];
        for(j = 0; j < CHAR_BIT; j++)
            if(r & 1) r = (r >> 1) ^ CRCPOLY2;
            else      r >>= 1;
    }
    return r ^ 0xFFFFU;
}
