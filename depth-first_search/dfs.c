#include <stdio.h>
#include <stdlib.h>

#define NMAX 7

int n;
char adjacent[NMAX + 1][NMAX + 1];
/**
 * 0: not visited
 * 1: visited
 */
char visited[NMAX + 1];

void readgraph()
{
    // 1 <-> 2 <-> 3
    // 1 <-> 3
    // 2 <-> 4
    // 5 <-> 7
    for (int i = 1; i <= NMAX; ++i) {
        for (int j = 1; j <= NMAX; ++j)
            adjacent[i][j] = 0;
        visited[i] = 0;
    }
    adjacent[1][2] = adjacent[2][1] = 1;
    adjacent[2][3] = adjacent[3][2] = 1;
    adjacent[1][3] = adjacent[3][1] = 1;
    adjacent[2][4] = adjacent[4][2] = 1;
    adjacent[5][7] = adjacent[7][5] = 1;
}

void visit(int i)
{
    int j;

    printf(" %d", i);
    visited[i] = 1;
    for (j = 1; j <= n; j++)
        if (adjacent[i][j] && ! visited[j]) visit(j);
}

int main()
{
    int i, count;
    n = NMAX;

    readgraph();
    for (i = 1; i <= n; i++) visited[i] = 0;
    count = 0;
    for (i = 1; i <= n; i++)
        if (! visited[i]) {
            printf("%3d:", ++count);
            visit(i);
            printf("\n");
        }
    return EXIT_SUCCESS;
}
