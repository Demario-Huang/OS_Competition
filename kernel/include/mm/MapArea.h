#ifndef __MAPAREA_H
#define __MAPAREA_H

#include "types.h"


// 存储一个连续虚拟地址的段，并有访问的特权级区分
struct Map_Area{
    uint64 start_addr;
    uint64 end_addr;
    uint64 vpn_start;
    uint64 vpn_end;
    uint64 map_type;     // 0: 直接映射。 1： Framed
    uint64 permission;   // 0b1111: 从左到右分别代表 UXWR
};

struct Map_Area new_Map_Area(uint64 start_addr, uint64 end_addr, uint64 map_type, uint64 permissions);

// 将整个Map_Area建立page table映射
// 如果是Framed映射，还要进行拷贝申请framed并把数据拷贝进去
void push_Map_Area(struct Map_Area map_area, struct PageTable pg, uint64 copy_start, uint64 copy_end);   // copy_start要拷贝位置的起点指针

// 给一个起始物理页号和拷贝位置的起点指针，将相应内容拷贝到物理页帧中
void copy_to_frame(uint64 ppn, uint64 copy_start, uint64 copy_end, uint64 start_offset);  

// 释放一个MapArea中的所有页表，并将其映射的物理页帧释放。
void free_Map_Area(struct Map_Area map_area, struct PageTable pg);  

void test_map_area();

#endif