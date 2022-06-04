#define __module_name__ 	"task_manager"

#include "task_manager.h"
#include "types.h"
#include "pid_allocator.h"
#include "panic.h"
#include "task_control_block.h"


struct task_manager TASK_MANAGER;


void add_task_control_block(struct task_control_block TCB){   //Add one TCB to TASK_MANAGER_CONTAINER

    int pid = TCB.pid;
    
    if (!check_valid(pid)){
        panic("Cannot add TCB to TASK_MANAGER!\n");
    }

    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = TCB;
    TASK_MANAGER.number_of_apps += 1;
    printf("[task manager] the pid is %d\n", pid);
}

void free_task_control_block(int pid){

    if (!check_valid(pid)){
        panic("Some thing wrong when free the tcb from TASK_MANAGER!\n");
    }
    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = empty_tcb();
    free_pid(pid);
    TASK_MANAGER.number_of_apps -= 1;
}

struct task_control_block schedule(int pid){   // give out one task control block
    
    for (int i = pid; i < MAX_NUM_OF_APPS; i++){
        if (check_valid(i)){
            return TASK_MANAGER.TASK_MANAGER_CONTAINER[i];
        }
    }
    for (int i = 0; i <= pid; i++){
        if (check_valid(i)){
            return TASK_MANAGER.TASK_MANAGER_CONTAINER[i];
        }
    }
    panic("Error when scheduling task!");
}