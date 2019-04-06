#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
/** Vertical */
#define N 32
/** Horizontal */
#define M 128
char a[N + 2][M + 2], b[N + 2][M + 2];

#define NUM_OF_GENERATIONS 1000

void clrscr()
{
    system("clear");
}

void init_1()
{
    a[N/2][M/2] = 1;
    a[N/2-1][M/2] = 1;
    a[N/2+1][M/2] = 1;
    a[N/2][M/2-1] = 1;
    a[N/2-1][M/2+1] = 1;

    int centerN = 3 * N/4;
    int centerM = 3 * M/4;
    a[ 0 + centerN][ 0 + centerM] = 1;
    a[ 1 + centerN][ 0 + centerM] = 1;
    a[-1 + centerN][ 0 + centerM] = 1;
    a[ 0 + centerN][ 1 + centerM] = 1;
    a[ 1 + centerN][-1 + centerM] = 1;
}

void init_2()
{
    int centerN = 1 * N/2;
    int centerM = 1 * M/2;
    a[-3 + centerN][ 0 + centerM] = 1;
    a[-2 + centerN][-1 + centerM] = 1;
    a[-2 + centerN][ 1 + centerM] = 1;

    a[-1 + centerN][-2 + centerM] = 1;
    a[ 0 + centerN][-2 + centerM] = 1;
    a[ 1 + centerN][-2 + centerM] = 1;
    a[-1 + centerN][ 2 + centerM] = 1;
    a[ 0 + centerN][ 2 + centerM] = 1;
    a[ 1 + centerN][ 2 + centerM] = 1;

    a[ 2 + centerN][-1 + centerM] = 1;
    a[ 2 + centerN][ 1 + centerM] = 1;
    a[ 3 + centerN][ 0 + centerM] = 1;
}

void init_const_1()
{
    int centerN = 1 * N/2;
    int centerM = 1 * M/2;
    a[-1 + centerN][ 0 + centerM] = 1;
    a[ 0 + centerN][ 0 + centerM] = 1;
    a[ 1 + centerN][ 0 + centerM] = 1;
}

void init_const_2()
{
    int centerN = 1 * N/2;
    int centerM = 1 * M/2;
    a[ 0 + centerN][ 0 + centerM] = 1;
    a[ 1 + centerN][ 0 + centerM] = 1;
    a[ 2 + centerN][ 0 + centerM] = 1;
    a[-1 + centerN][ 1 + centerM] = 1;
    a[ 0 + centerN][ 1 + centerM] = 1;
    a[ 1 + centerN][ 1 + centerM] = 1;
}

void init_const_3()
{
    int centerN = 0 * N/2;
    int centerM = 0 * M/2;
    a[ 2 + centerN][ 1 + centerM] = 1;
    a[ 3 + centerN][ 1 + centerM] = 1;
    a[ 4 + centerN][ 1 + centerM] = 1;

    a[ 1 + centerN][ 2 + centerM] = 1;
    a[ 1 + centerN][ 3 + centerM] = 1;
    a[ 1 + centerN][ 4 + centerM] = 1;

    a[ 2 + centerN][ 6 + centerM] = 1;
    a[ 3 + centerN][ 6 + centerM] = 1;
    a[ 4 + centerN][ 6 + centerM] = 1;

    a[ 6 + centerN][ 2 + centerM] = 1;
    a[ 6 + centerN][ 3 + centerM] = 1;
    a[ 6 + centerN][ 4 + centerM] = 1;
}

void init_from_file_32_128()
{
    FILE *file;
    char lifes[M+2];
    file = fopen("./initial.txt", "r");
    for(int i = 0; i < N; ++i) {
        fgets(lifes, M + 2, file);
        for (int j = 0; j < M; ++j) {
            a[i + 1][j + 1] = (lifes[j] == '*');
        }
    }
    fclose(file);
}

int main()
{
    int i, j, g;

    init_from_file_32_128();
    // init_1();
    // init_2();
    // init_const_1();
    // init_const_2();
    // init_const_3();

    for (g = 1; g <= NUM_OF_GENERATIONS; g++) {
        clrscr();
        printf("Generation %4d\n", g);
        for (i = 1; i <= N; i++) {
            for (j = 1; j <= M; j++)
                if (a[i][j]) {
                    printf("*");
                    b[i-1][j-1]++; b[i-1][j]++; b[i-1][j+1]++;
                    b[i  ][j-1]++;              b[i  ][j+1]++;
                    b[i+1][j-1]++; b[i+1][j]++; b[i+1][j+1]++;
                } else {
                    printf(".");
                }
            printf("\n");
        }
        for (i = 0; i <= N + 1; i++)
            for (j = 0; j <= M + 1; j++) {
                if (b[i][j] != 2)
                    a[i][j] = (b[i][j] == 3);
                b[i][j] = 0;
            }
        fflush(stdout);
        usleep(50000);
    }
    return EXIT_SUCCESS;
}
