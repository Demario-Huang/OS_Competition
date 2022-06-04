#define __module_name__ 	"maparea"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "mm/pagetable.h"
#include "mm/framealloc.h"
#include "mm/MapArea.h"
#include "mm/MemorySet.h"
#include "console.h"
#include "riscv.h"
#include "trap_context.h"
#include "proc.h"


extern uint32 skernel;
extern uint32 ekernel;
extern uint32 stext;
extern uint32 etext;
extern uint32 srodata;
extern uint32 erodata;
extern uint32 sdata;
extern uint32 edata;
extern uint32 sbss_with_stack;
extern uint32 ebss;
extern void __restore(uint64 a0, uint64 a1);

void map_kernel(){

    kernel_memorySet.page_table = new_pagetable();

    // map .text
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    push_Map_Area(kernel_memorySet.text, kernel_memorySet.page_table, &stext, &etext);

    // map .rodata
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    push_Map_Area(kernel_memorySet.rodata, kernel_memorySet.page_table, &srodata, &erodata);

    // map .data
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    push_Map_Area(kernel_memorySet.data, kernel_memorySet.page_table, &sdata, &edata);

    // map .bss
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    push_Map_Area(kernel_memorySet.bss, kernel_memorySet.page_table, &sbss_with_stack, &ebss);

    // map Avaibable Frames
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    push_Map_Area(kernel_memorySet.Available_Frames, kernel_memorySet.page_table, &ekernel, 0x80A00000);
}

uint64 root_ppn_to_token(uint64 root_ppn){
    uint64 eight = 8;     // 我的编译器无法让我正常8 << 60，只能这样
    return (eight << 60) | root_ppn;
}

void activate_mm(){
    uint64 kernel_token = root_ppn_to_token(kernel_memorySet.page_table.root_ppn);
    w_satp(kernel_token);
    sfence_vma();
}


struct User_MemorySet copy_mem_set(struct User_MemorySet target_mem_set){

    struct User_MemorySet return_memory_set;

    uint64 target_root_ppn = target_mem_set.page_table.root_ppn; 

    return_memory_set.page_table = new_pagetable();

    // map text
    struct Map_Area target_text;
    target_text = target_mem_set.text;
    uint64 start_va = target_text.start_addr;
    uint64 end_va = target_text.end_addr;
    uint64 permission = target_text.permission;
    return_memory_set.text = new_Map_Area(start_va, end_va, 1, permission);
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.text, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));

    // map rodata
    struct Map_Area target_rodata;
    target_rodata = target_mem_set.rodata;
    start_va = target_rodata.start_addr;
    end_va = target_rodata.end_addr;
    permission = target_rodata.permission;
    return_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.rodata, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));


    // map data
    struct Map_Area target_data;
    target_data = target_mem_set.data;
    start_va = target_data.start_addr;
    end_va = target_data.end_addr;
    permission = target_data.permission;
    return_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.data, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));

    // map bss
    // 需要map吗？

    // map UserStackLow
    struct Map_Area target_UserStackLow;
    target_UserStackLow = target_mem_set.UserStackLow;
    start_va = target_UserStackLow.start_addr;
    end_va = target_UserStackLow.end_addr;
    permission = target_UserStackLow.permission;
    return_memory_set.UserStackLow = new_Map_Area(start_va,end_va, 1, permission);
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.UserStackLow, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));


    // map UserStackHigh
    struct Map_Area target_UserStackHigh;
    target_UserStackHigh = target_mem_set.UserStackHigh;
    start_va = target_UserStackHigh.start_addr;
    end_va = target_UserStackHigh.end_addr;
    permission = target_UserStackHigh.permission;
    return_memory_set.UserStackHigh = new_Map_Area(start_va, end_va, 1, permission);
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.UserStackHigh, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));


    // map Trampline
    struct Map_Area target_Trampline;
    target_Trampline = target_mem_set.Trampline;
    start_va = __restore;
    end_va = start_va + 1024;
    return_memory_set.Trampline = new_Map_Area(start_va, end_va, 0, 0b0101);
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.Trampline, return_memory_set.page_table, start_va, end_va); 


    // map Kernel_Stack
    struct Map_Area target_Kernel_Stack;
    target_Kernel_Stack = target_mem_set.Kernel_Stack;
    start_va = target_Kernel_Stack.start_addr;
    end_va = target_Kernel_Stack.end_addr;
    permission = target_Kernel_Stack.permission;
    return_memory_set.Kernel_Stack = new_Map_Area(start_va, end_va, 1, permission);
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.Kernel_Stack, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));  

    return return_memory_set;    
    
}
