#ifndef __TASK_CONTROL_BLOCK_H
#define __TASK_CONTROL_BLOCK_H

#include "types.h"
#include "mm/MemorySet.h"
#include "task_context.h"

struct task_control_block {
    uint64 user_token;
    struct User_MemorySet memoryset;
    struct task_context task_context;
    char* Kernel_stack;
    uint64 pid;
    int waiting;  // 0: not waiting; -1: wait; >0: wait for pid. -2: unlock
};

struct task_control_block new_task_control_block(struct task_context task_cx, char* Kernel_stack, uint64 current_pid);

struct task_control_block empty_tcb();

#endif