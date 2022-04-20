
target/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_entry>:
    80200000:	00100513          	li	a0,1
    80200004:	00015117          	auipc	sp,0x15
    80200008:	ffc10113          	addi	sp,sp,-4 # 80215000 <boot_stack_top>
    8020000c:	004000ef          	jal	ra,80200010 <main>

0000000080200010 <main>:
#include "laoder.h"

extern uint64 app_0_start;
extern uint64 app_0_end;

void main(int num_core) {
    80200010:	1141                	addi	sp,sp,-16
    80200012:	e406                	sd	ra,8(sp)
    80200014:	e022                	sd	s0,0(sp)
    80200016:	0800                	addi	s0,sp,16
    80200018:	85aa                	mv	a1,a0
    printf("num of cores: %d \n", num_core);  // 通过寄存器entry.S中设置的寄存器a0来传这个num_core参数
    8020001a:	00001517          	auipc	a0,0x1
    8020001e:	fe650513          	addi	a0,a0,-26 # 80201000 <etext>
    80200022:	00000097          	auipc	ra,0x0
    80200026:	068080e7          	jalr	104(ra) # 8020008a <printf>
    printf("Hello, World!\n");
    8020002a:	00001517          	auipc	a0,0x1
    8020002e:	fee50513          	addi	a0,a0,-18 # 80201018 <etext+0x18>
    80200032:	00000097          	auipc	ra,0x0
    80200036:	058080e7          	jalr	88(ra) # 8020008a <printf>
    load();    // 将应用程序load到主内存中
    8020003a:	00000097          	auipc	ra,0x0
    8020003e:	290080e7          	jalr	656(ra) # 802002ca <load>
    
    panic("Stop!\n");
    80200042:	00001517          	auipc	a0,0x1
    80200046:	fe650513          	addi	a0,a0,-26 # 80201028 <etext+0x28>
    8020004a:	00000097          	auipc	ra,0x0
    8020004e:	1d4080e7          	jalr	468(ra) # 8020021e <panic>
    while (1) {}
    80200052:	a001                	j	80200052 <main+0x42>

0000000080200054 <consputc>:
#include "sbi.h"
#include "console.h"

#define BACKSPACE 0x100

void consputc(int c) {
    80200054:	1141                	addi	sp,sp,-16
    80200056:	e422                	sd	s0,8(sp)
    80200058:	0800                	addi	s0,sp,16
	if(c == BACKSPACE){
    8020005a:	10000793          	li	a5,256
    8020005e:	00f50863          	beq	a0,a5,8020006e <consputc+0x1a>
#define SBI_CONSOLE_PUTCHAR 	1
#define SBI_CONSOLE_GETCHAR 	2
#define SBI_SHUTDOWN 			8

static inline void sbi_console_putchar(int ch) {
	LEGACY_SBI_CALL(SBI_CONSOLE_PUTCHAR, ch);
    80200062:	4885                	li	a7,1
    80200064:	00000073          	ecall
		sbi_console_putchar(' ');
		sbi_console_putchar('\b');
	} else {
		sbi_console_putchar(c);
	}
    80200068:	6422                	ld	s0,8(sp)
    8020006a:	0141                	addi	sp,sp,16
    8020006c:	8082                	ret
    8020006e:	4521                	li	a0,8
    80200070:	4885                	li	a7,1
    80200072:	00000073          	ecall
    80200076:	02000513          	li	a0,32
    8020007a:	00000073          	ecall
    8020007e:	4521                	li	a0,8
    80200080:	00000073          	ecall
    80200084:	6422                	ld	s0,8(sp)
    80200086:	0141                	addi	sp,sp,16
    80200088:	8082                	ret

000000008020008a <printf>:

static char digits[] = "0123456789abcdef";



void printf(char *fmt, ...){
    8020008a:	7155                	addi	sp,sp,-208
    8020008c:	e122                	sd	s0,128(sp)
    8020008e:	ecd6                	sd	s5,88(sp)
    80200090:	0900                	addi	s0,sp,144
    80200092:	e506                	sd	ra,136(sp)
    80200094:	fca6                	sd	s1,120(sp)
    80200096:	f8ca                	sd	s2,112(sp)
    80200098:	f4ce                	sd	s3,104(sp)
    8020009a:	f0d2                	sd	s4,96(sp)
    8020009c:	e8da                	sd	s6,80(sp)
    8020009e:	e4de                	sd	s7,72(sp)
    802000a0:	e0e2                	sd	s8,64(sp)
    802000a2:	fc66                	sd	s9,56(sp)
    802000a4:	f86a                	sd	s10,48(sp)
    802000a6:	f46e                	sd	s11,40(sp)
    802000a8:	8aaa                	mv	s5,a0
	va_list ap;
	va_start(ap, fmt);
	char buf[16];
	int index = 0;
	uint64 integer = 0;
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    802000aa:	00054503          	lbu	a0,0(a0)
void printf(char *fmt, ...){
    802000ae:	f41c                	sd	a5,40(s0)
	va_start(ap, fmt);
    802000b0:	00840793          	addi	a5,s0,8
void printf(char *fmt, ...){
    802000b4:	e40c                	sd	a1,8(s0)
    802000b6:	e810                	sd	a2,16(s0)
    802000b8:	ec14                	sd	a3,24(s0)
    802000ba:	f018                	sd	a4,32(s0)
    802000bc:	03043823          	sd	a6,48(s0)
    802000c0:	03143c23          	sd	a7,56(s0)
	va_start(ap, fmt);
    802000c4:	f6f43c23          	sd	a5,-136(s0)
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    802000c8:	cd29                	beqz	a0,80200122 <printf+0x98>
    802000ca:	4481                	li	s1,0
		if (c != '%'){
    802000cc:	02500c13          	li	s8,37
			consputc(c);
			continue;
		}
		c = fmt[++i];
		switch(c){
    802000d0:	06400d13          	li	s10,100
				if (integer == 0){
					consputc('0');
				}
				index = 0;
				while (integer > 0) {
					print_num = integer % 10;
    802000d4:	4a29                	li	s4,10
				while (integer > 0) {
    802000d6:	4b25                	li	s6,9
    802000d8:	00001997          	auipc	s3,0x1
    802000dc:	f5898993          	addi	s3,s3,-168 # 80201030 <digits>
		switch(c){
    802000e0:	07800c93          	li	s9,120
    802000e4:	a00d                	j	80200106 <printf+0x7c>
		c = fmt[++i];
    802000e6:	00094783          	lbu	a5,0(s2)
		switch(c){
    802000ea:	2489                	addiw	s1,s1,2
    802000ec:	009a8933          	add	s2,s5,s1
    802000f0:	0da78863          	beq	a5,s10,802001c0 <printf+0x136>
    802000f4:	07978563          	beq	a5,s9,8020015e <printf+0xd4>
    802000f8:	06300713          	li	a4,99
    802000fc:	04e78263          	beq	a5,a4,80200140 <printf+0xb6>
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80200100:	00094503          	lbu	a0,0(s2)
    80200104:	cd19                	beqz	a0,80200122 <printf+0x98>
		if (c != '%'){
    80200106:	00148b9b          	addiw	s7,s1,1
    8020010a:	017a8933          	add	s2,s5,s7
    8020010e:	fd850ce3          	beq	a0,s8,802000e6 <printf+0x5c>
			consputc(c);
    80200112:	00000097          	auipc	ra,0x0
    80200116:	f42080e7          	jalr	-190(ra) # 80200054 <consputc>
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8020011a:	00094503          	lbu	a0,0(s2)
			continue;
    8020011e:	84de                	mv	s1,s7
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80200120:	f17d                	bnez	a0,80200106 <printf+0x7c>
				buf[0] = va_arg(ap, int);
				consputc(buf[0]);
				break;
		}
	}
    80200122:	60aa                	ld	ra,136(sp)
    80200124:	640a                	ld	s0,128(sp)
    80200126:	74e6                	ld	s1,120(sp)
    80200128:	7946                	ld	s2,112(sp)
    8020012a:	79a6                	ld	s3,104(sp)
    8020012c:	7a06                	ld	s4,96(sp)
    8020012e:	6ae6                	ld	s5,88(sp)
    80200130:	6b46                	ld	s6,80(sp)
    80200132:	6ba6                	ld	s7,72(sp)
    80200134:	6c06                	ld	s8,64(sp)
    80200136:	7ce2                	ld	s9,56(sp)
    80200138:	7d42                	ld	s10,48(sp)
    8020013a:	7da2                	ld	s11,40(sp)
    8020013c:	6169                	addi	sp,sp,208
    8020013e:	8082                	ret
				buf[0] = va_arg(ap, int);
    80200140:	f7843783          	ld	a5,-136(s0)
    80200144:	4398                	lw	a4,0(a5)
    80200146:	07a1                	addi	a5,a5,8
    80200148:	f6f43c23          	sd	a5,-136(s0)
				consputc(buf[0]);
    8020014c:	0ff77513          	andi	a0,a4,255
				buf[0] = va_arg(ap, int);
    80200150:	f8e40023          	sb	a4,-128(s0)
				consputc(buf[0]);
    80200154:	00000097          	auipc	ra,0x0
    80200158:	f00080e7          	jalr	-256(ra) # 80200054 <consputc>
				break;
    8020015c:	b755                	j	80200100 <printf+0x76>
				consputc('0');
    8020015e:	03000513          	li	a0,48
    80200162:	00000097          	auipc	ra,0x0
    80200166:	ef2080e7          	jalr	-270(ra) # 80200054 <consputc>
				consputc('x');
    8020016a:	07800513          	li	a0,120
    8020016e:	00000097          	auipc	ra,0x0
    80200172:	ee6080e7          	jalr	-282(ra) # 80200054 <consputc>
				integer = va_arg(ap, int);
    80200176:	f7843783          	ld	a5,-136(s0)
				if (integer == 0){
    8020017a:	f8040613          	addi	a2,s0,-128
    8020017e:	4681                	li	a3,0
				integer = va_arg(ap, int);
    80200180:	4398                	lw	a4,0(a5)
    80200182:	07a1                	addi	a5,a5,8
    80200184:	f6f43c23          	sd	a5,-136(s0)
				if (integer == 0){
    80200188:	c741                	beqz	a4,80200210 <printf+0x186>
					buf[index] = print_num;
    8020018a:	00f77793          	andi	a5,a4,15
    8020018e:	00f60023          	sb	a5,0(a2)
					integer /= 16;
    80200192:	8311                	srli	a4,a4,0x4
    80200194:	8db6                	mv	s11,a3
    80200196:	0605                	addi	a2,a2,1
					index += 1;
    80200198:	2685                	addiw	a3,a3,1
				while (integer > 0) {
    8020019a:	fb65                	bnez	a4,8020018a <printf+0x100>
    8020019c:	f8040713          	addi	a4,s0,-128
    802001a0:	9dba                	add	s11,s11,a4
    802001a2:	8bba                	mv	s7,a4
    802001a4:	a021                	j	802001ac <printf+0x122>
    802001a6:	fffdc783          	lbu	a5,-1(s11)
    802001aa:	1dfd                	addi	s11,s11,-1
					consputc(digits[buf[index]]);
    802001ac:	97ce                	add	a5,a5,s3
    802001ae:	0007c503          	lbu	a0,0(a5)
    802001b2:	00000097          	auipc	ra,0x0
    802001b6:	ea2080e7          	jalr	-350(ra) # 80200054 <consputc>
				while (index >= 0){
    802001ba:	ffbb96e3          	bne	s7,s11,802001a6 <printf+0x11c>
    802001be:	b789                	j	80200100 <printf+0x76>
				integer = va_arg(ap, int);
    802001c0:	f7843783          	ld	a5,-136(s0)
				if (integer == 0){
    802001c4:	f8040613          	addi	a2,s0,-128
    802001c8:	4681                	li	a3,0
				integer = va_arg(ap, int);
    802001ca:	4398                	lw	a4,0(a5)
    802001cc:	07a1                	addi	a5,a5,8
    802001ce:	f6f43c23          	sd	a5,-136(s0)
				if (integer == 0){
    802001d2:	cf1d                	beqz	a4,80200210 <printf+0x186>
					buf[index] = print_num;
    802001d4:	034777b3          	remu	a5,a4,s4
    802001d8:	85ba                	mv	a1,a4
    802001da:	8db6                	mv	s11,a3
    802001dc:	0605                	addi	a2,a2,1
					index += 1;
    802001de:	2685                	addiw	a3,a3,1
					buf[index] = print_num;
    802001e0:	fef60fa3          	sb	a5,-1(a2)
					integer /= 10;
    802001e4:	03475733          	divu	a4,a4,s4
				while (integer > 0) {
    802001e8:	febb66e3          	bltu	s6,a1,802001d4 <printf+0x14a>
    802001ec:	f8040713          	addi	a4,s0,-128
    802001f0:	9dba                	add	s11,s11,a4
    802001f2:	8bba                	mv	s7,a4
    802001f4:	a021                	j	802001fc <printf+0x172>
    802001f6:	fffdc783          	lbu	a5,-1(s11)
    802001fa:	1dfd                	addi	s11,s11,-1
					consputc(digits[buf[index]]);
    802001fc:	97ce                	add	a5,a5,s3
    802001fe:	0007c503          	lbu	a0,0(a5)
    80200202:	00000097          	auipc	ra,0x0
    80200206:	e52080e7          	jalr	-430(ra) # 80200054 <consputc>
				while (index >= 0){
    8020020a:	ffbb96e3          	bne	s7,s11,802001f6 <printf+0x16c>
    8020020e:	bdcd                	j	80200100 <printf+0x76>
					consputc('0');
    80200210:	03000513          	li	a0,48
    80200214:	00000097          	auipc	ra,0x0
    80200218:	e40080e7          	jalr	-448(ra) # 80200054 <consputc>
				while (index >= 0){
    8020021c:	b5d5                	j	80200100 <printf+0x76>

000000008020021e <panic>:
#include "printf.h"
#include "panic.h"
#include "sbi.h"


void panic(char *msg, ...){
    8020021e:	715d                	addi	sp,sp,-80
    80200220:	e022                	sd	s0,0(sp)
    80200222:	e406                	sd	ra,8(sp)
    80200224:	0800                	addi	s0,sp,16
    80200226:	03143c23          	sd	a7,56(s0)
    8020022a:	e40c                	sd	a1,8(s0)
    8020022c:	e810                	sd	a2,16(s0)
    8020022e:	ec14                	sd	a3,24(s0)
    80200230:	f018                	sd	a4,32(s0)
    80200232:	f41c                	sd	a5,40(s0)
    80200234:	03043823          	sd	a6,48(s0)
    printf(msg);
    80200238:	00000097          	auipc	ra,0x0
    8020023c:	e52080e7          	jalr	-430(ra) # 8020008a <printf>
static inline int sbi_console_getchar(void) {
	return LEGACY_SBI_CALL(SBI_CONSOLE_GETCHAR, 0);
}

static inline void sbi_shutdown(void) {
	LEGACY_SBI_CALL(SBI_SHUTDOWN, 0);
    80200240:	4501                	li	a0,0
    80200242:	48a1                	li	a7,8
    80200244:	00000073          	ecall
    sbi_shutdown();      // Panic in the kernel means directly shutdown all 
    80200248:	60a2                	ld	ra,8(sp)
    8020024a:	6402                	ld	s0,0(sp)
    8020024c:	6161                	addi	sp,sp,80
    8020024e:	8082                	ret

0000000080200250 <new_trap_cx>:

#include "trap_context.h"
#include "types.h"


struct trap_context new_trap_cx(uint64 spec, uint64 kernel_satp, uint64 trap_handler, uint64 current_sp){
    80200250:	1141                	addi	sp,sp,-16
    80200252:	e422                	sd	s0,8(sp)
    80200254:	0800                	addi	s0,sp,16
    new_trap_context.spec = spec;    // 设为用户程序的入口
    new_trap_context.kernel_satp = kernel_satp;   
    new_trap_context.trap_handler = trap_handler;

    return new_trap_context;
    80200256:	6422                	ld	s0,8(sp)
    return new_trap_context;
    80200258:	e918                	sd	a4,16(a0)
    8020025a:	10b53023          	sd	a1,256(a0)
    8020025e:	10c53423          	sd	a2,264(a0)
    80200262:	10d53823          	sd	a3,272(a0)
    80200266:	0141                	addi	sp,sp,16
    80200268:	8082                	ret

000000008020026a <return_to_user>:

#define EXCP_ENV_CALL     0x8



void return_to_user(struct trap_context trap_cx){
    8020026a:	1141                	addi	sp,sp,-16
    8020026c:	e422                	sd	s0,8(sp)
    8020026e:	0800                	addi	s0,sp,16

}
    80200270:	6422                	ld	s0,8(sp)
    80200272:	0141                	addi	sp,sp,16
    80200274:	8082                	ret

0000000080200276 <trap_handler>:

void trap_handler(struct trap_context trap_cx){
    80200276:	7179                	addi	sp,sp,-48
    80200278:	f022                	sd	s0,32(sp)
    8020027a:	f406                	sd	ra,40(sp)
    8020027c:	1800                	addi	s0,sp,48
// Supervisor Trap Cause
static inline uint64
r_scause()
{
	uint64 x;
	asm volatile("csrr %0, scause" : "=r" (x) );
    8020027e:	14202773          	csrr	a4,scause
    uint64 trap_cause = r_scause();
    switch(trap_cause){
    80200282:	47a1                	li	a5,8
    80200284:	00f70e63          	beq	a4,a5,802002a0 <trap_handler+0x2a>
            trap_cx.spec += 4;
            uint64 args[3] = {trap_cx.general_register[10], trap_cx.general_register[11], trap_cx.general_register[12]};
            trap_cx.general_register[10] = syscall(trap_cx.general_register[17], args);
            break;
        default:
            printf("No one handle it!");
    80200288:	00001517          	auipc	a0,0x1
    8020028c:	dc050513          	addi	a0,a0,-576 # 80201048 <digits+0x18>
    80200290:	00000097          	auipc	ra,0x0
    80200294:	dfa080e7          	jalr	-518(ra) # 8020008a <printf>
            break;
    }
    80200298:	70a2                	ld	ra,40(sp)
    8020029a:	7402                	ld	s0,32(sp)
    8020029c:	6145                	addi	sp,sp,48
    8020029e:	8082                	ret
            uint64 args[3] = {trap_cx.general_register[10], trap_cx.general_register[11], trap_cx.general_register[12]};
    802002a0:	6934                	ld	a3,80(a0)
    802002a2:	6d38                	ld	a4,88(a0)
    802002a4:	713c                	ld	a5,96(a0)
            trap_cx.general_register[10] = syscall(trap_cx.general_register[17], args);
    802002a6:	6548                	ld	a0,136(a0)
    802002a8:	fd840593          	addi	a1,s0,-40
            uint64 args[3] = {trap_cx.general_register[10], trap_cx.general_register[11], trap_cx.general_register[12]};
    802002ac:	fcd43c23          	sd	a3,-40(s0)
    802002b0:	fee43023          	sd	a4,-32(s0)
    802002b4:	fef43423          	sd	a5,-24(s0)
            trap_cx.general_register[10] = syscall(trap_cx.general_register[17], args);
    802002b8:	00000097          	auipc	ra,0x0
    802002bc:	144080e7          	jalr	324(ra) # 802003fc <syscall>
    802002c0:	70a2                	ld	ra,40(sp)
    802002c2:	7402                	ld	s0,32(sp)
    802002c4:	6145                	addi	sp,sp,48
    802002c6:	8082                	ret
	...

00000000802002ca <load>:
extern char* app_0_start;
extern char* app_0_end;
uint64 static app_entry = 0x80400000;


void load(){
    802002ca:	1101                	addi	sp,sp,-32
    802002cc:	ec06                	sd	ra,24(sp)
    802002ce:	e822                	sd	s0,16(sp)
    802002d0:	e426                	sd	s1,8(sp)
    802002d2:	1000                	addi	s0,sp,32
    802002d4:	e04a                	sd	s2,0(sp)
    uint64 size = (&app_0_end - &app_0_start)*8;    
    802002d6:	00002917          	auipc	s2,0x2
    802002da:	d6290913          	addi	s2,s2,-670 # 80202038 <app_0_start>
    printf("The address of app_0_start is %x \n", &app_0_start);
    802002de:	85ca                	mv	a1,s2
    802002e0:	00001517          	auipc	a0,0x1
    802002e4:	d8050513          	addi	a0,a0,-640 # 80201060 <digits+0x30>
    802002e8:	00000097          	auipc	ra,0x0
    802002ec:	da2080e7          	jalr	-606(ra) # 8020008a <printf>
    uint64 size = (&app_0_end - &app_0_start)*8;    
    802002f0:	00004497          	auipc	s1,0x4
    802002f4:	fc048493          	addi	s1,s1,-64 # 802042b0 <app_0_end>
    printf("The address of app_0_end is %x \n", &app_0_end);
    802002f8:	85a6                	mv	a1,s1
    802002fa:	00001517          	auipc	a0,0x1
    802002fe:	d8e50513          	addi	a0,a0,-626 # 80201088 <digits+0x58>
    80200302:	00000097          	auipc	ra,0x0
    80200306:	d88080e7          	jalr	-632(ra) # 8020008a <printf>
    uint64 size = (&app_0_end - &app_0_start)*8;    
    8020030a:	412484b3          	sub	s1,s1,s2
    printf("the size is %x\n", size);
    8020030e:	85a6                	mv	a1,s1
    80200310:	00001517          	auipc	a0,0x1
    80200314:	da050513          	addi	a0,a0,-608 # 802010b0 <digits+0x80>
    80200318:	00000097          	auipc	ra,0x0
    8020031c:	d72080e7          	jalr	-654(ra) # 8020008a <printf>
    memcpy(&app_entry, &app_0_start, size);
}
    80200320:	6442                	ld	s0,16(sp)
    80200322:	60e2                	ld	ra,24(sp)
    memcpy(&app_entry, &app_0_start, size);
    80200324:	0004861b          	sext.w	a2,s1
    80200328:	85ca                	mv	a1,s2
}
    8020032a:	64a2                	ld	s1,8(sp)
    8020032c:	6902                	ld	s2,0(sp)
    memcpy(&app_entry, &app_0_start, size);
    8020032e:	0000d517          	auipc	a0,0xd
    80200332:	97a50513          	addi	a0,a0,-1670 # 8020cca8 <app_entry>
}
    80200336:	6105                	addi	sp,sp,32
    memcpy(&app_entry, &app_0_start, size);
    80200338:	00000317          	auipc	t1,0x0
    8020033c:	06630067          	jr	102(t1) # 8020039e <memcpy>

0000000080200340 <memmove>:
#include "types.h"
#include "string.h"



void memmove(uint64 dst, uint64 src, int size){
    80200340:	7179                	addi	sp,sp,-48
    80200342:	f022                	sd	s0,32(sp)
    80200344:	ec26                	sd	s1,24(sp)
    80200346:	e84a                	sd	s2,16(sp)
    80200348:	e44e                	sd	s3,8(sp)
    8020034a:	f406                	sd	ra,40(sp)
    8020034c:	1800                	addi	s0,sp,48
    8020034e:	89b2                	mv	s3,a2
    80200350:	892a                	mv	s2,a0
    80200352:	84ae                	mv	s1,a1
    int cpy_index = 0;
    printf("the size is %d \n", size);
    80200354:	00001517          	auipc	a0,0x1
    80200358:	d6c50513          	addi	a0,a0,-660 # 802010c0 <digits+0x90>
    8020035c:	85b2                	mv	a1,a2
    8020035e:	00000097          	auipc	ra,0x0
    80200362:	d2c080e7          	jalr	-724(ra) # 8020008a <printf>

    while (cpy_index < size){
    80200366:	03305563          	blez	s3,80200390 <memmove+0x50>
    8020036a:	39fd                	addiw	s3,s3,-1
    8020036c:	1982                	slli	s3,s3,0x20
    8020036e:	00148693          	addi	a3,s1,1
    80200372:	0209d993          	srli	s3,s3,0x20
    80200376:	85a6                	mv	a1,s1
    80200378:	96ce                	add	a3,a3,s3
    8020037a:	40990533          	sub	a0,s2,s1
        *(char*)(dst + cpy_index) = *(char*)(src + cpy_index);    // 一个一个byte的复制过去
    8020037e:	0005c703          	lbu	a4,0(a1)
    80200382:	00b507b3          	add	a5,a0,a1
    80200386:	0585                	addi	a1,a1,1
    80200388:	00e78023          	sb	a4,0(a5)
    while (cpy_index < size){
    8020038c:	fed599e3          	bne	a1,a3,8020037e <memmove+0x3e>
        cpy_index ++;
    }
}
    80200390:	70a2                	ld	ra,40(sp)
    80200392:	7402                	ld	s0,32(sp)
    80200394:	64e2                	ld	s1,24(sp)
    80200396:	6942                	ld	s2,16(sp)
    80200398:	69a2                	ld	s3,8(sp)
    8020039a:	6145                	addi	sp,sp,48
    8020039c:	8082                	ret

000000008020039e <memcpy>:

void memcpy(uint64 dst, uint64 src, int size){
    8020039e:	7179                	addi	sp,sp,-48
    802003a0:	f022                	sd	s0,32(sp)
    802003a2:	ec26                	sd	s1,24(sp)
    802003a4:	e84a                	sd	s2,16(sp)
    802003a6:	e44e                	sd	s3,8(sp)
    802003a8:	f406                	sd	ra,40(sp)
    802003aa:	1800                	addi	s0,sp,48
    802003ac:	89b2                	mv	s3,a2
    802003ae:	892a                	mv	s2,a0
    802003b0:	84ae                	mv	s1,a1
    printf("the size is %d \n", size);
    802003b2:	00001517          	auipc	a0,0x1
    802003b6:	d0e50513          	addi	a0,a0,-754 # 802010c0 <digits+0x90>
    802003ba:	85b2                	mv	a1,a2
    802003bc:	00000097          	auipc	ra,0x0
    802003c0:	cce080e7          	jalr	-818(ra) # 8020008a <printf>
    while (cpy_index < size){
    802003c4:	03305563          	blez	s3,802003ee <memcpy+0x50>
    802003c8:	39fd                	addiw	s3,s3,-1
    802003ca:	1982                	slli	s3,s3,0x20
    802003cc:	00148693          	addi	a3,s1,1
    802003d0:	0209d993          	srli	s3,s3,0x20
    802003d4:	85a6                	mv	a1,s1
    802003d6:	96ce                	add	a3,a3,s3
    802003d8:	40990533          	sub	a0,s2,s1
        *(char*)(dst + cpy_index) = *(char*)(src + cpy_index);    // 一个一个byte的复制过去
    802003dc:	0005c703          	lbu	a4,0(a1)
    802003e0:	00b507b3          	add	a5,a0,a1
    802003e4:	0585                	addi	a1,a1,1
    802003e6:	00e78023          	sb	a4,0(a5)
    while (cpy_index < size){
    802003ea:	fed599e3          	bne	a1,a3,802003dc <memcpy+0x3e>
    memmove(dst, src, size);
    802003ee:	70a2                	ld	ra,40(sp)
    802003f0:	7402                	ld	s0,32(sp)
    802003f2:	64e2                	ld	s1,24(sp)
    802003f4:	6942                	ld	s2,16(sp)
    802003f6:	69a2                	ld	s3,8(sp)
    802003f8:	6145                	addi	sp,sp,48
    802003fa:	8082                	ret

00000000802003fc <syscall>:
#include "types.h"
#include "syscall.h"

uint64 syscall(uint64 type, uint64 args[3]){
    802003fc:	1141                	addi	sp,sp,-16
    802003fe:	e422                	sd	s0,8(sp)
    80200400:	0800                	addi	s0,sp,16
    // TODO
    return 0;
    80200402:	6422                	ld	s0,8(sp)
    80200404:	4501                	li	a0,0
    80200406:	0141                	addi	sp,sp,16
    80200408:	8082                	ret
