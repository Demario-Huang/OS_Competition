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
#include "fs/fsinfo.h"
#include "fs/driver.h"
#include "trap_context.h"

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
        sys_yield();
    }
    else if (type == SYSCALL_GET_TIME){
        return r_time() / 10000000;
    }
    else if (type == SYSCALL_FORK){
        return sys_fork();
    }
    else if (type == SYSCALL_WAITPID){

        sys_wait();

    }
    else if (type == SYSCALL_EXEC){
        uint64 path = translate(root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn), args[0]);
        sys_exec(path);
    }
    else{
        panic("[kernel] Not supported system call: %d\n", type);
    }
    return 0;
}

void sys_exit(uint64 exit_code){
    printf("[kernel] The application end with exit code: %d\n", exit_code);
    free_task_control_block(TASK_MANAGER.processing_tcb.pid);
    sys_unlock_wait(TASK_MANAGER.processing_tcb.pid);

    if (TASK_MANAGER.number_of_apps > 0){
        run_next_app(0);

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

void sys_yield(){

    run_next_app(0);

}


uint64 sys_fork(){

    uint64 pid = tcb_clone(TASK_MANAGER.processing_tcb.pid);

    return pid;

}

// open a file, return a fd (start file block)
uint32 sys_fs_open(uint8* filename){
  uint32 fd;
  if (!IfExistFile) {
    fd = fs_create_Inode(filename);
    return fd;
  } else {
    fd = FindByfilename(filename);
    return fd;
  }
}

// read the file, could directly read the disk, do not do the protection like identiy the fd is valid
uint32* sys_fs_read(uint32 fd, uint32 size){
  return driver_read_fs(fd, size);
}

// write the file into disk 
void sys_fs_write(uint32 * data, uint32 fd,uint32 size){
  driver_write_fs(data, fd, size);
  update_Inode(fd, size);
}

void sys_fs_close(uint32 fd){
  fd = -1;
  return;
}


void sys_exec(uint64 path){
    
    exec_new_app(path);

    if (TASK_MANAGER.number_of_apps > 0){
        run_next_app(0);
    }
}


void sys_wait(){
    if (TASK_MANAGER.processing_tcb.waiting == -1){
        pc_back_one_inst();
        run_next_app(0);
    } 
    else if (TASK_MANAGER.processing_tcb.waiting == -2){
        TASK_MANAGER.TASK_MANAGER_CONTAINER[TASK_MANAGER.processing_tcb.pid].waiting = 0;    // been unlock
        return 0;
    }
    else{
        TASK_MANAGER.TASK_MANAGER_CONTAINER[TASK_MANAGER.processing_tcb.pid].waiting = -1;   // set its status to be waiting!
        printf("[kernel] pid %d begin waiting!\n", TASK_MANAGER.processing_tcb.pid);
        pc_back_one_inst();
        run_next_app(0);
    }
}





// Two auxilary functions for sys_wait()

void sys_unlock_wait(uint64 self_pid){
    
    for (int pid_i = 0; pid_i < MAX_NUM_OF_APPS; pid_i ++){
        if (TASK_MANAGER.TASK_MANAGER_CONTAINER[pid_i].waiting == -1){
            TASK_MANAGER.TASK_MANAGER_CONTAINER[pid_i].waiting = -2;
            printf("[kernel] pid %d unlock pid %d\n", self_pid, pid_i);
        }
        if (TASK_MANAGER.TASK_MANAGER_CONTAINER[pid_i].waiting == self_pid){
            TASK_MANAGER.TASK_MANAGER_CONTAINER[pid_i].waiting = -2;
        }
    }
}

void pc_back_one_inst(){

    uint64 user_high_sp = TASK_MANAGER.processing_tcb.memoryset.UserStackHigh.start_addr;
        
    uint64 phy_user_high_sp = translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, user_high_sp);

    struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);

    current_trap_cx.spec = current_trap_cx.spec - 4;    // re-run the current instruction
    *((struct trap_context *)phy_user_high_sp) = current_trap_cx;

}
    

