#include <string.h>

int check_sum(char c[])
{
    int n = strlen(c);
    unsigned char checksum = 0;
    for (int i = 0; i < n; i++) checksum ^= c[i];
    return checksum;
}

int is_valid(char check_sum_byte, char c[])
{
    int n = strlen(c);
    unsigned char checksum = 0;
    for (int i = 0; i < n; i++) checksum ^= c[i];
    checksum ^= check_sum_byte;
    return checksum == 0;
}
