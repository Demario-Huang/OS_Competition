#ifndef __TASK_MANAGER_H
#define __TASK_MANAGER_H

#include "types.h"
#include "task_context.h"
#include "task_control_block.h"
#include "pid_allocator.h"



void add_task_control_block(struct task_control_block TCB);   //Add one TCB to TASK_MANAGER_CONTAINER

void free_task_control_block(int pid);

struct task_control_block schedule(int pid);


struct task_manager{
    struct task_control_block TASK_MANAGER_CONTAINER[MAX_NUM_OF_APPS];   // 与pid一一对应   MAX_NUM_OF_APPS 定义在pid_allocator.h中
    struct task_control_block processing_tcb;
    uint64 number_of_apps;
};

#endif