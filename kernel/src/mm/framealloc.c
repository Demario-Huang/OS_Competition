#define __module_name__ 	"framealloc"

#include "mm/framealloc.h"
#include "types.h"
#include "memlayout.h"
#include "printf.h"
#include "console.h"

extern uint32 ekernel;


void initframe(){
  uint32 kernel_end = &ekernel;
  printf("[kernel] end of ekernel is %x \n", kernel_end);
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
  uint32 remain =  (kernel_end - BASE_ADDRESS) % PAGE_SIZE;
  if (remain > 0) kernel_frame++;
  uint32 kernel_bit_end = kernel_frame / 8;
  uint32 kernel_bit_offset = kernel_frame % 8;

  for (uint32 i = 0; i < kernel_bit_end; i++){
    bitmap[i] = 255; // 0x11111111
  }
  bitmap[kernel_bit_end] = (uint8)(255 >> (8-kernel_bit_offset)); // 0x11111111 >> kernel_bit_offset
  Isinit = 1;
  kernel_frame_end = kernel_frame;
}

uint32 If_bitmap_is_set(uint32 frame_number){
    uint32 byte_number = frame_number / 8;
    uint32 bit_number = frame_number % 8;
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
}

uint32 get_frame(){
  if (!Isinit){
    initframe();
  }
  uint32 start_free_frame = kernel_frame_end + 1; // protection of kernel

  // search for valid free frame
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    if (If_bitmap_is_set(index)) {
      continue;
    } else {
      // update the frame
      uint32 byte_number = index / 8;
      uint32 bit_number = index % 8;
      bitmap[byte_number] |= (1 << bit_number);
      return index + (0x80200000 / 4096);
    }
  }

  return -1; // invalid
}

void free_frame(uint32 frame_number){
  frame_number -= (0x80200000 / 4096);
  for (uint32 index = 0; index < PAGE_SIZE; index+=32) {
    uint32 * addr = (uint32*)(BASE_ADDRESS + frame_number * PAGE_SIZE + index);
    *addr = 0;
  }
  uint32 byte_number = frame_number / 8;
  uint32 bit_number = frame_number % 8;
  bitmap[byte_number] &= ~(1 << bit_number);
}
