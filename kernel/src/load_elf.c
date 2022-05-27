#define __module_name__ 	"load_elf"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "load_elf.h"
#include "mm/pagetable.h"
#include "mm/framealloc.h"
#include "mm/MapArea.h"
#include "mm/MemorySet.h"
#include "mm/kmalloc.h"
#include "console.h"
#include "riscv.h"
#include "proc.h"
#include "config.h"

struct User_MemorySet load_elf(uint64 elf_source){
    struct User_MemorySet user_memory_set;

    user_memory_set.page_table = new_pagetable();
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;

    // check the magic of elf file
    for (int i = 0; i < 4; i++){
        if (i == 0){
            if (ehdr.e_ident[i] != 0x7f){
                panic("[kernel] Wrong elf magic");
            }
        }
        if (i == 1){
            if (ehdr.e_ident[i] != 'E'){
                panic("[kernel] Wrong elf magic");
            }
        }
        if (i == 2){
            if (ehdr.e_ident[i] != 'L'){
                panic("[kernel] Wrong elf magic");
            }
        }
        if (i == 3){
            if (ehdr.e_ident[i] != 'F'){
                panic("[kernel] Wrong elf magic");
            }
        }
    }

    uint16 ph_count = ehdr.e_phnum;

    uint64 ptr_ph_table = elf_source + ehdr.e_phoff;


    Elf64_Phdr phdr = *(Elf64_Phdr *)ptr_ph_table;
    uint64 base_address = phdr.p_paddr;

    for (int i = 0; i < ph_count; i++){
        Elf64_Phdr phdr = *(Elf64_Phdr *)ptr_ph_table;

        if (phdr.p_type == 1){   // LOAD
            uint64 start_va = phdr.p_vaddr;
            uint64 end_va = start_va + phdr.p_memsz;

            uint64 flags = phdr.p_flags;

            uint64 permission = 0x1000 | flags;   

            uint64 copy_start = phdr.p_offset + elf_source;
            uint64 copy_end = copy_start + phdr.p_filesz;
            if (i == 0){ // map text
                user_memory_set.text = new_Map_Area(start_va, end_va, 1, permission);
                push_Map_Area(user_memory_set.text, user_memory_set.page_table, copy_start, copy_end);
            }else if (i == 1){
                user_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
                push_Map_Area(user_memory_set.rodata, user_memory_set.page_table, copy_start, copy_end);
            }else if (i == 2){
                user_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
                push_Map_Area(user_memory_set.data, user_memory_set.page_table, copy_start, copy_end);
            }else if (i == 3){
                user_memory_set.bss = new_Map_Area(start_va, end_va, 1, permission);
                push_Map_Area(user_memory_set.bss, user_memory_set.page_table, copy_start, copy_end);
            }
        }
        ptr_ph_table += ehdr.e_phentsize;
    }
    // Then, map user stack low and user stack high(trap context)
    // low
    // struct U_Stack new_user_stack;
    uint64 start_va = kmalloc(USER_STACK_SIZE);
    uint64 end_va = start_va + USER_STACK_SIZE;

    printf("the start_va of stack is %x\n", start_va);
    user_memory_set.UserStackLow = new_Map_Area(start_va, end_va, 1, 0x1111);
    push_Map_Area(user_memory_set.UserStackLow, user_memory_set.page_table, start_va, end_va);
    
    // High
    start_va = kmalloc(1024);
    end_va = start_va + 1024;

    user_memory_set.UserStackHigh = new_Map_Area(start_va, end_va, 1, 0x1111);
    push_Map_Area(user_memory_set.UserStackHigh, user_memory_set.page_table, start_va, end_va);

    return user_memory_set;
}