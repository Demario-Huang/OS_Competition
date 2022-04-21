

#define __module_name__ 	"main"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "laoder.h"
#include "proc.h"

extern uint64 app_0_start;
extern uint64 app_0_end;

void main(int num_core) {
    printf("[kernel] num of cores: %d \n", num_core);  // 通过寄存器entry.S中设置的寄存器a0来传这个num_core参数
    load();    // 将应用程序load到主内存中
    init_app(); // 初始化App，包括初始化其trap上下文，将trap上下文放到用户栈中。
    run_app();
    panic("[kernel] If this is printed, sth must get wrong!\n");
    while (1) {}
}
