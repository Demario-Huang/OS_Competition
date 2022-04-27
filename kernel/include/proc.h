#ifndef __PROC_H
#define __PROC_H

#include "types.h"
#include "config.h"

// 区分高位低位是为了方便在开启分页模式后移植过去

// below wait to be delete
static char UserStack_LOW[USER_STACK_SIZE];
static char UserStack_HIGH[1024];
static char KernelStack[1024];
// up wait to be delete


static char UserStack_LOW_0[USER_STACK_SIZE];     // 同时，一个这样的用户栈，内核栈对应一个pid
static char UserStack_HIGH_0[1024];
static char UserStack_LOW_1[USER_STACK_SIZE];
static char UserStack_HIGH_1[1024];
static char UserStack_LOW_2[USER_STACK_SIZE];
static char UserStack_HIGH_2[1024];
static char UserStack_LOW_3[USER_STACK_SIZE];
static char UserStack_HIGH_3[1024];
static char UserStack_LOW_4[USER_STACK_SIZE];
static char UserStack_HIGH_4[1024];
static char UserStack_LOW_5[USER_STACK_SIZE];
static char UserStack_HIGH_5[1024];
static char UserStack_LOW_6[USER_STACK_SIZE];
static char UserStack_HIGH_6[1024];
static char UserStack_LOW_7[USER_STACK_SIZE];
static char UserStack_HIGH_7[1024];
static char UserStack_LOW_8[USER_STACK_SIZE];
static char UserStack_HIGH_8[1024];
static char UserStack_LOW_9[USER_STACK_SIZE];
static char UserStack_HIGH_9[1024];

static char KernelStack_0[1024];
static char KernelStack_2[1024];
static char KernelStack_3[1024];
static char KernelStack_4[1024];
static char KernelStack_5[1024];
static char KernelStack_6[1024];
static char KernelStack_7[1024];
static char KernelStack_8[1024];
static char KernelStack_9[1024];


uint64 get_user_stack_low_top();

uint64 get_user_stack_high_top();

uint64 get_kernel_stack_top();

void init_app();

void run_app();

#endif