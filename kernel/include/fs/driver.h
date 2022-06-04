#ifndef __DRIVER_H
#define __DRIVER_H

#include "types.h"

// write the info into data block 
void write_fs(uint32 * data, uint32 block_id, uint32 size );

// read from physical fs, return a file stream
uint32 * read_fs(uint32 block_id, uint32 size);

#endif