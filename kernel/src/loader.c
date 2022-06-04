// 将应用程序从.bss位置load到0x80400000的位置

#define __module_name__ 	"loader"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "mm/MemorySet.h"
#include "load_elf.h"
#include "proc.h"


extern uint64 _num_app;
extern uint64 _app_names;
extern uint64 app_8_start;
extern struct task_manager TASK_MANAGER;



// struct User_MemorySet load(uint64 app_index){

//     uint64 num_of_apps = *(uint64 *)(&_num_app);

//     uint64 start_addr = *(uint64 *)(&_num_app + app_index);

//     // 将elf文件解析开
//     struct User_MemorySet new_mem_set = load_elf(start_addr);

//     return new_mem_set;
// }


// check whether two strings are the same
uint64 check_name(uint64 left_addr, uint64 right_addr){
    uint64 index = 0;
    while (1){
        if (*(char *)(left_addr + index) == *(char *)(right_addr + index)){
            if (*(char *)(left_addr + index) == '\0' && index > 0){
                return 1;
            }
            index += 1;
        }
        else{
            return 0;
        }
    }
}

// Change to load by app name
struct User_MemorySet load(uint64 str_addr){

    uint64 num_of_apps = *(uint64 *)(&_num_app);

    uint64 index = &_app_names;
    uint64 found = 0;
    uint64 found_app = -1; 
    for (uint64 app_i = 0; app_i < num_of_apps; app_i ++){
        found = check_name(index, str_addr);
        if (found == 1){
            found_app = app_i;
            break;
        }
        while (*(char *)index != '\0'){
            index += 1;
        }
        index += 1;
    }

    found_app += 1;
    uint64 start_addr = *(uint64 *)(&_num_app + found_app);

    // 将elf文件解析开
    struct User_MemorySet new_mem_set = load_elf(start_addr);

    return new_mem_set;
}





void zero_init(uint64 start, uint64 end){
    for (uint64 i = start; i <= end; i++){
        *(char*)i = 0;
    }
}

