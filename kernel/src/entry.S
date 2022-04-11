	.section .text.entry
	.globl _entry
_entry: 
	la sp, boot_stack_top
    call main

	.section .bss.stack 
	.align 12
	.globl boot_stack 
boot_stack: 
	.space 4096 * 4 * 2
	.globl boot_stack_top 
boot_stack_top: