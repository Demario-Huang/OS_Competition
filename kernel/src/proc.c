// 暂时负责将一个程序初始化，初始化用户栈，初始化用户上下文


#define __module_name__ 	"proc"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "proc.h"
#include "config.h"
#include "trap_context.h"


uint64 get_user_stack_top(){
    return KERNEL_STACK + KERNEL_STACK_SIZE;
}

void init_app(){
    // 第一步：初始化trap上下文
    sepc = get_user_stack_top;
    kernel_satp = 0;   // 暂时还没有开启分页模式这个功能，先设成0
    trap_handler = 
    trap_context = new_trap_cx(uint64 spec, uint64 kernel_satp, uint64 trap_handler, uint64 current_sp);
}

void run_app();

