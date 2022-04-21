// 将应用程序从.bss位置load到0x80400000的位置

#define __module_name__ 	"loader"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"

extern char* app_0_start;
extern char* app_0_end;
uint64 static app_entry = 0x80400000;


void load(){
    uint64 size = (&app_0_end - &app_0_start)*8;    
    memcpy(app_entry, &app_0_start, size);
}

