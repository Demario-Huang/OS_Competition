#ifndef __SYSCALL_H
#define __SYSCALL_H

#include "types.h"

uint64 syscall(uint64 type, uint64 args[3]);

#endif 