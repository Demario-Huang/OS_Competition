#include "types.h"
#include "syscall.h"
#include "panic.h"
#include "console.h"

#define SYSCALL_READ 63
#define SYSCALL_WRITE 64
#define SYSCALL_EXIT 93
#define SYSCALL_YIELD 124
#define SYSCALL_GET_TIME 169
#define SYSCALL_GETPID 172
#define SYSCALL_FORK 220
#define SYSCALL_EXEC 221
#define SYSCALL_WAITPID 260

uint64 syscall(uint64 type, uint64 args[3]){
    if (type == SYSCALL_WRITE){
        sys_write(args[0], args[1], args[2]);
    }
    else if (type == SYSCALL_EXIT){
        sys_exit(args[0]);
    }
    else{
        printf("Not supported system call!\n");
    }
    return 0;
}

void sys_exit(uint64 exit_code){
    panic("[kernel] The application end with exit code: %d\n", exit_code);
}

uint64 sys_write(uint64 fd, char* buf, uint64 length) {
    if (fd == 1){    // means STDOUT
        for (int i = 0; i < length; i++){
            consputc(buf[i]);
        }
    }
    return length;
}

