#include <stdio.h>
#include "check_sum.h"

int main()
{
    printf("%d\n", check_sum("hello, world"));
    printf("%d\n", is_valid(12, "hello, world"));
    return 0;
}
