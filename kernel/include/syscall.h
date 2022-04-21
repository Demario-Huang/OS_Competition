#ifndef __SYSCALL_H
#define __SYSCALL_H

#include "types.h"

uint64 syscall(uint64 type, uint64 args[3]);

void sys_exit(uint64 exit_code);

uint64 sys_write(uint64 fd, char* buf, uint64 length);

#endif 