#ifndef __PROC_H
#define __PROC_H

#include "types.h"
#include "config.h"



// 区分高位低位是为了方便在开启分页模式后移植过去
static char UserStack_LOW_0[USER_STACK_SIZE];     // 同时，一个这样的用户栈，内核栈对应一个pid
static char UserStack_HIGH_0[1024];
static char KernerlStack[KERNEL_STACK_SIZE];

void init_all_apps();

void init_app(uint64 app_name);

void run_next_app(int init);

void run_next_app_from_kernel(int init);

uint64 scheduler();

void timerinit();
void set_next_timeout();


uint64 tcb_clone(uint64 target_pid);

void exec_new_app(uint64 path);


#endif