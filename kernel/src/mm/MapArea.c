#define __module_name__ 	"maparea"

#include "printf.h"
#include "panic.h"
#include "types.h"
#include "string.h"
#include "mm/pagetable.h"
#include "mm/framealloc.h"
#include "mm/MapArea.h"
#include "console.h"

struct Map_Area new_Map_Area(uint64 start_addr, uint64 end_addr, uint64 map_type, uint64 permissions){
    uint64 start_vpn = (start_addr) / PAGE_SIZE;
    uint64 end_vpn = (end_addr) / PAGE_SIZE;

    if (((end_addr) % PAGE_SIZE) > 0) end_vpn += 1;

    struct Map_Area new_map_area;
    new_map_area.vpn_start = start_vpn;
    new_map_area.vpn_end = end_vpn;
    new_map_area.map_type = map_type;
    new_map_area.permission = permissions;
    return new_map_area;
}

void copy_to_frame(uint64 ppn, uint64 copy_start, uint64 copy_end){
    uint64 phys_addr_start = to_physical_addr(ppn);
    if (copy_end == 0){
        for (int i = 0; i < PAGE_SIZE; i++){
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
        }
    }else{
        for (int i = 0; i < copy_end - copy_start; i++){
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
        }
    }
}

void push_Map_Area(struct Map_Area map_area, struct PageTable pg, uint64 copy_start, uint64 copy_end){
    uint64 map_type = map_area.map_type;
    uint64 vpn_start = map_area.vpn_start;
    uint64 vpn_end = map_area.vpn_end;
    uint64 permission = map_area.permission;

    if (map_type == 0){    // 进行Identical的映射
        for (uint64 vpn = vpn_start; vpn <= vpn_end; vpn++){
            map(pg, vpn, vpn, permission);
        }
    }else if (map_type == 1){    // 进行Framed映射
        for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
            uint64 target_ppn = get_frame();
            copy_to_frame(target_ppn, copy_start, 0);    // 将目标值拷贝进页帧
            map(pg, vpn, target_ppn, permission);
            copy_start += PAGE_SIZE;
        }
        uint64 target_ppn = get_frame();
        copy_to_frame(target_ppn, copy_start, copy_end);
        map(pg, vpn_end, target_ppn, permission);
    }else{
        panic("Wrong in pushing MapArea!");
    }
}

void free_Map_Area(struct Map_Area map_area, struct PageTable pg){
    uint64 vpn_start = map_area.vpn_start;
    uint64 vpn_end = map_area.vpn_end;

    for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
        unmap(pg, vpn);
    }
}


void test_map_area(){
    struct Map_Area MA = new_Map_Area(0X80200000, 0X80300000, 1, 0b1111);
    struct PageTable PG = new_pagetable();


    push_Map_Area(MA, PG, 0x80200000, 0x80300000);
}