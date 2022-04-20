

#define __module_name__ 	"main"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "laoder.h"

extern uint64 app_0_start;
extern uint64 app_0_end;

void main(int num_core) {
    printf("num of cores: %d \n", num_core);  // 通过寄存器entry.S中设置的寄存器a0来传这个num_core参数
    printf("Hello, World!\n");
    load();    // 将应用程序load到主内存中
    
    panic("Stop!\n");
    while (1) {}
}
