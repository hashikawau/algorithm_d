#! /bin/bash

gcc -o marriage.exe marriage.c
./marriage.exe <<< '1 2 3
1 3 2
2 1 3
3 1 2
3 2 1
1 2 3'

./marriage.exe <<< '2 3 1
2 1 3
3 2 1
1 3 2
2 3 1
3 1 2'

rm marriage.exe

