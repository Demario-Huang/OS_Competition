// 暂时负责将一个程序初始化，初始化用户栈，初始化用户上下文


#define __module_name__ 	"proc"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "proc.h"
#include "config.h"
#include "trap_context.h"
#include "trap.h"
#include "riscv.h"

extern void __alltraps();

uint64 get_user_stack_low_top(){
    return UserStack_LOW + USER_STACK_SIZE;
}

uint64 get_user_stack_high_top(){
    return UserStack_HIGH + 1024;
}

uint64 get_kernel_stack_top(){
    return KernelStack + 1024;
}

void init_app(){
    // 第一步：初始化trap上下文：

    uint64 user_low_sp = get_user_stack_low_top();
    uint64 app_entry = 0x80400000;    // 还没实现分页功能，先指定app的入口在这里
    uint64 kernel_satp = 0;   // 暂时还没有开启分页模式这个功能，先将应用程序根页表设成0
    uint64 app_trap_handler = trap_handler;
    uint64 kernel_stack_top = get_kernel_stack_top();

    printf("the addr of trap handler is %x\n", app_trap_handler);
    struct trap_context app_trap_context = new_trap_cx(app_entry, kernel_satp, app_trap_handler, user_low_sp, kernel_stack_top);

    // 第二步将trap上下文放在用户栈高位栈顶：
    uint64 user_high_sp = get_user_stack_high_top();
    *((struct trap_context *)user_high_sp) = app_trap_context;
    // 第三步，将stvec修改成__alltraps的位置
    w_stvec(__alltraps);
}

void run_app(){
    // 调用return_to_user()
    return_to_user();
}

