#include <limits.h>
#define CRCPOLY1 0x04C11DB7UL
#define CRCPOLY2 0xEDB88320UL
typedef unsigned char byte;

unsigned long crc1(int n, byte c[])
{
    unsigned int i, j;
    unsigned long r;

    r = 0xFFFFFFFFUL;
    for(i = 0; i < n; i++){
        r ^= (unsigned long)c[i] << (32 - CHAR_BIT);
        for(j = 0; j < CHAR_BIT; j++)
            if(r & 0x80000000UL) r = (r << 1) ^ CRCPOLY1;
            else                 r <<= 1;
    }
    return ~r & 0xFFFFFFFFUL;
}

unsigned long crc2(int n, byte c[])
{
    unsigned int i, j;
    unsigned long r;

    r = 0xFFFFFFFFUL;
    for(i = 0; i < n; i++){
        r ^= c[i];
        for(j = 0; j < CHAR_BIT; j++)
            if(r & 1) r = (r >> 1) ^ CRCPOLY2;
            else      r >>= 1;
    }
    return r ^ 0xFFFFFFFFUL;
}

#include <stdio.h>
#include <string.h>
int main()
{
    byte b[] = "hello, world";
    printf("crc1: %s -> %d\n", b, crc1(strlen(b), b));
    printf("crc2: %s -> %d\n", b, crc2(strlen(b), b));
    return 0;
}
