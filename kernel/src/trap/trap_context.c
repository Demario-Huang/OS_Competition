// 定义一个trap上下文，并定义这个数据结构的初始化函数
#define __module_name__ 	"trap_context"

#include "trap_context.h"
#include "types.h"


struct trap_context new_trap_cx(uint64 spec, uint64 kernel_satp, uint64 trap_handler, uint64 user_stack_sp, uint64 kernel_stack_top){
    struct trap_context new_trap_context;

    for (int i = 0; i < 32; i++){      // 先将寄存器0初始化
        new_trap_context.general_register[i] = 0;
    }

    new_trap_context.general_register[2] = user_stack_sp;
    new_trap_context.spec = spec;    // 设为用户程序的入口
    new_trap_context.kernel_satp = kernel_satp;   
    new_trap_context.trap_handler = trap_handler;
    new_trap_context.kernel_stack = kernel_stack_top;

    return new_trap_context;
}