#ifndef __PROC_H
#define __PROC_H

#include "types.h"
#include "config.h"

static char UserStack[KERNEL_STACK_SIZE];

uint64 get_user_stack_top();

void init_app();

void run_app();

#endif