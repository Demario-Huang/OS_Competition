// 暂时负责将一个程序初始化，初始化用户栈，初始化用户上下文


#define __module_name__ 	"proc"

#include "mm/MemorySet.h"
#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "proc.h"
#include "config.h"
#include "trap_context.h"
#include "trap.h"
#include "riscv.h"
#include "task_manager.h"
#include "task_control_block.h"
#include "task_context.h"
#include "loader.h"



extern void __alltraps();
extern struct task_manager TASK_MANAGER;


void init_app(uint64 pid){

    // 初始化进程管理
    // 第一步：初始化app的地址空间
    struct User_MemorySet current_mem_set = load(pid + 1);    // 将应用程序load到主内存中
    uint64 kernel_stack_top = current_mem_set.Kernel_Stack.end_addr;

    // 第二步：初始化进程上下文
    struct task_context app_task_context = new_task_cx(current_mem_set.text.start_addr, kernel_stack_top, current_mem_set.page_table.root_ppn);

    // 第三步：初始化TCB
    struct task_control_block app_tcb = new_task_control_block(app_task_context,  kernel_stack_top);
    app_tcb.memoryset = current_mem_set;
    app_tcb.user_token = root_ppn_to_token(current_mem_set.page_table.root_ppn);

    // 第四步：将初始化好的TCB放入task manager中
    add_task_control_block(app_tcb);

    // 初始化trap管理
    // 第一步：初始化trap上下文：
    uint64 user_low_sp = current_mem_set.UserStackLow.end_addr;
    uint64 app_entry = current_mem_set.text.start_addr;  // app执行的第一条指令位置
    uint64 kernel_satp = r_satp();   
    uint64 app_trap_handler = trap_handler;


    struct trap_context app_trap_context = new_trap_cx(app_entry, kernel_satp, app_trap_handler, user_low_sp, kernel_stack_top);


    // 第二步: 将trap上下文放在用户栈高位栈顶：
    uint64 user_high_sp = current_mem_set.UserStackHigh.start_addr;
    uint64 phy_user_high_sp = translate(current_mem_set.page_table.root_ppn, user_high_sp);
    *((struct trap_context *)phy_user_high_sp) = app_trap_context;


    // 第三步: 将stvec修改成__alltraps的位置
    w_stvec(__alltraps);    


    // TASK_MANAGER.processing_tcb = app_tcb;
}

void run_next_app(uint64 pid){

    TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[pid];
    if (pid == 0){
        return_to_user();
    }

}

