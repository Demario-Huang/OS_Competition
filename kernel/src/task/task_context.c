// 定义一个任务上下文，并定义这个数据结构的初始化函数
#define __module_name__ 	"task_context"

#include "task_context.h"
#include "types.h"


struct task_context new_task_cx(uint64 app_entry, uint64 app_sp, uint64 app_satp){
    struct task_context new_task_context;

    for (int i = 0; i < 12; i++){
        new_task_context.general_register[i] = 0;
    }

    new_task_context.ra = app_entry;
    new_task_context.sp = app_sp;
    new_task_context.satp = app_satp;


    return new_task_context;
}
