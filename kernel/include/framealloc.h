#ifndef __FRAMEALLOC_H
#define __FRAMEALLOC_H


// Here the physical kernel space is 8MB.
// contains  2k frame, for each frame 4kb size
// I implement the frame allocation by using bitmap, the bitmap is 2k bit, whic is half of one frame.

#include "types.h"

extern uint32 get_frame(); // return the first address of current free frame
extern void free_frame(uint32 frame_number);

#endif // FRAMEALLOC_H