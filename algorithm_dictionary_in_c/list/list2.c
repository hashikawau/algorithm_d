#include <stdio.h>
#include <stdlib.h>
typedef int infotype;

typedef struct item{
    infotype info;
    struct item *next;
} *pointer;

pointer add_list(infotype x, pointer p)
{
    pointer q;

    q = malloc(sizeof *q);
    if(q == NULL){
        printf("Out of memory\n"); exit(EXIT_FAILURE);
    }
    q->info = x; q->next = p;
    return q;
}

void show_list(pointer p)
{
    while(p != NULL){
        printf(" %d", p->info); p = p->next;
    }
    printf("\n");
}

pointer reverse_list(pointer p)
{
    pointer q, t;

    q = NULL;
    while(p != NULL){
        t = q; q = p; p = p->next; q->next = t;
    }
    return q;
}

int main()
{
    infotype x;
    pointer head;

    head = NULL;
    for(x = 1; x <= 9; x++)
        head = add_list(x, head);
    show_list(head);
    head = reverse_list(head);
    show_list(head);
    return EXIT_SUCCESS;
}
