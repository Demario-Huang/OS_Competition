#define __module_name__ 	"fsinfo"

#include "fs/fsinfo.h"
#include "mm/framealloc.h"
#include "fs/driver.h"
#include "types.h"
#include "printf.h"


// read the infomation from disk, and create a logic file system 
void fs_init(){

  printf("hello i am in \n");
  // 读取文件系统里super block和所有inode的信息，在内核中为inode创建链表
  Inode test;
  test.file_size = 123;
  Node_array[0].file_size = test.file_size;

  printf("node size is %d \n" , Node_array[0].file_size);
}

uint32 IfExistFile(uint8 * filename){
  for (int i = 0; i < 20; i++){
    uint8 * Inodefilename = Node_array[i].filename;
    uint8 flag  = 1; 
    for (int j = 0; j < 32; j++){
      if( *(filename+j) !=  *(Inodefilename + j)){
        flag = 0;
        break;
      }
    }
    if (flag = 1){
      return 1;
    }
  }
  return 0;
}

uint32 FindByfilename(uint8 * filename){
  for (int i = 0; i < 20; i++){
    uint8 * Inodefilename = Node_array[i].filename;
    uint8 flag  = 1; 
    for (int j = 0; j < 32; j++){
      if( *(filename+j) !=  *(Inodefilename + j)){
        uint8 flag  = 0; 
        break;
      }
    }
    if (flag = 1){
      return Node_array[i].start_block;
    }
  }
  return -1;
}


// create the Inode and write the info into disk
uint32 fs_create_Inode(uint8 * filename ){
  uint8 * Inodefilename = Node_array[current_Inode_index].filename;
  for (int i  = 0; i < 32; i++){
    *(Inodefilename + i) = *(filename + i);
  }
  Node_array[current_Inode_index].start_block =current_data_block_end;
  Node_array[current_Inode_index].end_block = current_data_block_end + 1;
  Node_array[current_Inode_index].file_size = 1;
  current_data_block_end += 1;
  datablock_total_num += 1;
  current_Inode_index += 1;
  // write the info into disk, lack of api to do so

  return (Node_array[current_Inode_index -1 ].start_block) ;// return the start block as fd;
}

void update_Inode(uint32 fd, uint32 size){}

void fs_mytest(){
}