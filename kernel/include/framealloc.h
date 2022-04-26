#ifndef __FRAMEALLOC_H
#define __FRAMEALLOC_H

#define PAGE_SIZE 4096 // 4kb size for each page and frame
#include "types.h"

extern uint64 get_frame(void); // return the first address of current free frame
extern void free_frame(uint64 frame_addr);

struct frame {
    uint64 addr;
    uint32 frame_id;
    struct frame *next;
};


#endif // FRAMEALLOC_H