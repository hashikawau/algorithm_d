#include <stdio.h>
#include <stdlib.h>

#define NMAX 7

int n;
char adjacent[NMAX + 1][NMAX + 1];

void readgraph()
{
    // 1 <-> 2 <-> 3
    // 1 <-> 3
    // 2 <-> 4
    // 5 <-> 7
    for (int i = 1; i <= NMAX; ++i) {
        for (int j = 1; j <= NMAX; ++j)
            adjacent[i][j] = 0;
    }
    adjacent[1][2] = adjacent[2][1] = 1;
    adjacent[2][3] = adjacent[3][2] = 1;
    adjacent[1][3] = adjacent[3][1] = 1;
    adjacent[2][4] = adjacent[4][2] = 1;
    adjacent[5][7] = adjacent[7][5] = 1;
}

struct queue {
    int item;
    struct queue *next;
} *head, *tail;

void initialize_queue(void)
{
    head = tail = malloc(sizeof(struct queue));
    if (head == NULL) exit(EXIT_FAILURE);
}

void addqueue(int x)
{
    tail->item = x;
    tail->next = malloc(sizeof(struct queue));
    if (tail->next == NULL) exit(EXIT_FAILURE);
    tail = tail->next;
}

int removequeue(void)
{
    int x;
    struct queue *p;

    p = head;
    head = p->next;
    x = p->item;
    free(p);
    return x;
}

#define START 1

int main()
{
    int i, j;
    static int distance[NMAX + 1], prev[NMAX + 1];
    n = NMAX;

    initialize_queue();
    readgraph();
    for (i = 1; i <= n; i++) distance[i] = -1;
    addqueue(START);
    distance[START] = 0;
    do {
        i = removequeue();
        for (j = 1; j <= n; j++)
            if (adjacent[i][j] && distance[j] < 0) {
                addqueue(j);
                distance[j] = distance[i] + 1;
                prev[j] = i;
            }
    } while (head != tail);
    printf("point  prev_point  least_distance\n");
    for (i = 1; i <= n; i++)
        if (distance[i] > 0)
            printf("%2d%10d%10d\n", i, prev[i], distance[i]);
    return EXIT_SUCCESS;
}
