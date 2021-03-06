
#define __module_name__ 	"string"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "console.h"



void memmove(uint64 dst, uint64 src, int size){
    int cpy_index = 0;

    while (cpy_index < size){
        *(char*)(dst + cpy_index) = *(char*)(src + cpy_index);    // 一个一个byte的复制过去
        cpy_index ++;
    }
}

void memcpy(uint64 dst, uint64 src, int size){
    memmove(dst, src, size);
}