#ifndef __PID_ALLOCATOR_H
#define __PID_ALLOCATOR_H

#include "types.h"
#define MAX_NUM_OF_APPS 10   // 暂时只允许10个应用程序同时载入

static int PID_BITMAP[MAX_NUM_OF_APPS];    // kind of a bitmap to indicate whether one pid is valid. 0 means valid

void init_pid_bitmap();    // 对PID_BITMAP进行0初始化

int alloct_pid();   // find a valid pid, then return it. 

void free_pid(int pid);

int check_valid(int pid); // check whether a pid is valid or not. If it has been used return 1;

#endif