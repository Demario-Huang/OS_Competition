
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
#include "sbi.h"


#define EXCP_ENV_CALL     0x8
#define TIMER_INTERUPT 0x8000000000000005L

extern void __restore(uint64 a0, uint64 a1);
extern struct task_manager TASK_MANAGER;
extern void __alltraps();


void return_to_user(){
    uint64 a1 = root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn);    // 用户satp
    uint64 a0 = TASK_MANAGER.processing_tcb.memoryset.UserStackHigh.start_addr;      // trap context的位置

    // printf("the a1 is %x\n", a1);
    // printf("the a0 is %x\n", translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, a0));

    w_stvec(__alltraps);
    // printf("the address of __restore is %x\n", __restore);
    __restore(a0, a1);
}


// 先简单处理sys_write和exit两种系统调用
void trap_handler(){

    uint64 scause = r_scause();   // 获取中断的原因
    uint64 stval = r_stval();

    uint64 sstatus = r_sstatus();
    // if sstatus is 0x0 it is User mode before, 
    // if sstatus is 0x100 it is Kernel mode before, 

    uint64 trap_from_kernel = 0;
    if (sstatus != 0x0){    // status == 0x100: from kernel mode
        panic("hello!~~~\n");
        // trap_from_kernel = 1;
        // trap_from_kernel = 0;
    }else{
        trap_from_kernel = 0;
        w_stvec(trap_handler);  
    }


    if (scause == EXCP_ENV_CALL){
            // 先找到trap上下文中用户程序传递过来的参数
        uint64 user_high_sp = TASK_MANAGER.processing_tcb.memoryset.UserStackHigh.start_addr;
        
        uint64 phy_user_high_sp = translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, user_high_sp);

        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);
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
            *((struct trap_context *)phy_user_high_sp) = current_trap_cx;
        }
    }
    else if (scause == TIMER_INTERUPT){    // 时钟中断

        uint64 user_high_sp = TASK_MANAGER.processing_tcb.memoryset.UserStackHigh.start_addr;
        
        uint64 phy_user_high_sp = translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, user_high_sp);

        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);

        current_trap_cx.spec = current_trap_cx.spec - 4;    // re-run the current instruction
        *((struct trap_context *)phy_user_high_sp) = current_trap_cx;

        sbi_set_timer(r_time() + INTERVAL / 100);
        if (trap_from_kernel){
            run_next_app_from_kernel(0);
        }else{
            run_next_app(0);
        }
    }
    else{
        panic("[kernel] unrecognized scause: %d!\n", scause);
    }

    // panic("here ok!\n");
    return_to_user();
}

