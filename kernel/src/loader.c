// 将应用程序从.bss位置load到0x80400000的位置

#define __module_name__ 	"loader"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "mm/MemorySet.h"
#include "load_elf.h"

extern uint64 _num_app;
int num_of_apps;
uint64 current_app = 0;

struct User_MemorySet load(uint64 app_index){

    num_of_apps = *(uint64 *)(&_num_app);

    uint64 start_addr = *(uint64 *)(&_num_app + app_index);

    // 将elf文件解析开
    struct User_MemorySet new_mem_set = load_elf(start_addr);

    return new_mem_set;
}

void zero_init(uint64 start, uint64 end){
    for (uint64 i = start; i <= end; i++){
        *(char*)i = 0;
    }
}

