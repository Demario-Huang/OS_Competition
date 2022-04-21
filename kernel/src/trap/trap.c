
#define __module_name__ 	"trap"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "trap.h"
#include "trap_context.h"
#include "riscv.h"
#include "syscall.h"
#include "proc.h"


#define EXCP_ENV_CALL     0x8

extern void __restore(uint64 a0, uint64 a1);

void return_to_user(){
    printf("prepare to return to user!\n");
    uint64 a1 = 0;    // 用户satp，暂时先设置成0
    uint64 a0 = get_user_stack_high_top();      // 用户栈顶
    printf("before restore, the kernel_top is: %x\n", a0);
    __restore(a0, a1);
}

void trap_handler(){
    printf("enter trap_handler!");
    return_to_user();
}