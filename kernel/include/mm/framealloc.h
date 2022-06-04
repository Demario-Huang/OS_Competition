#ifndef __FRAMEALLOC_H
#define __FRAMEALLOC_H


// Here the physical kernel space is 8MB.
// contains  2k frame, for each frame 4kb size
// I implement the frame allocation by using bitmap, the bitmap is 2k bit, whic is half of one frame.

#include "types.h"

#define PAGE_SIZE 4096 // 4kb size for each page and frame
#define BITMAP_SIZE 2048 // 2k bit represent 2k frame
#define BASE_ADDRESS 0x80200000

static uint8 bitmap[BITMAP_SIZE/8]; // use char to store 2k bit
static uint8 Isinit = 0;
static uint32 kernel_frame_end = 0;

void initframe(); // init frame
uint32 get_frame(); // return the first free frame number
void free_frame(uint32 frame_number);

#endif // FRAMEALLOC_H