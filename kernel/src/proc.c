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
#include "sbi.h"



extern void __alltraps();
extern void __switch(uint64 a0, uint64 a1);
extern struct task_manager TASK_MANAGER;
extern uint64 _num_app;


void init_app(uint64 pid){

    // 初始化进程管理
    // 第一步：初始化app的地址空间
    struct User_MemorySet current_mem_set = load(pid + 1);    // 将应用程序load到主内存中
    uint64 kernel_stack_top = current_mem_set.Kernel_Stack.end_addr;

    // 第二步：初始化进程上下文
    struct task_context app_task_context = new_task_cx(return_to_user, kernel_stack_top, root_ppn_to_token(current_mem_set.page_table.root_ppn));

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
    uint64 sstatus = r_sstatus();


    struct trap_context app_trap_context = new_trap_cx(app_entry, kernel_satp, app_trap_handler, user_low_sp, kernel_stack_top, sstatus);


    // 第二步: 将trap上下文放在用户栈高位栈顶：
    uint64 user_high_sp = current_mem_set.UserStackHigh.start_addr;
    uint64 phy_user_high_sp = translate(current_mem_set.page_table.root_ppn, user_high_sp);
    *((struct trap_context *)phy_user_high_sp) = app_trap_context;


    // 第三步: 将stvec修改成__alltraps的位置
    w_stvec(__alltraps);    

}

uint64 scheduler(){

    // 先采用FIFO的schedule策略

    uint64 current_pid = TASK_MANAGER.processing_tcb.pid;

    uint64 next_pid = (current_pid + 1) % MAX_NUM_OF_APPS;

    while(!check_valid(next_pid)){
        next_pid = (next_pid + 1) % MAX_NUM_OF_APPS;
    }

    return next_pid;

}

// 开启时钟中断  - 有关timer的这两个函数照搬了xv6的
void timerinit(){
    w_sie(r_sie() | SIE_STIE);
    set_next_timeout();
    printf("[kernel] timerinit\n");
}

void set_next_timeout(){
    sbi_set_timer(r_time() + INTERVAL / 100);
}




void init_all_apps(){
    
    uint64 num_of_apps = *(uint64 *)(&_num_app);

    for (int i = 0; i < num_of_apps; i++){
        init_app(i);
    }

}

void run_next_app(int init){

    if (init == 1){
        TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[0];
        return_to_user();
        return 0;
    }

    uint64 pid = scheduler();

    TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[pid];

}


void run_next_app_from_kernel(int init){

    if (init == 1){
        TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[0];
        return_to_user();
        return 0;
    }

    uint64 previous_pid = TASK_MANAGER.processing_tcb.pid;
    uint64 a0 = &(TASK_MANAGER.TASK_MANAGER_CONTAINER[previous_pid].task_context);
    uint64 pid = scheduler();
    uint64 a1 = &(TASK_MANAGER.TASK_MANAGER_CONTAINER[pid].task_context);

    TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[pid];

    
    printf("[from kernel] prepare to return to %x\n", TASK_MANAGER.TASK_MANAGER_CONTAINER[pid].task_context.ra);
    // 将a0的信息存入tcb
    // 将a1的信息从tcb放入寄存器
    __switch(a0, a1);

}
