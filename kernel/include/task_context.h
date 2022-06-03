#ifndef __TASK_CONTEXT_H
#define __TASK_CONTEXT_H

#include "types.h"


struct task_context {
    uint64 ra;    // 保留返回时应该运行的代码，初始化为应用程序入口  0(sp)
    uint64 sp;  // 内核栈的位置                                   8(sp)
    uint64 satp;   // 地址空间                                   16(sp)
    uint64 general_register[12];   // 保存12个通用寄存器
};

struct task_context new_task_cx(uint64 app_entry, uint64 app_sp, uint64 app_satp);

#endif