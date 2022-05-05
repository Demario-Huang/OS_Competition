#ifndef __KMALLOC_H
#define __KMALLOC_H

#include "types.h"

#define MAX_SIZE 131072 // 128KB
#define BASE_ADDRESS 0x80200000

static uint8 heap[MAX_SIZE];
static uint8 memomap[8] = {1,1,2,4,8,16,32,64}; // free memory block
static uint8 usedmap[8] = {0,0,0,0,0,0,0,0}; // used memory block

void initmalloc();

// use low level buddy allocate algorithm, will not recursively divide and combine free list
void * kmalloc(uint32 size);

void  kfree(void * addr);

#endif // !__KMALLOC_H