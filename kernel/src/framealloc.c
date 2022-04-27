#define __module_name__ 	"framealloc"

#include "framealloc.h"
#include "types.h"
#include "memlayout.h"
#include "printf.h"
#include "console.h"

#define PAGE_SIZE 4096 // 4kb size for each page and frame
#define BITMAP_SIZE 2048 // 2k bit represent 2k frame
#define BASE_ADDRESS 0x80200000

static uint8 bitmap[BITMAP_SIZE/8]; // use char to store 2k bit


bool If_bitmap_is_set(uint32 frame_number){
    uint32 byte_number = frame_number / 8;
    uint32 bit_number = frame_number % 8;
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
}

uint32 get_frame(){
  printf("hello! this is frame\n");

  uint32 kernel_end = 0x80400000;
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
  uint32 remain =  (kernel_end - BASE_ADDRESS) % PAGE_SIZE;
  if (remain > 0) kernel_frame++;
  uint32 kernel_bit_end = kernel_frame / 8;
  uint32 kernel_bit_offset = kernel_frame % 8;

  for (uint32 i = 0; i < kernel_bit_end; i++){
    bitmap[i] = 255; // 0x11111111
  }
  bitmap[kernel_bit_end] = (uint8)(255 >> (8-kernel_bit_offset)); // 0x11111111 >> kernel_bit_offset

  uint32 start_free_frame = BITMAP_SIZE - kernel_frame;

  for (uint32 index = start_free_frame; index < BITMAP_SIZE, index++) {
    if (If_bitmap_is_set(index)) {
      continue;
    } else {
      return index;
    }
  }

  return -1; // invalid
}

void free_frame(uint32 frame_number){
  uint32 byte_number = frame_number / 8;
  uint32 bit_number = frame_number % 8;
  bitmap[byte_number] &= ~(1 << bit_number);
}



