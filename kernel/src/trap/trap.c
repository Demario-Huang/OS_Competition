
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
#include "mm/pagetable.h"
#include "mm/framealloc.h"
#include "mm/MapArea.h"
#include "mm/MemorySet.h"
#include "mm/kmalloc.h"
#include "task_manager.h"


#define EXCP_ENV_CALL     0x8

extern void __restore(uint64 a0, uint64 a1);

extern uint64 current_user_stack_high;
extern uint64 current_user_satp;
extern current_app;

void return_to_user(){
    
    uint64 a1 = current_user_satp;    // 用户satp，暂时先设置成0
    uint64 a0 = current_user_stack_high;      // 用户栈顶
    __restore(a0, a1);
}


// 先简单处理sys_write和exit两种系统调用
void trap_handler(){
    uint64 scause = r_scause();   // 获取中断的原因
    uint64 stval = r_stval();
    if (scause != 8){
        printf("the scause now is %d\n", scause);
    }
    if (scause == EXCP_ENV_CALL){
            // 先找到trap上下文中用户程序传递过来的参数
        uint64 user_high_sp = current_user_stack_high;
        struct trap_context current_trap_cx = *((struct trap_context *)user_high_sp);
        uint64 x17 = current_trap_cx.general_register[17];
        uint64 x10 = current_trap_cx.general_register[10];
        uint64 x11 = current_trap_cx.general_register[11];
        uint64 x12 = current_trap_cx.general_register[12];
        uint64 args[3];
        args[0] = x10;
        args[1] = x11;
        args[2] = x12;
        uint64 return_value = syscall(x17, args);
        if (return_value > 0){
            current_trap_cx.general_register[10] = return_value;
            printf("the current return value is %x\n", return_value);
            *((struct trap_context *)user_high_sp) = current_trap_cx;
        }
    }else{
        printf("[kernel] unrecognized scause!\n");
    }
    run_app(current_app);
}