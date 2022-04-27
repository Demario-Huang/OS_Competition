#ifndef __TASK_MANAGER_H
#define __TASK_MANAGER_H

#include "types.h"
#include "task_context.h"
#include "task_control_block.h"
#include "pid_allocator.h"

// contains several one bitmap. 
static struct task_control_block TASK_MANAGER_CONTAINER[MAX_NUM_OF_APPS];   // 与pid一一对应

void add_task_control_block(struct task_control_block TCB);   //Add one TCB to TASK_MANAGER_CONTAINER

void free_task_control_block(int pid);

struct task_control_block schedule(int pid);

#endif