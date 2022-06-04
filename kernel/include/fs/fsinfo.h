#ifndef __FSINFO_H
#define __FSINFO_H

#include "types.h"

static uint32 fs_size = 524288; // byte 
static uint32 total_block_num = 1000; 

static uint32 bitmap_start = 5;
static uint32 bitmap_block_num = 10;

static uint32 inode_start = 20 ;
static uint32 inode_block_num = 50;

static uint32 data_block_start = 100;
static uint32 current_data_block_end = 100;
static uint32 datablock_total_num = 0;

static uint32 current_Inode_index = 0;


// 内核中为inode创建链表
typedef struct Inode
{
  uint8 filename[32];
  uint32 start_block;
  uint32 end_block;
  uint32 file_size;
} Inode;

// 暂时让他只储存20个文件上限，后续完善malloc函数之后再用链表储存
static Inode Node_array[20];



// used to init the file system and load the information from physical filesystem 
// allocate the page to store the infomation, and update above infomation
void fsinit();

uint32 IfExistFile(uint8 * filename);

uint32 FindByfilename(uint8 * filename);

// return the start block as fd
uint32 fs_create_Inode( uint8 * filename );

void update_Inode(uint32 fd, uint32 size);

uint32 fsgetsize();

uint32  fsget_bitmap_start();

uint32 fsget_inode_start();

uint32 fsget_data_block_end();


#endif
