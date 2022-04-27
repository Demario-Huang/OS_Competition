#define __module_name__ 	"pid_allocator"

#include "pid_allocator.h"
#include "types.h"
#include "printf.h"
#include "panic.h"


void init_pid_bitmap(){     // 对PID_BITMAP进行0初始化
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
        PID_BITMAP[i] = 0;     // 0 means all are not used.
    }
}    

int alloct_pid(){   // find a valid pid, then return it. 
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
        if (PID_BITMAP[i] == 0){
            PID_BITMAP[i] = 1;
            return i;
        }
    }
    panic("All the pids have been used!!");
    return -100;
}

void free_pid(int pid){
    if (PID_BITMAP[pid] == 1){
        PID_BITMAP[pid] = 0;
    }
    else {
        panic("PID has already been free?");
    }
}

int check_valid(int pid){
    return PID_BITMAP[pid];
}