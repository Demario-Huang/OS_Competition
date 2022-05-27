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

uint64 current_user_stack_high;     // a global variable for the current high postion of user stack
uint64 current_user_satp;

uint64 get_user_stack_low_top(uint64 num){
    return UserStack_Low_List[num] + USER_STACK_SIZE;
}

uint64 get_user_stack_high_top(uint64 num){
    return UserStack_High_List[num] + 1024;
}

uint64 get_kernel_stack_top(uint64 num){

    return KernelStack_List[num] + 1024;
}

void set_current_user_stack_high(uint64 num){
    // current_user_stack_high = processing_tcb.memoryset.UserStackHigh.end_addr;
    // printf("the current user_stack_high is %x\n", current_user_stack_high);
}


void init_app(uint64 num){

    struct K_Stack new_kstack;
    uint64 kernel_stack_top = new_kstack.stack;

    // 初始化进程管理

    // 第一步：初始化app的地址空间
    struct User_MemorySet current_mem_set = load(num + 1);    // 将应用程序load到主内存中

    // 第二步：初始化进程上下文
    struct task_context app_task_context = new_task_cx(current_mem_set.text.start_addr, kernel_stack_top, current_mem_set.page_table.root_ppn);

    // 第三步：初始化TCB
    struct task_control_block app_tcb = new_task_control_block(app_task_context,  kernel_stack_top);
    app_tcb.memoryset = current_mem_set;
    app_tcb.user_token = 60 | current_mem_set.page_table.root_ppn;

    // 第四步：将初始化好的TCB放入task manager中
    add_task_control_block(app_tcb);

    // 初始化trap管理
    // 第一步：初始化trap上下文：
    uint64 user_low_sp = current_mem_set.UserStackLow.end_addr;
    uint64 app_entry = current_mem_set.text.start_addr;  // app执行的第一条指令位置
    uint64 kernel_satp = r_satp();   
    uint64 app_trap_handler = trap_handler;

    current_user_stack_high = current_mem_set.UserStackHigh.end_addr;
    current_user_satp = current_mem_set.page_table.root_ppn;

    struct trap_context app_trap_context = new_trap_cx(app_entry, kernel_satp, app_trap_handler, user_low_sp, kernel_stack_top);


    // 第二步: 将trap上下文放在用户栈高位栈顶：
    uint64 user_high_sp = current_mem_set.UserStackHigh.end_addr;
    *((struct trap_context *)user_high_sp) = app_trap_context;

    
    // 第三步: 将stvec修改成__alltraps的位置
    w_stvec(__alltraps);
    
}

void run_app(uint64 num){
    set_current_user_stack_high(num);
    return_to_user();
}

