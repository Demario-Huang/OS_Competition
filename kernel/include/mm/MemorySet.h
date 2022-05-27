#ifndef __MEMORYSET_H
#define __MEMORYSET_H

#include "types.h"
#include "MapArea.h"
#include "pagetable.h"

struct Kernel_MemorySet{
    struct PageTable page_table;
    struct Map_Area text;
    struct Map_Area rodata;
    struct Map_Area data;
    struct Map_Area bss;
    struct Map_Area Available_Frames;
};
static struct Kernel_MemorySet kernel_memorySet;

struct User_MemorySet{
    struct PageTable page_table;
    struct Map_Area text;
    struct Map_Area rodata;
    struct Map_Area data;
    struct Map_Area bss;
    struct Map_Area GuardPage;   //4k, 不允许读写
    struct Map_Area UserStackLow; // 4k
    struct Map_Area UserStackHigh; // Trampoline(4k) + TrapContext(4k)
};
static struct User_MemorySet user_memory_set;

void map_kernel();    // 将整个kernel建立联系

uint64 root_ppn_to_token(uint64 root_ppn);

void activate_mm();

#endif