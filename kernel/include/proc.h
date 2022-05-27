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
static char KernelStack_1[1024];
static char KernelStack_2[1024];
static char KernelStack_3[1024];
static char KernelStack_4[1024];
static char KernelStack_5[1024];
static char KernelStack_6[1024];
static char KernelStack_7[1024];
static char KernelStack_8[1024];
static char KernelStack_9[1024];

static uint64 KernelStack_List[10] = {KernelStack, KernelStack_1, KernelStack_2, KernelStack_3, KernelStack_4, KernelStack_5, KernelStack_6, KernelStack_7, KernelStack_8, KernelStack_9};
static uint64 UserStack_Low_List[10] = {UserStack_LOW, UserStack_LOW_1, UserStack_LOW_2, UserStack_LOW_3, UserStack_LOW_4, UserStack_LOW_5, UserStack_LOW_6, UserStack_LOW_7, UserStack_LOW_8, UserStack_LOW_9};
static uint64 UserStack_High_List[10] = {UserStack_HIGH, UserStack_HIGH_1, UserStack_HIGH_2, UserStack_HIGH_3, UserStack_HIGH_4, UserStack_HIGH_5, UserStack_HIGH_6, UserStack_HIGH_7, UserStack_HIGH_8, UserStack_HIGH_9};

struct U_Stack{
    char Low[USER_STACK_SIZE];
    char High[1024];
};

struct K_Stack{
    char stack[1024];
};

uint64 get_user_stack_low_top(uint64 num);

uint64 get_user_stack_high_top(uint64 num);

uint64 get_kernel_stack_top(uint64 num);

void init_app(uint64 num);

void run_app(uint64 num);

#endif