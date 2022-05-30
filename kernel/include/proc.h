#ifndef __PROC_H
#define __PROC_H

#include "types.h"
#include "config.h"



// 区分高位低位是为了方便在开启分页模式后移植过去
static char UserStack_LOW_0[USER_STACK_SIZE];     // 同时，一个这样的用户栈，内核栈对应一个pid
static char UserStack_HIGH_0[1024];

void init_app(uint64 num);

void run_app(uint64 num);

#endif