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
      if( (*filename+j) !=  (*Inodefilename + j)){
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


void fs_mytest(){
}