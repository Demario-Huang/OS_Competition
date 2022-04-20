
#define __module_name__ 	"trap"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "trap.h"
#include "trap_context.h"
#include "riscv.h"
#include "syscall.h"


#define EXCP_ENV_CALL     0x8



void return_to_user(struct trap_context trap_cx){

}

void trap_handler(struct trap_context trap_cx){
    uint64 trap_cause = r_scause();
    switch(trap_cause){
        case(EXCP_ENV_CALL):
            trap_cx.spec += 4;
            uint64 args[3] = {trap_cx.general_register[10], trap_cx.general_register[11], trap_cx.general_register[12]};
            trap_cx.general_register[10] = syscall(trap_cx.general_register[17], args);
            break;
        default:
            printf("No one handle it!");
            break;
    }
}