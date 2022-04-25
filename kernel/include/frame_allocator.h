#ifndef FRAME_ALLOCATOR_H
#define FRAME_ALLOCATOR_H

#define PAGE_SIZE 4096 // 4kb size for each page and frame
#include "types.h"

extern unsigned long get_frame(void);
extern void free_frame(unsigned long frame_addr);

#endif // FRAME_ALLOCATOR_H