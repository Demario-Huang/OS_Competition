#ifndef __PROC_H
#define __PROC_H

#include "types.h"
#include "config.h"

// 区分高位低位是为了方便在开启分页模式后移植过去
static char UserStack_LOW[USER_STACK_SIZE];
static char UserStack_HIGH[1024];
static char KernelStack[1024];

uint64 get_user_stack_low_top();

uint64 get_user_stack_high_top();

uint64 get_kernel_stack_top();

void init_app();

void run_app();

#endif