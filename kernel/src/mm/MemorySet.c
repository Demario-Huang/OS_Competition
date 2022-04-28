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

void map_kernel(){
    printf("[Memory Set] kernel [%x] - [%x]\n", &skernel, &ekernel);
    printf("[Memory Set] .text [%x] - [%x]\n", &stext, &etext);
    printf("[Memory Set] .rodata [%x] - [%x]\n", &srodata, &erodata);
    printf("[Memory Set] .data [%x] - [%x]\n", &sdata, &edata);
    printf("[Memory Set] .bss [%x] - [%x]\n", &sbss_with_stack, &ebss);

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
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0011);
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
