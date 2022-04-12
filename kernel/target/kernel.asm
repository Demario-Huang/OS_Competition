
target/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_entry>:
    80200000:	0000a117          	auipc	sp,0xa
    80200004:	00010113          	mv	sp,sp
    80200008:	004000ef          	jal	ra,8020000c <main>

000000008020000c <main>:

#define __module_name__ 	"main"

#include "printf.h"

void main() {
    8020000c:	1141                	addi	sp,sp,-16
    8020000e:	e022                	sd	s0,0(sp)
    80200010:	e406                	sd	ra,8(sp)
    80200012:	0800                	addi	s0,sp,16
    printf("Hello, World!");
    80200014:	00001517          	auipc	a0,0x1
    80200018:	fec50513          	addi	a0,a0,-20 # 80201000 <etext>
    8020001c:	00000097          	auipc	ra,0x0
    80200020:	040080e7          	jalr	64(ra) # 8020005c <printf>
    while (1) {}
    80200024:	a001                	j	80200024 <main+0x18>

0000000080200026 <consputc>:
#include "sbi.h"
#include "console.h"

#define BACKSPACE 0x100

void consputc(int c) {
    80200026:	1141                	addi	sp,sp,-16
    80200028:	e422                	sd	s0,8(sp)
    8020002a:	0800                	addi	s0,sp,16
	if(c == BACKSPACE){
    8020002c:	10000793          	li	a5,256
    80200030:	00f50863          	beq	a0,a5,80200040 <consputc+0x1a>
#define SBI_CONSOLE_PUTCHAR 	1
#define SBI_CONSOLE_GETCHAR 	2
#define SBI_SHUTDOWN 			8

static inline void sbi_console_putchar(int ch) {
	LEGACY_SBI_CALL(SBI_CONSOLE_PUTCHAR, ch);
    80200034:	4885                	li	a7,1
    80200036:	00000073          	ecall
		sbi_console_putchar(' ');
		sbi_console_putchar('\b');
	} else {
		sbi_console_putchar(c);
	}
    8020003a:	6422                	ld	s0,8(sp)
    8020003c:	0141                	addi	sp,sp,16
    8020003e:	8082                	ret
    80200040:	4521                	li	a0,8
    80200042:	4885                	li	a7,1
    80200044:	00000073          	ecall
    80200048:	02000513          	li	a0,32
    8020004c:	00000073          	ecall
    80200050:	4521                	li	a0,8
    80200052:	00000073          	ecall
    80200056:	6422                	ld	s0,8(sp)
    80200058:	0141                	addi	sp,sp,16
    8020005a:	8082                	ret

000000008020005c <printf>:
#include "console.h"

char c;
void printf(char *fmt, ...){
    8020005c:	711d                	addi	sp,sp,-96
    8020005e:	e822                	sd	s0,16(sp)
    80200060:	e426                	sd	s1,8(sp)
    80200062:	1000                	addi	s0,sp,32
    80200064:	e04a                	sd	s2,0(sp)
    80200066:	ec06                	sd	ra,24(sp)
    80200068:	84aa                	mv	s1,a0
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8020006a:	00054503          	lbu	a0,0(a0)
    8020006e:	0000a917          	auipc	s2,0xa
    80200072:	f9290913          	addi	s2,s2,-110 # 8020a000 <c>
void printf(char *fmt, ...){
    80200076:	e40c                	sd	a1,8(s0)
    80200078:	e810                	sd	a2,16(s0)
    8020007a:	ec14                	sd	a3,24(s0)
    8020007c:	f018                	sd	a4,32(s0)
    8020007e:	f41c                	sd	a5,40(s0)
    80200080:	03043823          	sd	a6,48(s0)
    80200084:	03143c23          	sd	a7,56(s0)
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80200088:	00a90023          	sb	a0,0(s2)
    8020008c:	cd01                	beqz	a0,802000a4 <printf+0x48>
    8020008e:	0485                	addi	s1,s1,1
		consputc(c);
    80200090:	00000097          	auipc	ra,0x0
    80200094:	f96080e7          	jalr	-106(ra) # 80200026 <consputc>
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80200098:	0004c503          	lbu	a0,0(s1)
    8020009c:	0485                	addi	s1,s1,1
    8020009e:	00a90023          	sb	a0,0(s2)
    802000a2:	f57d                	bnez	a0,80200090 <printf+0x34>
	}
    802000a4:	60e2                	ld	ra,24(sp)
    802000a6:	6442                	ld	s0,16(sp)
    802000a8:	64a2                	ld	s1,8(sp)
    802000aa:	6902                	ld	s2,0(sp)
    802000ac:	6125                	addi	sp,sp,96
    802000ae:	8082                	ret