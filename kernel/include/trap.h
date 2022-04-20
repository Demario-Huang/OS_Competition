#ifndef __TRAP_H
#define __TRAP_H

#include "types.h"
#include "trap_context.h"


// struct trap_context trap_cx;

void return_to_user(struct trap_context trap_cx);

void trap_handler(struct trap_context trap_cx);

#endif