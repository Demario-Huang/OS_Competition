#include "types.h"
#include "syscall.h"
#include "panic.h"
#include "console.h"
#include "proc.h"
#include "riscv.h"
#include "mm/pagetable.h"
#include "mm/framealloc.h"
#include "mm/MapArea.h"
#include "mm/MemorySet.h"
#include "mm/kmalloc.h"
#include "task_manager.h"

#define SYSCALL_READ 63
#define SYSCALL_WRITE 64
#define SYSCALL_EXIT 93
#define SYSCALL_YIELD 124
#define SYSCALL_GET_TIME 169
#define SYSCALL_GETPID 172
#define SYSCALL_FORK 220
#define SYSCALL_EXEC 221
#define SYSCALL_WAITPID 260


extern struct task_manager TASK_MANAGER;

uint64 syscall(uint64 type, uint64 args[3]){
    if (type == SYSCALL_WRITE){
        args[1] = translate(root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn), args[1]);
        sys_write(args[0], args[1], args[2]);
    }
    else if (type == SYSCALL_EXIT){
        sys_exit(args[0]);
    }
    else if (type == SYSCALL_YIELD){
        panic("[kernel] We haven't implement yield system call, so you can't sleep! Keep working!\n");
    }
    else if (type == SYSCALL_GET_TIME){
        return r_time() / 10000000;
    }
    else{
        printf("[kernel] Not supported system call: %d\n", type);
    }
    return 0;
}

void sys_exit(uint64 exit_code){
    printf("[kernel] The application end with exit code: %d\n", exit_code);

    // then, switch to another app. 
    if (TASK_MANAGER.processing_tcb.pid + 1 < 4){

        init_app(TASK_MANAGER.processing_tcb.pid + 1);

    }else{
        panic("finish running all the apps!\n");
    }
}

uint64 sys_write(uint64 fd, char* buf, uint64 length) {
    if (fd == 1){    // means STDOUT
        for (int i = 0; i < length; i++){
            consputc(buf[i]);
        }
    }
    return length;
}

