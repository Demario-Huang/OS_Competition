#define __module_name__   "kmalloc"

#include "mm/kmalloc.h"
#include "types.h"
#include "printf.h"
#include "panic.h"


void initmalloc(){
  uint8 * heap_start = &heap;
  printf("[kernel] heap start is %x \n", heap_start);
  for (uint32 index = 0; index < MAX_SIZE/8; index++) {
    heap[index] = 0x0; // initialize the heap data
  }
  printf("[kernel] heap end is %x \n", heap_start + MAX_SIZE);
}

void * kmalloc(uint32 size){
  if (size > MAX_SIZE/2){ // if greater than 64kb, then the allocation is not allowed
    panic("[kernel] kmalloc falied, size is too large!\n");
  } else {
    uint8 * heap_start = &heap;
    uint32 index = 0;
    for (uint8 i = 0; i <8; i++) {
      if (size <= memomap[i]) {
        index = i;
        break;
      }
    }
    usedmap[index] = 1;
    if(index == 0) return (void*) heap_start; 
    else return (void*) heap_start + 1024 * memomap[index];
  }
}

void  kfree(void * addr){
  uint8 * heap_start = &heap;
  uint8 * allocated_start = (uint8*) addr;
  uint32 memo = (allocated_start - heap_start) / 1024;
  uint32 index = 0;
  if (memo == 0) index = 0;
  else {
    for (uint32 i = i; i < 8; i++){
      if (memomap[i] == memo){
        index = i;
        break;
      }
    }
  }
  usedmap[index] = 0;
  for (uint32 i = 0; i < memo*1024; i++){
    *(allocated_start + i) = 0x0;
  }
}