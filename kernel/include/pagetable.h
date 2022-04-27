#ifndef __PAGETABLE_H
#define __PAGETABLE_H

#include "types.h"




// PageTable数据结构，储存根目录的物理页号
struct PageTable{
    uint64 root_ppn;
};

// 假设frame_allocator已经实现了的 -> 分配一个物理页号
uint64 get_frame();

// 从vpn中提取出二级PPN
uint64 get_ppn_2(uint64 ppn);

// 从vpn中提取出一级PPN
uint64 get_ppn_1(uint64 ppn);

// 从vpn中提取出零级PPN
uint64 get_ppn_0(uint64 ppn);

uint64 to_physical_addr(uint64 ppn);

uint64 get_PTE(uint64 ppn, uint64 index);

uint64 check_PTE_valid(uint64 PTE);

void set_permission(uint64 PTE_addr, uint64 set_bit);

void set_PTE_ppn(uint64 PTE_addr, uint64 ppn);

uint64 get_PTE_ppn(uint64 PTE_addr);

// 创建一个新的页表
struct PageTable new_pagetable();

// 给定一个虚拟页号，一个物理物理页号，建立page_table来形成映射关系
void map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags);

// 给定一个虚拟页号，释放其映射的物理页帧，并清空对应的PTE
void unmap(struct PageTable pg, uint64 vpn);

// a test mapping vpn = 1 to ppn = 10
void test_page_table();

#endif