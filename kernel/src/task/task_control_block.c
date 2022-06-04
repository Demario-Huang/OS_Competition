// 定义一个任务上下文，并定义这个数据结构的初始化函数
#define __module_name__ 	"task_control_block"

#include "task_context.h"
#include "types.h"
#include "task_control_block.h"
#include "pid_allocator.h"

struct task_control_block new_task_control_block(struct task_context task_cx, char* Kernel_stack, uint64 current_pid){
    struct task_control_block TCB;
    
    TCB.task_context = task_cx;
    TCB.Kernel_stack = Kernel_stack;
    TCB.waiting = 0;
    if (current_pid == 0){
        TCB.pid = alloct_pid();
    }else{
        TCB.pid = current_pid;
    }
    return TCB;
}

struct task_control_block empty_tcb(){
    struct task_control_block empty_tcb;

    return empty_tcb;
}