

#define __module_name__ 	"main"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "loader.h"
#include "proc.h"
#include "mm/framealloc.h"
#include "pid_allocator.h"
#include "mm/pagetable.h"
#include "mm/kmalloc.h"
#include "riscv.h"
#include "mm/MapArea.h"
#include "mm/MemorySet.h"
#include "task_manager.h"
<<<<<<< HEAD
#include "fs/fsinfo.h"
=======
>>>>>>> 6fd289ae543ced2cf470eaa4358fa2983b3b825a

extern struct task_manager TASK_MANAGER;

void main(int num_core) {
    printf("[kernel] num of cores: %d \n", num_core);  // 通过寄存器entry.S中设置的寄存器a0来传这个num_core参数
    initmalloc();
    test_alloc();

    map_kernel();
    activate_mm();
    printf("[kernel] ok to activate mm! Back to Kernel!\n");

    test_page_table();

<<<<<<< HEAD
    fs_init();
    printf("fs init.. and fs size is %d \n", fs_size);
    printf("fs 0 size is %d \n", Node_array[0].file_size);
    printf("test a is %d \n", testa[0]);
    test();


    // TASK_MANAGER.number_of_apps = 0; 
    // init_all_apps(); // 初始化App，包括初始化其trap上下文，将trap上下文放到用户栈中。
    // timerinit();
    // run_next_app(1);
=======

    TASK_MANAGER.number_of_apps = 0; 
    init_all_apps(); // 初始化App，包括初始化其trap上下文，将trap上下文放到用户栈中。
    timerinit();
    run_next_app(1);
>>>>>>> 6fd289ae543ced2cf470eaa4358fa2983b3b825a


    panic("[kernel] If this is printed, sth must get wrong!\n");
}


void test_alloc(){
    uint32 frame1 = get_frame();
    uint32 frame2 = get_frame();
    uint32 frame3 = get_frame();
    free_frame(frame1);
    free_frame(frame2);
    uint32 frame4 = get_frame();
}
