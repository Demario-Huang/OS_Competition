// 将应用程序从.bss位置load到0x80400000的位置

#define __module_name__ 	"loader"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"

extern uint64 _num_app;
int num_of_apps;
uint64 current_app = 0;

void load(){

    num_of_apps = *(uint64 *)(&_num_app);

    uint64 entry = 0x80400000;
    for (int i = 1; i <= num_of_apps; i++){
        uint64 start_addr = *(uint64 *)(&_num_app + i);
        uint64 end_addr = *(uint64 *)(&_num_app + i + num_of_apps);
        uint64 size = end_addr - start_addr;

        memcpy(entry, start_addr, size);
        entry += 0x20000;
    }

}

void zero_init(uint64 start, uint64 end){
    for (uint64 i = start; i <= end; i++){
        *(char*)i = 0;
    }
}

