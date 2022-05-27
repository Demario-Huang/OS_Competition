#define __module_name__ 	"task_manager"

#include "task_manager.h"
#include "types.h"
#include "pid_allocator.h"
#include "panic.h"

void add_task_control_block(struct task_control_block TCB){   //Add one TCB to TASK_MANAGER_CONTAINER

    int pid = TCB.pid;
    
    if (!check_valid(pid)){
        panic("Cannot add TCB to TASK_MANAGER!\n");
    }

    TASK_MANAGER_CONTAINER[pid] = TCB;

}
void free_task_control_block(int pid){

    if (!check_valid(pid)){
        panic("Some thing wrong when free the tcb from TASK_MANAGER!\n");
    }

    TASK_MANAGER_CONTAINER[pid] = empty_tcb();

    free_pid(pid);
}

struct task_control_block schedule(int pid){   // give out one task control block
    
    for (int i = pid; i < MAX_NUM_OF_APPS; i++){
        if (check_valid(i)){
            return TASK_MANAGER_CONTAINER[i];
        }
    }
    for (int i = 0; i <= pid; i++){
        if (check_valid(i)){
            return TASK_MANAGER_CONTAINER[i];
        }
    }
    panic("Error when scheduling task!");
}