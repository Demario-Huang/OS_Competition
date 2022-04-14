

#define __module_name__ 	"main"

#include "printf.h"
#include "panic.h"

void main(int num_core) {
    printf("num of cores: %d \n", num_core);  // 通过寄存器entry.S中设置的寄存器a0来传这个num_core参数
    printf("Hello, World!\n");
    panic("Stop!\n");
    while (1) {}
}
