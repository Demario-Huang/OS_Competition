#ifndef __LOAD_ELF_H
#define __LOAD_ELF_H


typedef struct elf64_phdr
{
    uint32 p_type;
    uint32 p_flags;
    uint64 p_offset;   /* Segment file offset */
    uint64 p_vaddr;   /* Segment virtual address */
    uint64 p_paddr;   /* Segment physical address */
    uint64 p_filesz; /* Segment size in file */
    uint64 p_memsz;  /* Segment size in memory */
    uint64 p_align;  /* Segment alignment, file & memory */
} Elf64_Phdr;


typedef struct elf64_hdr
{
    unsigned char e_ident[16]; /* ELF "magic number" */
    uint16 e_type;
    uint16 e_machine;
    uint32 e_version;
    uint64 e_entry; /* Entry point virtual address */
    uint64 e_phoff;  /* Program header table file offset */
    uint64 e_shoff;  /* Section header table file offset */
    uint32 e_flags;
    uint16 e_ehsize;
    uint16 e_phentsize;
    uint16 e_phnum;
    uint16 e_shentsize;
    uint16 e_shnum;
    uint16 e_shstrndx;
} Elf64_Ehdr;

struct User_MemorySet load_elf(uint64 elf_source);  // elf_source is the address of the target elf file

#endif
