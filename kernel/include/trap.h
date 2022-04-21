#ifndef __TRAP_H
#define __TRAP_H

#include "types.h"
#include "trap_context.h"


// struct trap_context trap_cx;

extern void __restore(uint64 a0, uint64 a1);

void return_to_user();

void trap_handler();

#endif