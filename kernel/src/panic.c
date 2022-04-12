#include "printf.h"
#include "panic.h"
#include "sbi.h"


void panic(char *msg, ...){
    printf(msg);
    sbi_shutdown();      // Panic in the kernel means directly shutdown all 
}