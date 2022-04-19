#ifndef __TRAP_CONTEXT_H
#define __TRAP_CONTEXT_H

#include "types.h"


struct trap_context {
    uint64 general_register[32];   // 保存32个通用寄存器
    uint64 spec;    // 指示返回Usermode后该执行的第一段代码，
    uint64 kernel_satp;   // 内核根目录的物理页帧页数
    uint64 trap_handler;  // trap_handler的地址
};

struct trap_context new_trap_cx(uint64 spec, uint64 kernel_satp, uint64 trap_handler, uint64 current_sp);

#endif