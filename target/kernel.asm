
target/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_entry>:
    80200000:	00100513          	li	a0,1
    80200004:	001a4117          	auipc	sp,0x1a4
    80200008:	ffc10113          	addi	sp,sp,-4 # 803a4000 <bitmap>
    8020000c:	056000ef          	jal	ra,80200062 <main>

0000000080200010 <test_alloc>:

    panic("[kernel] If this is printed, sth must get wrong!\n");
}


void test_alloc(){
    80200010:	1101                	addi	sp,sp,-32
    80200012:	ec06                	sd	ra,24(sp)
    80200014:	e822                	sd	s0,16(sp)
    80200016:	e426                	sd	s1,8(sp)
    80200018:	1000                	addi	s0,sp,32
    8020001a:	e04a                	sd	s2,0(sp)
    uint32 frame1 = get_frame();
    8020001c:	00001097          	auipc	ra,0x1
    80200020:	c90080e7          	jalr	-880(ra) # 80200cac <get_frame>
    80200024:	0005091b          	sext.w	s2,a0
    uint32 frame2 = get_frame();
    80200028:	00001097          	auipc	ra,0x1
    8020002c:	c84080e7          	jalr	-892(ra) # 80200cac <get_frame>
    80200030:	0005049b          	sext.w	s1,a0
    uint32 frame3 = get_frame();
    80200034:	00001097          	auipc	ra,0x1
    80200038:	c78080e7          	jalr	-904(ra) # 80200cac <get_frame>
    free_frame(frame1);
    8020003c:	854a                	mv	a0,s2
    8020003e:	00001097          	auipc	ra,0x1
    80200042:	d96080e7          	jalr	-618(ra) # 80200dd4 <free_frame>
    free_frame(frame2);
    80200046:	8526                	mv	a0,s1
    80200048:	00001097          	auipc	ra,0x1
    8020004c:	d8c080e7          	jalr	-628(ra) # 80200dd4 <free_frame>
    uint32 frame4 = get_frame();
}
    80200050:	6442                	ld	s0,16(sp)
    80200052:	60e2                	ld	ra,24(sp)
    80200054:	64a2                	ld	s1,8(sp)
    80200056:	6902                	ld	s2,0(sp)
    80200058:	6105                	addi	sp,sp,32
    uint32 frame4 = get_frame();
    8020005a:	00001317          	auipc	t1,0x1
    8020005e:	c5230067          	jr	-942(t1) # 80200cac <get_frame>

0000000080200062 <main>:
void main(int num_core) {
    80200062:	1141                	addi	sp,sp,-16
    80200064:	e406                	sd	ra,8(sp)
    80200066:	e022                	sd	s0,0(sp)
    80200068:	0800                	addi	s0,sp,16
    8020006a:	85aa                	mv	a1,a0
    printf("[kernel] num of cores: %d \n", num_core);  // 通过寄存器entry.S中设置的寄存器a0来传这个num_core参数
    8020006c:	00003517          	auipc	a0,0x3
    80200070:	f9450513          	addi	a0,a0,-108 # 80203000 <etext>
    80200074:	00000097          	auipc	ra,0x0
    80200078:	0a6080e7          	jalr	166(ra) # 8020011a <printf>
    initmalloc();
    8020007c:	00001097          	auipc	ra,0x1
    80200080:	6f6080e7          	jalr	1782(ra) # 80201772 <initmalloc>
    map_kernel();
    80200084:	00002097          	auipc	ra,0x2
    80200088:	ad4080e7          	jalr	-1324(ra) # 80201b58 <map_kernel>
    activate_mm();
    8020008c:	00002097          	auipc	ra,0x2
    80200090:	cce080e7          	jalr	-818(ra) # 80201d5a <activate_mm>
    printf("[kernel] ok to activate mm! Back to Kernel!\n");
    80200094:	00003517          	auipc	a0,0x3
    80200098:	f8c50513          	addi	a0,a0,-116 # 80203020 <etext+0x20>
    8020009c:	00000097          	auipc	ra,0x0
    802000a0:	07e080e7          	jalr	126(ra) # 8020011a <printf>
    init_app("initproc");   // 初始化App，包括初始化其trap上下文，将trap上下文放到用户栈中。
    802000a4:	00003517          	auipc	a0,0x3
    802000a8:	fac50513          	addi	a0,a0,-84 # 80203050 <etext+0x50>
    TASK_MANAGER.number_of_apps = 0; 
    802000ac:	001a7797          	auipc	a5,0x1a7
    802000b0:	0807b623          	sd	zero,140(a5) # 803a7138 <TASK_MANAGER+0x2fe8>
    init_app("initproc");   // 初始化App，包括初始化其trap上下文，将trap上下文放到用户栈中。
    802000b4:	00000097          	auipc	ra,0x0
    802000b8:	5fc080e7          	jalr	1532(ra) # 802006b0 <init_app>
    timerinit();
    802000bc:	00000097          	auipc	ra,0x0
    802000c0:	7f0080e7          	jalr	2032(ra) # 802008ac <timerinit>
    run_next_app(1);
    802000c4:	4505                	li	a0,1
    802000c6:	00001097          	auipc	ra,0x1
    802000ca:	876080e7          	jalr	-1930(ra) # 8020093c <run_next_app>
}
    802000ce:	6402                	ld	s0,0(sp)
    802000d0:	60a2                	ld	ra,8(sp)
    panic("[kernel] If this is printed, sth must get wrong!\n");
    802000d2:	00003517          	auipc	a0,0x3
    802000d6:	f8e50513          	addi	a0,a0,-114 # 80203060 <etext+0x60>
}
    802000da:	0141                	addi	sp,sp,16
    panic("[kernel] If this is printed, sth must get wrong!\n");
    802000dc:	00000317          	auipc	t1,0x0
    802000e0:	1d230067          	jr	466(t1) # 802002ae <panic>

00000000802000e4 <consputc>:
#include "sbi.h"
#include "console.h"

#define BACKSPACE 0x100

void consputc(int c) {
    802000e4:	1141                	addi	sp,sp,-16
    802000e6:	e422                	sd	s0,8(sp)
    802000e8:	0800                	addi	s0,sp,16
	if(c == BACKSPACE){
    802000ea:	10000793          	li	a5,256
    802000ee:	00f50863          	beq	a0,a5,802000fe <consputc+0x1a>
#define SBI_CONSOLE_PUTCHAR 	1
#define SBI_CONSOLE_GETCHAR 	2
#define SBI_SHUTDOWN 			8

static inline void sbi_console_putchar(int ch) {
	LEGACY_SBI_CALL(SBI_CONSOLE_PUTCHAR, ch);
    802000f2:	4885                	li	a7,1
    802000f4:	00000073          	ecall
		sbi_console_putchar(' ');
		sbi_console_putchar('\b');
	} else {
		sbi_console_putchar(c);
	}
    802000f8:	6422                	ld	s0,8(sp)
    802000fa:	0141                	addi	sp,sp,16
    802000fc:	8082                	ret
    802000fe:	4521                	li	a0,8
    80200100:	4885                	li	a7,1
    80200102:	00000073          	ecall
    80200106:	02000513          	li	a0,32
    8020010a:	00000073          	ecall
    8020010e:	4521                	li	a0,8
    80200110:	00000073          	ecall
    80200114:	6422                	ld	s0,8(sp)
    80200116:	0141                	addi	sp,sp,16
    80200118:	8082                	ret

000000008020011a <printf>:

static char digits[] = "0123456789abcdef";



void printf(char *fmt, ...){
    8020011a:	7155                	addi	sp,sp,-208
    8020011c:	e122                	sd	s0,128(sp)
    8020011e:	ecd6                	sd	s5,88(sp)
    80200120:	0900                	addi	s0,sp,144
    80200122:	e506                	sd	ra,136(sp)
    80200124:	fca6                	sd	s1,120(sp)
    80200126:	f8ca                	sd	s2,112(sp)
    80200128:	f4ce                	sd	s3,104(sp)
    8020012a:	f0d2                	sd	s4,96(sp)
    8020012c:	e8da                	sd	s6,80(sp)
    8020012e:	e4de                	sd	s7,72(sp)
    80200130:	e0e2                	sd	s8,64(sp)
    80200132:	fc66                	sd	s9,56(sp)
    80200134:	f86a                	sd	s10,48(sp)
    80200136:	f46e                	sd	s11,40(sp)
    80200138:	8aaa                	mv	s5,a0
	va_list ap;
	va_start(ap, fmt);
	char buf[16];
	int index = 0;
	uint64 integer = 0;
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8020013a:	00054503          	lbu	a0,0(a0)
void printf(char *fmt, ...){
    8020013e:	f41c                	sd	a5,40(s0)
	va_start(ap, fmt);
    80200140:	00840793          	addi	a5,s0,8
void printf(char *fmt, ...){
    80200144:	e40c                	sd	a1,8(s0)
    80200146:	e810                	sd	a2,16(s0)
    80200148:	ec14                	sd	a3,24(s0)
    8020014a:	f018                	sd	a4,32(s0)
    8020014c:	03043823          	sd	a6,48(s0)
    80200150:	03143c23          	sd	a7,56(s0)
	va_start(ap, fmt);
    80200154:	f6f43c23          	sd	a5,-136(s0)
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80200158:	cd29                	beqz	a0,802001b2 <printf+0x98>
    8020015a:	4481                	li	s1,0
		if (c != '%'){
    8020015c:	02500c13          	li	s8,37
			consputc(c);
			continue;
		}
		c = fmt[++i];
		switch(c){
    80200160:	06400d13          	li	s10,100
				if (integer == 0){
					consputc('0');
				}
				index = 0;
				while (integer > 0) {
					print_num = integer % 10;
    80200164:	4a29                	li	s4,10
				while (integer > 0) {
    80200166:	4b25                	li	s6,9
    80200168:	00003997          	auipc	s3,0x3
    8020016c:	f3098993          	addi	s3,s3,-208 # 80203098 <digits>
		switch(c){
    80200170:	07800c93          	li	s9,120
    80200174:	a00d                	j	80200196 <printf+0x7c>
		c = fmt[++i];
    80200176:	00094783          	lbu	a5,0(s2)
		switch(c){
    8020017a:	2489                	addiw	s1,s1,2
    8020017c:	009a8933          	add	s2,s5,s1
    80200180:	0da78863          	beq	a5,s10,80200250 <printf+0x136>
    80200184:	07978563          	beq	a5,s9,802001ee <printf+0xd4>
    80200188:	06300713          	li	a4,99
    8020018c:	04e78263          	beq	a5,a4,802001d0 <printf+0xb6>
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80200190:	00094503          	lbu	a0,0(s2)
    80200194:	cd19                	beqz	a0,802001b2 <printf+0x98>
		if (c != '%'){
    80200196:	00148b9b          	addiw	s7,s1,1
    8020019a:	017a8933          	add	s2,s5,s7
    8020019e:	fd850ce3          	beq	a0,s8,80200176 <printf+0x5c>
			consputc(c);
    802001a2:	00000097          	auipc	ra,0x0
    802001a6:	f42080e7          	jalr	-190(ra) # 802000e4 <consputc>
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    802001aa:	00094503          	lbu	a0,0(s2)
			continue;
    802001ae:	84de                	mv	s1,s7
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
    802001b0:	f17d                	bnez	a0,80200196 <printf+0x7c>
				buf[0] = va_arg(ap, int);
				consputc(buf[0]);
				break;
		}
	}
    802001b2:	60aa                	ld	ra,136(sp)
    802001b4:	640a                	ld	s0,128(sp)
    802001b6:	74e6                	ld	s1,120(sp)
    802001b8:	7946                	ld	s2,112(sp)
    802001ba:	79a6                	ld	s3,104(sp)
    802001bc:	7a06                	ld	s4,96(sp)
    802001be:	6ae6                	ld	s5,88(sp)
    802001c0:	6b46                	ld	s6,80(sp)
    802001c2:	6ba6                	ld	s7,72(sp)
    802001c4:	6c06                	ld	s8,64(sp)
    802001c6:	7ce2                	ld	s9,56(sp)
    802001c8:	7d42                	ld	s10,48(sp)
    802001ca:	7da2                	ld	s11,40(sp)
    802001cc:	6169                	addi	sp,sp,208
    802001ce:	8082                	ret
				buf[0] = va_arg(ap, int);
    802001d0:	f7843783          	ld	a5,-136(s0)
    802001d4:	4398                	lw	a4,0(a5)
    802001d6:	07a1                	addi	a5,a5,8
    802001d8:	f6f43c23          	sd	a5,-136(s0)
				consputc(buf[0]);
    802001dc:	0ff77513          	andi	a0,a4,255
				buf[0] = va_arg(ap, int);
    802001e0:	f8e40023          	sb	a4,-128(s0)
				consputc(buf[0]);
    802001e4:	00000097          	auipc	ra,0x0
    802001e8:	f00080e7          	jalr	-256(ra) # 802000e4 <consputc>
				break;
    802001ec:	b755                	j	80200190 <printf+0x76>
				consputc('0');
    802001ee:	03000513          	li	a0,48
    802001f2:	00000097          	auipc	ra,0x0
    802001f6:	ef2080e7          	jalr	-270(ra) # 802000e4 <consputc>
				consputc('x');
    802001fa:	07800513          	li	a0,120
    802001fe:	00000097          	auipc	ra,0x0
    80200202:	ee6080e7          	jalr	-282(ra) # 802000e4 <consputc>
				integer = va_arg(ap, int);
    80200206:	f7843783          	ld	a5,-136(s0)
				if (integer == 0){
    8020020a:	f8040613          	addi	a2,s0,-128
    8020020e:	4681                	li	a3,0
				integer = va_arg(ap, int);
    80200210:	4398                	lw	a4,0(a5)
    80200212:	07a1                	addi	a5,a5,8
    80200214:	f6f43c23          	sd	a5,-136(s0)
				if (integer == 0){
    80200218:	c741                	beqz	a4,802002a0 <printf+0x186>
					buf[index] = print_num;
    8020021a:	00f77793          	andi	a5,a4,15
    8020021e:	00f60023          	sb	a5,0(a2)
					integer /= 16;
    80200222:	8311                	srli	a4,a4,0x4
    80200224:	8db6                	mv	s11,a3
    80200226:	0605                	addi	a2,a2,1
					index += 1;
    80200228:	2685                	addiw	a3,a3,1
				while (integer > 0) {
    8020022a:	fb65                	bnez	a4,8020021a <printf+0x100>
    8020022c:	f8040713          	addi	a4,s0,-128
    80200230:	9dba                	add	s11,s11,a4
    80200232:	8bba                	mv	s7,a4
    80200234:	a021                	j	8020023c <printf+0x122>
    80200236:	fffdc783          	lbu	a5,-1(s11)
    8020023a:	1dfd                	addi	s11,s11,-1
					consputc(digits[buf[index]]);
    8020023c:	97ce                	add	a5,a5,s3
    8020023e:	0007c503          	lbu	a0,0(a5)
    80200242:	00000097          	auipc	ra,0x0
    80200246:	ea2080e7          	jalr	-350(ra) # 802000e4 <consputc>
				while (index >= 0){
    8020024a:	ffbb96e3          	bne	s7,s11,80200236 <printf+0x11c>
    8020024e:	b789                	j	80200190 <printf+0x76>
				integer = va_arg(ap, int);
    80200250:	f7843783          	ld	a5,-136(s0)
				if (integer == 0){
    80200254:	f8040613          	addi	a2,s0,-128
    80200258:	4681                	li	a3,0
				integer = va_arg(ap, int);
    8020025a:	4398                	lw	a4,0(a5)
    8020025c:	07a1                	addi	a5,a5,8
    8020025e:	f6f43c23          	sd	a5,-136(s0)
				if (integer == 0){
    80200262:	cf1d                	beqz	a4,802002a0 <printf+0x186>
					buf[index] = print_num;
    80200264:	034777b3          	remu	a5,a4,s4
    80200268:	85ba                	mv	a1,a4
    8020026a:	8db6                	mv	s11,a3
    8020026c:	0605                	addi	a2,a2,1
					index += 1;
    8020026e:	2685                	addiw	a3,a3,1
					buf[index] = print_num;
    80200270:	fef60fa3          	sb	a5,-1(a2)
					integer /= 10;
    80200274:	03475733          	divu	a4,a4,s4
				while (integer > 0) {
    80200278:	febb66e3          	bltu	s6,a1,80200264 <printf+0x14a>
    8020027c:	f8040713          	addi	a4,s0,-128
    80200280:	9dba                	add	s11,s11,a4
    80200282:	8bba                	mv	s7,a4
    80200284:	a021                	j	8020028c <printf+0x172>
    80200286:	fffdc783          	lbu	a5,-1(s11)
    8020028a:	1dfd                	addi	s11,s11,-1
					consputc(digits[buf[index]]);
    8020028c:	97ce                	add	a5,a5,s3
    8020028e:	0007c503          	lbu	a0,0(a5)
    80200292:	00000097          	auipc	ra,0x0
    80200296:	e52080e7          	jalr	-430(ra) # 802000e4 <consputc>
				while (index >= 0){
    8020029a:	ffbb96e3          	bne	s7,s11,80200286 <printf+0x16c>
    8020029e:	bdcd                	j	80200190 <printf+0x76>
					consputc('0');
    802002a0:	03000513          	li	a0,48
    802002a4:	00000097          	auipc	ra,0x0
    802002a8:	e40080e7          	jalr	-448(ra) # 802000e4 <consputc>
				while (index >= 0){
    802002ac:	b5d5                	j	80200190 <printf+0x76>

00000000802002ae <panic>:
#include "printf.h"
#include "panic.h"
#include "sbi.h"


void panic(char *msg, ...){
    802002ae:	715d                	addi	sp,sp,-80
    802002b0:	e022                	sd	s0,0(sp)
    802002b2:	e406                	sd	ra,8(sp)
    802002b4:	0800                	addi	s0,sp,16
    802002b6:	03143c23          	sd	a7,56(s0)
    802002ba:	e40c                	sd	a1,8(s0)
    802002bc:	e810                	sd	a2,16(s0)
    802002be:	ec14                	sd	a3,24(s0)
    802002c0:	f018                	sd	a4,32(s0)
    802002c2:	f41c                	sd	a5,40(s0)
    802002c4:	03043823          	sd	a6,48(s0)
    printf(msg);
    802002c8:	00000097          	auipc	ra,0x0
    802002cc:	e52080e7          	jalr	-430(ra) # 8020011a <printf>
static inline int sbi_console_getchar(void) {
	return LEGACY_SBI_CALL(SBI_CONSOLE_GETCHAR, 0);
}

static inline void sbi_shutdown(void) {
	LEGACY_SBI_CALL(SBI_SHUTDOWN, 0);
    802002d0:	4501                	li	a0,0
    802002d2:	48a1                	li	a7,8
    802002d4:	00000073          	ecall
    sbi_shutdown();      // Panic in the kernel means directly shutdown all 
    802002d8:	60a2                	ld	ra,8(sp)
    802002da:	6402                	ld	s0,0(sp)
    802002dc:	6161                	addi	sp,sp,80
    802002de:	8082                	ret

00000000802002e0 <new_trap_cx>:

#include "trap_context.h"
#include "types.h"


struct trap_context new_trap_cx(uint64 spec, uint64 kernel_satp, uint64 trap_handler, uint64 user_stack_sp, uint64 kernel_stack_top, uint64 sstatus){
    802002e0:	7129                	addi	sp,sp,-320
    802002e2:	fe22                	sd	s0,312(sp)
    802002e4:	0280                	addi	s0,sp,320
    802002e6:	ec840893          	addi	a7,s0,-312
    802002ea:	fc840313          	addi	t1,s0,-56
    struct trap_context new_trap_context;

    for (int i = 0; i < 32; i++){      // 先将寄存器0初始化
        new_trap_context.general_register[i] = 0;
    802002ee:	0008b023          	sd	zero,0(a7)
    for (int i = 0; i < 32; i++){      // 先将寄存器0初始化
    802002f2:	08a1                	addi	a7,a7,8
    802002f4:	ff131de3          	bne	t1,a7,802002ee <new_trap_cx+0xe>
    }

    new_trap_context.general_register[2] = user_stack_sp;
    802002f8:	ece43c23          	sd	a4,-296(s0)
    new_trap_context.kernel_satp = kernel_satp;   
    new_trap_context.trap_handler = trap_handler;
    new_trap_context.kernel_stack = kernel_stack_top;
    new_trap_context.sstatus = sstatus;

    return new_trap_context;
    802002fc:	fef43023          	sd	a5,-32(s0)
    80200300:	fcb43423          	sd	a1,-56(s0)
    80200304:	fcc43823          	sd	a2,-48(s0)
    80200308:	fcd43c23          	sd	a3,-40(s0)
    8020030c:	ff043423          	sd	a6,-24(s0)
    80200310:	ec840793          	addi	a5,s0,-312
    80200314:	872a                	mv	a4,a0
    80200316:	fe840893          	addi	a7,s0,-24
    8020031a:	0007b803          	ld	a6,0(a5)
    8020031e:	678c                	ld	a1,8(a5)
    80200320:	6b90                	ld	a2,16(a5)
    80200322:	6f94                	ld	a3,24(a5)
    80200324:	01073023          	sd	a6,0(a4)
    80200328:	e70c                	sd	a1,8(a4)
    8020032a:	eb10                	sd	a2,16(a4)
    8020032c:	ef14                	sd	a3,24(a4)
    8020032e:	02078793          	addi	a5,a5,32
    80200332:	02070713          	addi	a4,a4,32
    80200336:	ff1792e3          	bne	a5,a7,8020031a <new_trap_cx+0x3a>
    8020033a:	639c                	ld	a5,0(a5)
    8020033c:	7472                	ld	s0,312(sp)
    return new_trap_context;
    8020033e:	e31c                	sd	a5,0(a4)
    80200340:	6131                	addi	sp,sp,320
    80200342:	8082                	ret

0000000080200344 <return_to_user>:
extern void __restore(uint64 a0, uint64 a1);
extern struct task_manager TASK_MANAGER;
extern void __alltraps();


void return_to_user(){
    80200344:	1101                	addi	sp,sp,-32
    80200346:	e822                	sd	s0,16(sp)
    80200348:	e426                	sd	s1,8(sp)
    8020034a:	ec06                	sd	ra,24(sp)
    8020034c:	1000                	addi	s0,sp,32
    uint64 a1 = root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn);    // 用户satp
    8020034e:	001a7497          	auipc	s1,0x1a7
    80200352:	e0248493          	addi	s1,s1,-510 # 803a7150 <heap+0x10>
    80200356:	da84b503          	ld	a0,-600(s1)
    8020035a:	00002097          	auipc	ra,0x2
    8020035e:	9ee080e7          	jalr	-1554(ra) # 80201d48 <root_ppn_to_token>
    80200362:	85aa                	mv	a1,a0
// Supervisor Trap-Vector Base Address
// low two bits are mode.
static inline void 
w_stvec(uint64 x)
{
	asm volatile("csrw stvec, %0" : : "r" (x));
    80200364:	00001797          	auipc	a5,0x1
    80200368:	ca078793          	addi	a5,a5,-864 # 80201004 <__alltraps>
    8020036c:	10579073          	csrw	stvec,a5
    // printf("the a0 is %x\n", translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, a0));

    w_stvec(__alltraps);
    // printf("the address of __restore is %x\n", __restore);
    __restore(a0, a1);
}
    80200370:	6442                	ld	s0,16(sp)
    __restore(a0, a1);
    80200372:	ed04b503          	ld	a0,-304(s1)
}
    80200376:	60e2                	ld	ra,24(sp)
    80200378:	64a2                	ld	s1,8(sp)
    8020037a:	6105                	addi	sp,sp,32
    __restore(a0, a1);
    8020037c:	00001317          	auipc	t1,0x1
    80200380:	cea30067          	jr	-790(t1) # 80201066 <__restore>

0000000080200384 <trap_handler>:


// 先简单处理sys_write和exit两种系统调用
void trap_handler(){
    80200384:	7109                	addi	sp,sp,-384
    80200386:	faa2                	sd	s0,368(sp)
    80200388:	fe86                	sd	ra,376(sp)
    8020038a:	f6a6                	sd	s1,360(sp)
    8020038c:	f2ca                	sd	s2,352(sp)
    8020038e:	eece                	sd	s3,344(sp)
    80200390:	ead2                	sd	s4,336(sp)
    80200392:	e6d6                	sd	s5,328(sp)
    80200394:	0300                	addi	s0,sp,384
// Supervisor Trap Cause
static inline uint64
r_scause()
{
	uint64 x;
	asm volatile("csrr %0, scause" : "=r" (x) );
    80200396:	142024f3          	csrr	s1,scause
// Supervisor Trap Value
static inline uint64
r_stval()
{
	uint64 x;
	asm volatile("csrr %0, stval" : "=r" (x) );
    8020039a:	143027f3          	csrr	a5,stval
	asm volatile("csrr %0, sstatus" : "=r" (x) );
    8020039e:	10002973          	csrr	s2,sstatus
    uint64 sstatus = r_sstatus();
    // if sstatus is 0x0 it is User mode before, 
    // if sstatus is 0x100 it is Kernel mode before, 

    uint64 trap_from_kernel = 0;
    if (sstatus != 0x0){    // status == 0x100: from kernel mode
    802003a2:	04091663          	bnez	s2,802003ee <trap_handler+0x6a>
	asm volatile("csrw stvec, %0" : : "r" (x));
    802003a6:	00000797          	auipc	a5,0x0
    802003aa:	fde78793          	addi	a5,a5,-34 # 80200384 <trap_handler>
    802003ae:	10579073          	csrw	stvec,a5
        trap_from_kernel = 0;
        w_stvec(trap_handler);  
    }


    if (scause == EXCP_ENV_CALL){
    802003b2:	47a1                	li	a5,8
    802003b4:	04f48963          	beq	s1,a5,80200406 <trap_handler+0x82>
        if (return_value > 0){
            current_trap_cx.general_register[10] = return_value;
            *((struct trap_context *)phy_user_high_sp) = current_trap_cx;
        }
    }
    else if (scause == TIMER_INTERUPT){    // 时钟中断
    802003b8:	57fd                	li	a5,-1
    802003ba:	17fe                	slli	a5,a5,0x3f
    802003bc:	0795                	addi	a5,a5,5
    802003be:	0ef48963          	beq	s1,a5,802004b0 <trap_handler+0x12c>
        }else{
            run_next_app(0);
        }
    }
    else{
        panic("[kernel] unrecognized scause: %d!\n", scause);
    802003c2:	85a6                	mv	a1,s1
    802003c4:	00003517          	auipc	a0,0x3
    802003c8:	cfc50513          	addi	a0,a0,-772 # 802030c0 <digits+0x28>
    802003cc:	00000097          	auipc	ra,0x0
    802003d0:	ee2080e7          	jalr	-286(ra) # 802002ae <panic>
    }

    // panic("here ok!\n");
    return_to_user();
    802003d4:	00000097          	auipc	ra,0x0
    802003d8:	f70080e7          	jalr	-144(ra) # 80200344 <return_to_user>
    802003dc:	70f6                	ld	ra,376(sp)
    802003de:	7456                	ld	s0,368(sp)
    802003e0:	74b6                	ld	s1,360(sp)
    802003e2:	7916                	ld	s2,352(sp)
    802003e4:	69f6                	ld	s3,344(sp)
    802003e6:	6a56                	ld	s4,336(sp)
    802003e8:	6ab6                	ld	s5,328(sp)
    802003ea:	6119                	addi	sp,sp,384
    802003ec:	8082                	ret
        panic("hello!~~~\n");
    802003ee:	00003517          	auipc	a0,0x3
    802003f2:	cc250513          	addi	a0,a0,-830 # 802030b0 <digits+0x18>
    802003f6:	00000097          	auipc	ra,0x0
    802003fa:	eb8080e7          	jalr	-328(ra) # 802002ae <panic>
    if (scause == EXCP_ENV_CALL){
    802003fe:	47a1                	li	a5,8
        trap_from_kernel = 1;
    80200400:	4905                	li	s2,1
    if (scause == EXCP_ENV_CALL){
    80200402:	faf49be3          	bne	s1,a5,802003b8 <trap_handler+0x34>
        uint64 user_high_sp = TASK_MANAGER.processing_tcb.memoryset.UserStackHigh.start_addr;
    80200406:	001a7797          	auipc	a5,0x1a7
    8020040a:	d4a78793          	addi	a5,a5,-694 # 803a7150 <heap+0x10>
        uint64 phy_user_high_sp = translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, user_high_sp);
    8020040e:	ed07b583          	ld	a1,-304(a5)
    80200412:	da87b503          	ld	a0,-600(a5)
        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);
    80200416:	e9840993          	addi	s3,s0,-360
        uint64 phy_user_high_sp = translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, user_high_sp);
    8020041a:	00001097          	auipc	ra,0x1
    8020041e:	27a080e7          	jalr	634(ra) # 80201694 <translate>
    80200422:	84aa                	mv	s1,a0
        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);
    80200424:	87aa                	mv	a5,a0
    80200426:	874e                	mv	a4,s3
    80200428:	12050813          	addi	a6,a0,288
    8020042c:	6388                	ld	a0,0(a5)
    8020042e:	678c                	ld	a1,8(a5)
    80200430:	6b90                	ld	a2,16(a5)
    80200432:	6f94                	ld	a3,24(a5)
    80200434:	e308                	sd	a0,0(a4)
    80200436:	e70c                	sd	a1,8(a4)
    80200438:	eb10                	sd	a2,16(a4)
    8020043a:	ef14                	sd	a3,24(a4)
    8020043c:	02078793          	addi	a5,a5,32
    80200440:	02070713          	addi	a4,a4,32
    80200444:	ff0794e3          	bne	a5,a6,8020042c <trap_handler+0xa8>
    80200448:	639c                	ld	a5,0(a5)
        uint64 return_value = syscall(x17, args);
    8020044a:	e8040593          	addi	a1,s0,-384
        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);
    8020044e:	e31c                	sd	a5,0(a4)
    80200450:	0884b903          	ld	s2,136(s1)
    80200454:	0584ba83          	ld	s5,88(s1)
    80200458:	0604ba03          	ld	s4,96(s1)
        args[0] = x10;
    8020045c:	68bc                	ld	a5,80(s1)
        uint64 return_value = syscall(x17, args);
    8020045e:	854a                	mv	a0,s2
        args[1] = x11;
    80200460:	e9543423          	sd	s5,-376(s0)
        args[0] = x10;
    80200464:	e8f43023          	sd	a5,-384(s0)
        args[2] = x12;
    80200468:	e9443823          	sd	s4,-368(s0)
        uint64 return_value = syscall(x17, args);
    8020046c:	00001097          	auipc	ra,0x1
    80200470:	a1c080e7          	jalr	-1508(ra) # 80200e88 <syscall>
        if (return_value > 0){
    80200474:	d125                	beqz	a0,802003d4 <trap_handler+0x50>
            *((struct trap_context *)phy_user_high_sp) = current_trap_cx;
    80200476:	eea43423          	sd	a0,-280(s0)
    8020047a:	ef543823          	sd	s5,-272(s0)
    8020047e:	ef443c23          	sd	s4,-264(s0)
    80200482:	f3243023          	sd	s2,-224(s0)
    80200486:	87ce                	mv	a5,s3
    80200488:	8526                	mv	a0,s1
    8020048a:	fb840813          	addi	a6,s0,-72
    8020048e:	638c                	ld	a1,0(a5)
    80200490:	6790                	ld	a2,8(a5)
    80200492:	6b94                	ld	a3,16(a5)
    80200494:	6f98                	ld	a4,24(a5)
    80200496:	e10c                	sd	a1,0(a0)
    80200498:	e510                	sd	a2,8(a0)
    8020049a:	e914                	sd	a3,16(a0)
    8020049c:	ed18                	sd	a4,24(a0)
    8020049e:	02078793          	addi	a5,a5,32
    802004a2:	02050513          	addi	a0,a0,32
    802004a6:	ff0794e3          	bne	a5,a6,8020048e <trap_handler+0x10a>
    802004aa:	639c                	ld	a5,0(a5)
    802004ac:	e11c                	sd	a5,0(a0)
    802004ae:	b71d                	j	802003d4 <trap_handler+0x50>
        uint64 user_high_sp = TASK_MANAGER.processing_tcb.memoryset.UserStackHigh.start_addr;
    802004b0:	001a7797          	auipc	a5,0x1a7
    802004b4:	ca078793          	addi	a5,a5,-864 # 803a7150 <heap+0x10>
        uint64 phy_user_high_sp = translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, user_high_sp);
    802004b8:	ed07b583          	ld	a1,-304(a5)
    802004bc:	da87b503          	ld	a0,-600(a5)
        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);
    802004c0:	e9840993          	addi	s3,s0,-360
        uint64 phy_user_high_sp = translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, user_high_sp);
    802004c4:	00001097          	auipc	ra,0x1
    802004c8:	1d0080e7          	jalr	464(ra) # 80201694 <translate>
        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);
    802004cc:	87aa                	mv	a5,a0
    802004ce:	86ce                	mv	a3,s3
    802004d0:	12050893          	addi	a7,a0,288
    802004d4:	0007b803          	ld	a6,0(a5)
    802004d8:	678c                	ld	a1,8(a5)
    802004da:	6b90                	ld	a2,16(a5)
    802004dc:	6f98                	ld	a4,24(a5)
    802004de:	0106b023          	sd	a6,0(a3)
    802004e2:	e68c                	sd	a1,8(a3)
    802004e4:	ea90                	sd	a2,16(a3)
    802004e6:	ee98                	sd	a4,24(a3)
    802004e8:	02078793          	addi	a5,a5,32
    802004ec:	02068693          	addi	a3,a3,32
    802004f0:	ff1792e3          	bne	a5,a7,802004d4 <trap_handler+0x150>
    802004f4:	6390                	ld	a2,0(a5)
        *((struct trap_context *)phy_user_high_sp) = current_trap_cx;
    802004f6:	872a                	mv	a4,a0
    802004f8:	87ce                	mv	a5,s3
        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);
    802004fa:	e290                	sd	a2,0(a3)
        current_trap_cx.spec = current_trap_cx.spec - 4;    // re-run the current instruction
    802004fc:	10053683          	ld	a3,256(a0)
        *((struct trap_context *)phy_user_high_sp) = current_trap_cx;
    80200500:	fb840813          	addi	a6,s0,-72
        current_trap_cx.spec = current_trap_cx.spec - 4;    // re-run the current instruction
    80200504:	16f1                	addi	a3,a3,-4
        *((struct trap_context *)phy_user_high_sp) = current_trap_cx;
    80200506:	f8d43c23          	sd	a3,-104(s0)
    8020050a:	6388                	ld	a0,0(a5)
    8020050c:	678c                	ld	a1,8(a5)
    8020050e:	6b90                	ld	a2,16(a5)
    80200510:	6f94                	ld	a3,24(a5)
    80200512:	e308                	sd	a0,0(a4)
    80200514:	e70c                	sd	a1,8(a4)
    80200516:	eb10                	sd	a2,16(a4)
    80200518:	ef14                	sd	a3,24(a4)
    8020051a:	02078793          	addi	a5,a5,32
    8020051e:	02070713          	addi	a4,a4,32
    80200522:	ff0794e3          	bne	a5,a6,8020050a <trap_handler+0x186>
    80200526:	639c                	ld	a5,0(a5)
    80200528:	e31c                	sd	a5,0(a4)
r_time()
{
	uint64 x;
	// asm volatile("csrr %0, time" : "=r" (x) );
	// this instruction will trap in SBI
	asm volatile("rdtime %0" : "=r" (x) );
    8020052a:	c0102573          	rdtime	a0
        sbi_set_timer(r_time() + INTERVAL / 100);
    8020052e:	67e1                	lui	a5,0x18
    80200530:	6a078793          	addi	a5,a5,1696 # 186a0 <n+0x18680>
    80200534:	953e                	add	a0,a0,a5

#define TIME_EID 	0x54494d45
#define TIME_SET_TIMER 	0

static inline struct sbiret sbi_set_timer(uint64 stime_value) {
	return SBI_CALL_1(0, TIME_SET_TIMER, stime_value);
    80200536:	4581                	li	a1,0
    80200538:	4601                	li	a2,0
    8020053a:	4681                	li	a3,0
    8020053c:	4801                	li	a6,0
    8020053e:	4881                	li	a7,0
    80200540:	00000073          	ecall
            run_next_app_from_kernel(0);
    80200544:	4501                	li	a0,0
        if (trap_from_kernel){
    80200546:	00090763          	beqz	s2,80200554 <trap_handler+0x1d0>
            run_next_app_from_kernel(0);
    8020054a:	00000097          	auipc	ra,0x0
    8020054e:	48e080e7          	jalr	1166(ra) # 802009d8 <run_next_app_from_kernel>
    80200552:	b549                	j	802003d4 <trap_handler+0x50>
            run_next_app(0);
    80200554:	00000097          	auipc	ra,0x0
    80200558:	3e8080e7          	jalr	1000(ra) # 8020093c <run_next_app>
    8020055c:	bda5                	j	802003d4 <trap_handler+0x50>
    8020055e:	0000                	unimp
	...

0000000080200562 <check_name>:
//     return new_mem_set;
// }


// check whether two strings are the same
uint64 check_name(uint64 left_addr, uint64 right_addr){
    80200562:	1141                	addi	sp,sp,-16
    80200564:	e422                	sd	s0,8(sp)
    80200566:	0800                	addi	s0,sp,16
    uint64 index = 0;
    while (1){
        if (*(char *)(left_addr + index) == *(char *)(right_addr + index)){
    80200568:	00054703          	lbu	a4,0(a0)
    8020056c:	0005c783          	lbu	a5,0(a1)
    80200570:	02e79463          	bne	a5,a4,80200598 <check_name+0x36>
    uint64 index = 0;
    80200574:	4781                	li	a5,0
            if (*(char *)(left_addr + index) == '\0' && index > 0){
    80200576:	e711                	bnez	a4,80200582 <check_name+0x20>
    80200578:	c789                	beqz	a5,80200582 <check_name+0x20>
        }
        else{
            return 0;
        }
    }
}
    8020057a:	6422                	ld	s0,8(sp)
                return 1;
    8020057c:	4505                	li	a0,1
}
    8020057e:	0141                	addi	sp,sp,16
    80200580:	8082                	ret
            index += 1;
    80200582:	0785                	addi	a5,a5,1
        if (*(char *)(left_addr + index) == *(char *)(right_addr + index)){
    80200584:	00f50733          	add	a4,a0,a5
    80200588:	00f586b3          	add	a3,a1,a5
    8020058c:	00074703          	lbu	a4,0(a4)
    80200590:	0006c683          	lbu	a3,0(a3)
    80200594:	fee681e3          	beq	a3,a4,80200576 <check_name+0x14>
}
    80200598:	6422                	ld	s0,8(sp)
            return 0;
    8020059a:	4501                	li	a0,0
}
    8020059c:	0141                	addi	sp,sp,16
    8020059e:	8082                	ret

00000000802005a0 <load>:

// Change to load by app name
struct User_MemorySet load(uint64 str_addr){
    802005a0:	1101                	addi	sp,sp,-32
    802005a2:	e822                	sd	s0,16(sp)
    802005a4:	e426                	sd	s1,8(sp)
    802005a6:	ec06                	sd	ra,24(sp)
    802005a8:	1000                	addi	s0,sp,32

    uint64 num_of_apps = *(uint64 *)(&_num_app);
    802005aa:	00004e97          	auipc	t4,0x4
    802005ae:	a56e8e93          	addi	t4,t4,-1450 # 80204000 <_num_app>
    802005b2:	000eb283          	ld	t0,0(t4)
struct User_MemorySet load(uint64 str_addr){
    802005b6:	84aa                	mv	s1,a0

    uint64 index = &_app_names;
    uint64 found = 0;
    uint64 found_app = -1; 
    for (uint64 app_i = 0; app_i < num_of_apps; app_i ++){
    802005b8:	04028163          	beqz	t0,802005fa <load+0x5a>
        if (*(char *)(left_addr + index) == *(char *)(right_addr + index)){
    802005bc:	0005cf83          	lbu	t6,0(a1)
    802005c0:	00004697          	auipc	a3,0x4
    802005c4:	ad068693          	addi	a3,a3,-1328 # 80204090 <_app_names>
    for (uint64 app_i = 0; app_i < num_of_apps; app_i ++){
    802005c8:	4801                	li	a6,0
        if (*(char *)(left_addr + index) == *(char *)(right_addr + index)){
    802005ca:	0006cf03          	lbu	t5,0(a3)
    802005ce:	00168793          	addi	a5,a3,1
            if (*(char *)(left_addr + index) == '\0' && index > 0){
    802005d2:	fff6ce13          	not	t3,a3
    802005d6:	873e                	mv	a4,a5
        if (*(char *)(left_addr + index) == *(char *)(right_addr + index)){
    802005d8:	867e                	mv	a2,t6
    802005da:	40d586b3          	sub	a3,a1,a3
    802005de:	05ff1163          	bne	t5,t6,80200620 <load+0x80>
    802005e2:	00e688b3          	add	a7,a3,a4
            if (*(char *)(left_addr + index) == '\0' && index > 0){
    802005e6:	00ee0333          	add	t1,t3,a4
    802005ea:	e605                	bnez	a2,80200612 <load+0x72>
    802005ec:	02030363          	beqz	t1,80200612 <load+0x72>
    802005f0:	0805                	addi	a6,a6,1
    802005f2:	080e                	slli	a6,a6,0x3
    802005f4:	9876                	add	a6,a6,t4
    802005f6:	00083283          	ld	t0,0(a6)

    found_app += 1;
    uint64 start_addr = *(uint64 *)(&_num_app + found_app);

    // 将elf文件解析开
    struct User_MemorySet new_mem_set = load_elf(start_addr);
    802005fa:	8526                	mv	a0,s1
    802005fc:	8596                	mv	a1,t0
    802005fe:	00002097          	auipc	ra,0x2
    80200602:	aec080e7          	jalr	-1300(ra) # 802020ea <load_elf>

    return new_mem_set;
}
    80200606:	60e2                	ld	ra,24(sp)
    80200608:	6442                	ld	s0,16(sp)
    8020060a:	8526                	mv	a0,s1
    8020060c:	64a2                	ld	s1,8(sp)
    8020060e:	6105                	addi	sp,sp,32
    80200610:	8082                	ret
        if (*(char *)(left_addr + index) == *(char *)(right_addr + index)){
    80200612:	00074603          	lbu	a2,0(a4)
    80200616:	0008c883          	lbu	a7,0(a7)
    8020061a:	0705                	addi	a4,a4,1
    8020061c:	fd1603e3          	beq	a2,a7,802005e2 <load+0x42>
        while (*(char *)index != '\0'){
    80200620:	000f0663          	beqz	t5,8020062c <load+0x8c>
    80200624:	0007c703          	lbu	a4,0(a5)
    80200628:	0785                	addi	a5,a5,1
    8020062a:	ff6d                	bnez	a4,80200624 <load+0x84>
    for (uint64 app_i = 0; app_i < num_of_apps; app_i ++){
    8020062c:	0805                	addi	a6,a6,1
        index += 1;
    8020062e:	86be                	mv	a3,a5
    for (uint64 app_i = 0; app_i < num_of_apps; app_i ++){
    80200630:	f9029de3          	bne	t0,a6,802005ca <load+0x2a>
    80200634:	b7d9                	j	802005fa <load+0x5a>

0000000080200636 <zero_init>:





void zero_init(uint64 start, uint64 end){
    80200636:	1141                	addi	sp,sp,-16
    80200638:	e422                	sd	s0,8(sp)
    8020063a:	0800                	addi	s0,sp,16
    for (uint64 i = start; i <= end; i++){
    8020063c:	00a5e763          	bltu	a1,a0,8020064a <zero_init+0x14>
        *(char*)i = 0;
    80200640:	00050023          	sb	zero,0(a0)
    for (uint64 i = start; i <= end; i++){
    80200644:	0505                	addi	a0,a0,1
    80200646:	fea5fde3          	bgeu	a1,a0,80200640 <zero_init+0xa>
    }
}
    8020064a:	6422                	ld	s0,8(sp)
    8020064c:	0141                	addi	sp,sp,16
    8020064e:	8082                	ret

0000000080200650 <memmove>:
#include "string.h"
#include "console.h"



void memmove(uint64 dst, uint64 src, int size){
    80200650:	1141                	addi	sp,sp,-16
    80200652:	e422                	sd	s0,8(sp)
    80200654:	0800                	addi	s0,sp,16
    int cpy_index = 0;

    while (cpy_index < size){
    80200656:	02c05263          	blez	a2,8020067a <memmove+0x2a>
    8020065a:	367d                	addiw	a2,a2,-1
    8020065c:	1602                	slli	a2,a2,0x20
    8020065e:	00158693          	addi	a3,a1,1
    80200662:	9201                	srli	a2,a2,0x20
    80200664:	96b2                	add	a3,a3,a2
    80200666:	8d0d                	sub	a0,a0,a1
        *(char*)(dst + cpy_index) = *(char*)(src + cpy_index);    // 一个一个byte的复制过去
    80200668:	0005c703          	lbu	a4,0(a1)
    8020066c:	00b507b3          	add	a5,a0,a1
    80200670:	0585                	addi	a1,a1,1
    80200672:	00e78023          	sb	a4,0(a5)
    while (cpy_index < size){
    80200676:	fed599e3          	bne	a1,a3,80200668 <memmove+0x18>
        cpy_index ++;
    }
}
    8020067a:	6422                	ld	s0,8(sp)
    8020067c:	0141                	addi	sp,sp,16
    8020067e:	8082                	ret

0000000080200680 <memcpy>:

void memcpy(uint64 dst, uint64 src, int size){
    80200680:	1141                	addi	sp,sp,-16
    80200682:	e422                	sd	s0,8(sp)
    80200684:	0800                	addi	s0,sp,16
    while (cpy_index < size){
    80200686:	02c05263          	blez	a2,802006aa <memcpy+0x2a>
    8020068a:	367d                	addiw	a2,a2,-1
    8020068c:	1602                	slli	a2,a2,0x20
    8020068e:	00158693          	addi	a3,a1,1
    80200692:	9201                	srli	a2,a2,0x20
    80200694:	96b2                	add	a3,a3,a2
    80200696:	8d0d                	sub	a0,a0,a1
        *(char*)(dst + cpy_index) = *(char*)(src + cpy_index);    // 一个一个byte的复制过去
    80200698:	0005c703          	lbu	a4,0(a1)
    8020069c:	00b507b3          	add	a5,a0,a1
    802006a0:	0585                	addi	a1,a1,1
    802006a2:	00e78023          	sb	a4,0(a5)
    while (cpy_index < size){
    802006a6:	fed599e3          	bne	a1,a3,80200698 <memcpy+0x18>
    memmove(dst, src, size);
    802006aa:	6422                	ld	s0,8(sp)
    802006ac:	0141                	addi	sp,sp,16
    802006ae:	8082                	ret

00000000802006b0 <init_app>:
extern void __switch(uint64 a0, uint64 a1);
extern struct task_manager TASK_MANAGER;
extern uint64 _num_app;


void init_app(uint64 app_name){
    802006b0:	7115                	addi	sp,sp,-224
    802006b2:	ed86                	sd	ra,216(sp)
    802006b4:	e9a2                	sd	s0,208(sp)
    802006b6:	e1ca                	sd	s2,192(sp)
    802006b8:	1180                	addi	s0,sp,224
    802006ba:	fd4e                	sd	s3,184(sp)
    802006bc:	f952                	sd	s4,176(sp)
    802006be:	f556                	sd	s5,168(sp)
    802006c0:	f15a                	sd	s6,160(sp)
    802006c2:	ed5e                	sd	s7,152(sp)
    802006c4:	e962                	sd	s8,144(sp)
    802006c6:	e5a6                	sd	s1,200(sp)
    802006c8:	85aa                	mv	a1,a0

    // 初始化进程管理
    // 第一步：初始化app的地址空间
    struct User_MemorySet current_mem_set = load(app_name);    // 将应用程序load到主内存中
    802006ca:	bb040513          	addi	a0,s0,-1104
void init_app(uint64 app_name){
    802006ce:	81010113          	addi	sp,sp,-2032
    struct User_MemorySet current_mem_set = load(app_name);    // 将应用程序load到主内存中
    802006d2:	00000097          	auipc	ra,0x0
    802006d6:	ece080e7          	jalr	-306(ra) # 802005a0 <load>
    802006da:	bb043983          	ld	s3,-1104(s0)
    802006de:	d4043a03          	ld	s4,-704(s0)
    802006e2:	bb843b03          	ld	s6,-1096(s0)

    uint64 kernel_stack_top = current_mem_set.Kernel_Stack.end_addr;

    // 第二步：初始化进程上下文
    struct task_context app_task_context = new_task_cx(return_to_user, kernel_stack_top, root_ppn_to_token(current_mem_set.page_table.root_ppn));
    802006e6:	854e                	mv	a0,s3
    struct User_MemorySet current_mem_set = load(app_name);    // 将应用程序load到主内存中
    802006e8:	cb043b83          	ld	s7,-848(s0)
    802006ec:	cd843a83          	ld	s5,-808(s0)
    struct task_context app_task_context = new_task_cx(return_to_user, kernel_stack_top, root_ppn_to_token(current_mem_set.page_table.root_ppn));
    802006f0:	00001097          	auipc	ra,0x1
    802006f4:	658080e7          	jalr	1624(ra) # 80201d48 <root_ppn_to_token>
    802006f8:	86aa                	mv	a3,a0
    802006fa:	8652                	mv	a2,s4
    802006fc:	00000597          	auipc	a1,0x0
    80200700:	c4858593          	addi	a1,a1,-952 # 80200344 <return_to_user>
    80200704:	a1040513          	addi	a0,s0,-1520
    80200708:	00001097          	auipc	ra,0x1
    8020070c:	9be080e7          	jalr	-1602(ra) # 802010c6 <new_task_cx>

    // 第三步：初始化TCB
    struct task_control_block app_tcb = new_task_control_block(app_task_context,  kernel_stack_top);
    80200710:	d6840c13          	addi	s8,s0,-664
    80200714:	a1040793          	addi	a5,s0,-1520
    80200718:	99040713          	addi	a4,s0,-1648
    8020071c:	a8840913          	addi	s2,s0,-1400
    80200720:	0007b803          	ld	a6,0(a5)
    80200724:	6788                	ld	a0,8(a5)
    80200726:	6b8c                	ld	a1,16(a5)
    80200728:	6f90                	ld	a2,24(a5)
    8020072a:	7394                	ld	a3,32(a5)
    8020072c:	01073023          	sd	a6,0(a4)
    80200730:	e708                	sd	a0,8(a4)
    80200732:	eb0c                	sd	a1,16(a4)
    80200734:	ef10                	sd	a2,24(a4)
    80200736:	f314                	sd	a3,32(a4)
    80200738:	02878793          	addi	a5,a5,40
    8020073c:	02870713          	addi	a4,a4,40
    80200740:	fef910e3          	bne	s2,a5,80200720 <init_app+0x70>
    80200744:	8652                	mv	a2,s4
    80200746:	99040593          	addi	a1,s0,-1648
    8020074a:	8562                	mv	a0,s8
    8020074c:	00001097          	auipc	ra,0x1
    80200750:	9d6080e7          	jalr	-1578(ra) # 80201122 <new_task_control_block>
    app_tcb.memoryset = current_mem_set;
    80200754:	bb040493          	addi	s1,s0,-1104
    80200758:	d7040793          	addi	a5,s0,-656
    8020075c:	6088                	ld	a0,0(s1)
    8020075e:	648c                	ld	a1,8(s1)
    80200760:	6890                	ld	a2,16(s1)
    80200762:	6c94                	ld	a3,24(s1)
    80200764:	7098                	ld	a4,32(s1)
    80200766:	e388                	sd	a0,0(a5)
    80200768:	e78c                	sd	a1,8(a5)
    8020076a:	eb90                	sd	a2,16(a5)
    8020076c:	ef94                	sd	a3,24(a5)
    8020076e:	f398                	sd	a4,32(a5)
    80200770:	02848493          	addi	s1,s1,40
    80200774:	02878793          	addi	a5,a5,40
    80200778:	ff8492e3          	bne	s1,s8,8020075c <init_app+0xac>
    app_tcb.user_token = root_ppn_to_token(current_mem_set.page_table.root_ppn);
    8020077c:	854e                	mv	a0,s3
    8020077e:	00001097          	auipc	ra,0x1
    80200782:	5ca080e7          	jalr	1482(ra) # 80201d48 <root_ppn_to_token>

    // 第四步：将初始化好的TCB放入task manager中
    add_task_control_block(app_tcb);
    80200786:	fb040713          	addi	a4,s0,-80
    8020078a:	77fd                	lui	a5,0xfffff
    8020078c:	76fd                	lui	a3,0xfffff
    8020078e:	97ba                	add	a5,a5,a4
    80200790:	73868713          	addi	a4,a3,1848 # fffffffffffff738 <ebss+0xffffffff7fc35738>
    80200794:	9722                	add	a4,a4,s0
    80200796:	e31c                	sd	a5,0(a4)
    80200798:	631c                	ld	a5,0(a4)
    app_tcb.user_token = root_ppn_to_token(current_mem_set.page_table.root_ppn);
    8020079a:	d6a43423          	sd	a0,-664(s0)
    add_task_control_block(app_tcb);
    8020079e:	fa840713          	addi	a4,s0,-88
    802007a2:	79078793          	addi	a5,a5,1936 # fffffffffffff790 <ebss+0xffffffff7fc35790>
    802007a6:	6088                	ld	a0,0(s1)
    802007a8:	648c                	ld	a1,8(s1)
    802007aa:	6890                	ld	a2,16(s1)
    802007ac:	6c94                	ld	a3,24(s1)
    802007ae:	e388                	sd	a0,0(a5)
    802007b0:	e78c                	sd	a1,8(a5)
    802007b2:	eb90                	sd	a2,16(a5)
    802007b4:	ef94                	sd	a3,24(a5)
    802007b6:	02048493          	addi	s1,s1,32
    802007ba:	02078793          	addi	a5,a5,32
    802007be:	fee494e3          	bne	s1,a4,802007a6 <init_app+0xf6>
    802007c2:	6098                	ld	a4,0(s1)
    802007c4:	757d                	lui	a0,0xfffff
    802007c6:	fb040693          	addi	a3,s0,-80
    802007ca:	79050513          	addi	a0,a0,1936 # fffffffffffff790 <ebss+0xffffffff7fc35790>
    802007ce:	9536                	add	a0,a0,a3
    802007d0:	e398                	sd	a4,0(a5)
    802007d2:	00001097          	auipc	ra,0x1
    802007d6:	a82080e7          	jalr	-1406(ra) # 80201254 <add_task_control_block>
	asm volatile("csrr %0, satp" : "=r" (x) );
    802007da:	18002673          	csrr	a2,satp
	asm volatile("csrr %0, sstatus" : "=r" (x) );
    802007de:	10002873          	csrr	a6,sstatus
    uint64 kernel_satp = r_satp();   
    uint64 app_trap_handler = trap_handler;
    uint64 sstatus = r_sstatus();


    struct trap_context app_trap_context = new_trap_cx(app_entry, kernel_satp, app_trap_handler, user_low_sp, kernel_stack_top, sstatus);
    802007e2:	00000697          	auipc	a3,0x0
    802007e6:	ba268693          	addi	a3,a3,-1118 # 80200384 <trap_handler>
    802007ea:	87d2                	mv	a5,s4
    802007ec:	875e                	mv	a4,s7
    802007ee:	85da                	mv	a1,s6
    802007f0:	854a                	mv	a0,s2
    802007f2:	00000097          	auipc	ra,0x0
    802007f6:	aee080e7          	jalr	-1298(ra) # 802002e0 <new_trap_cx>


    // 第二步: 将trap上下文放在用户栈高位栈顶：
    uint64 user_high_sp = current_mem_set.UserStackHigh.start_addr;
    uint64 phy_user_high_sp = translate(current_mem_set.page_table.root_ppn, user_high_sp);
    802007fa:	85d6                	mv	a1,s5
    802007fc:	854e                	mv	a0,s3
    802007fe:	00001097          	auipc	ra,0x1
    80200802:	e96080e7          	jalr	-362(ra) # 80201694 <translate>
    *((struct trap_context *)phy_user_high_sp) = app_trap_context;
    80200806:	87ca                	mv	a5,s2
    80200808:	ba840713          	addi	a4,s0,-1112
    8020080c:	0007b803          	ld	a6,0(a5)
    80200810:	678c                	ld	a1,8(a5)
    80200812:	6b90                	ld	a2,16(a5)
    80200814:	6f94                	ld	a3,24(a5)
    80200816:	01053023          	sd	a6,0(a0)
    8020081a:	e50c                	sd	a1,8(a0)
    8020081c:	e910                	sd	a2,16(a0)
    8020081e:	ed14                	sd	a3,24(a0)
    80200820:	02078793          	addi	a5,a5,32
    80200824:	02050513          	addi	a0,a0,32
    80200828:	fee792e3          	bne	a5,a4,8020080c <init_app+0x15c>
    8020082c:	639c                	ld	a5,0(a5)
    8020082e:	e11c                	sd	a5,0(a0)
	asm volatile("csrw stvec, %0" : : "r" (x));
    80200830:	00000797          	auipc	a5,0x0
    80200834:	7d478793          	addi	a5,a5,2004 # 80201004 <__alltraps>
    80200838:	10579073          	csrw	stvec,a5


    // 第三步: 将stvec修改成__alltraps的位置
    w_stvec(__alltraps);    

}
    8020083c:	7f010113          	addi	sp,sp,2032
    80200840:	60ee                	ld	ra,216(sp)
    80200842:	644e                	ld	s0,208(sp)
    80200844:	64ae                	ld	s1,200(sp)
    80200846:	690e                	ld	s2,192(sp)
    80200848:	79ea                	ld	s3,184(sp)
    8020084a:	7a4a                	ld	s4,176(sp)
    8020084c:	7aaa                	ld	s5,168(sp)
    8020084e:	7b0a                	ld	s6,160(sp)
    80200850:	6bea                	ld	s7,152(sp)
    80200852:	6c4a                	ld	s8,144(sp)
    80200854:	612d                	addi	sp,sp,224
    80200856:	8082                	ret

0000000080200858 <scheduler>:

uint64 scheduler(){
    80200858:	1101                	addi	sp,sp,-32
    8020085a:	e822                	sd	s0,16(sp)
    8020085c:	e426                	sd	s1,8(sp)
    8020085e:	e04a                	sd	s2,0(sp)
    80200860:	ec06                	sd	ra,24(sp)
    80200862:	1000                	addi	s0,sp,32

    // 先采用FIFO的schedule策略

    uint64 current_pid = TASK_MANAGER.processing_tcb.pid;

    uint64 next_pid = (current_pid + 1) % MAX_NUM_OF_APPS;
    80200864:	001a7497          	auipc	s1,0x1a7
    80200868:	8cc4b483          	ld	s1,-1844(s1) # 803a7130 <TASK_MANAGER+0x2fe0>
    8020086c:	0485                	addi	s1,s1,1
    8020086e:	45d1                	li	a1,20
    80200870:	02b4f4b3          	remu	s1,s1,a1

    while(!check_valid(next_pid)){
        next_pid = (next_pid + 1) % MAX_NUM_OF_APPS;
    80200874:	4951                	li	s2,20
    while(!check_valid(next_pid)){
    80200876:	a019                	j	8020087c <scheduler+0x24>
        next_pid = (next_pid + 1) % MAX_NUM_OF_APPS;
    80200878:	0327f4b3          	remu	s1,a5,s2
    while(!check_valid(next_pid)){
    8020087c:	8526                	mv	a0,s1
    8020087e:	00001097          	auipc	ra,0x1
    80200882:	9ba080e7          	jalr	-1606(ra) # 80201238 <check_valid>
        next_pid = (next_pid + 1) % MAX_NUM_OF_APPS;
    80200886:	00148793          	addi	a5,s1,1
    while(!check_valid(next_pid)){
    8020088a:	d57d                	beqz	a0,80200878 <scheduler+0x20>
    }

    printf("[scheduler] schedule to nex pid: %d\n", next_pid);
    8020088c:	85a6                	mv	a1,s1
    8020088e:	00003517          	auipc	a0,0x3
    80200892:	85a50513          	addi	a0,a0,-1958 # 802030e8 <digits+0x50>
    80200896:	00000097          	auipc	ra,0x0
    8020089a:	884080e7          	jalr	-1916(ra) # 8020011a <printf>

    return next_pid;

}
    8020089e:	60e2                	ld	ra,24(sp)
    802008a0:	6442                	ld	s0,16(sp)
    802008a2:	6902                	ld	s2,0(sp)
    802008a4:	8526                	mv	a0,s1
    802008a6:	64a2                	ld	s1,8(sp)
    802008a8:	6105                	addi	sp,sp,32
    802008aa:	8082                	ret

00000000802008ac <timerinit>:

// 开启时钟中断  - 有关timer的这两个函数照搬了xv6的
void timerinit(){
    802008ac:	1141                	addi	sp,sp,-16
    802008ae:	e422                	sd	s0,8(sp)
    802008b0:	0800                	addi	s0,sp,16
	asm volatile("rdtime %0" : "=r" (x) );
    802008b2:	c0102573          	rdtime	a0
    set_next_timeout();
    printf("[kernel] timerinit\n");
}

void set_next_timeout(){
    sbi_set_timer(r_time() + INTERVAL / 100);
    802008b6:	67e1                	lui	a5,0x18
    802008b8:	6a078793          	addi	a5,a5,1696 # 186a0 <n+0x18680>
    802008bc:	953e                	add	a0,a0,a5
    802008be:	4581                	li	a1,0
    802008c0:	4601                	li	a2,0
    802008c2:	4681                	li	a3,0
    802008c4:	4801                	li	a6,0
    802008c6:	4881                	li	a7,0
    802008c8:	00000073          	ecall
}
    802008cc:	6422                	ld	s0,8(sp)
    printf("[kernel] timerinit\n");
    802008ce:	00003517          	auipc	a0,0x3
    802008d2:	84250513          	addi	a0,a0,-1982 # 80203110 <digits+0x78>
}
    802008d6:	0141                	addi	sp,sp,16
    printf("[kernel] timerinit\n");
    802008d8:	00000317          	auipc	t1,0x0
    802008dc:	84230067          	jr	-1982(t1) # 8020011a <printf>

00000000802008e0 <set_next_timeout>:
void set_next_timeout(){
    802008e0:	1141                	addi	sp,sp,-16
    802008e2:	e422                	sd	s0,8(sp)
    802008e4:	0800                	addi	s0,sp,16
    802008e6:	c0102573          	rdtime	a0
    sbi_set_timer(r_time() + INTERVAL / 100);
    802008ea:	67e1                	lui	a5,0x18
    802008ec:	6a078793          	addi	a5,a5,1696 # 186a0 <n+0x18680>
    802008f0:	953e                	add	a0,a0,a5
    802008f2:	4581                	li	a1,0
    802008f4:	4601                	li	a2,0
    802008f6:	4681                	li	a3,0
    802008f8:	4801                	li	a6,0
    802008fa:	4881                	li	a7,0
    802008fc:	00000073          	ecall
}
    80200900:	6422                	ld	s0,8(sp)
    80200902:	0141                	addi	sp,sp,16
    80200904:	8082                	ret

0000000080200906 <init_all_apps>:




void init_all_apps(){
    80200906:	1101                	addi	sp,sp,-32
    80200908:	e822                	sd	s0,16(sp)
    8020090a:	e04a                	sd	s2,0(sp)
    8020090c:	ec06                	sd	ra,24(sp)
    8020090e:	e426                	sd	s1,8(sp)
    80200910:	1000                	addi	s0,sp,32
    
    uint64 num_of_apps = *(uint64 *)(&_num_app);
    80200912:	00003917          	auipc	s2,0x3
    80200916:	6ee93903          	ld	s2,1774(s2) # 80204000 <_num_app>

    for (int i = 0; i < num_of_apps; i++){
    8020091a:	00090b63          	beqz	s2,80200930 <init_all_apps+0x2a>
    8020091e:	4481                	li	s1,0
        init_app(i);
    80200920:	8526                	mv	a0,s1
    80200922:	0485                	addi	s1,s1,1
    80200924:	00000097          	auipc	ra,0x0
    80200928:	d8c080e7          	jalr	-628(ra) # 802006b0 <init_app>
    for (int i = 0; i < num_of_apps; i++){
    8020092c:	ff249ae3          	bne	s1,s2,80200920 <init_all_apps+0x1a>
    }

}
    80200930:	60e2                	ld	ra,24(sp)
    80200932:	6442                	ld	s0,16(sp)
    80200934:	64a2                	ld	s1,8(sp)
    80200936:	6902                	ld	s2,0(sp)
    80200938:	6105                	addi	sp,sp,32
    8020093a:	8082                	ret

000000008020093c <run_next_app>:

void run_next_app(int init){
    if (init == 1){
    8020093c:	4785                	li	a5,1
    8020093e:	04f50d63          	beq	a0,a5,80200998 <run_next_app+0x5c>
void run_next_app(int init){
    80200942:	1141                	addi	sp,sp,-16
    80200944:	e022                	sd	s0,0(sp)
    80200946:	e406                	sd	ra,8(sp)
    80200948:	0800                	addi	s0,sp,16
        TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[0];
        return_to_user();
        return 0;
    }

    uint64 pid = scheduler();
    8020094a:	00000097          	auipc	ra,0x0
    8020094e:	f0e080e7          	jalr	-242(ra) # 80200858 <scheduler>

    TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[pid];
    80200952:	24800713          	li	a4,584
    80200956:	02e50733          	mul	a4,a0,a4
    8020095a:	001a3517          	auipc	a0,0x1a3
    8020095e:	7f650513          	addi	a0,a0,2038 # 803a4150 <TASK_MANAGER>
    80200962:	001a6797          	auipc	a5,0x1a6
    80200966:	58e78793          	addi	a5,a5,1422 # 803a6ef0 <TASK_MANAGER+0x2da0>
    8020096a:	953a                	add	a0,a0,a4
    8020096c:	24050813          	addi	a6,a0,576
    80200970:	610c                	ld	a1,0(a0)
    80200972:	6510                	ld	a2,8(a0)
    80200974:	6914                	ld	a3,16(a0)
    80200976:	6d18                	ld	a4,24(a0)
    80200978:	e38c                	sd	a1,0(a5)
    8020097a:	e790                	sd	a2,8(a5)
    8020097c:	eb94                	sd	a3,16(a5)
    8020097e:	ef98                	sd	a4,24(a5)
    80200980:	02050513          	addi	a0,a0,32
    80200984:	02078793          	addi	a5,a5,32
    80200988:	ff0514e3          	bne	a0,a6,80200970 <run_next_app+0x34>
    8020098c:	6118                	ld	a4,0(a0)
}
    8020098e:	60a2                	ld	ra,8(sp)
    80200990:	6402                	ld	s0,0(sp)
    TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[pid];
    80200992:	e398                	sd	a4,0(a5)
}
    80200994:	0141                	addi	sp,sp,16
    80200996:	8082                	ret
        TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[0];
    80200998:	001a3797          	auipc	a5,0x1a3
    8020099c:	7b878793          	addi	a5,a5,1976 # 803a4150 <TASK_MANAGER>
    802009a0:	001a6717          	auipc	a4,0x1a6
    802009a4:	55070713          	addi	a4,a4,1360 # 803a6ef0 <TASK_MANAGER+0x2da0>
    802009a8:	001a4817          	auipc	a6,0x1a4
    802009ac:	9e880813          	addi	a6,a6,-1560 # 803a4390 <TASK_MANAGER+0x240>
    802009b0:	6388                	ld	a0,0(a5)
    802009b2:	678c                	ld	a1,8(a5)
    802009b4:	6b90                	ld	a2,16(a5)
    802009b6:	6f94                	ld	a3,24(a5)
    802009b8:	e308                	sd	a0,0(a4)
    802009ba:	e70c                	sd	a1,8(a4)
    802009bc:	eb10                	sd	a2,16(a4)
    802009be:	ef14                	sd	a3,24(a4)
    802009c0:	02078793          	addi	a5,a5,32
    802009c4:	02070713          	addi	a4,a4,32
    802009c8:	ff0794e3          	bne	a5,a6,802009b0 <run_next_app+0x74>
    802009cc:	639c                	ld	a5,0(a5)
    802009ce:	e31c                	sd	a5,0(a4)
        return_to_user();
    802009d0:	00000317          	auipc	t1,0x0
    802009d4:	97430067          	jr	-1676(t1) # 80200344 <return_to_user>

00000000802009d8 <run_next_app_from_kernel>:


void run_next_app_from_kernel(int init){
    802009d8:	1141                	addi	sp,sp,-16
    802009da:	e422                	sd	s0,8(sp)
    802009dc:	0800                	addi	s0,sp,16
    panic("Wrong if enter into this function!\n");
}
    802009de:	6422                	ld	s0,8(sp)
    panic("Wrong if enter into this function!\n");
    802009e0:	00002517          	auipc	a0,0x2
    802009e4:	74850513          	addi	a0,a0,1864 # 80203128 <digits+0x90>
}
    802009e8:	0141                	addi	sp,sp,16
    panic("Wrong if enter into this function!\n");
    802009ea:	00000317          	auipc	t1,0x0
    802009ee:	8c430067          	jr	-1852(t1) # 802002ae <panic>

00000000802009f2 <tcb_clone>:


uint64 tcb_clone(uint64 target_pid){

    struct task_control_block target_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[target_pid];
    802009f2:	24800713          	li	a4,584
    802009f6:	02e50733          	mul	a4,a0,a4
uint64 tcb_clone(uint64 target_pid){
    802009fa:	81010113          	addi	sp,sp,-2032
    802009fe:	7e813023          	sd	s0,2016(sp)
    struct task_control_block target_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[target_pid];
    80200a02:	001a3517          	auipc	a0,0x1a3
    80200a06:	74e50513          	addi	a0,a0,1870 # 803a4150 <TASK_MANAGER>
uint64 tcb_clone(uint64 target_pid){
    80200a0a:	7f010413          	addi	s0,sp,2032
    80200a0e:	7d213823          	sd	s2,2000(sp)
    80200a12:	7e113423          	sd	ra,2024(sp)
    80200a16:	7c913c23          	sd	s1,2008(sp)
    80200a1a:	7d313423          	sd	s3,1992(sp)
    80200a1e:	7d413023          	sd	s4,1984(sp)
    struct task_control_block target_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[target_pid];
    80200a22:	b4040913          	addi	s2,s0,-1216
    80200a26:	953a                	add	a0,a0,a4
    80200a28:	87ca                	mv	a5,s2
uint64 tcb_clone(uint64 target_pid){
    80200a2a:	c6010113          	addi	sp,sp,-928
    struct task_control_block target_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[target_pid];
    80200a2e:	24050713          	addi	a4,a0,576
    80200a32:	00053803          	ld	a6,0(a0)
    80200a36:	650c                	ld	a1,8(a0)
    80200a38:	6910                	ld	a2,16(a0)
    80200a3a:	6d14                	ld	a3,24(a0)
    80200a3c:	0107b023          	sd	a6,0(a5)
    80200a40:	e78c                	sd	a1,8(a5)
    80200a42:	eb90                	sd	a2,16(a5)
    80200a44:	ef94                	sd	a3,24(a5)
    80200a46:	02050513          	addi	a0,a0,32
    80200a4a:	02078793          	addi	a5,a5,32
    80200a4e:	fee512e3          	bne	a0,a4,80200a32 <tcb_clone+0x40>
    80200a52:	6114                	ld	a3,0(a0)

    // 对于新的进程，复制父进程地址空间
    struct User_MemorySet clone_mem_set = copy_mem_set(target_tcb.memoryset);
    80200a54:	777d                	lui	a4,0xfffff
    80200a56:	98840993          	addi	s3,s0,-1656
    struct task_control_block target_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[target_pid];
    80200a5a:	e394                	sd	a3,0(a5)
    struct User_MemorySet clone_mem_set = copy_mem_set(target_tcb.memoryset);
    80200a5c:	fd040793          	addi	a5,s0,-48
    80200a60:	76fd                	lui	a3,0xfffff
    80200a62:	97ba                	add	a5,a5,a4
    80200a64:	47868713          	addi	a4,a3,1144 # fffffffffffff478 <ebss+0xffffffff7fc35478>
    80200a68:	9722                	add	a4,a4,s0
    80200a6a:	e31c                	sd	a5,0(a4)
    80200a6c:	631c                	ld	a5,0(a4)
    80200a6e:	b4840493          	addi	s1,s0,-1208
    80200a72:	d0040713          	addi	a4,s0,-768
    80200a76:	78078793          	addi	a5,a5,1920
    80200a7a:	0004b803          	ld	a6,0(s1)
    80200a7e:	6488                	ld	a0,8(s1)
    80200a80:	688c                	ld	a1,16(s1)
    80200a82:	6c90                	ld	a2,24(s1)
    80200a84:	7094                	ld	a3,32(s1)
    80200a86:	0107b023          	sd	a6,0(a5)
    80200a8a:	e788                	sd	a0,8(a5)
    80200a8c:	eb8c                	sd	a1,16(a5)
    80200a8e:	ef90                	sd	a2,24(a5)
    80200a90:	f394                	sd	a3,32(a5)
    80200a92:	02848493          	addi	s1,s1,40
    80200a96:	02878793          	addi	a5,a5,40
    80200a9a:	fee490e3          	bne	s1,a4,80200a7a <tcb_clone+0x88>
    80200a9e:	75fd                	lui	a1,0xfffff
    80200aa0:	fd040793          	addi	a5,s0,-48
    80200aa4:	78058593          	addi	a1,a1,1920 # fffffffffffff780 <ebss+0xffffffff7fc35780>
    80200aa8:	95be                	add	a1,a1,a5
    80200aaa:	854e                	mv	a0,s3
    80200aac:	00001097          	auipc	ra,0x1
    80200ab0:	2d0080e7          	jalr	720(ra) # 80201d7c <copy_mem_set>
    80200ab4:	b1843603          	ld	a2,-1256(s0)
    80200ab8:	98843a03          	ld	s4,-1656(s0)
    struct task_context clone_task_context = target_tcb.task_context;
    80200abc:	91040793          	addi	a5,s0,-1776
    80200ac0:	d7840713          	addi	a4,s0,-648
    80200ac4:	0004b883          	ld	a7,0(s1)
    80200ac8:	0084b803          	ld	a6,8(s1)
    80200acc:	6888                	ld	a0,16(s1)
    80200ace:	6c8c                	ld	a1,24(s1)
    80200ad0:	7094                	ld	a3,32(s1)
    80200ad2:	0117b023          	sd	a7,0(a5)
    80200ad6:	0107b423          	sd	a6,8(a5)
    80200ada:	eb88                	sd	a0,16(a5)
    80200adc:	ef8c                	sd	a1,24(a5)
    80200ade:	f394                	sd	a3,32(a5)
    80200ae0:	02848493          	addi	s1,s1,40
    80200ae4:	02878793          	addi	a5,a5,40
    80200ae8:	fce49ee3          	bne	s1,a4,80200ac4 <tcb_clone+0xd2>

    uint64 kernel_stack_top = clone_mem_set.Kernel_Stack.end_addr;
    struct task_control_block clone_tcb = new_task_control_block(clone_task_context,  kernel_stack_top);
    80200aec:	fd040713          	addi	a4,s0,-48
    80200af0:	77fd                	lui	a5,0xfffff
    80200af2:	76fd                	lui	a3,0xfffff
    80200af4:	97ba                	add	a5,a5,a4
    80200af6:	47868713          	addi	a4,a3,1144 # fffffffffffff478 <ebss+0xffffffff7fc35478>
    80200afa:	9722                	add	a4,a4,s0
    80200afc:	e31c                	sd	a5,0(a4)
    80200afe:	631c                	ld	a5,0(a4)
    80200b00:	91040493          	addi	s1,s0,-1776
    80200b04:	70078793          	addi	a5,a5,1792 # fffffffffffff700 <ebss+0xffffffff7fc35700>
    80200b08:	0004b803          	ld	a6,0(s1)
    80200b0c:	6488                	ld	a0,8(s1)
    80200b0e:	688c                	ld	a1,16(s1)
    80200b10:	6c94                	ld	a3,24(s1)
    80200b12:	7098                	ld	a4,32(s1)
    80200b14:	0107b023          	sd	a6,0(a5)
    80200b18:	e788                	sd	a0,8(a5)
    80200b1a:	eb8c                	sd	a1,16(a5)
    80200b1c:	ef94                	sd	a3,24(a5)
    80200b1e:	f398                	sd	a4,32(a5)
    80200b20:	02848493          	addi	s1,s1,40
    80200b24:	02878793          	addi	a5,a5,40
    80200b28:	ff3490e3          	bne	s1,s3,80200b08 <tcb_clone+0x116>
    80200b2c:	75fd                	lui	a1,0xfffff
    80200b2e:	fd040793          	addi	a5,s0,-48
    80200b32:	70058593          	addi	a1,a1,1792 # fffffffffffff700 <ebss+0xffffffff7fc35700>
    80200b36:	95be                	add	a1,a1,a5
    80200b38:	d8840513          	addi	a0,s0,-632
    80200b3c:	00000097          	auipc	ra,0x0
    80200b40:	5e6080e7          	jalr	1510(ra) # 80201122 <new_task_control_block>
    clone_tcb.memoryset = clone_mem_set;
    80200b44:	d9040793          	addi	a5,s0,-624
    80200b48:	6088                	ld	a0,0(s1)
    80200b4a:	648c                	ld	a1,8(s1)
    80200b4c:	6890                	ld	a2,16(s1)
    80200b4e:	6c94                	ld	a3,24(s1)
    80200b50:	7098                	ld	a4,32(s1)
    80200b52:	e388                	sd	a0,0(a5)
    80200b54:	e78c                	sd	a1,8(a5)
    80200b56:	eb90                	sd	a2,16(a5)
    80200b58:	ef94                	sd	a3,24(a5)
    80200b5a:	f398                	sd	a4,32(a5)
    80200b5c:	02848493          	addi	s1,s1,40
    80200b60:	02878793          	addi	a5,a5,40
    80200b64:	ff2492e3          	bne	s1,s2,80200b48 <tcb_clone+0x156>
    clone_tcb.user_token = root_ppn_to_token(clone_mem_set.page_table.root_ppn);
    80200b68:	8552                	mv	a0,s4
    80200b6a:	00001097          	auipc	ra,0x1
    80200b6e:	1de080e7          	jalr	478(ra) # 80201d48 <root_ppn_to_token>
    add_task_control_block(clone_tcb);
    80200b72:	fd040693          	addi	a3,s0,-48
    80200b76:	777d                	lui	a4,0xfffff
    80200b78:	767d                	lui	a2,0xfffff
    80200b7a:	9736                	add	a4,a4,a3
    80200b7c:	47860693          	addi	a3,a2,1144 # fffffffffffff478 <ebss+0xffffffff7fc35478>
    80200b80:	96a2                	add	a3,a3,s0
    80200b82:	e298                	sd	a4,0(a3)
    80200b84:	6298                	ld	a4,0(a3)
    clone_tcb.user_token = root_ppn_to_token(clone_mem_set.page_table.root_ppn);
    80200b86:	d8a43423          	sd	a0,-632(s0)
    add_task_control_block(clone_tcb);
    80200b8a:	d8840793          	addi	a5,s0,-632
    80200b8e:	4b070713          	addi	a4,a4,1200 # fffffffffffff4b0 <ebss+0xffffffff7fc354b0>
    80200b92:	fc840693          	addi	a3,s0,-56
    80200b96:	0007b803          	ld	a6,0(a5)
    80200b9a:	6788                	ld	a0,8(a5)
    80200b9c:	6b8c                	ld	a1,16(a5)
    80200b9e:	6f90                	ld	a2,24(a5)
    80200ba0:	01073023          	sd	a6,0(a4)
    80200ba4:	e708                	sd	a0,8(a4)
    80200ba6:	eb0c                	sd	a1,16(a4)
    80200ba8:	ef10                	sd	a2,24(a4)
    80200baa:	02078793          	addi	a5,a5,32
    80200bae:	02070713          	addi	a4,a4,32
    80200bb2:	fed792e3          	bne	a5,a3,80200b96 <tcb_clone+0x1a4>
    80200bb6:	639c                	ld	a5,0(a5)
    80200bb8:	757d                	lui	a0,0xfffff
    80200bba:	fd040693          	addi	a3,s0,-48
    80200bbe:	4b050513          	addi	a0,a0,1200 # fffffffffffff4b0 <ebss+0xffffffff7fc354b0>
    80200bc2:	9536                	add	a0,a0,a3
    80200bc4:	e31c                	sd	a5,0(a4)
    80200bc6:	00000097          	auipc	ra,0x0
    80200bca:	68e080e7          	jalr	1678(ra) # 80201254 <add_task_control_block>

    return clone_tcb.pid;

}
    80200bce:	fc843503          	ld	a0,-56(s0)
    80200bd2:	3a010113          	addi	sp,sp,928
    80200bd6:	7e813083          	ld	ra,2024(sp)
    80200bda:	7e013403          	ld	s0,2016(sp)
    80200bde:	7d813483          	ld	s1,2008(sp)
    80200be2:	7d013903          	ld	s2,2000(sp)
    80200be6:	7c813983          	ld	s3,1992(sp)
    80200bea:	7c013a03          	ld	s4,1984(sp)
    80200bee:	7f010113          	addi	sp,sp,2032
    80200bf2:	8082                	ret

0000000080200bf4 <initframe>:
#include "console.h"

extern uint32 ekernel;


void initframe(){
    80200bf4:	1141                	addi	sp,sp,-16
    80200bf6:	e422                	sd	s0,8(sp)
  uint32  kernel_end = &ekernel;
    80200bf8:	001c9797          	auipc	a5,0x1c9
    80200bfc:	40878793          	addi	a5,a5,1032 # 803ca000 <ebss>
void initframe(){
    80200c00:	0800                	addi	s0,sp,16
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
    80200c02:	7fe006b7          	lui	a3,0x7fe00
    80200c06:	9ebd                	addw	a3,a3,a5
  uint32 remain =  (kernel_end - BASE_ADDRESS) % PAGE_SIZE;
    80200c08:	17d2                	slli	a5,a5,0x34
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
    80200c0a:	00c6d71b          	srliw	a4,a3,0xc
    80200c0e:	00c6d69b          	srliw	a3,a3,0xc
  if (remain > 0) kernel_frame++;
    80200c12:	c399                	beqz	a5,80200c18 <initframe+0x24>
    80200c14:	0017069b          	addiw	a3,a4,1
  uint32 kernel_bit_end = kernel_frame / 8;
    80200c18:	0036d61b          	srliw	a2,a3,0x3
    80200c1c:	0036d59b          	srliw	a1,a3,0x3
  uint32 kernel_bit_offset = kernel_frame % 8;
    80200c20:	0076f813          	andi	a6,a3,7

  for (uint32 i = 0; i < kernel_bit_end; i++){
    80200c24:	001a3517          	auipc	a0,0x1a3
    80200c28:	3dc50513          	addi	a0,a0,988 # 803a4000 <bitmap>
    80200c2c:	c60d                	beqz	a2,80200c56 <initframe+0x62>
    80200c2e:	fff5871b          	addiw	a4,a1,-1
    80200c32:	1702                	slli	a4,a4,0x20
    80200c34:	001a3617          	auipc	a2,0x1a3
    80200c38:	3cd60613          	addi	a2,a2,973 # 803a4001 <bitmap+0x1>
    80200c3c:	001a3517          	auipc	a0,0x1a3
    80200c40:	3c450513          	addi	a0,a0,964 # 803a4000 <bitmap>
    80200c44:	9301                	srli	a4,a4,0x20
    80200c46:	9732                	add	a4,a4,a2
    80200c48:	87aa                	mv	a5,a0
    bitmap[i] = 255; // 0x11111111
    80200c4a:	567d                	li	a2,-1
    80200c4c:	00c78023          	sb	a2,0(a5)
  for (uint32 i = 0; i < kernel_bit_end; i++){
    80200c50:	0785                	addi	a5,a5,1
    80200c52:	fee79de3          	bne	a5,a4,80200c4c <initframe+0x58>
  }
  bitmap[kernel_bit_end] = (uint8)(255 >> (8-kernel_bit_offset)); // 0x11111111 >> kernel_bit_offset
    80200c56:	47a1                	li	a5,8
    80200c58:	1582                	slli	a1,a1,0x20
    80200c5a:	4107873b          	subw	a4,a5,a6
    80200c5e:	9181                	srli	a1,a1,0x20
    80200c60:	0ff00793          	li	a5,255
    80200c64:	40e7d7bb          	sraw	a5,a5,a4
    80200c68:	95aa                	add	a1,a1,a0
    80200c6a:	00f58023          	sb	a5,0(a1)
  Isinit = 1;
  kernel_frame_end = kernel_frame;
}
    80200c6e:	6422                	ld	s0,8(sp)
  Isinit = 1;
    80200c70:	4785                	li	a5,1
    80200c72:	001c9717          	auipc	a4,0x1c9
    80200c76:	9cf70523          	sb	a5,-1590(a4) # 803c963c <Isinit>
  kernel_frame_end = kernel_frame;
    80200c7a:	001c9797          	auipc	a5,0x1c9
    80200c7e:	9ad7af23          	sw	a3,-1602(a5) # 803c9638 <kernel_frame_end>
}
    80200c82:	0141                	addi	sp,sp,16
    80200c84:	8082                	ret

0000000080200c86 <If_bitmap_is_set>:

uint32 If_bitmap_is_set(uint32 frame_number){
    80200c86:	1141                	addi	sp,sp,-16
    80200c88:	e422                	sd	s0,8(sp)
    uint32 byte_number = frame_number / 8;
    uint32 bit_number = frame_number % 8;
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200c8a:	0035571b          	srliw	a4,a0,0x3
uint32 If_bitmap_is_set(uint32 frame_number){
    80200c8e:	0800                	addi	s0,sp,16
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200c90:	001a3797          	auipc	a5,0x1a3
    80200c94:	37078793          	addi	a5,a5,880 # 803a4000 <bitmap>
    80200c98:	97ba                	add	a5,a5,a4
    80200c9a:	0007c783          	lbu	a5,0(a5)
}
    80200c9e:	6422                	ld	s0,8(sp)
    uint32 bit_number = frame_number % 8;
    80200ca0:	891d                	andi	a0,a0,7
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200ca2:	40a7d53b          	sraw	a0,a5,a0
}
    80200ca6:	8905                	andi	a0,a0,1
    80200ca8:	0141                	addi	sp,sp,16
    80200caa:	8082                	ret

0000000080200cac <get_frame>:

uint32 get_frame(){
    80200cac:	1141                	addi	sp,sp,-16
    80200cae:	e422                	sd	s0,8(sp)
    80200cb0:	0800                	addi	s0,sp,16
  if (!Isinit){
    80200cb2:	001c9897          	auipc	a7,0x1c9
    80200cb6:	98a88893          	addi	a7,a7,-1654 # 803c963c <Isinit>
    80200cba:	0008c783          	lbu	a5,0(a7)
    80200cbe:	cfbd                	beqz	a5,80200d3c <get_frame+0x90>
    80200cc0:	001c9517          	auipc	a0,0x1c9
    80200cc4:	97852503          	lw	a0,-1672(a0) # 803c9638 <kernel_frame_end>
    80200cc8:	2505                	addiw	a0,a0,1
    initframe();
  }
  uint32 start_free_frame = kernel_frame_end + 1; // protection of kernel

  // search for valid free frame
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    80200cca:	7ff00793          	li	a5,2047
    80200cce:	0ea7ef63          	bltu	a5,a0,80200dcc <get_frame+0x120>
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200cd2:	001a3617          	auipc	a2,0x1a3
    80200cd6:	32e60613          	addi	a2,a2,814 # 803a4000 <bitmap>
    80200cda:	0035579b          	srliw	a5,a0,0x3
    80200cde:	97b2                	add	a5,a5,a2
    80200ce0:	0007c703          	lbu	a4,0(a5)
    uint32 bit_number = frame_number % 8;
    80200ce4:	00757693          	andi	a3,a0,7
    uint32 byte_number = frame_number / 8;
    80200ce8:	0035579b          	srliw	a5,a0,0x3
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200cec:	40d755bb          	sraw	a1,a4,a3
    if (If_bitmap_is_set(index)) {
    80200cf0:	8985                	andi	a1,a1,1
    80200cf2:	e185                	bnez	a1,80200d12 <get_frame+0x66>
      continue;
    } else {
      // update the frame
      uint32 byte_number = index / 8;
      uint32 bit_number = index % 8;
      bitmap[byte_number] |= (1 << bit_number);
    80200cf4:	4585                	li	a1,1
    80200cf6:	00d596bb          	sllw	a3,a1,a3
    80200cfa:	97b2                	add	a5,a5,a2
    80200cfc:	8f55                	or	a4,a4,a3
    80200cfe:	00e78023          	sb	a4,0(a5)
      return index + (0x80200000 / 4096);
    }
  }

  return -1; // invalid
}
    80200d02:	6422                	ld	s0,8(sp)
      return index + (0x80200000 / 4096);
    80200d04:	000807b7          	lui	a5,0x80
    80200d08:	2007879b          	addiw	a5,a5,512
    80200d0c:	9d3d                	addw	a0,a0,a5
}
    80200d0e:	0141                	addi	sp,sp,16
    80200d10:	8082                	ret
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    80200d12:	0015079b          	addiw	a5,a0,1
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200d16:	0037d71b          	srliw	a4,a5,0x3
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    80200d1a:	8007859b          	addiw	a1,a5,-2048
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200d1e:	9732                	add	a4,a4,a2
    uint32 bit_number = frame_number % 8;
    80200d20:	0077f693          	andi	a3,a5,7
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    80200d24:	0007851b          	sext.w	a0,a5
    80200d28:	c1d5                	beqz	a1,80200dcc <get_frame+0x120>
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200d2a:	00074703          	lbu	a4,0(a4)
    uint32 byte_number = frame_number / 8;
    80200d2e:	0037d79b          	srliw	a5,a5,0x3
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200d32:	40d755bb          	sraw	a1,a4,a3
    if (If_bitmap_is_set(index)) {
    80200d36:	8985                	andi	a1,a1,1
    80200d38:	ddd5                	beqz	a1,80200cf4 <get_frame+0x48>
    80200d3a:	bfe1                	j	80200d12 <get_frame+0x66>
  uint32  kernel_end = &ekernel;
    80200d3c:	001c9797          	auipc	a5,0x1c9
    80200d40:	2c478793          	addi	a5,a5,708 # 803ca000 <ebss>
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
    80200d44:	7fe006b7          	lui	a3,0x7fe00
    80200d48:	9ebd                	addw	a3,a3,a5
    80200d4a:	00c6d71b          	srliw	a4,a3,0xc
  uint32 remain =  (kernel_end - BASE_ADDRESS) % PAGE_SIZE;
    80200d4e:	17d2                	slli	a5,a5,0x34
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
    80200d50:	00c6d69b          	srliw	a3,a3,0xc
  if (remain > 0) kernel_frame++;
    80200d54:	0017051b          	addiw	a0,a4,1
    80200d58:	c781                	beqz	a5,80200d60 <get_frame+0xb4>
    80200d5a:	86aa                	mv	a3,a0
    80200d5c:	0027051b          	addiw	a0,a4,2
  uint32 kernel_bit_end = kernel_frame / 8;
    80200d60:	0036d79b          	srliw	a5,a3,0x3
    80200d64:	0036d81b          	srliw	a6,a3,0x3
  uint32 kernel_bit_offset = kernel_frame % 8;
    80200d68:	0076f313          	andi	t1,a3,7
  for (uint32 i = 0; i < kernel_bit_end; i++){
    80200d6c:	cbb9                	beqz	a5,80200dc2 <get_frame+0x116>
    80200d6e:	fff8071b          	addiw	a4,a6,-1
    80200d72:	02071593          	slli	a1,a4,0x20
    80200d76:	9181                	srli	a1,a1,0x20
    80200d78:	001a3617          	auipc	a2,0x1a3
    80200d7c:	28860613          	addi	a2,a2,648 # 803a4000 <bitmap>
    80200d80:	001a3717          	auipc	a4,0x1a3
    80200d84:	28170713          	addi	a4,a4,641 # 803a4001 <bitmap+0x1>
    80200d88:	972e                	add	a4,a4,a1
    80200d8a:	87b2                	mv	a5,a2
    bitmap[i] = 255; // 0x11111111
    80200d8c:	55fd                	li	a1,-1
    80200d8e:	00b78023          	sb	a1,0(a5)
  for (uint32 i = 0; i < kernel_bit_end; i++){
    80200d92:	0785                	addi	a5,a5,1
    80200d94:	fef71de3          	bne	a4,a5,80200d8e <get_frame+0xe2>
  bitmap[kernel_bit_end] = (uint8)(255 >> (8-kernel_bit_offset)); // 0x11111111 >> kernel_bit_offset
    80200d98:	4721                	li	a4,8
    80200d9a:	02081793          	slli	a5,a6,0x20
    80200d9e:	406705bb          	subw	a1,a4,t1
    80200da2:	9381                	srli	a5,a5,0x20
    80200da4:	0ff00713          	li	a4,255
    80200da8:	97b2                	add	a5,a5,a2
    80200daa:	40b7573b          	sraw	a4,a4,a1
    80200dae:	00e78023          	sb	a4,0(a5)
  Isinit = 1;
    80200db2:	4785                	li	a5,1
    80200db4:	00f88023          	sb	a5,0(a7)
  kernel_frame_end = kernel_frame;
    80200db8:	001c9797          	auipc	a5,0x1c9
    80200dbc:	88d7a023          	sw	a3,-1920(a5) # 803c9638 <kernel_frame_end>
}
    80200dc0:	b729                	j	80200cca <get_frame+0x1e>
    80200dc2:	001a3617          	auipc	a2,0x1a3
    80200dc6:	23e60613          	addi	a2,a2,574 # 803a4000 <bitmap>
    80200dca:	b7f9                	j	80200d98 <get_frame+0xec>
}
    80200dcc:	6422                	ld	s0,8(sp)
  return -1; // invalid
    80200dce:	557d                	li	a0,-1
}
    80200dd0:	0141                	addi	sp,sp,16
    80200dd2:	8082                	ret

0000000080200dd4 <free_frame>:

void free_frame(uint32 frame_number){
    80200dd4:	1141                	addi	sp,sp,-16
  frame_number = frame_number-0x80200000/4096;
    80200dd6:	fff80637          	lui	a2,0xfff80
void free_frame(uint32 frame_number){
    80200dda:	e422                	sd	s0,8(sp)
  for (uint32 index = 0; index < PAGE_SIZE; index+=32) {
    uint32 * addr = (uint32*)(BASE_ADDRESS + frame_number * PAGE_SIZE + index);
    80200ddc:	00c5179b          	slliw	a5,a0,0xc
void free_frame(uint32 frame_number){
    80200de0:	0800                	addi	s0,sp,16
  frame_number = frame_number-0x80200000/4096;
    80200de2:	e006061b          	addiw	a2,a2,-512
    80200de6:	6685                	lui	a3,0x1
    80200de8:	9e29                	addw	a2,a2,a0
  for (uint32 index = 0; index < PAGE_SIZE; index+=32) {
    80200dea:	9ebd                	addw	a3,a3,a5
    uint32 * addr = (uint32*)(BASE_ADDRESS + frame_number * PAGE_SIZE + index);
    80200dec:	02079713          	slli	a4,a5,0x20
    80200df0:	9301                	srli	a4,a4,0x20
    *addr = 0;
    80200df2:	00072023          	sw	zero,0(a4)
  for (uint32 index = 0; index < PAGE_SIZE; index+=32) {
    80200df6:	0207879b          	addiw	a5,a5,32
    80200dfa:	fef699e3          	bne	a3,a5,80200dec <free_frame+0x18>
  }
  // modify the bitmap
  uint32 byte_number = frame_number / 8;
  uint32 bit_number = frame_number % 8;
  bitmap[byte_number] &= ~(1 << bit_number);
    80200dfe:	0036579b          	srliw	a5,a2,0x3
    80200e02:	001a3717          	auipc	a4,0x1a3
    80200e06:	1fe70713          	addi	a4,a4,510 # 803a4000 <bitmap>
    80200e0a:	973e                	add	a4,a4,a5
    80200e0c:	00074683          	lbu	a3,0(a4)
  uint32 bit_number = frame_number % 8;
    80200e10:	8a1d                	andi	a2,a2,7
  bitmap[byte_number] &= ~(1 << bit_number);
    80200e12:	4785                	li	a5,1
    80200e14:	00c797bb          	sllw	a5,a5,a2
    80200e18:	fff7c793          	not	a5,a5
    80200e1c:	8ff5                	and	a5,a5,a3
    80200e1e:	00f70023          	sb	a5,0(a4)
}
    80200e22:	6422                	ld	s0,8(sp)
    80200e24:	0141                	addi	sp,sp,16
    80200e26:	8082                	ret

0000000080200e28 <sys_exit>:
        printf("[kernel] Not supported system call: %d\n", type);
    }
    return 0;
}

void sys_exit(uint64 exit_code){
    80200e28:	1101                	addi	sp,sp,-32
    80200e2a:	ec06                	sd	ra,24(sp)
    80200e2c:	e822                	sd	s0,16(sp)
    80200e2e:	e426                	sd	s1,8(sp)
    80200e30:	1000                	addi	s0,sp,32
    80200e32:	85aa                	mv	a1,a0
    printf("[kernel] The application end with exit code: %d\n", exit_code);
    80200e34:	00002517          	auipc	a0,0x2
    80200e38:	31c50513          	addi	a0,a0,796 # 80203150 <digits+0xb8>
    80200e3c:	fffff097          	auipc	ra,0xfffff
    80200e40:	2de080e7          	jalr	734(ra) # 8020011a <printf>
    free_task_control_block(TASK_MANAGER.processing_tcb.pid);
    80200e44:	001a6497          	auipc	s1,0x1a6
    80200e48:	30c48493          	addi	s1,s1,780 # 803a7150 <heap+0x10>
    80200e4c:	fe04a503          	lw	a0,-32(s1)
    80200e50:	00000097          	auipc	ra,0x0
    80200e54:	49e080e7          	jalr	1182(ra) # 802012ee <free_task_control_block>

    if (TASK_MANAGER.number_of_apps > 0){
    80200e58:	fe84b783          	ld	a5,-24(s1)
    80200e5c:	cb91                	beqz	a5,80200e70 <sys_exit+0x48>

    }else{
        panic("finish running all the apps!\n");
    }

}
    80200e5e:	6442                	ld	s0,16(sp)
    80200e60:	60e2                	ld	ra,24(sp)
    80200e62:	64a2                	ld	s1,8(sp)
        run_next_app(0);
    80200e64:	4501                	li	a0,0
}
    80200e66:	6105                	addi	sp,sp,32
        run_next_app(0);
    80200e68:	00000317          	auipc	t1,0x0
    80200e6c:	ad430067          	jr	-1324(t1) # 8020093c <run_next_app>
}
    80200e70:	6442                	ld	s0,16(sp)
    80200e72:	60e2                	ld	ra,24(sp)
    80200e74:	64a2                	ld	s1,8(sp)
        panic("finish running all the apps!\n");
    80200e76:	00002517          	auipc	a0,0x2
    80200e7a:	31250513          	addi	a0,a0,786 # 80203188 <digits+0xf0>
}
    80200e7e:	6105                	addi	sp,sp,32
        panic("finish running all the apps!\n");
    80200e80:	fffff317          	auipc	t1,0xfffff
    80200e84:	42e30067          	jr	1070(t1) # 802002ae <panic>

0000000080200e88 <syscall>:
uint64 syscall(uint64 type, uint64 args[3]){
    80200e88:	1101                	addi	sp,sp,-32
    80200e8a:	e822                	sd	s0,16(sp)
    80200e8c:	e426                	sd	s1,8(sp)
    80200e8e:	ec06                	sd	ra,24(sp)
    80200e90:	e04a                	sd	s2,0(sp)
    80200e92:	1000                	addi	s0,sp,32
    if (type == SYSCALL_WRITE){
    80200e94:	04000793          	li	a5,64
uint64 syscall(uint64 type, uint64 args[3]){
    80200e98:	84ae                	mv	s1,a1
    if (type == SYSCALL_WRITE){
    80200e9a:	04f50263          	beq	a0,a5,80200ede <syscall+0x56>
    else if (type == SYSCALL_EXIT){
    80200e9e:	05d00793          	li	a5,93
    80200ea2:	08f50c63          	beq	a0,a5,80200f3a <syscall+0xb2>
    else if (type == SYSCALL_YIELD){
    80200ea6:	07c00793          	li	a5,124
    80200eaa:	0af50463          	beq	a0,a5,80200f52 <syscall+0xca>
    else if (type == SYSCALL_GET_TIME){
    80200eae:	0a900793          	li	a5,169
    80200eb2:	06f50663          	beq	a0,a5,80200f1e <syscall+0x96>
    else if (type == SYSCALL_FORK){
    80200eb6:	0dc00793          	li	a5,220
    80200eba:	0af50863          	beq	a0,a5,80200f6a <syscall+0xe2>
        printf("[kernel] Not supported system call: %d\n", type);
    80200ebe:	85aa                	mv	a1,a0
    80200ec0:	00002517          	auipc	a0,0x2
    80200ec4:	2e850513          	addi	a0,a0,744 # 802031a8 <digits+0x110>
    80200ec8:	fffff097          	auipc	ra,0xfffff
    80200ecc:	252080e7          	jalr	594(ra) # 8020011a <printf>
}
    80200ed0:	60e2                	ld	ra,24(sp)
    80200ed2:	6442                	ld	s0,16(sp)
    80200ed4:	64a2                	ld	s1,8(sp)
    80200ed6:	6902                	ld	s2,0(sp)
    return 0;
    80200ed8:	4501                	li	a0,0
}
    80200eda:	6105                	addi	sp,sp,32
    80200edc:	8082                	ret
        args[1] = translate(root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn), args[1]);
    80200ede:	001a6517          	auipc	a0,0x1a6
    80200ee2:	01a53503          	ld	a0,26(a0) # 803a6ef8 <TASK_MANAGER+0x2da8>
    80200ee6:	00001097          	auipc	ra,0x1
    80200eea:	e62080e7          	jalr	-414(ra) # 80201d48 <root_ppn_to_token>
    80200eee:	648c                	ld	a1,8(s1)
    80200ef0:	00000097          	auipc	ra,0x0
    80200ef4:	7a4080e7          	jalr	1956(ra) # 80201694 <translate>

uint64 sys_write(uint64 fd, char* buf, uint64 length) {
    if (fd == 1){    // means STDOUT
    80200ef8:	6098                	ld	a4,0(s1)
        args[1] = translate(root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn), args[1]);
    80200efa:	e488                	sd	a0,8(s1)
    if (fd == 1){    // means STDOUT
    80200efc:	4785                	li	a5,1
        args[1] = translate(root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn), args[1]);
    80200efe:	892a                	mv	s2,a0
    if (fd == 1){    // means STDOUT
    80200f00:	fcf718e3          	bne	a4,a5,80200ed0 <syscall+0x48>
        sys_write(args[0], args[1], args[2]);
    80200f04:	6884                	ld	s1,16(s1)
        for (int i = 0; i < length; i++){
    80200f06:	d4e9                	beqz	s1,80200ed0 <syscall+0x48>
    80200f08:	94aa                	add	s1,s1,a0
            consputc(buf[i]);
    80200f0a:	00094503          	lbu	a0,0(s2)
    80200f0e:	0905                	addi	s2,s2,1
    80200f10:	fffff097          	auipc	ra,0xfffff
    80200f14:	1d4080e7          	jalr	468(ra) # 802000e4 <consputc>
        for (int i = 0; i < length; i++){
    80200f18:	ff2499e3          	bne	s1,s2,80200f0a <syscall+0x82>
    80200f1c:	bf55                	j	80200ed0 <syscall+0x48>
    80200f1e:	c0102573          	rdtime	a0
}
    80200f22:	60e2                	ld	ra,24(sp)
    80200f24:	6442                	ld	s0,16(sp)
        return r_time() / 10000000;
    80200f26:	009897b7          	lui	a5,0x989
    80200f2a:	68078793          	addi	a5,a5,1664 # 989680 <n+0x989660>
}
    80200f2e:	64a2                	ld	s1,8(sp)
    80200f30:	6902                	ld	s2,0(sp)
        return r_time() / 10000000;
    80200f32:	02f55533          	divu	a0,a0,a5
}
    80200f36:	6105                	addi	sp,sp,32
    80200f38:	8082                	ret
        sys_exit(args[0]);
    80200f3a:	6188                	ld	a0,0(a1)
    80200f3c:	00000097          	auipc	ra,0x0
    80200f40:	eec080e7          	jalr	-276(ra) # 80200e28 <sys_exit>
}
    80200f44:	60e2                	ld	ra,24(sp)
    80200f46:	6442                	ld	s0,16(sp)
    80200f48:	64a2                	ld	s1,8(sp)
    80200f4a:	6902                	ld	s2,0(sp)
    return 0;
    80200f4c:	4501                	li	a0,0
}
    80200f4e:	6105                	addi	sp,sp,32
    80200f50:	8082                	ret
    return length;
}

void sys_yield(){

    run_next_app(0);
    80200f52:	4501                	li	a0,0
    80200f54:	00000097          	auipc	ra,0x0
    80200f58:	9e8080e7          	jalr	-1560(ra) # 8020093c <run_next_app>
}
    80200f5c:	60e2                	ld	ra,24(sp)
    80200f5e:	6442                	ld	s0,16(sp)
    80200f60:	64a2                	ld	s1,8(sp)
    80200f62:	6902                	ld	s2,0(sp)
    return 0;
    80200f64:	4501                	li	a0,0
}
    80200f66:	6105                	addi	sp,sp,32
    80200f68:	8082                	ret
    80200f6a:	6442                	ld	s0,16(sp)
    80200f6c:	60e2                	ld	ra,24(sp)
    80200f6e:	64a2                	ld	s1,8(sp)
    80200f70:	6902                	ld	s2,0(sp)
}


uint64 sys_fork(){

    uint64 pid = tcb_clone(TASK_MANAGER.processing_tcb.pid);
    80200f72:	001a6517          	auipc	a0,0x1a6
    80200f76:	1be53503          	ld	a0,446(a0) # 803a7130 <TASK_MANAGER+0x2fe0>
}
    80200f7a:	6105                	addi	sp,sp,32
    uint64 pid = tcb_clone(TASK_MANAGER.processing_tcb.pid);
    80200f7c:	00000317          	auipc	t1,0x0
    80200f80:	a7630067          	jr	-1418(t1) # 802009f2 <tcb_clone>

0000000080200f84 <sys_write>:
uint64 sys_write(uint64 fd, char* buf, uint64 length) {
    80200f84:	7179                	addi	sp,sp,-48
    80200f86:	f022                	sd	s0,32(sp)
    80200f88:	e84a                	sd	s2,16(sp)
    80200f8a:	f406                	sd	ra,40(sp)
    80200f8c:	ec26                	sd	s1,24(sp)
    80200f8e:	e44e                	sd	s3,8(sp)
    80200f90:	1800                	addi	s0,sp,48
    if (fd == 1){    // means STDOUT
    80200f92:	4785                	li	a5,1
uint64 sys_write(uint64 fd, char* buf, uint64 length) {
    80200f94:	8932                	mv	s2,a2
    if (fd == 1){    // means STDOUT
    80200f96:	00f50a63          	beq	a0,a5,80200faa <sys_write+0x26>
}
    80200f9a:	70a2                	ld	ra,40(sp)
    80200f9c:	7402                	ld	s0,32(sp)
    80200f9e:	64e2                	ld	s1,24(sp)
    80200fa0:	69a2                	ld	s3,8(sp)
    80200fa2:	854a                	mv	a0,s2
    80200fa4:	6942                	ld	s2,16(sp)
    80200fa6:	6145                	addi	sp,sp,48
    80200fa8:	8082                	ret
        for (int i = 0; i < length; i++){
    80200faa:	da65                	beqz	a2,80200f9a <sys_write+0x16>
    80200fac:	84ae                	mv	s1,a1
    80200fae:	00c589b3          	add	s3,a1,a2
            consputc(buf[i]);
    80200fb2:	0004c503          	lbu	a0,0(s1)
    80200fb6:	0485                	addi	s1,s1,1
    80200fb8:	fffff097          	auipc	ra,0xfffff
    80200fbc:	12c080e7          	jalr	300(ra) # 802000e4 <consputc>
        for (int i = 0; i < length; i++){
    80200fc0:	ff3499e3          	bne	s1,s3,80200fb2 <sys_write+0x2e>
}
    80200fc4:	70a2                	ld	ra,40(sp)
    80200fc6:	7402                	ld	s0,32(sp)
    80200fc8:	64e2                	ld	s1,24(sp)
    80200fca:	69a2                	ld	s3,8(sp)
    80200fcc:	854a                	mv	a0,s2
    80200fce:	6942                	ld	s2,16(sp)
    80200fd0:	6145                	addi	sp,sp,48
    80200fd2:	8082                	ret

0000000080200fd4 <sys_yield>:
void sys_yield(){
    80200fd4:	1141                	addi	sp,sp,-16
    80200fd6:	e422                	sd	s0,8(sp)
    80200fd8:	0800                	addi	s0,sp,16
}
    80200fda:	6422                	ld	s0,8(sp)
    run_next_app(0);
    80200fdc:	4501                	li	a0,0
}
    80200fde:	0141                	addi	sp,sp,16
    run_next_app(0);
    80200fe0:	00000317          	auipc	t1,0x0
    80200fe4:	95c30067          	jr	-1700(t1) # 8020093c <run_next_app>

0000000080200fe8 <sys_fork>:
uint64 sys_fork(){
    80200fe8:	1141                	addi	sp,sp,-16
    80200fea:	e422                	sd	s0,8(sp)
    80200fec:	0800                	addi	s0,sp,16

    return pid;

}
    80200fee:	6422                	ld	s0,8(sp)
    uint64 pid = tcb_clone(TASK_MANAGER.processing_tcb.pid);
    80200ff0:	001a6517          	auipc	a0,0x1a6
    80200ff4:	14053503          	ld	a0,320(a0) # 803a7130 <TASK_MANAGER+0x2fe0>
}
    80200ff8:	0141                	addi	sp,sp,16
    uint64 pid = tcb_clone(TASK_MANAGER.processing_tcb.pid);
    80200ffa:	00000317          	auipc	t1,0x0
    80200ffe:	9f830067          	jr	-1544(t1) # 802009f2 <tcb_clone>
	...

0000000080201004 <__alltraps>:
    80201004:	14011173          	csrrw	sp,sscratch,sp
    80201008:	e406                	sd	ra,8(sp)
    8020100a:	ec0e                	sd	gp,24(sp)
    8020100c:	f416                	sd	t0,40(sp)
    8020100e:	f81a                	sd	t1,48(sp)
    80201010:	fc1e                	sd	t2,56(sp)
    80201012:	e0a2                	sd	s0,64(sp)
    80201014:	e4a6                	sd	s1,72(sp)
    80201016:	e8aa                	sd	a0,80(sp)
    80201018:	ecae                	sd	a1,88(sp)
    8020101a:	f0b2                	sd	a2,96(sp)
    8020101c:	f4b6                	sd	a3,104(sp)
    8020101e:	f8ba                	sd	a4,112(sp)
    80201020:	fcbe                	sd	a5,120(sp)
    80201022:	e142                	sd	a6,128(sp)
    80201024:	e546                	sd	a7,136(sp)
    80201026:	e94a                	sd	s2,144(sp)
    80201028:	ed4e                	sd	s3,152(sp)
    8020102a:	f152                	sd	s4,160(sp)
    8020102c:	f556                	sd	s5,168(sp)
    8020102e:	f95a                	sd	s6,176(sp)
    80201030:	fd5e                	sd	s7,184(sp)
    80201032:	e1e2                	sd	s8,192(sp)
    80201034:	e5e6                	sd	s9,200(sp)
    80201036:	e9ea                	sd	s10,208(sp)
    80201038:	edee                	sd	s11,216(sp)
    8020103a:	f1f2                	sd	t3,224(sp)
    8020103c:	f5f6                	sd	t4,232(sp)
    8020103e:	f9fa                	sd	t5,240(sp)
    80201040:	fdfe                	sd	t6,248(sp)
    80201042:	100022f3          	csrr	t0,sstatus
    80201046:	14102373          	csrr	t1,sepc
    8020104a:	0311                	addi	t1,t1,4
    8020104c:	f216                	sd	t0,288(sp)
    8020104e:	e21a                	sd	t1,256(sp)
    80201050:	140023f3          	csrr	t2,sscratch
    80201054:	e81e                	sd	t2,16(sp)
    80201056:	62b2                	ld	t0,264(sp)
    80201058:	6352                	ld	t1,272(sp)
    8020105a:	6172                	ld	sp,280(sp)
    8020105c:	18029073          	csrw	satp,t0
    80201060:	12000073          	sfence.vma
    80201064:	8302                	jr	t1

0000000080201066 <__restore>:
    80201066:	0000100f          	fence.i
    8020106a:	18059073          	csrw	satp,a1
    8020106e:	12000073          	sfence.vma
    80201072:	14051073          	csrw	sscratch,a0
    80201076:	812a                	mv	sp,a0
    80201078:	7292                	ld	t0,288(sp)
    8020107a:	6312                	ld	t1,256(sp)
    8020107c:	10029073          	csrw	sstatus,t0
    80201080:	14131073          	csrw	sepc,t1
    80201084:	60a2                	ld	ra,8(sp)
    80201086:	61e2                	ld	gp,24(sp)
    80201088:	72a2                	ld	t0,40(sp)
    8020108a:	7342                	ld	t1,48(sp)
    8020108c:	73e2                	ld	t2,56(sp)
    8020108e:	6406                	ld	s0,64(sp)
    80201090:	64a6                	ld	s1,72(sp)
    80201092:	6546                	ld	a0,80(sp)
    80201094:	65e6                	ld	a1,88(sp)
    80201096:	7606                	ld	a2,96(sp)
    80201098:	76a6                	ld	a3,104(sp)
    8020109a:	7746                	ld	a4,112(sp)
    8020109c:	77e6                	ld	a5,120(sp)
    8020109e:	680a                	ld	a6,128(sp)
    802010a0:	68aa                	ld	a7,136(sp)
    802010a2:	694a                	ld	s2,144(sp)
    802010a4:	69ea                	ld	s3,152(sp)
    802010a6:	7a0a                	ld	s4,160(sp)
    802010a8:	7aaa                	ld	s5,168(sp)
    802010aa:	7b4a                	ld	s6,176(sp)
    802010ac:	7bea                	ld	s7,184(sp)
    802010ae:	6c0e                	ld	s8,192(sp)
    802010b0:	6cae                	ld	s9,200(sp)
    802010b2:	6d4e                	ld	s10,208(sp)
    802010b4:	6dee                	ld	s11,216(sp)
    802010b6:	7e0e                	ld	t3,224(sp)
    802010b8:	7eae                	ld	t4,232(sp)
    802010ba:	7f4e                	ld	t5,240(sp)
    802010bc:	7fee                	ld	t6,248(sp)
    802010be:	6142                	ld	sp,16(sp)
    802010c0:	10200073          	sret
	...

00000000802010c6 <new_task_cx>:

#include "task_context.h"
#include "types.h"


struct task_context new_task_cx(uint64 app_entry, uint64 app_sp, uint64 app_satp){
    802010c6:	7175                	addi	sp,sp,-144
    802010c8:	e522                	sd	s0,136(sp)
    802010ca:	0900                	addi	s0,sp,144
    802010cc:	f9040793          	addi	a5,s0,-112
    802010d0:	ff040713          	addi	a4,s0,-16
    struct task_context new_task_context;

    for (int i = 0; i < 12; i++){
        new_task_context.general_register[i] = 0;
    802010d4:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 12; i++){
    802010d8:	07a1                	addi	a5,a5,8
    802010da:	fee79de3          	bne	a5,a4,802010d4 <new_task_cx+0xe>
    new_task_context.ra = app_entry;
    new_task_context.sp = app_sp;
    new_task_context.satp = app_satp;


    return new_task_context;
    802010de:	f6b43c23          	sd	a1,-136(s0)
    802010e2:	f8c43023          	sd	a2,-128(s0)
    802010e6:	f8d43423          	sd	a3,-120(s0)
    802010ea:	f7840793          	addi	a5,s0,-136
    802010ee:	872a                	mv	a4,a0
    802010f0:	ff040313          	addi	t1,s0,-16
    802010f4:	0007b883          	ld	a7,0(a5)
    802010f8:	0087b803          	ld	a6,8(a5)
    802010fc:	6b8c                	ld	a1,16(a5)
    802010fe:	6f90                	ld	a2,24(a5)
    80201100:	7394                	ld	a3,32(a5)
    80201102:	01173023          	sd	a7,0(a4)
    80201106:	01073423          	sd	a6,8(a4)
    8020110a:	eb0c                	sd	a1,16(a4)
    8020110c:	ef10                	sd	a2,24(a4)
    8020110e:	f314                	sd	a3,32(a4)
    80201110:	02878793          	addi	a5,a5,40
    80201114:	02870713          	addi	a4,a4,40
    80201118:	fc679ee3          	bne	a5,t1,802010f4 <new_task_cx+0x2e>
}
    8020111c:	642a                	ld	s0,136(sp)
    8020111e:	6149                	addi	sp,sp,144
    80201120:	8082                	ret

0000000080201122 <new_task_control_block>:
#include "task_context.h"
#include "types.h"
#include "task_control_block.h"
#include "pid_allocator.h"

struct task_control_block new_task_control_block(struct task_context task_cx, char* Kernel_stack){
    80201122:	1101                	addi	sp,sp,-32
    80201124:	e822                	sd	s0,16(sp)
    80201126:	e426                	sd	s1,8(sp)
    80201128:	e04a                	sd	s2,0(sp)
    8020112a:	ec06                	sd	ra,24(sp)
    8020112c:	1000                	addi	s0,sp,32
    8020112e:	84aa                	mv	s1,a0
    80201130:	8932                	mv	s2,a2
    struct task_control_block TCB;
    
    TCB.task_context = task_cx;
    80201132:	1c050793          	addi	a5,a0,448
    80201136:	07858713          	addi	a4,a1,120
    8020113a:	0005b883          	ld	a7,0(a1)
    8020113e:	0085b803          	ld	a6,8(a1)
    80201142:	6988                	ld	a0,16(a1)
    80201144:	6d90                	ld	a2,24(a1)
    80201146:	7194                	ld	a3,32(a1)
    80201148:	0117b023          	sd	a7,0(a5)
    8020114c:	0107b423          	sd	a6,8(a5)
    80201150:	eb88                	sd	a0,16(a5)
    80201152:	ef90                	sd	a2,24(a5)
    80201154:	f394                	sd	a3,32(a5)
    80201156:	02858593          	addi	a1,a1,40
    8020115a:	02878793          	addi	a5,a5,40
    8020115e:	fce59ee3          	bne	a1,a4,8020113a <new_task_control_block+0x18>
    TCB.Kernel_stack = Kernel_stack;
    TCB.pid = alloct_pid();
    80201162:	00000097          	auipc	ra,0x0
    80201166:	050080e7          	jalr	80(ra) # 802011b2 <alloct_pid>
    return TCB;
}
    8020116a:	60e2                	ld	ra,24(sp)
    8020116c:	6442                	ld	s0,16(sp)
    return TCB;
    8020116e:	2324bc23          	sd	s2,568(s1)
    TCB.pid = alloct_pid();
    80201172:	24a4b023          	sd	a0,576(s1)
}
    80201176:	6902                	ld	s2,0(sp)
    80201178:	8526                	mv	a0,s1
    8020117a:	64a2                	ld	s1,8(sp)
    8020117c:	6105                	addi	sp,sp,32
    8020117e:	8082                	ret

0000000080201180 <empty_tcb>:

struct task_control_block empty_tcb(){
    80201180:	1141                	addi	sp,sp,-16
    80201182:	e422                	sd	s0,8(sp)
    80201184:	0800                	addi	s0,sp,16
    struct task_control_block empty_tcb;

    return empty_tcb;
    80201186:	6422                	ld	s0,8(sp)
    80201188:	0141                	addi	sp,sp,16
    8020118a:	8082                	ret

000000008020118c <init_pid_bitmap>:
#include "types.h"
#include "printf.h"
#include "panic.h"


void init_pid_bitmap(){     // 对PID_BITMAP进行0初始化
    8020118c:	1141                	addi	sp,sp,-16
    8020118e:	e422                	sd	s0,8(sp)
    80201190:	0800                	addi	s0,sp,16
    80201192:	001a3797          	auipc	a5,0x1a3
    80201196:	f6e78793          	addi	a5,a5,-146 # 803a4100 <PID_BITMAP>
    8020119a:	001a3717          	auipc	a4,0x1a3
    8020119e:	fb670713          	addi	a4,a4,-74 # 803a4150 <TASK_MANAGER>
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
        PID_BITMAP[i] = 0;     // 0 means all are not used.
    802011a2:	0007a023          	sw	zero,0(a5)
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
    802011a6:	0791                	addi	a5,a5,4
    802011a8:	fee79de3          	bne	a5,a4,802011a2 <init_pid_bitmap+0x16>
    }
}    
    802011ac:	6422                	ld	s0,8(sp)
    802011ae:	0141                	addi	sp,sp,16
    802011b0:	8082                	ret

00000000802011b2 <alloct_pid>:

int alloct_pid(){   // find a valid pid, then return it. 
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
    802011b2:	001a3617          	auipc	a2,0x1a3
    802011b6:	f4e60613          	addi	a2,a2,-178 # 803a4100 <PID_BITMAP>
    802011ba:	87b2                	mv	a5,a2
    802011bc:	4501                	li	a0,0
    802011be:	46d1                	li	a3,20
    802011c0:	a021                	j	802011c8 <alloct_pid+0x16>
    802011c2:	2505                	addiw	a0,a0,1
    802011c4:	00d50b63          	beq	a0,a3,802011da <alloct_pid+0x28>
        if (PID_BITMAP[i] == 0){
    802011c8:	4398                	lw	a4,0(a5)
    802011ca:	0791                	addi	a5,a5,4
    802011cc:	fb7d                	bnez	a4,802011c2 <alloct_pid+0x10>
            PID_BITMAP[i] = 1;
    802011ce:	00251793          	slli	a5,a0,0x2
    802011d2:	963e                	add	a2,a2,a5
    802011d4:	4785                	li	a5,1
    802011d6:	c21c                	sw	a5,0(a2)
            return i;
        }
    }
    panic("[kernel] All the pids have been used!!");
    return -100;
}
    802011d8:	8082                	ret
int alloct_pid(){   // find a valid pid, then return it. 
    802011da:	1141                	addi	sp,sp,-16
    802011dc:	e022                	sd	s0,0(sp)
    802011de:	e406                	sd	ra,8(sp)
    802011e0:	0800                	addi	s0,sp,16
    panic("[kernel] All the pids have been used!!");
    802011e2:	00002517          	auipc	a0,0x2
    802011e6:	fee50513          	addi	a0,a0,-18 # 802031d0 <digits+0x138>
    802011ea:	fffff097          	auipc	ra,0xfffff
    802011ee:	0c4080e7          	jalr	196(ra) # 802002ae <panic>
}
    802011f2:	60a2                	ld	ra,8(sp)
    802011f4:	6402                	ld	s0,0(sp)
    return -100;
    802011f6:	f9c00513          	li	a0,-100
}
    802011fa:	0141                	addi	sp,sp,16
    802011fc:	8082                	ret

00000000802011fe <free_pid>:

void free_pid(int pid){
    802011fe:	1141                	addi	sp,sp,-16
    if (PID_BITMAP[pid] == 1){
    80201200:	00251793          	slli	a5,a0,0x2
void free_pid(int pid){
    80201204:	e422                	sd	s0,8(sp)
    if (PID_BITMAP[pid] == 1){
    80201206:	001a3517          	auipc	a0,0x1a3
    8020120a:	efa50513          	addi	a0,a0,-262 # 803a4100 <PID_BITMAP>
void free_pid(int pid){
    8020120e:	0800                	addi	s0,sp,16
    if (PID_BITMAP[pid] == 1){
    80201210:	953e                	add	a0,a0,a5
    80201212:	4118                	lw	a4,0(a0)
    80201214:	4785                	li	a5,1
    80201216:	00f71763          	bne	a4,a5,80201224 <free_pid+0x26>
        PID_BITMAP[pid] = 0;
    }
    else {
        panic("[kernel] PID has already been free?");
    }
}
    8020121a:	6422                	ld	s0,8(sp)
        PID_BITMAP[pid] = 0;
    8020121c:	00052023          	sw	zero,0(a0)
}
    80201220:	0141                	addi	sp,sp,16
    80201222:	8082                	ret
    80201224:	6422                	ld	s0,8(sp)
        panic("[kernel] PID has already been free?");
    80201226:	00002517          	auipc	a0,0x2
    8020122a:	fd250513          	addi	a0,a0,-46 # 802031f8 <digits+0x160>
}
    8020122e:	0141                	addi	sp,sp,16
        panic("[kernel] PID has already been free?");
    80201230:	fffff317          	auipc	t1,0xfffff
    80201234:	07e30067          	jr	126(t1) # 802002ae <panic>

0000000080201238 <check_valid>:

int check_valid(int pid){
    80201238:	1141                	addi	sp,sp,-16
    8020123a:	e422                	sd	s0,8(sp)
    8020123c:	0800                	addi	s0,sp,16
    return PID_BITMAP[pid];
    8020123e:	6422                	ld	s0,8(sp)
    return PID_BITMAP[pid];
    80201240:	00251793          	slli	a5,a0,0x2
    80201244:	001a3517          	auipc	a0,0x1a3
    80201248:	ebc50513          	addi	a0,a0,-324 # 803a4100 <PID_BITMAP>
    8020124c:	953e                	add	a0,a0,a5
    8020124e:	4108                	lw	a0,0(a0)
    80201250:	0141                	addi	sp,sp,16
    80201252:	8082                	ret

0000000080201254 <add_task_control_block>:


struct task_manager TASK_MANAGER;


void add_task_control_block(struct task_control_block TCB){   //Add one TCB to TASK_MANAGER_CONTAINER
    80201254:	1101                	addi	sp,sp,-32
    80201256:	e822                	sd	s0,16(sp)
    80201258:	e426                	sd	s1,8(sp)
    8020125a:	e04a                	sd	s2,0(sp)
    8020125c:	ec06                	sd	ra,24(sp)
    8020125e:	1000                	addi	s0,sp,32

    int pid = TCB.pid;
    80201260:	24052903          	lw	s2,576(a0)
void add_task_control_block(struct task_control_block TCB){   //Add one TCB to TASK_MANAGER_CONTAINER
    80201264:	84aa                	mv	s1,a0
    
    if (!check_valid(pid)){
    80201266:	854a                	mv	a0,s2
    80201268:	00000097          	auipc	ra,0x0
    8020126c:	fd0080e7          	jalr	-48(ra) # 80201238 <check_valid>
    80201270:	c535                	beqz	a0,802012dc <add_task_control_block+0x88>
        panic("Cannot add TCB to TASK_MANAGER!\n");
    }

    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = TCB;
    80201272:	24800793          	li	a5,584
    80201276:	02f90733          	mul	a4,s2,a5
    8020127a:	001a3797          	auipc	a5,0x1a3
    8020127e:	ed678793          	addi	a5,a5,-298 # 803a4150 <TASK_MANAGER>
    80201282:	8526                	mv	a0,s1
    80201284:	24048693          	addi	a3,s1,576
    80201288:	97ba                	add	a5,a5,a4
    8020128a:	00053803          	ld	a6,0(a0)
    8020128e:	650c                	ld	a1,8(a0)
    80201290:	6910                	ld	a2,16(a0)
    80201292:	6d18                	ld	a4,24(a0)
    80201294:	0107b023          	sd	a6,0(a5)
    80201298:	e78c                	sd	a1,8(a5)
    8020129a:	eb90                	sd	a2,16(a5)
    8020129c:	ef98                	sd	a4,24(a5)
    8020129e:	02050513          	addi	a0,a0,32
    802012a2:	02078793          	addi	a5,a5,32
    802012a6:	fed512e3          	bne	a0,a3,8020128a <add_task_control_block+0x36>
    802012aa:	6114                	ld	a3,0(a0)
    TASK_MANAGER.number_of_apps += 1;
    802012ac:	001a6717          	auipc	a4,0x1a6
    802012b0:	ea470713          	addi	a4,a4,-348 # 803a7150 <heap+0x10>
    printf("[task manager] the pid is %d\n", pid);
}
    802012b4:	6442                	ld	s0,16(sp)
    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = TCB;
    802012b6:	e394                	sd	a3,0(a5)
    TASK_MANAGER.number_of_apps += 1;
    802012b8:	fe873783          	ld	a5,-24(a4)
}
    802012bc:	60e2                	ld	ra,24(sp)
    802012be:	64a2                	ld	s1,8(sp)
    printf("[task manager] the pid is %d\n", pid);
    802012c0:	85ca                	mv	a1,s2
    TASK_MANAGER.number_of_apps += 1;
    802012c2:	0785                	addi	a5,a5,1
}
    802012c4:	6902                	ld	s2,0(sp)
    TASK_MANAGER.number_of_apps += 1;
    802012c6:	fef73423          	sd	a5,-24(a4)
    printf("[task manager] the pid is %d\n", pid);
    802012ca:	00002517          	auipc	a0,0x2
    802012ce:	f7e50513          	addi	a0,a0,-130 # 80203248 <digits+0x1b0>
}
    802012d2:	6105                	addi	sp,sp,32
    printf("[task manager] the pid is %d\n", pid);
    802012d4:	fffff317          	auipc	t1,0xfffff
    802012d8:	e4630067          	jr	-442(t1) # 8020011a <printf>
        panic("Cannot add TCB to TASK_MANAGER!\n");
    802012dc:	00002517          	auipc	a0,0x2
    802012e0:	f4450513          	addi	a0,a0,-188 # 80203220 <digits+0x188>
    802012e4:	fffff097          	auipc	ra,0xfffff
    802012e8:	fca080e7          	jalr	-54(ra) # 802002ae <panic>
    802012ec:	b759                	j	80201272 <add_task_control_block+0x1e>

00000000802012ee <free_task_control_block>:

void free_task_control_block(int pid){
    802012ee:	d9010113          	addi	sp,sp,-624
    802012f2:	26813023          	sd	s0,608(sp)
    802012f6:	25213823          	sd	s2,592(sp)
    802012fa:	26113423          	sd	ra,616(sp)
    802012fe:	24913c23          	sd	s1,600(sp)
    80201302:	1c80                	addi	s0,sp,624
    80201304:	892a                	mv	s2,a0

    if (!check_valid(pid)){
    80201306:	00000097          	auipc	ra,0x0
    8020130a:	f32080e7          	jalr	-206(ra) # 80201238 <check_valid>
    8020130e:	c141                	beqz	a0,8020138e <free_task_control_block+0xa0>
        panic("Some thing wrong when free the tcb from TASK_MANAGER!\n");
    }
    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = empty_tcb();
    80201310:	24800493          	li	s1,584
    80201314:	029904b3          	mul	s1,s2,s1
    80201318:	001a3797          	auipc	a5,0x1a3
    8020131c:	e3878793          	addi	a5,a5,-456 # 803a4150 <TASK_MANAGER>
    80201320:	d9040513          	addi	a0,s0,-624
    80201324:	94be                	add	s1,s1,a5
    80201326:	00000097          	auipc	ra,0x0
    8020132a:	e5a080e7          	jalr	-422(ra) # 80201180 <empty_tcb>
    8020132e:	d9040713          	addi	a4,s0,-624
    80201332:	87a6                	mv	a5,s1
    80201334:	fd040693          	addi	a3,s0,-48
    80201338:	00073803          	ld	a6,0(a4)
    8020133c:	6708                	ld	a0,8(a4)
    8020133e:	6b0c                	ld	a1,16(a4)
    80201340:	6f10                	ld	a2,24(a4)
    80201342:	0107b023          	sd	a6,0(a5)
    80201346:	e788                	sd	a0,8(a5)
    80201348:	eb8c                	sd	a1,16(a5)
    8020134a:	ef90                	sd	a2,24(a5)
    8020134c:	02070713          	addi	a4,a4,32
    80201350:	02078793          	addi	a5,a5,32
    80201354:	fed712e3          	bne	a4,a3,80201338 <free_task_control_block+0x4a>
    80201358:	6318                	ld	a4,0(a4)
    free_pid(pid);
    8020135a:	854a                	mv	a0,s2
    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = empty_tcb();
    8020135c:	e398                	sd	a4,0(a5)
    free_pid(pid);
    8020135e:	00000097          	auipc	ra,0x0
    80201362:	ea0080e7          	jalr	-352(ra) # 802011fe <free_pid>
    TASK_MANAGER.number_of_apps -= 1;
    80201366:	001a6717          	auipc	a4,0x1a6
    8020136a:	dea70713          	addi	a4,a4,-534 # 803a7150 <heap+0x10>
    8020136e:	fe873783          	ld	a5,-24(a4)
}
    80201372:	26813083          	ld	ra,616(sp)
    80201376:	26013403          	ld	s0,608(sp)
    TASK_MANAGER.number_of_apps -= 1;
    8020137a:	17fd                	addi	a5,a5,-1
    8020137c:	fef73423          	sd	a5,-24(a4)
}
    80201380:	25813483          	ld	s1,600(sp)
    80201384:	25013903          	ld	s2,592(sp)
    80201388:	27010113          	addi	sp,sp,624
    8020138c:	8082                	ret
        panic("Some thing wrong when free the tcb from TASK_MANAGER!\n");
    8020138e:	00002517          	auipc	a0,0x2
    80201392:	eda50513          	addi	a0,a0,-294 # 80203268 <digits+0x1d0>
    80201396:	fffff097          	auipc	ra,0xfffff
    8020139a:	f18080e7          	jalr	-232(ra) # 802002ae <panic>
    8020139e:	bf8d                	j	80201310 <free_task_control_block+0x22>

00000000802013a0 <schedule>:

struct task_control_block schedule(int pid){   // give out one task control block
    802013a0:	7179                	addi	sp,sp,-48
    802013a2:	f022                	sd	s0,32(sp)
    802013a4:	e84a                	sd	s2,16(sp)
    802013a6:	e052                	sd	s4,0(sp)
    802013a8:	f406                	sd	ra,40(sp)
    802013aa:	ec26                	sd	s1,24(sp)
    802013ac:	e44e                	sd	s3,8(sp)
    802013ae:	1800                	addi	s0,sp,48
    
    for (int i = pid; i < MAX_NUM_OF_APPS; i++){
    802013b0:	47cd                	li	a5,19
struct task_control_block schedule(int pid){   // give out one task control block
    802013b2:	892e                	mv	s2,a1
    802013b4:	8a2a                	mv	s4,a0
    for (int i = pid; i < MAX_NUM_OF_APPS; i++){
    802013b6:	06b7c563          	blt	a5,a1,80201420 <schedule+0x80>
    802013ba:	84ae                	mv	s1,a1
    802013bc:	49d1                	li	s3,20
    802013be:	a021                	j	802013c6 <schedule+0x26>
    802013c0:	2485                	addiw	s1,s1,1
    802013c2:	05348d63          	beq	s1,s3,8020141c <schedule+0x7c>
        if (check_valid(i)){
    802013c6:	8526                	mv	a0,s1
    802013c8:	00000097          	auipc	ra,0x0
    802013cc:	e70080e7          	jalr	-400(ra) # 80201238 <check_valid>
    802013d0:	d965                	beqz	a0,802013c0 <schedule+0x20>
            return TASK_MANAGER.TASK_MANAGER_CONTAINER[i];
    802013d2:	24800793          	li	a5,584
    802013d6:	02f484b3          	mul	s1,s1,a5
    802013da:	001a3797          	auipc	a5,0x1a3
    802013de:	d7678793          	addi	a5,a5,-650 # 803a4150 <TASK_MANAGER>
    802013e2:	8752                	mv	a4,s4
    802013e4:	94be                	add	s1,s1,a5
    802013e6:	24048513          	addi	a0,s1,576
    802013ea:	608c                	ld	a1,0(s1)
    802013ec:	6490                	ld	a2,8(s1)
    802013ee:	6894                	ld	a3,16(s1)
    802013f0:	6c9c                	ld	a5,24(s1)
    802013f2:	e30c                	sd	a1,0(a4)
    802013f4:	e710                	sd	a2,8(a4)
    802013f6:	eb14                	sd	a3,16(a4)
    802013f8:	ef1c                	sd	a5,24(a4)
    802013fa:	02048493          	addi	s1,s1,32
    802013fe:	02070713          	addi	a4,a4,32
    80201402:	fea494e3          	bne	s1,a0,802013ea <schedule+0x4a>
        }
    }
    for (int i = 0; i <= pid; i++){
        if (check_valid(i)){
            return TASK_MANAGER.TASK_MANAGER_CONTAINER[i];
    80201406:	609c                	ld	a5,0(s1)
    80201408:	e31c                	sd	a5,0(a4)
        }
    }
    panic("Error when scheduling task!");
    8020140a:	70a2                	ld	ra,40(sp)
    8020140c:	7402                	ld	s0,32(sp)
    8020140e:	64e2                	ld	s1,24(sp)
    80201410:	6942                	ld	s2,16(sp)
    80201412:	69a2                	ld	s3,8(sp)
    80201414:	8552                	mv	a0,s4
    80201416:	6a02                	ld	s4,0(sp)
    80201418:	6145                	addi	sp,sp,48
    8020141a:	8082                	ret
    for (int i = 0; i <= pid; i++){
    8020141c:	04094863          	bltz	s2,8020146c <schedule+0xcc>
    80201420:	4481                	li	s1,0
    80201422:	a021                	j	8020142a <schedule+0x8a>
    80201424:	2485                	addiw	s1,s1,1
    80201426:	04994363          	blt	s2,s1,8020146c <schedule+0xcc>
        if (check_valid(i)){
    8020142a:	8526                	mv	a0,s1
    8020142c:	00000097          	auipc	ra,0x0
    80201430:	e0c080e7          	jalr	-500(ra) # 80201238 <check_valid>
    80201434:	d965                	beqz	a0,80201424 <schedule+0x84>
            return TASK_MANAGER.TASK_MANAGER_CONTAINER[i];
    80201436:	24800793          	li	a5,584
    8020143a:	02f484b3          	mul	s1,s1,a5
    8020143e:	001a3797          	auipc	a5,0x1a3
    80201442:	d1278793          	addi	a5,a5,-750 # 803a4150 <TASK_MANAGER>
    80201446:	8752                	mv	a4,s4
    80201448:	94be                	add	s1,s1,a5
    8020144a:	24048513          	addi	a0,s1,576
    8020144e:	608c                	ld	a1,0(s1)
    80201450:	6490                	ld	a2,8(s1)
    80201452:	6894                	ld	a3,16(s1)
    80201454:	6c9c                	ld	a5,24(s1)
    80201456:	e30c                	sd	a1,0(a4)
    80201458:	e710                	sd	a2,8(a4)
    8020145a:	eb14                	sd	a3,16(a4)
    8020145c:	ef1c                	sd	a5,24(a4)
    8020145e:	02048493          	addi	s1,s1,32
    80201462:	02070713          	addi	a4,a4,32
    80201466:	fea494e3          	bne	s1,a0,8020144e <schedule+0xae>
    8020146a:	bf71                	j	80201406 <schedule+0x66>
    panic("Error when scheduling task!");
    8020146c:	00002517          	auipc	a0,0x2
    80201470:	e3450513          	addi	a0,a0,-460 # 802032a0 <digits+0x208>
    80201474:	fffff097          	auipc	ra,0xfffff
    80201478:	e3a080e7          	jalr	-454(ra) # 802002ae <panic>
    8020147c:	b779                	j	8020140a <schedule+0x6a>

000000008020147e <get_ppn_2>:
#include "mm/pagetable.h"
#include "mm/framealloc.h"


// 从vpn中提取出二级PPN
uint64 get_ppn_2(uint64 ppn){
    8020147e:	1141                	addi	sp,sp,-16
    80201480:	e422                	sd	s0,8(sp)
    80201482:	0800                	addi	s0,sp,16
    return (ppn >> 18) & ((1 << 9) - 1);
}
    80201484:	6422                	ld	s0,8(sp)
    return (ppn >> 18) & ((1 << 9) - 1);
    80201486:	8149                	srli	a0,a0,0x12
}
    80201488:	1ff57513          	andi	a0,a0,511
    8020148c:	0141                	addi	sp,sp,16
    8020148e:	8082                	ret

0000000080201490 <get_ppn_1>:

// 从vpn中提取出一级PPN
uint64 get_ppn_1(uint64 ppn){
    80201490:	1141                	addi	sp,sp,-16
    80201492:	e422                	sd	s0,8(sp)
    80201494:	0800                	addi	s0,sp,16
    return (ppn >> 9) & ((1 << 9) - 1);
}
    80201496:	6422                	ld	s0,8(sp)
    return (ppn >> 9) & ((1 << 9) - 1);
    80201498:	8125                	srli	a0,a0,0x9
}
    8020149a:	1ff57513          	andi	a0,a0,511
    8020149e:	0141                	addi	sp,sp,16
    802014a0:	8082                	ret

00000000802014a2 <get_ppn_0>:

// 从vpn中提取出零级PPN
uint64 get_ppn_0(uint64 ppn){
    802014a2:	1141                	addi	sp,sp,-16
    802014a4:	e422                	sd	s0,8(sp)
    802014a6:	0800                	addi	s0,sp,16
    return ppn & ((1 << 9) - 1);
}
    802014a8:	6422                	ld	s0,8(sp)
    802014aa:	1ff57513          	andi	a0,a0,511
    802014ae:	0141                	addi	sp,sp,16
    802014b0:	8082                	ret

00000000802014b2 <to_physical_addr>:

uint64 to_physical_addr(uint64 ppn){
    802014b2:	1141                	addi	sp,sp,-16
    802014b4:	e422                	sd	s0,8(sp)
    802014b6:	0800                	addi	s0,sp,16
    return (ppn << 12);
}
    802014b8:	6422                	ld	s0,8(sp)
    802014ba:	0532                	slli	a0,a0,0xc
    802014bc:	0141                	addi	sp,sp,16
    802014be:	8082                	ret

00000000802014c0 <new_pagetable>:

struct PageTable new_pagetable(){
    802014c0:	1141                	addi	sp,sp,-16
    802014c2:	e022                	sd	s0,0(sp)
    802014c4:	e406                	sd	ra,8(sp)
    802014c6:	0800                	addi	s0,sp,16
    struct PageTable new_pt;
    new_pt.root_ppn = get_frame();
    802014c8:	fffff097          	auipc	ra,0xfffff
    802014cc:	7e4080e7          	jalr	2020(ra) # 80200cac <get_frame>

    return new_pt;
}
    802014d0:	60a2                	ld	ra,8(sp)
    802014d2:	6402                	ld	s0,0(sp)
    802014d4:	1502                	slli	a0,a0,0x20
    802014d6:	9101                	srli	a0,a0,0x20
    802014d8:	0141                	addi	sp,sp,16
    802014da:	8082                	ret

00000000802014dc <get_PTE>:

uint64 get_PTE(uint64 ppn, uint64 index){
    802014dc:	1141                	addi	sp,sp,-16
    802014de:	e422                	sd	s0,8(sp)
    802014e0:	0800                	addi	s0,sp,16

    uint64 phys_addr = to_physical_addr(ppn);
    return (uint64*)(phys_addr+index*8);

}
    802014e2:	6422                	ld	s0,8(sp)
    return (uint64*)(phys_addr+index*8);
    802014e4:	058e                	slli	a1,a1,0x3
    return (ppn << 12);
    802014e6:	0532                	slli	a0,a0,0xc
}
    802014e8:	952e                	add	a0,a0,a1
    802014ea:	0141                	addi	sp,sp,16
    802014ec:	8082                	ret

00000000802014ee <check_PTE_valid>:

uint64 check_PTE_valid(uint64 PTE){
    802014ee:	1141                	addi	sp,sp,-16
    802014f0:	e422                	sd	s0,8(sp)
    802014f2:	0800                	addi	s0,sp,16
    return PTE & 0x1;
}
    802014f4:	6422                	ld	s0,8(sp)
    802014f6:	8905                	andi	a0,a0,1
    802014f8:	0141                	addi	sp,sp,16
    802014fa:	8082                	ret

00000000802014fc <set_permission>:

void set_permission(uint64 PTE_addr, uint64 set_bit){
    802014fc:	1141                	addi	sp,sp,-16
    802014fe:	e422                	sd	s0,8(sp)
    80201500:	0800                	addi	s0,sp,16
    *(uint64*)PTE_addr = *(uint64*)PTE_addr | set_bit;  
    80201502:	611c                	ld	a5,0(a0)
}
    80201504:	6422                	ld	s0,8(sp)
    *(uint64*)PTE_addr = *(uint64*)PTE_addr | set_bit;  
    80201506:	8fcd                	or	a5,a5,a1
    80201508:	e11c                	sd	a5,0(a0)
}
    8020150a:	0141                	addi	sp,sp,16
    8020150c:	8082                	ret

000000008020150e <set_PTE_ppn>:

void set_PTE_ppn(uint64 PTE_addr, uint64 ppn){
    8020150e:	1141                	addi	sp,sp,-16
    80201510:	e422                	sd	s0,8(sp)
    80201512:	0800                	addi	s0,sp,16
    *(uint64*)PTE_addr |= (ppn << 10);
    80201514:	611c                	ld	a5,0(a0)
}
    80201516:	6422                	ld	s0,8(sp)
    *(uint64*)PTE_addr |= (ppn << 10);
    80201518:	05aa                	slli	a1,a1,0xa
    8020151a:	8fcd                	or	a5,a5,a1
    8020151c:	e11c                	sd	a5,0(a0)
}
    8020151e:	0141                	addi	sp,sp,16
    80201520:	8082                	ret

0000000080201522 <free_PTE>:

void free_PTE(uint64 PTE_addr){
    80201522:	1141                	addi	sp,sp,-16
    80201524:	e422                	sd	s0,8(sp)
    80201526:	0800                	addi	s0,sp,16
    *(uint64*)PTE_addr = 0;
}
    80201528:	6422                	ld	s0,8(sp)
    *(uint64*)PTE_addr = 0;
    8020152a:	00053023          	sd	zero,0(a0)
}
    8020152e:	0141                	addi	sp,sp,16
    80201530:	8082                	ret

0000000080201532 <get_PTE_ppn>:


uint64 get_PTE_ppn(uint64 PTE_addr){   // 从PTE中取出其指向的物理页号
    80201532:	1141                	addi	sp,sp,-16
    80201534:	e422                	sd	s0,8(sp)
    80201536:	0800                	addi	s0,sp,16
    uint64 PTE = *(uint64*)PTE_addr;
    return (PTE >> 10) & ((1 << 44) - 1);
    80201538:	6108                	ld	a0,0(a0)
}
    8020153a:	6422                	ld	s0,8(sp)
    8020153c:	8129                	srli	a0,a0,0xa
    8020153e:	0141                	addi	sp,sp,16
    80201540:	8082                	ret

0000000080201542 <map>:


uint64 map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    80201542:	7139                	addi	sp,sp,-64
    return (ppn >> 18) & ((1 << 9) - 1);
    80201544:	0125d793          	srli	a5,a1,0x12
uint64 map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    80201548:	f04a                	sd	s2,32(sp)
    return (ppn >> 18) & ((1 << 9) - 1);
    8020154a:	1ff7f913          	andi	s2,a5,511
uint64 map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    8020154e:	f822                	sd	s0,48(sp)
    80201550:	f426                	sd	s1,40(sp)
    80201552:	ec4e                	sd	s3,24(sp)
    80201554:	e852                	sd	s4,16(sp)
    80201556:	e456                	sd	s5,8(sp)
    return (ppn << 12);
    80201558:	0532                	slli	a0,a0,0xc
uint64 map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    8020155a:	fc06                	sd	ra,56(sp)
    8020155c:	0080                	addi	s0,sp,64
    return (uint64*)(phys_addr+index*8);
    8020155e:	090e                	slli	s2,s2,0x3
    80201560:	992a                	add	s2,s2,a0
    uint64 ppn_0 = get_ppn_0(vpn);

    uint64 PTE_addr = get_PTE(root_ppn, ppn_2);
    uint64 next_page_directory;
    
    if (!check_PTE_valid(*(uint64*)PTE_addr)){    // 证明下面的两级页表还没有建好。开始建表
    80201562:	00093703          	ld	a4,0(s2)
    return (ppn >> 9) & ((1 << 9) - 1);
    80201566:	0095d993          	srli	s3,a1,0x9
uint64 map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    8020156a:	8a32                	mv	s4,a2
    return PTE & 0x1;
    8020156c:	00177813          	andi	a6,a4,1
uint64 map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    80201570:	8ab6                	mv	s5,a3
    return (ppn >> 9) & ((1 << 9) - 1);
    80201572:	1ff9f993          	andi	s3,s3,511
    return ppn & ((1 << 9) - 1);
    80201576:	1ff5f493          	andi	s1,a1,511
    return PTE & 0x1;
    8020157a:	00a75513          	srli	a0,a4,0xa
    if (!check_PTE_valid(*(uint64*)PTE_addr)){    // 证明下面的两级页表还没有建好。开始建表
    8020157e:	06080d63          	beqz	a6,802015f8 <map+0xb6>
    return (ppn << 12);
    80201582:	0532                	slli	a0,a0,0xc
    return (uint64*)(phys_addr+index*8);
    80201584:	00399913          	slli	s2,s3,0x3
    80201588:	992a                	add	s2,s2,a0
        next_page_directory = get_PTE_ppn(PTE_addr);
    }

    // 开始找第一级页表
    PTE_addr = get_PTE(next_page_directory, ppn_1);
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    8020158a:	00093703          	ld	a4,0(s2)
    return PTE & 0x1;
    8020158e:	00177613          	andi	a2,a4,1
    return (PTE >> 10) & ((1 << 44) - 1);
    80201592:	00a75593          	srli	a1,a4,0xa
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    80201596:	ce15                	beqz	a2,802015d2 <map+0x90>
    return (ppn << 12);
    80201598:	00c59513          	slli	a0,a1,0xc
    return (uint64*)(phys_addr+index*8);
    8020159c:	00349593          	slli	a1,s1,0x3
    802015a0:	95aa                	add	a1,a1,a0
        next_page_directory = get_PTE_ppn(PTE_addr);
    }

    // 开始找第0级页表
    PTE_addr = get_PTE(next_page_directory, ppn_0);
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    802015a2:	6198                	ld	a4,0(a1)
    return PTE & 0x1;
    802015a4:	00177513          	andi	a0,a4,1
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    802015a8:	e115                	bnez	a0,802015cc <map+0x8a>
        flags = (flags << 1) + 1;    // 左移一位加一：加上valid bit
    802015aa:	001a9793          	slli	a5,s5,0x1
    802015ae:	0785                	addi	a5,a5,1
    *(uint64*)PTE_addr |= (ppn << 10);
    802015b0:	0a2a                	slli	s4,s4,0xa
    802015b2:	0147e7b3          	or	a5,a5,s4
    802015b6:	8fd9                	or	a5,a5,a4
    802015b8:	e19c                	sd	a5,0(a1)
        set_PTE_ppn(PTE_addr, ppn);  // 一级页表 -> 零级页表
    }else{
        return get_PTE_ppn(PTE_addr);     // means the PTE has already been taken
    }
    return 0;   // means finish mapping.
}
    802015ba:	70e2                	ld	ra,56(sp)
    802015bc:	7442                	ld	s0,48(sp)
    802015be:	74a2                	ld	s1,40(sp)
    802015c0:	7902                	ld	s2,32(sp)
    802015c2:	69e2                	ld	s3,24(sp)
    802015c4:	6a42                	ld	s4,16(sp)
    802015c6:	6aa2                	ld	s5,8(sp)
    802015c8:	6121                	addi	sp,sp,64
    802015ca:	8082                	ret
    return (PTE >> 10) & ((1 << 44) - 1);
    802015cc:	00a75513          	srli	a0,a4,0xa
        return get_PTE_ppn(PTE_addr);     // means the PTE has already been taken
    802015d0:	b7ed                	j	802015ba <map+0x78>
    *(uint64*)PTE_addr = *(uint64*)PTE_addr | set_bit;  
    802015d2:	00176713          	ori	a4,a4,1
    802015d6:	00e93023          	sd	a4,0(s2)
        next_page_directory = get_frame();    // 为零级页表申请了一个frame
    802015da:	fffff097          	auipc	ra,0xfffff
    802015de:	6d2080e7          	jalr	1746(ra) # 80200cac <get_frame>
    *(uint64*)PTE_addr |= (ppn << 10);
    802015e2:	00093783          	ld	a5,0(s2)
        next_page_directory = get_frame();    // 为零级页表申请了一个frame
    802015e6:	02051593          	slli	a1,a0,0x20
    802015ea:	9181                	srli	a1,a1,0x20
    *(uint64*)PTE_addr |= (ppn << 10);
    802015ec:	00a59713          	slli	a4,a1,0xa
    802015f0:	8fd9                	or	a5,a5,a4
    802015f2:	00f93023          	sd	a5,0(s2)
}
    802015f6:	b74d                	j	80201598 <map+0x56>
    *(uint64*)PTE_addr = *(uint64*)PTE_addr | set_bit;  
    802015f8:	00176713          	ori	a4,a4,1
    802015fc:	00e93023          	sd	a4,0(s2)
        next_page_directory = get_frame();       // 为一级页表申请了一个frame
    80201600:	fffff097          	auipc	ra,0xfffff
    80201604:	6ac080e7          	jalr	1708(ra) # 80200cac <get_frame>
    *(uint64*)PTE_addr |= (ppn << 10);
    80201608:	00093783          	ld	a5,0(s2)
        next_page_directory = get_frame();       // 为一级页表申请了一个frame
    8020160c:	1502                	slli	a0,a0,0x20
    8020160e:	9101                	srli	a0,a0,0x20
    *(uint64*)PTE_addr |= (ppn << 10);
    80201610:	00a51713          	slli	a4,a0,0xa
    80201614:	8fd9                	or	a5,a5,a4
    80201616:	00f93023          	sd	a5,0(s2)
}
    8020161a:	b7a5                	j	80201582 <map+0x40>

000000008020161c <unmap>:
    return (ppn >> 18) & ((1 << 9) - 1);
    8020161c:	0125d793          	srli	a5,a1,0x12


void unmap(struct PageTable pg, uint64 vpn){
    80201620:	1141                	addi	sp,sp,-16
    return (ppn >> 18) & ((1 << 9) - 1);
    80201622:	1ff7f793          	andi	a5,a5,511
void unmap(struct PageTable pg, uint64 vpn){
    80201626:	e422                	sd	s0,8(sp)
    return (uint64*)(phys_addr+index*8);
    80201628:	078e                	slli	a5,a5,0x3
void unmap(struct PageTable pg, uint64 vpn){
    8020162a:	0800                	addi	s0,sp,16
    return (ppn << 12);
    8020162c:	0532                	slli	a0,a0,0xc
    return (uint64*)(phys_addr+index*8);
    8020162e:	953e                	add	a0,a0,a5
    uint64 ppn_1 = get_ppn_1(vpn);
    uint64 ppn_0 = get_ppn_0(vpn);

    uint64 first_PTE_addr = get_PTE(root_ppn, ppn_2);

    if (check_PTE_valid(*(uint64*)first_PTE_addr)){    
    80201630:	6118                	ld	a4,0(a0)
    return PTE & 0x1;
    80201632:	00177793          	andi	a5,a4,1
    if (check_PTE_valid(*(uint64*)first_PTE_addr)){    
    80201636:	c7a9                	beqz	a5,80201680 <unmap+0x64>
    return (ppn >> 9) & ((1 << 9) - 1);
    80201638:	0095d793          	srli	a5,a1,0x9
    8020163c:	1ff7f793          	andi	a5,a5,511
    return (PTE >> 10) & ((1 << 44) - 1);
    80201640:	8329                	srli	a4,a4,0xa
    return (ppn << 12);
    80201642:	0732                	slli	a4,a4,0xc
    return (uint64*)(phys_addr+index*8);
    80201644:	078e                	slli	a5,a5,0x3
    *(uint64*)PTE_addr = 0;
    80201646:	00053023          	sd	zero,0(a0)
    return (uint64*)(phys_addr+index*8);
    8020164a:	97ba                	add	a5,a5,a4
     
        uint64 next_page_directory = get_PTE_ppn(first_PTE_addr);            
        uint64 second_PTE_addr = get_PTE(next_page_directory, ppn_1);
        free_PTE(first_PTE_addr);  

        if (check_PTE_valid(*(uint64*)second_PTE_addr)){
    8020164c:	6398                	ld	a4,0(a5)
    return PTE & 0x1;
    8020164e:	00177693          	andi	a3,a4,1
        if (check_PTE_valid(*(uint64*)second_PTE_addr)){
    80201652:	c69d                	beqz	a3,80201680 <unmap+0x64>
    return (PTE >> 10) & ((1 << 44) - 1);
    80201654:	8329                	srli	a4,a4,0xa
    return ppn & ((1 << 9) - 1);
    80201656:	1ff5f593          	andi	a1,a1,511
    return (ppn << 12);
    8020165a:	0732                	slli	a4,a4,0xc
    return (uint64*)(phys_addr+index*8);
    8020165c:	058e                	slli	a1,a1,0x3
    *(uint64*)PTE_addr = 0;
    8020165e:	0007b023          	sd	zero,0(a5)
    return (uint64*)(phys_addr+index*8);
    80201662:	95ba                	add	a1,a1,a4
            
            next_page_directory = get_PTE_ppn(second_PTE_addr);            
            uint64 third_PTE_addr = get_PTE(next_page_directory, ppn_0);
            free_PTE(second_PTE_addr);

            if (check_PTE_valid(*(uint64*)third_PTE_addr)){
    80201664:	6188                	ld	a0,0(a1)
    return PTE & 0x1;
    80201666:	00157793          	andi	a5,a0,1
            if (check_PTE_valid(*(uint64*)third_PTE_addr)){
    8020166a:	cb99                	beqz	a5,80201680 <unmap+0x64>
            panic("Wrong in unmapping!\n");
        }  
    }else{
        panic("Wrong in unmapping!\n");
    }
}
    8020166c:	6422                	ld	s0,8(sp)
    return (PTE >> 10) & ((1 << 44) - 1);
    8020166e:	8129                	srli	a0,a0,0xa
    *(uint64*)PTE_addr = 0;
    80201670:	0005b023          	sd	zero,0(a1)
                free_frame(corresponding_frame);
    80201674:	2501                	sext.w	a0,a0
}
    80201676:	0141                	addi	sp,sp,16
                free_frame(corresponding_frame);
    80201678:	fffff317          	auipc	t1,0xfffff
    8020167c:	75c30067          	jr	1884(t1) # 80200dd4 <free_frame>
}
    80201680:	6422                	ld	s0,8(sp)
                panic("Wrong in unmapping!\n");
    80201682:	00002517          	auipc	a0,0x2
    80201686:	c3e50513          	addi	a0,a0,-962 # 802032c0 <digits+0x228>
}
    8020168a:	0141                	addi	sp,sp,16
                panic("Wrong in unmapping!\n");
    8020168c:	fffff317          	auipc	t1,0xfffff
    80201690:	c2230067          	jr	-990(t1) # 802002ae <panic>

0000000080201694 <translate>:
    return (ppn >> 18) & ((1 << 9) - 1);
    80201694:	01e5d793          	srli	a5,a1,0x1e

uint64 translate(uint64 root_ppn, uint64 vir_addr){
    80201698:	1101                	addi	sp,sp,-32
    return (ppn >> 18) & ((1 << 9) - 1);
    8020169a:	1ff7f793          	andi	a5,a5,511
uint64 translate(uint64 root_ppn, uint64 vir_addr){
    8020169e:	e822                	sd	s0,16(sp)
    802016a0:	e04a                	sd	s2,0(sp)
    802016a2:	ec06                	sd	ra,24(sp)
    802016a4:	e426                	sd	s1,8(sp)
    802016a6:	1000                	addi	s0,sp,32
    return (ppn << 12);
    802016a8:	0532                	slli	a0,a0,0xc
    uint64 ppn_0 = get_ppn_0(vpn);

    uint64 first_PTE_addr = get_PTE(root_ppn, ppn_2);
    uint64 corresponding_frame;

    if (check_PTE_valid(*(uint64*)first_PTE_addr)){    
    802016aa:	078e                	slli	a5,a5,0x3
    802016ac:	97aa                	add	a5,a5,a0
    802016ae:	6398                	ld	a4,0(a5)
    uint64 offset = vir_addr & 0b111111111111;
    802016b0:	03459913          	slli	s2,a1,0x34
    802016b4:	03495913          	srli	s2,s2,0x34
    return PTE & 0x1;
    802016b8:	00177793          	andi	a5,a4,1
    if (check_PTE_valid(*(uint64*)first_PTE_addr)){    
    802016bc:	c7a1                	beqz	a5,80201704 <translate+0x70>
    return (ppn >> 9) & ((1 << 9) - 1);
    802016be:	0155d793          	srli	a5,a1,0x15
    802016c2:	1ff7f793          	andi	a5,a5,511
    return (PTE >> 10) & ((1 << 44) - 1);
    802016c6:	8329                	srli	a4,a4,0xa
    return (ppn << 12);
    802016c8:	0732                	slli	a4,a4,0xc
     
        uint64 next_page_directory = get_PTE_ppn(first_PTE_addr);            
        uint64 second_PTE_addr = get_PTE(next_page_directory, ppn_1);

        if (check_PTE_valid(*(uint64*)second_PTE_addr)){
    802016ca:	078e                	slli	a5,a5,0x3
    802016cc:	97ba                	add	a5,a5,a4
    802016ce:	639c                	ld	a5,0(a5)
    return PTE & 0x1;
    802016d0:	0017f713          	andi	a4,a5,1
        if (check_PTE_valid(*(uint64*)second_PTE_addr)){
    802016d4:	cb05                	beqz	a4,80201704 <translate+0x70>
    uint64 vpn = vir_addr >> 12;
    802016d6:	81b1                	srli	a1,a1,0xc
    return ppn & ((1 << 9) - 1);
    802016d8:	1ff5f593          	andi	a1,a1,511
    return (PTE >> 10) & ((1 << 44) - 1);
    802016dc:	83a9                	srli	a5,a5,0xa
    return (ppn << 12);
    802016de:	07b2                	slli	a5,a5,0xc
            
            next_page_directory = get_PTE_ppn(second_PTE_addr);            
            uint64 third_PTE_addr = get_PTE(next_page_directory, ppn_0);

            if (check_PTE_valid(*(uint64*)third_PTE_addr)){
    802016e0:	058e                	slli	a1,a1,0x3
    802016e2:	95be                	add	a1,a1,a5
    802016e4:	619c                	ld	a5,0(a1)
    return PTE & 0x1;
    802016e6:	0017f713          	andi	a4,a5,1
            if (check_PTE_valid(*(uint64*)third_PTE_addr)){
    802016ea:	cf09                	beqz	a4,80201704 <translate+0x70>
        }  
    }else{
        panic("Wrong in translate!\n");
    }
    return corresponding_frame << 12 | offset;
}
    802016ec:	60e2                	ld	ra,24(sp)
    802016ee:	6442                	ld	s0,16(sp)
    return (PTE >> 10) & ((1 << 44) - 1);
    802016f0:	00a7d493          	srli	s1,a5,0xa
    return corresponding_frame << 12 | offset;
    802016f4:	00c49513          	slli	a0,s1,0xc
}
    802016f8:	01256533          	or	a0,a0,s2
    802016fc:	64a2                	ld	s1,8(sp)
    802016fe:	6902                	ld	s2,0(sp)
    80201700:	6105                	addi	sp,sp,32
    80201702:	8082                	ret
                panic("Wrong in translate!\n");
    80201704:	00002517          	auipc	a0,0x2
    80201708:	bd450513          	addi	a0,a0,-1068 # 802032d8 <digits+0x240>
    8020170c:	fffff097          	auipc	ra,0xfffff
    80201710:	ba2080e7          	jalr	-1118(ra) # 802002ae <panic>
}
    80201714:	60e2                	ld	ra,24(sp)
    80201716:	6442                	ld	s0,16(sp)
    return corresponding_frame << 12 | offset;
    80201718:	00c49513          	slli	a0,s1,0xc
}
    8020171c:	01256533          	or	a0,a0,s2
    80201720:	64a2                	ld	s1,8(sp)
    80201722:	6902                	ld	s2,0(sp)
    80201724:	6105                	addi	sp,sp,32
    80201726:	8082                	ret

0000000080201728 <test_page_table>:

void test_page_table(){
    80201728:	1101                	addi	sp,sp,-32
    8020172a:	ec06                	sd	ra,24(sp)
    8020172c:	e822                	sd	s0,16(sp)
    8020172e:	e426                	sd	s1,8(sp)
    80201730:	1000                	addi	s0,sp,32
    new_pt.root_ppn = get_frame();
    80201732:	fffff097          	auipc	ra,0xfffff
    80201736:	57a080e7          	jalr	1402(ra) # 80200cac <get_frame>
    8020173a:	0005049b          	sext.w	s1,a0
    8020173e:	1482                	slli	s1,s1,0x20
    struct PageTable test_page_table = new_pagetable();

    uint64 root_ppn = test_page_table.root_ppn;

    uint64 test_frame = get_frame();
    80201740:	fffff097          	auipc	ra,0xfffff
    80201744:	56c080e7          	jalr	1388(ra) # 80200cac <get_frame>
    new_pt.root_ppn = get_frame();
    80201748:	9081                	srli	s1,s1,0x20

    map(test_page_table, 1, test_frame, 0b1111);   // map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags)
    8020174a:	02051613          	slli	a2,a0,0x20
    8020174e:	4585                	li	a1,1
    80201750:	8526                	mv	a0,s1
    80201752:	46bd                	li	a3,15
    80201754:	9201                	srli	a2,a2,0x20
    80201756:	00000097          	auipc	ra,0x0
    8020175a:	dec080e7          	jalr	-532(ra) # 80201542 <map>

    unmap(test_page_table, 1);    // unmap(struct PageTable pg, uint64 vpn)
}
    8020175e:	6442                	ld	s0,16(sp)
    80201760:	60e2                	ld	ra,24(sp)
    unmap(test_page_table, 1);    // unmap(struct PageTable pg, uint64 vpn)
    80201762:	8526                	mv	a0,s1
}
    80201764:	64a2                	ld	s1,8(sp)
    unmap(test_page_table, 1);    // unmap(struct PageTable pg, uint64 vpn)
    80201766:	4585                	li	a1,1
}
    80201768:	6105                	addi	sp,sp,32
    unmap(test_page_table, 1);    // unmap(struct PageTable pg, uint64 vpn)
    8020176a:	00000317          	auipc	t1,0x0
    8020176e:	eb230067          	jr	-334(t1) # 8020161c <unmap>

0000000080201772 <initmalloc>:
#include "types.h"
#include "printf.h"
#include "panic.h"


void initmalloc(){
    80201772:	1141                	addi	sp,sp,-16
    80201774:	e022                	sd	s0,0(sp)
    80201776:	e406                	sd	ra,8(sp)
    80201778:	0800                	addi	s0,sp,16
  uint8 * heap_start = &heap;
  printf("[kernel] heap start is %x \n", heap_start);
    8020177a:	001a6597          	auipc	a1,0x1a6
    8020177e:	9c658593          	addi	a1,a1,-1594 # 803a7140 <heap>
    80201782:	00002517          	auipc	a0,0x2
    80201786:	b6e50513          	addi	a0,a0,-1170 # 802032f0 <digits+0x258>
    8020178a:	fffff097          	auipc	ra,0xfffff
    8020178e:	990080e7          	jalr	-1648(ra) # 8020011a <printf>
  for (uint32 index = 0; index < MAX_SIZE/8; index++) {
    80201792:	001a6797          	auipc	a5,0x1a6
    80201796:	9ae78793          	addi	a5,a5,-1618 # 803a7140 <heap>
    8020179a:	001aa717          	auipc	a4,0x1aa
    8020179e:	9a670713          	addi	a4,a4,-1626 # 803ab140 <heap+0x4000>
    heap[index] = 0x0; // initialize the heap data
    802017a2:	00078023          	sb	zero,0(a5)
  for (uint32 index = 0; index < MAX_SIZE/8; index++) {
    802017a6:	0785                	addi	a5,a5,1
    802017a8:	fee79de3          	bne	a5,a4,802017a2 <initmalloc+0x30>
  }
  printf("[kernel] heap end is %x \n", heap_start + MAX_SIZE);
}
    802017ac:	6402                	ld	s0,0(sp)
    802017ae:	60a2                	ld	ra,8(sp)
  printf("[kernel] heap end is %x \n", heap_start + MAX_SIZE);
    802017b0:	001c6597          	auipc	a1,0x1c6
    802017b4:	99058593          	addi	a1,a1,-1648 # 803c7140 <kernel_memorySet>
    802017b8:	00002517          	auipc	a0,0x2
    802017bc:	b5850513          	addi	a0,a0,-1192 # 80203310 <digits+0x278>
}
    802017c0:	0141                	addi	sp,sp,16
  printf("[kernel] heap end is %x \n", heap_start + MAX_SIZE);
    802017c2:	fffff317          	auipc	t1,0xfffff
    802017c6:	95830067          	jr	-1704(t1) # 8020011a <printf>

00000000802017ca <kmalloc>:

void * kmalloc(uint32 size){
  if (size > MAX_SIZE/2){ // if greater than 64kb, then the allocation is not allowed
    802017ca:	67c1                	lui	a5,0x10
    802017cc:	04a7e963          	bltu	a5,a0,8020181e <kmalloc+0x54>
    802017d0:	00002817          	auipc	a6,0x2
    802017d4:	bd080813          	addi	a6,a6,-1072 # 802033a0 <memomap>
    802017d8:	8742                	mv	a4,a6
    802017da:	4685                	li	a3,1
    panic("[kernel] kmalloc falied, size is too large!\n");
  } else {
    uint8 * heap_start = &heap;
    uint32 index = 0;
    for (uint8 i = 0; i <8; i++) {
    802017dc:	4781                	li	a5,0
    802017de:	45a1                	li	a1,8
    802017e0:	a019                	j	802017e6 <kmalloc+0x1c>
    802017e2:	00074683          	lbu	a3,0(a4)
    802017e6:	0017861b          	addiw	a2,a5,1
      if (size <= memomap[i]) {
    802017ea:	00a6fc63          	bgeu	a3,a0,80201802 <kmalloc+0x38>
    for (uint8 i = 0; i <8; i++) {
    802017ee:	0ff67793          	andi	a5,a2,255
    802017f2:	0705                	addi	a4,a4,1
    802017f4:	feb797e3          	bne	a5,a1,802017e2 <kmalloc+0x18>
        index = i;
        break;
      }
    }
    usedmap[index] = 1;
    if(index == 0) return (void*) heap_start; 
    802017f8:	001a6517          	auipc	a0,0x1a6
    802017fc:	94850513          	addi	a0,a0,-1720 # 803a7140 <heap>
    else return (void*) heap_start + 1024 * memomap[index];
  }
}
    80201800:	8082                	ret
        index = i;
    80201802:	0007871b          	sext.w	a4,a5
    if(index == 0) return (void*) heap_start; 
    80201806:	dbed                	beqz	a5,802017f8 <kmalloc+0x2e>
    else return (void*) heap_start + 1024 * memomap[index];
    80201808:	983a                	add	a6,a6,a4
    8020180a:	00084503          	lbu	a0,0(a6)
    8020180e:	001a6797          	auipc	a5,0x1a6
    80201812:	93278793          	addi	a5,a5,-1742 # 803a7140 <heap>
    80201816:	00a5151b          	slliw	a0,a0,0xa
    8020181a:	953e                	add	a0,a0,a5
    8020181c:	8082                	ret
void * kmalloc(uint32 size){
    8020181e:	1141                	addi	sp,sp,-16
    80201820:	e022                	sd	s0,0(sp)
    80201822:	e406                	sd	ra,8(sp)
    80201824:	0800                	addi	s0,sp,16
    panic("[kernel] kmalloc falied, size is too large!\n");
    80201826:	00002517          	auipc	a0,0x2
    8020182a:	b0a50513          	addi	a0,a0,-1270 # 80203330 <digits+0x298>
    8020182e:	fffff097          	auipc	ra,0xfffff
    80201832:	a80080e7          	jalr	-1408(ra) # 802002ae <panic>
}
    80201836:	60a2                	ld	ra,8(sp)
    80201838:	6402                	ld	s0,0(sp)
    8020183a:	0141                	addi	sp,sp,16
    8020183c:	8082                	ret

000000008020183e <kfree>:

void  kfree(void * addr){
  uint8 * heap_start = &heap;
  uint8 * allocated_start = (uint8*) addr;
  uint32 memo = (allocated_start - heap_start) / 1024;
    8020183e:	001a6797          	auipc	a5,0x1a6
    80201842:	90278793          	addi	a5,a5,-1790 # 803a7140 <heap>
    80201846:	40f50733          	sub	a4,a0,a5
    8020184a:	43f75793          	srai	a5,a4,0x3f
    8020184e:	3ff7f793          	andi	a5,a5,1023
void  kfree(void * addr){
    80201852:	1141                	addi	sp,sp,-16
  uint32 memo = (allocated_start - heap_start) / 1024;
    80201854:	9fb9                	addw	a5,a5,a4
void  kfree(void * addr){
    80201856:	e422                	sd	s0,8(sp)
        break;
      }
    }
  }
  usedmap[index] = 0;
  for (uint32 i = 0; i < memo*1024; i++){
    80201858:	c007f793          	andi	a5,a5,-1024
void  kfree(void * addr){
    8020185c:	0800                	addi	s0,sp,16
  for (uint32 i = 0; i < memo*1024; i++){
    8020185e:	0007871b          	sext.w	a4,a5
    80201862:	cf01                	beqz	a4,8020187a <kfree+0x3c>
    80201864:	37fd                	addiw	a5,a5,-1
    80201866:	1782                	slli	a5,a5,0x20
    80201868:	00150713          	addi	a4,a0,1
    8020186c:	9381                	srli	a5,a5,0x20
    8020186e:	97ba                	add	a5,a5,a4
    *(allocated_start + i) = 0x0;
    80201870:	00050023          	sb	zero,0(a0)
  for (uint32 i = 0; i < memo*1024; i++){
    80201874:	0505                	addi	a0,a0,1
    80201876:	fef51de3          	bne	a0,a5,80201870 <kfree+0x32>
  }
    8020187a:	6422                	ld	s0,8(sp)
    8020187c:	0141                	addi	sp,sp,16
    8020187e:	8082                	ret

0000000080201880 <new_Map_Area>:
#include "mm/framealloc.h"
#include "mm/MapArea.h"
#include "console.h"
#include "trap_context.h"

struct Map_Area new_Map_Area(uint64 start_addr, uint64 end_addr, uint64 map_type, uint64 permissions){
    80201880:	1141                	addi	sp,sp,-16
    80201882:	e422                	sd	s0,8(sp)
    80201884:	0800                	addi	s0,sp,16
    uint64 start_vpn = (start_addr) / PAGE_SIZE;
    uint64 end_vpn = (end_addr) / PAGE_SIZE;

    if (((end_addr) % PAGE_SIZE) > 0) end_vpn += 1;
    80201886:	03461893          	slli	a7,a2,0x34
    new_map_area.vpn_start = start_vpn;
    new_map_area.vpn_end = end_vpn;
    new_map_area.map_type = map_type;
    new_map_area.permission = permissions;
    return new_map_area;
}
    8020188a:	6422                	ld	s0,8(sp)
    uint64 end_vpn = (end_addr) / PAGE_SIZE;
    8020188c:	00c65813          	srli	a6,a2,0xc
    if (((end_addr) % PAGE_SIZE) > 0) end_vpn += 1;
    80201890:	011038b3          	snez	a7,a7
    uint64 start_vpn = (start_addr) / PAGE_SIZE;
    80201894:	00c5d313          	srli	t1,a1,0xc
    if (((end_addr) % PAGE_SIZE) > 0) end_vpn += 1;
    80201898:	9846                	add	a6,a6,a7
    return new_map_area;
    8020189a:	e10c                	sd	a1,0(a0)
    8020189c:	e510                	sd	a2,8(a0)
    8020189e:	00653823          	sd	t1,16(a0)
    802018a2:	01053c23          	sd	a6,24(a0)
    802018a6:	f114                	sd	a3,32(a0)
    802018a8:	f518                	sd	a4,40(a0)
}
    802018aa:	0141                	addi	sp,sp,16
    802018ac:	8082                	ret

00000000802018ae <copy_to_frame>:

void copy_to_frame(uint64 ppn, uint64 copy_start, uint64 copy_end, uint64 start_offset){
    802018ae:	7179                	addi	sp,sp,-48
    802018b0:	f022                	sd	s0,32(sp)
    802018b2:	ec26                	sd	s1,24(sp)
    802018b4:	e84a                	sd	s2,16(sp)
    802018b6:	e44e                	sd	s3,8(sp)
    802018b8:	f406                	sd	ra,40(sp)
    802018ba:	1800                	addi	s0,sp,48
    802018bc:	89b6                	mv	s3,a3
    802018be:	84ae                	mv	s1,a1
    802018c0:	8932                	mv	s2,a2
    uint64 phys_addr_start = to_physical_addr(ppn) + start_offset;
    802018c2:	00000097          	auipc	ra,0x0
    802018c6:	bf0080e7          	jalr	-1040(ra) # 802014b2 <to_physical_addr>
    802018ca:	954e                	add	a0,a0,s3

    if (copy_end == 0){
    802018cc:	02090663          	beqz	s2,802018f8 <copy_to_frame+0x4a>
        for (int i = 0; i < PAGE_SIZE - start_offset; i++){
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
        }
    }else{
        for (int i = 0; i < copy_end - copy_start; i++){
    802018d0:	85a6                	mv	a1,s1
    802018d2:	8d05                	sub	a0,a0,s1
    802018d4:	00990b63          	beq	s2,s1,802018ea <copy_to_frame+0x3c>
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
    802018d8:	0005c703          	lbu	a4,0(a1)
    802018dc:	00b507b3          	add	a5,a0,a1
    802018e0:	0585                	addi	a1,a1,1
    802018e2:	00e78023          	sb	a4,0(a5)
        for (int i = 0; i < copy_end - copy_start; i++){
    802018e6:	ff2599e3          	bne	a1,s2,802018d8 <copy_to_frame+0x2a>
        }
    }
}
    802018ea:	70a2                	ld	ra,40(sp)
    802018ec:	7402                	ld	s0,32(sp)
    802018ee:	64e2                	ld	s1,24(sp)
    802018f0:	6942                	ld	s2,16(sp)
    802018f2:	69a2                	ld	s3,8(sp)
    802018f4:	6145                	addi	sp,sp,48
    802018f6:	8082                	ret
        for (int i = 0; i < PAGE_SIZE - start_offset; i++){
    802018f8:	6785                	lui	a5,0x1
    802018fa:	413785b3          	sub	a1,a5,s3
    802018fe:	ff3786e3          	beq	a5,s3,802018ea <copy_to_frame+0x3c>
    80201902:	87a6                	mv	a5,s1
    80201904:	95a6                	add	a1,a1,s1
    80201906:	8d05                	sub	a0,a0,s1
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
    80201908:	0007c683          	lbu	a3,0(a5) # 1000 <n+0xfe0>
    8020190c:	00f50733          	add	a4,a0,a5
    80201910:	0785                	addi	a5,a5,1
    80201912:	00d70023          	sb	a3,0(a4)
        for (int i = 0; i < PAGE_SIZE - start_offset; i++){
    80201916:	fef599e3          	bne	a1,a5,80201908 <copy_to_frame+0x5a>
}
    8020191a:	70a2                	ld	ra,40(sp)
    8020191c:	7402                	ld	s0,32(sp)
    8020191e:	64e2                	ld	s1,24(sp)
    80201920:	6942                	ld	s2,16(sp)
    80201922:	69a2                	ld	s3,8(sp)
    80201924:	6145                	addi	sp,sp,48
    80201926:	8082                	ret

0000000080201928 <push_Map_Area>:

void push_Map_Area(struct Map_Area map_area, struct PageTable pg, uint64 copy_start, uint64 copy_end){
    80201928:	7159                	addi	sp,sp,-112
    8020192a:	f0a2                	sd	s0,96(sp)
    8020192c:	eca6                	sd	s1,88(sp)
    8020192e:	e4ce                	sd	s3,72(sp)
    80201930:	e0d2                	sd	s4,64(sp)
    80201932:	fc56                	sd	s5,56(sp)
    80201934:	f486                	sd	ra,104(sp)
    80201936:	e8ca                	sd	s2,80(sp)
    80201938:	f85a                	sd	s6,48(sp)
    8020193a:	f45e                	sd	s7,40(sp)
    8020193c:	f062                	sd	s8,32(sp)
    8020193e:	ec66                	sd	s9,24(sp)
    80201940:	e86a                	sd	s10,16(sp)
    80201942:	e46e                	sd	s11,8(sp)
    80201944:	1880                	addi	s0,sp,112
    uint64 map_type = map_area.map_type;
    80201946:	711c                	ld	a5,32(a0)
    uint64 vpn_start = map_area.vpn_start;
    80201948:	6904                	ld	s1,16(a0)
    uint64 vpn_end = map_area.vpn_end;
    8020194a:	01853a03          	ld	s4,24(a0)
    uint64 permission = map_area.permission;
    8020194e:	02853a83          	ld	s5,40(a0)
void push_Map_Area(struct Map_Area map_area, struct PageTable pg, uint64 copy_start, uint64 copy_end){
    80201952:	89ae                	mv	s3,a1

    uint64 start_addr = map_area.start_addr;
    uint64 start_offset = start_addr & 0b111111111111;

    if (map_type == 0){    // 进行Identical的映射
    80201954:	ef8d                	bnez	a5,8020198e <push_Map_Area+0x66>
        for (uint64 vpn = vpn_start; vpn <= vpn_end; vpn++){
    80201956:	009a6d63          	bltu	s4,s1,80201970 <push_Map_Area+0x48>
            map(pg, vpn, vpn, permission);
    8020195a:	8626                	mv	a2,s1
    8020195c:	85a6                	mv	a1,s1
    8020195e:	86d6                	mv	a3,s5
        for (uint64 vpn = vpn_start; vpn <= vpn_end; vpn++){
    80201960:	0485                	addi	s1,s1,1
            map(pg, vpn, vpn, permission);
    80201962:	854e                	mv	a0,s3
    80201964:	00000097          	auipc	ra,0x0
    80201968:	bde080e7          	jalr	-1058(ra) # 80201542 <map>
        for (uint64 vpn = vpn_start; vpn <= vpn_end; vpn++){
    8020196c:	fe9a77e3          	bgeu	s4,s1,8020195a <push_Map_Area+0x32>
            map(pg, vpn_end, target_ppn, permission);
        }
    }else{
        panic("Wrong in pushing MapArea!");
    }
}
    80201970:	70a6                	ld	ra,104(sp)
    80201972:	7406                	ld	s0,96(sp)
    80201974:	64e6                	ld	s1,88(sp)
    80201976:	6946                	ld	s2,80(sp)
    80201978:	69a6                	ld	s3,72(sp)
    8020197a:	6a06                	ld	s4,64(sp)
    8020197c:	7ae2                	ld	s5,56(sp)
    8020197e:	7b42                	ld	s6,48(sp)
    80201980:	7ba2                	ld	s7,40(sp)
    80201982:	7c02                	ld	s8,32(sp)
    80201984:	6ce2                	ld	s9,24(sp)
    80201986:	6d42                	ld	s10,16(sp)
    80201988:	6da2                	ld	s11,8(sp)
    8020198a:	6165                	addi	sp,sp,112
    8020198c:	8082                	ret
    }else if (map_type == 1){    // 进行Framed映射
    8020198e:	4705                	li	a4,1
    80201990:	0ae79f63          	bne	a5,a4,80201a4e <push_Map_Area+0x126>
    uint64 start_offset = start_addr & 0b111111111111;
    80201994:	00053c03          	ld	s8,0(a0)
    80201998:	8932                	mv	s2,a2
    8020199a:	8b36                	mv	s6,a3
    8020199c:	1c52                	slli	s8,s8,0x34
    8020199e:	034c5c13          	srli	s8,s8,0x34
        for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    802019a2:	0544ff63          	bgeu	s1,s4,80201a00 <push_Map_Area+0xd8>
        for (int i = 0; i < PAGE_SIZE - start_offset; i++){
    802019a6:	6b85                	lui	s7,0x1
            uint64 target_ppn = get_frame();
    802019a8:	fffff097          	auipc	ra,0xfffff
    802019ac:	304080e7          	jalr	772(ra) # 80200cac <get_frame>
    802019b0:	02051d93          	slli	s11,a0,0x20
    802019b4:	020ddd93          	srli	s11,s11,0x20
    802019b8:	8d2a                	mv	s10,a0
            uint64 map_status = map(pg, vpn, target_ppn, permission);
    802019ba:	86d6                	mv	a3,s5
    802019bc:	866e                	mv	a2,s11
    802019be:	85a6                	mv	a1,s1
    802019c0:	854e                	mv	a0,s3
    802019c2:	00000097          	auipc	ra,0x0
    802019c6:	b80080e7          	jalr	-1152(ra) # 80201542 <map>
            uint64 target_ppn = get_frame();
    802019ca:	2d01                	sext.w	s10,s10
            uint64 map_status = map(pg, vpn, target_ppn, permission);
    802019cc:	8caa                	mv	s9,a0
            if (map_status != 0){                                      // the vpn has already been mapped
    802019ce:	e555                	bnez	a0,80201a7a <push_Map_Area+0x152>
    uint64 phys_addr_start = to_physical_addr(ppn) + start_offset;
    802019d0:	856e                	mv	a0,s11
    802019d2:	00000097          	auipc	ra,0x0
    802019d6:	ae0080e7          	jalr	-1312(ra) # 802014b2 <to_physical_addr>
    802019da:	9562                	add	a0,a0,s8
        for (int i = 0; i < PAGE_SIZE - start_offset; i++){
    802019dc:	87ca                	mv	a5,s2
    802019de:	418b8c33          	sub	s8,s7,s8
    802019e2:	9962                	add	s2,s2,s8
    802019e4:	8d1d                	sub	a0,a0,a5
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
    802019e6:	0007c603          	lbu	a2,0(a5)
    802019ea:	00f50733          	add	a4,a0,a5
    802019ee:	0785                	addi	a5,a5,1
    802019f0:	00c70023          	sb	a2,0(a4)
        for (int i = 0; i < PAGE_SIZE - start_offset; i++){
    802019f4:	fef919e3          	bne	s2,a5,802019e6 <push_Map_Area+0xbe>
        for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    802019f8:	0485                	addi	s1,s1,1
    802019fa:	4c01                	li	s8,0
    802019fc:	fa9a16e3          	bne	s4,s1,802019a8 <push_Map_Area+0x80>
        if (copy_end > copy_start){
    80201a00:	f76978e3          	bgeu	s2,s6,80201970 <push_Map_Area+0x48>
            uint64 target_ppn = get_frame();
    80201a04:	fffff097          	auipc	ra,0xfffff
    80201a08:	2a8080e7          	jalr	680(ra) # 80200cac <get_frame>
    80201a0c:	02051493          	slli	s1,a0,0x20
    80201a10:	9081                	srli	s1,s1,0x20
            copy_to_frame(target_ppn, copy_start, copy_end, start_offset);
    80201a12:	86e2                	mv	a3,s8
    80201a14:	865a                	mv	a2,s6
    80201a16:	85ca                	mv	a1,s2
    80201a18:	8526                	mv	a0,s1
    80201a1a:	00000097          	auipc	ra,0x0
    80201a1e:	e94080e7          	jalr	-364(ra) # 802018ae <copy_to_frame>
}
    80201a22:	7406                	ld	s0,96(sp)
    80201a24:	70a6                	ld	ra,104(sp)
    80201a26:	6946                	ld	s2,80(sp)
    80201a28:	7b42                	ld	s6,48(sp)
    80201a2a:	7ba2                	ld	s7,40(sp)
    80201a2c:	7c02                	ld	s8,32(sp)
    80201a2e:	6ce2                	ld	s9,24(sp)
    80201a30:	6d42                	ld	s10,16(sp)
    80201a32:	6da2                	ld	s11,8(sp)
            map(pg, vpn_end, target_ppn, permission);
    80201a34:	86d6                	mv	a3,s5
    80201a36:	8626                	mv	a2,s1
}
    80201a38:	7ae2                	ld	s5,56(sp)
    80201a3a:	64e6                	ld	s1,88(sp)
            map(pg, vpn_end, target_ppn, permission);
    80201a3c:	85d2                	mv	a1,s4
    80201a3e:	854e                	mv	a0,s3
}
    80201a40:	6a06                	ld	s4,64(sp)
    80201a42:	69a6                	ld	s3,72(sp)
    80201a44:	6165                	addi	sp,sp,112
            map(pg, vpn_end, target_ppn, permission);
    80201a46:	00000317          	auipc	t1,0x0
    80201a4a:	afc30067          	jr	-1284(t1) # 80201542 <map>
}
    80201a4e:	7406                	ld	s0,96(sp)
    80201a50:	70a6                	ld	ra,104(sp)
    80201a52:	64e6                	ld	s1,88(sp)
    80201a54:	6946                	ld	s2,80(sp)
    80201a56:	69a6                	ld	s3,72(sp)
    80201a58:	6a06                	ld	s4,64(sp)
    80201a5a:	7ae2                	ld	s5,56(sp)
    80201a5c:	7b42                	ld	s6,48(sp)
    80201a5e:	7ba2                	ld	s7,40(sp)
    80201a60:	7c02                	ld	s8,32(sp)
    80201a62:	6ce2                	ld	s9,24(sp)
    80201a64:	6d42                	ld	s10,16(sp)
    80201a66:	6da2                	ld	s11,8(sp)
        panic("Wrong in pushing MapArea!");
    80201a68:	00002517          	auipc	a0,0x2
    80201a6c:	8f850513          	addi	a0,a0,-1800 # 80203360 <digits+0x2c8>
}
    80201a70:	6165                	addi	sp,sp,112
        panic("Wrong in pushing MapArea!");
    80201a72:	fffff317          	auipc	t1,0xfffff
    80201a76:	83c30067          	jr	-1988(t1) # 802002ae <panic>
                free_frame(target_ppn);
    80201a7a:	856a                	mv	a0,s10
    80201a7c:	fffff097          	auipc	ra,0xfffff
    80201a80:	358080e7          	jalr	856(ra) # 80200dd4 <free_frame>
    80201a84:	8de6                	mv	s11,s9
    80201a86:	b7a9                	j	802019d0 <push_Map_Area+0xa8>

0000000080201a88 <free_Map_Area>:

void free_Map_Area(struct Map_Area map_area, struct PageTable pg){
    80201a88:	7179                	addi	sp,sp,-48
    80201a8a:	f022                	sd	s0,32(sp)
    80201a8c:	ec26                	sd	s1,24(sp)
    80201a8e:	e44e                	sd	s3,8(sp)
    80201a90:	f406                	sd	ra,40(sp)
    80201a92:	e84a                	sd	s2,16(sp)
    80201a94:	1800                	addi	s0,sp,48
    uint64 vpn_start = map_area.vpn_start;
    80201a96:	6904                	ld	s1,16(a0)
    uint64 vpn_end = map_area.vpn_end;
    80201a98:	01853983          	ld	s3,24(a0)

    for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    80201a9c:	0134fc63          	bgeu	s1,s3,80201ab4 <free_Map_Area+0x2c>
    80201aa0:	892e                	mv	s2,a1
        unmap(pg, vpn);
    80201aa2:	85a6                	mv	a1,s1
    80201aa4:	854a                	mv	a0,s2
    for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    80201aa6:	0485                	addi	s1,s1,1
        unmap(pg, vpn);
    80201aa8:	00000097          	auipc	ra,0x0
    80201aac:	b74080e7          	jalr	-1164(ra) # 8020161c <unmap>
    for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    80201ab0:	fe9999e3          	bne	s3,s1,80201aa2 <free_Map_Area+0x1a>
    }
}
    80201ab4:	70a2                	ld	ra,40(sp)
    80201ab6:	7402                	ld	s0,32(sp)
    80201ab8:	64e2                	ld	s1,24(sp)
    80201aba:	6942                	ld	s2,16(sp)
    80201abc:	69a2                	ld	s3,8(sp)
    80201abe:	6145                	addi	sp,sp,48
    80201ac0:	8082                	ret

0000000080201ac2 <test_map_area>:


void test_map_area(){
    80201ac2:	7119                	addi	sp,sp,-128
    80201ac4:	fc86                	sd	ra,120(sp)
    80201ac6:	f8a2                	sd	s0,112(sp)
    80201ac8:	f4a6                	sd	s1,104(sp)
    80201aca:	0100                	addi	s0,sp,128
    80201acc:	f0ca                	sd	s2,96(sp)
    return new_map_area;
    80201ace:	000807b7          	lui	a5,0x80
    80201ad2:	20078713          	addi	a4,a5,512 # 80200 <n+0x801e0>
    80201ad6:	30078793          	addi	a5,a5,768
    80201ada:	fcf43423          	sd	a5,-56(s0)
    80201ade:	40100493          	li	s1,1025
    80201ae2:	4785                	li	a5,1
    80201ae4:	00803937          	lui	s2,0x803
    80201ae8:	04d6                	slli	s1,s1,0x15
    80201aea:	0922                	slli	s2,s2,0x8
    80201aec:	fcf43823          	sd	a5,-48(s0)
    80201af0:	47bd                	li	a5,15
    80201af2:	fa943823          	sd	s1,-80(s0)
    80201af6:	fb243c23          	sd	s2,-72(s0)
    80201afa:	fce43023          	sd	a4,-64(s0)
    80201afe:	fcf43c23          	sd	a5,-40(s0)
    struct Map_Area MA = new_Map_Area(0X80200000, 0X80300000, 1, 0b1111);
    struct PageTable PG = new_pagetable();
    80201b02:	00000097          	auipc	ra,0x0
    80201b06:	9be080e7          	jalr	-1602(ra) # 802014c0 <new_pagetable>


    push_Map_Area(MA, PG, 0x80200000, 0x80300000);
    80201b0a:	fb043783          	ld	a5,-80(s0)
    struct PageTable PG = new_pagetable();
    80201b0e:	85aa                	mv	a1,a0
    push_Map_Area(MA, PG, 0x80200000, 0x80300000);
    80201b10:	86ca                	mv	a3,s2
    80201b12:	f8f43023          	sd	a5,-128(s0)
    80201b16:	fb843783          	ld	a5,-72(s0)
    80201b1a:	8626                	mv	a2,s1
    80201b1c:	f8040513          	addi	a0,s0,-128
    80201b20:	f8f43423          	sd	a5,-120(s0)
    80201b24:	fc043783          	ld	a5,-64(s0)
    80201b28:	f8f43823          	sd	a5,-112(s0)
    80201b2c:	fc843783          	ld	a5,-56(s0)
    80201b30:	f8f43c23          	sd	a5,-104(s0)
    80201b34:	fd043783          	ld	a5,-48(s0)
    80201b38:	faf43023          	sd	a5,-96(s0)
    80201b3c:	fd843783          	ld	a5,-40(s0)
    80201b40:	faf43423          	sd	a5,-88(s0)
    80201b44:	00000097          	auipc	ra,0x0
    80201b48:	de4080e7          	jalr	-540(ra) # 80201928 <push_Map_Area>
    80201b4c:	70e6                	ld	ra,120(sp)
    80201b4e:	7446                	ld	s0,112(sp)
    80201b50:	74a6                	ld	s1,104(sp)
    80201b52:	7906                	ld	s2,96(sp)
    80201b54:	6109                	addi	sp,sp,128
    80201b56:	8082                	ret

0000000080201b58 <map_kernel>:
extern uint32 edata;
extern uint32 sbss_with_stack;
extern uint32 ebss;
extern void __restore(uint64 a0, uint64 a1);

void map_kernel(){
    80201b58:	711d                	addi	sp,sp,-96
    80201b5a:	ec86                	sd	ra,88(sp)
    80201b5c:	e8a2                	sd	s0,80(sp)
    80201b5e:	e4a6                	sd	s1,72(sp)
    80201b60:	1080                	addi	s0,sp,96
    80201b62:	e0ca                	sd	s2,64(sp)
    80201b64:	fc4e                	sd	s3,56(sp)

    kernel_memorySet.page_table = new_pagetable();
    80201b66:	001c5497          	auipc	s1,0x1c5
    80201b6a:	5da48493          	addi	s1,s1,1498 # 803c7140 <kernel_memorySet>
    80201b6e:	00000097          	auipc	ra,0x0
    80201b72:	952080e7          	jalr	-1710(ra) # 802014c0 <new_pagetable>

    // map .text
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201b76:	ffffe917          	auipc	s2,0xffffe
    80201b7a:	48a90913          	addi	s2,s2,1162 # 80200000 <_entry>
    80201b7e:	00001997          	auipc	s3,0x1
    80201b82:	48298993          	addi	s3,s3,1154 # 80203000 <etext>
    80201b86:	4715                	li	a4,5
    kernel_memorySet.page_table = new_pagetable();
    80201b88:	e088                	sd	a0,0(s1)
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201b8a:	864e                	mv	a2,s3
    80201b8c:	85ca                	mv	a1,s2
    80201b8e:	fa040513          	addi	a0,s0,-96
    80201b92:	4681                	li	a3,0
    80201b94:	00000097          	auipc	ra,0x0
    80201b98:	cec080e7          	jalr	-788(ra) # 80201880 <new_Map_Area>
    80201b9c:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.text, kernel_memorySet.page_table, &stext, &etext);
    80201ba0:	608c                	ld	a1,0(s1)
    80201ba2:	86ce                	mv	a3,s3
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201ba4:	e49c                	sd	a5,8(s1)
    80201ba6:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.text, kernel_memorySet.page_table, &stext, &etext);
    80201baa:	864a                	mv	a2,s2
    80201bac:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201bb0:	e89c                	sd	a5,16(s1)
    80201bb2:	fb043783          	ld	a5,-80(s0)

    // map .rodata
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    80201bb6:	00001917          	auipc	s2,0x1
    80201bba:	44a90913          	addi	s2,s2,1098 # 80203000 <etext>
    80201bbe:	00002997          	auipc	s3,0x2
    80201bc2:	44298993          	addi	s3,s3,1090 # 80204000 <_num_app>
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201bc6:	ec9c                	sd	a5,24(s1)
    80201bc8:	fb843783          	ld	a5,-72(s0)
    80201bcc:	f09c                	sd	a5,32(s1)
    80201bce:	fc043783          	ld	a5,-64(s0)
    80201bd2:	f49c                	sd	a5,40(s1)
    80201bd4:	fc843783          	ld	a5,-56(s0)
    80201bd8:	f89c                	sd	a5,48(s1)
    push_Map_Area(kernel_memorySet.text, kernel_memorySet.page_table, &stext, &etext);
    80201bda:	00000097          	auipc	ra,0x0
    80201bde:	d4e080e7          	jalr	-690(ra) # 80201928 <push_Map_Area>
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    80201be2:	4705                	li	a4,1
    80201be4:	864e                	mv	a2,s3
    80201be6:	85ca                	mv	a1,s2
    80201be8:	fa040513          	addi	a0,s0,-96
    80201bec:	4681                	li	a3,0
    80201bee:	00000097          	auipc	ra,0x0
    80201bf2:	c92080e7          	jalr	-878(ra) # 80201880 <new_Map_Area>
    80201bf6:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.rodata, kernel_memorySet.page_table, &srodata, &erodata);
    80201bfa:	608c                	ld	a1,0(s1)
    80201bfc:	86ce                	mv	a3,s3
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    80201bfe:	fc9c                	sd	a5,56(s1)
    80201c00:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.rodata, kernel_memorySet.page_table, &srodata, &erodata);
    80201c04:	864a                	mv	a2,s2
    80201c06:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    80201c0a:	e0bc                	sd	a5,64(s1)
    80201c0c:	fb043783          	ld	a5,-80(s0)

    // map .data
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    80201c10:	00002917          	auipc	s2,0x2
    80201c14:	3f090913          	addi	s2,s2,1008 # 80204000 <_num_app>
    80201c18:	0019a997          	auipc	s3,0x19a
    80201c1c:	3e898993          	addi	s3,s3,1000 # 8039c000 <boot_stack>
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    80201c20:	e4bc                	sd	a5,72(s1)
    80201c22:	fb843783          	ld	a5,-72(s0)
    80201c26:	e8bc                	sd	a5,80(s1)
    80201c28:	fc043783          	ld	a5,-64(s0)
    80201c2c:	ecbc                	sd	a5,88(s1)
    80201c2e:	fc843783          	ld	a5,-56(s0)
    80201c32:	f0bc                	sd	a5,96(s1)
    push_Map_Area(kernel_memorySet.rodata, kernel_memorySet.page_table, &srodata, &erodata);
    80201c34:	00000097          	auipc	ra,0x0
    80201c38:	cf4080e7          	jalr	-780(ra) # 80201928 <push_Map_Area>
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    80201c3c:	470d                	li	a4,3
    80201c3e:	864e                	mv	a2,s3
    80201c40:	85ca                	mv	a1,s2
    80201c42:	fa040513          	addi	a0,s0,-96
    80201c46:	4681                	li	a3,0
    80201c48:	00000097          	auipc	ra,0x0
    80201c4c:	c38080e7          	jalr	-968(ra) # 80201880 <new_Map_Area>
    80201c50:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.data, kernel_memorySet.page_table, &sdata, &edata);
    80201c54:	608c                	ld	a1,0(s1)
    80201c56:	86ce                	mv	a3,s3
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    80201c58:	f4bc                	sd	a5,104(s1)
    80201c5a:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.data, kernel_memorySet.page_table, &sdata, &edata);
    80201c5e:	864a                	mv	a2,s2
    80201c60:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    80201c64:	f8bc                	sd	a5,112(s1)
    80201c66:	fb043783          	ld	a5,-80(s0)

    // map .bss
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201c6a:	0019a917          	auipc	s2,0x19a
    80201c6e:	39690913          	addi	s2,s2,918 # 8039c000 <boot_stack>
    80201c72:	001c8997          	auipc	s3,0x1c8
    80201c76:	38e98993          	addi	s3,s3,910 # 803ca000 <ebss>
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    80201c7a:	fcbc                	sd	a5,120(s1)
    80201c7c:	fb843783          	ld	a5,-72(s0)
    80201c80:	e0dc                	sd	a5,128(s1)
    80201c82:	fc043783          	ld	a5,-64(s0)
    80201c86:	e4dc                	sd	a5,136(s1)
    80201c88:	fc843783          	ld	a5,-56(s0)
    80201c8c:	e8dc                	sd	a5,144(s1)
    push_Map_Area(kernel_memorySet.data, kernel_memorySet.page_table, &sdata, &edata);
    80201c8e:	00000097          	auipc	ra,0x0
    80201c92:	c9a080e7          	jalr	-870(ra) # 80201928 <push_Map_Area>
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201c96:	470d                	li	a4,3
    80201c98:	864e                	mv	a2,s3
    80201c9a:	85ca                	mv	a1,s2
    80201c9c:	fa040513          	addi	a0,s0,-96
    80201ca0:	4681                	li	a3,0
    80201ca2:	00000097          	auipc	ra,0x0
    80201ca6:	bde080e7          	jalr	-1058(ra) # 80201880 <new_Map_Area>
    80201caa:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.bss, kernel_memorySet.page_table, &sbss_with_stack, &ebss);
    80201cae:	608c                	ld	a1,0(s1)
    80201cb0:	86ce                	mv	a3,s3
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201cb2:	ecdc                	sd	a5,152(s1)
    80201cb4:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.bss, kernel_memorySet.page_table, &sbss_with_stack, &ebss);
    80201cb8:	864a                	mv	a2,s2
    80201cba:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201cbe:	f0dc                	sd	a5,160(s1)
    80201cc0:	fb043783          	ld	a5,-80(s0)

    // map Avaibable Frames
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    80201cc4:	40500913          	li	s2,1029
    80201cc8:	0956                	slli	s2,s2,0x15
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201cca:	f4dc                	sd	a5,168(s1)
    80201ccc:	fb843783          	ld	a5,-72(s0)
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    80201cd0:	001c8997          	auipc	s3,0x1c8
    80201cd4:	33098993          	addi	s3,s3,816 # 803ca000 <ebss>
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201cd8:	f8dc                	sd	a5,176(s1)
    80201cda:	fc043783          	ld	a5,-64(s0)
    80201cde:	fcdc                	sd	a5,184(s1)
    80201ce0:	fc843783          	ld	a5,-56(s0)
    80201ce4:	e0fc                	sd	a5,192(s1)
    push_Map_Area(kernel_memorySet.bss, kernel_memorySet.page_table, &sbss_with_stack, &ebss);
    80201ce6:	00000097          	auipc	ra,0x0
    80201cea:	c42080e7          	jalr	-958(ra) # 80201928 <push_Map_Area>
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    80201cee:	fff90613          	addi	a2,s2,-1
    80201cf2:	85ce                	mv	a1,s3
    80201cf4:	fa040513          	addi	a0,s0,-96
    80201cf8:	4681                	li	a3,0
    80201cfa:	471d                	li	a4,7
    80201cfc:	00000097          	auipc	ra,0x0
    80201d00:	b84080e7          	jalr	-1148(ra) # 80201880 <new_Map_Area>
    80201d04:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.Available_Frames, kernel_memorySet.page_table, &ekernel, 0x80A00000);
    80201d08:	608c                	ld	a1,0(s1)
    80201d0a:	86ca                	mv	a3,s2
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    80201d0c:	e4fc                	sd	a5,200(s1)
    80201d0e:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.Available_Frames, kernel_memorySet.page_table, &ekernel, 0x80A00000);
    80201d12:	864e                	mv	a2,s3
    80201d14:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    80201d18:	e8fc                	sd	a5,208(s1)
    80201d1a:	fb043783          	ld	a5,-80(s0)
    80201d1e:	ecfc                	sd	a5,216(s1)
    80201d20:	fb843783          	ld	a5,-72(s0)
    80201d24:	f0fc                	sd	a5,224(s1)
    80201d26:	fc043783          	ld	a5,-64(s0)
    80201d2a:	f4fc                	sd	a5,232(s1)
    80201d2c:	fc843783          	ld	a5,-56(s0)
    80201d30:	f8fc                	sd	a5,240(s1)
    push_Map_Area(kernel_memorySet.Available_Frames, kernel_memorySet.page_table, &ekernel, 0x80A00000);
    80201d32:	00000097          	auipc	ra,0x0
    80201d36:	bf6080e7          	jalr	-1034(ra) # 80201928 <push_Map_Area>
}
    80201d3a:	60e6                	ld	ra,88(sp)
    80201d3c:	6446                	ld	s0,80(sp)
    80201d3e:	64a6                	ld	s1,72(sp)
    80201d40:	6906                	ld	s2,64(sp)
    80201d42:	79e2                	ld	s3,56(sp)
    80201d44:	6125                	addi	sp,sp,96
    80201d46:	8082                	ret

0000000080201d48 <root_ppn_to_token>:

uint64 root_ppn_to_token(uint64 root_ppn){
    80201d48:	1141                	addi	sp,sp,-16
    80201d4a:	e422                	sd	s0,8(sp)
    80201d4c:	0800                	addi	s0,sp,16
    uint64 eight = 8;     // 我的编译器无法让我正常8 << 60，只能这样
    return (eight << 60) | root_ppn;
}
    80201d4e:	6422                	ld	s0,8(sp)
    return (eight << 60) | root_ppn;
    80201d50:	57fd                	li	a5,-1
    80201d52:	17fe                	slli	a5,a5,0x3f
}
    80201d54:	8d5d                	or	a0,a0,a5
    80201d56:	0141                	addi	sp,sp,16
    80201d58:	8082                	ret

0000000080201d5a <activate_mm>:

void activate_mm(){
    80201d5a:	1141                	addi	sp,sp,-16
    80201d5c:	e422                	sd	s0,8(sp)
    80201d5e:	0800                	addi	s0,sp,16
    return (eight << 60) | root_ppn;
    80201d60:	577d                	li	a4,-1
    80201d62:	001c5797          	auipc	a5,0x1c5
    80201d66:	3de7b783          	ld	a5,990(a5) # 803c7140 <kernel_memorySet>
    80201d6a:	177e                	slli	a4,a4,0x3f
    80201d6c:	8fd9                	or	a5,a5,a4
	asm volatile("csrw satp, %0" : : "r" (x));
    80201d6e:	18079073          	csrw	satp,a5
sfence_vma()
{
	// the zero, zero means flush all TLB entries.
	// asm volatile("sfence.vma zero, zero");
	#ifdef QEMU
	asm volatile("sfence.vma");
    80201d72:	12000073          	sfence.vma
    uint64 kernel_token = root_ppn_to_token(kernel_memorySet.page_table.root_ppn);
    w_satp(kernel_token);
    sfence_vma();
}
    80201d76:	6422                	ld	s0,8(sp)
    80201d78:	0141                	addi	sp,sp,16
    80201d7a:	8082                	ret

0000000080201d7c <copy_mem_set>:


struct User_MemorySet copy_mem_set(struct User_MemorySet target_mem_set){
    80201d7c:	7159                	addi	sp,sp,-112
    80201d7e:	f486                	sd	ra,104(sp)
    80201d80:	f0a2                	sd	s0,96(sp)
    80201d82:	eca6                	sd	s1,88(sp)
    80201d84:	1880                	addi	s0,sp,112
    80201d86:	e8ca                	sd	s2,80(sp)
    80201d88:	e4ce                	sd	s3,72(sp)
    80201d8a:	e0d2                	sd	s4,64(sp)
    80201d8c:	fc56                	sd	s5,56(sp)
    80201d8e:	892e                	mv	s2,a1
    80201d90:	84aa                	mv	s1,a0

    struct User_MemorySet return_memory_set;

    uint64 target_root_ppn = target_mem_set.page_table.root_ppn; 
    80201d92:	0005b983          	ld	s3,0(a1)

    return_memory_set.page_table = new_pagetable();
    80201d96:	fffff097          	auipc	ra,0xfffff
    80201d9a:	72a080e7          	jalr	1834(ra) # 802014c0 <new_pagetable>

    // map text
    struct Map_Area target_text;
    target_text = target_mem_set.text;
    80201d9e:	01093a83          	ld	s5,16(s2)
    80201da2:	00893a03          	ld	s4,8(s2)
    uint64 start_va = target_text.start_addr;
    uint64 end_va = target_text.end_addr;
    uint64 permission = target_text.permission;
    return_memory_set.text = new_Map_Area(start_va, end_va, 1, permission);
    80201da6:	03093703          	ld	a4,48(s2)
    80201daa:	8656                	mv	a2,s5
    80201dac:	4685                	li	a3,1
    return_memory_set.page_table = new_pagetable();
    80201dae:	e088                	sd	a0,0(s1)
    return_memory_set.text = new_Map_Area(start_va, end_va, 1, permission);
    80201db0:	85d2                	mv	a1,s4
    80201db2:	00848513          	addi	a0,s1,8
    80201db6:	00000097          	auipc	ra,0x0
    80201dba:	aca080e7          	jalr	-1334(ra) # 80201880 <new_Map_Area>
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.text, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));
    80201dbe:	85d2                	mv	a1,s4
    80201dc0:	854e                	mv	a0,s3
    80201dc2:	00000097          	auipc	ra,0x0
    80201dc6:	8d2080e7          	jalr	-1838(ra) # 80201694 <translate>
    80201dca:	8a2a                	mv	s4,a0
    80201dcc:	85d6                	mv	a1,s5
    80201dce:	854e                	mv	a0,s3
    80201dd0:	00000097          	auipc	ra,0x0
    80201dd4:	8c4080e7          	jalr	-1852(ra) # 80201694 <translate>
    80201dd8:	0084be03          	ld	t3,8(s1)
    80201ddc:	0104b303          	ld	t1,16(s1)
    80201de0:	0184b883          	ld	a7,24(s1)
    80201de4:	0204b803          	ld	a6,32(s1)
    80201de8:	789c                	ld	a5,48(s1)
    80201dea:	7498                	ld	a4,40(s1)
    80201dec:	608c                	ld	a1,0(s1)
    80201dee:	86aa                	mv	a3,a0
    80201df0:	8652                	mv	a2,s4
    80201df2:	f9040513          	addi	a0,s0,-112
    80201df6:	f9c43823          	sd	t3,-112(s0)
    80201dfa:	f8643c23          	sd	t1,-104(s0)
    80201dfe:	fb143023          	sd	a7,-96(s0)
    80201e02:	fb043423          	sd	a6,-88(s0)
    80201e06:	faf43c23          	sd	a5,-72(s0)
    80201e0a:	fae43823          	sd	a4,-80(s0)
    80201e0e:	00000097          	auipc	ra,0x0
    80201e12:	b1a080e7          	jalr	-1254(ra) # 80201928 <push_Map_Area>

    // map rodata
    struct Map_Area target_rodata;
    target_rodata = target_mem_set.rodata;
    80201e16:	04093a83          	ld	s5,64(s2)
    80201e1a:	03893a03          	ld	s4,56(s2)
    start_va = target_rodata.start_addr;
    end_va = target_rodata.end_addr;
    permission = target_rodata.permission;
    return_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
    80201e1e:	06093703          	ld	a4,96(s2)
    80201e22:	8656                	mv	a2,s5
    80201e24:	4685                	li	a3,1
    80201e26:	85d2                	mv	a1,s4
    80201e28:	03848513          	addi	a0,s1,56
    80201e2c:	00000097          	auipc	ra,0x0
    80201e30:	a54080e7          	jalr	-1452(ra) # 80201880 <new_Map_Area>
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.rodata, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));
    80201e34:	85d2                	mv	a1,s4
    80201e36:	854e                	mv	a0,s3
    80201e38:	00000097          	auipc	ra,0x0
    80201e3c:	85c080e7          	jalr	-1956(ra) # 80201694 <translate>
    80201e40:	8a2a                	mv	s4,a0
    80201e42:	85d6                	mv	a1,s5
    80201e44:	854e                	mv	a0,s3
    80201e46:	00000097          	auipc	ra,0x0
    80201e4a:	84e080e7          	jalr	-1970(ra) # 80201694 <translate>
    80201e4e:	0384be03          	ld	t3,56(s1)
    80201e52:	0404b303          	ld	t1,64(s1)
    80201e56:	0484b883          	ld	a7,72(s1)
    80201e5a:	0504b803          	ld	a6,80(s1)
    80201e5e:	70bc                	ld	a5,96(s1)
    80201e60:	6cb8                	ld	a4,88(s1)
    80201e62:	608c                	ld	a1,0(s1)
    80201e64:	86aa                	mv	a3,a0
    80201e66:	8652                	mv	a2,s4
    80201e68:	f9040513          	addi	a0,s0,-112
    80201e6c:	f9c43823          	sd	t3,-112(s0)
    80201e70:	f8643c23          	sd	t1,-104(s0)
    80201e74:	fb143023          	sd	a7,-96(s0)
    80201e78:	fb043423          	sd	a6,-88(s0)
    80201e7c:	faf43c23          	sd	a5,-72(s0)
    80201e80:	fae43823          	sd	a4,-80(s0)
    80201e84:	00000097          	auipc	ra,0x0
    80201e88:	aa4080e7          	jalr	-1372(ra) # 80201928 <push_Map_Area>


    // map data
    struct Map_Area target_data;
    target_data = target_mem_set.data;
    80201e8c:	07093a83          	ld	s5,112(s2)
    80201e90:	06893a03          	ld	s4,104(s2)
    start_va = target_data.start_addr;
    end_va = target_data.end_addr;
    permission = target_data.permission;
    return_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
    80201e94:	09093703          	ld	a4,144(s2)
    80201e98:	8656                	mv	a2,s5
    80201e9a:	4685                	li	a3,1
    80201e9c:	85d2                	mv	a1,s4
    80201e9e:	06848513          	addi	a0,s1,104
    80201ea2:	00000097          	auipc	ra,0x0
    80201ea6:	9de080e7          	jalr	-1570(ra) # 80201880 <new_Map_Area>
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.data, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));
    80201eaa:	85d2                	mv	a1,s4
    80201eac:	854e                	mv	a0,s3
    80201eae:	fffff097          	auipc	ra,0xfffff
    80201eb2:	7e6080e7          	jalr	2022(ra) # 80201694 <translate>
    80201eb6:	8a2a                	mv	s4,a0
    80201eb8:	85d6                	mv	a1,s5
    80201eba:	854e                	mv	a0,s3
    80201ebc:	fffff097          	auipc	ra,0xfffff
    80201ec0:	7d8080e7          	jalr	2008(ra) # 80201694 <translate>
    80201ec4:	0684be03          	ld	t3,104(s1)
    80201ec8:	0704b303          	ld	t1,112(s1)
    80201ecc:	0784b883          	ld	a7,120(s1)
    80201ed0:	0804b803          	ld	a6,128(s1)
    80201ed4:	68dc                	ld	a5,144(s1)
    80201ed6:	64d8                	ld	a4,136(s1)
    80201ed8:	608c                	ld	a1,0(s1)
    80201eda:	86aa                	mv	a3,a0
    80201edc:	8652                	mv	a2,s4
    80201ede:	f9040513          	addi	a0,s0,-112
    80201ee2:	f9c43823          	sd	t3,-112(s0)
    80201ee6:	f8643c23          	sd	t1,-104(s0)
    80201eea:	fb143023          	sd	a7,-96(s0)
    80201eee:	fb043423          	sd	a6,-88(s0)
    80201ef2:	faf43c23          	sd	a5,-72(s0)
    80201ef6:	fae43823          	sd	a4,-80(s0)
    80201efa:	00000097          	auipc	ra,0x0
    80201efe:	a2e080e7          	jalr	-1490(ra) # 80201928 <push_Map_Area>
    // map bss
    // 需要map吗？

    // map UserStackLow
    struct Map_Area target_UserStackLow;
    target_UserStackLow = target_mem_set.UserStackLow;
    80201f02:	10093a83          	ld	s5,256(s2)
    80201f06:	0f893a03          	ld	s4,248(s2)
    start_va = target_UserStackLow.start_addr;
    end_va = target_UserStackLow.end_addr;
    permission = target_UserStackLow.permission;
    return_memory_set.UserStackLow = new_Map_Area(start_va,end_va, 1, permission);
    80201f0a:	12093703          	ld	a4,288(s2)
    80201f0e:	8656                	mv	a2,s5
    80201f10:	4685                	li	a3,1
    80201f12:	85d2                	mv	a1,s4
    80201f14:	0f848513          	addi	a0,s1,248
    80201f18:	00000097          	auipc	ra,0x0
    80201f1c:	968080e7          	jalr	-1688(ra) # 80201880 <new_Map_Area>
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.UserStackLow, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));
    80201f20:	85d2                	mv	a1,s4
    80201f22:	854e                	mv	a0,s3
    80201f24:	fffff097          	auipc	ra,0xfffff
    80201f28:	770080e7          	jalr	1904(ra) # 80201694 <translate>
    80201f2c:	8a2a                	mv	s4,a0
    80201f2e:	85d6                	mv	a1,s5
    80201f30:	854e                	mv	a0,s3
    80201f32:	fffff097          	auipc	ra,0xfffff
    80201f36:	762080e7          	jalr	1890(ra) # 80201694 <translate>
    80201f3a:	0f84be03          	ld	t3,248(s1)
    80201f3e:	1004b303          	ld	t1,256(s1)
    80201f42:	1084b883          	ld	a7,264(s1)
    80201f46:	1104b803          	ld	a6,272(s1)
    80201f4a:	1204b783          	ld	a5,288(s1)
    80201f4e:	1184b703          	ld	a4,280(s1)
    80201f52:	608c                	ld	a1,0(s1)
    80201f54:	86aa                	mv	a3,a0
    80201f56:	8652                	mv	a2,s4
    80201f58:	f9040513          	addi	a0,s0,-112
    80201f5c:	f9c43823          	sd	t3,-112(s0)
    80201f60:	f8643c23          	sd	t1,-104(s0)
    80201f64:	fb143023          	sd	a7,-96(s0)
    80201f68:	fb043423          	sd	a6,-88(s0)
    80201f6c:	faf43c23          	sd	a5,-72(s0)
    80201f70:	fae43823          	sd	a4,-80(s0)
    80201f74:	00000097          	auipc	ra,0x0
    80201f78:	9b4080e7          	jalr	-1612(ra) # 80201928 <push_Map_Area>


    // map UserStackHigh
    struct Map_Area target_UserStackHigh;
    target_UserStackHigh = target_mem_set.UserStackHigh;
    80201f7c:	13093a83          	ld	s5,304(s2)
    80201f80:	12893a03          	ld	s4,296(s2)
    start_va = target_UserStackHigh.start_addr;
    end_va = target_UserStackHigh.end_addr;
    permission = target_UserStackHigh.permission;
    return_memory_set.UserStackHigh = new_Map_Area(start_va, end_va, 1, permission);
    80201f84:	15093703          	ld	a4,336(s2)
    80201f88:	8656                	mv	a2,s5
    80201f8a:	4685                	li	a3,1
    80201f8c:	85d2                	mv	a1,s4
    80201f8e:	12848513          	addi	a0,s1,296
    80201f92:	00000097          	auipc	ra,0x0
    80201f96:	8ee080e7          	jalr	-1810(ra) # 80201880 <new_Map_Area>
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.UserStackHigh, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));
    80201f9a:	85d2                	mv	a1,s4
    80201f9c:	854e                	mv	a0,s3
    80201f9e:	fffff097          	auipc	ra,0xfffff
    80201fa2:	6f6080e7          	jalr	1782(ra) # 80201694 <translate>
    80201fa6:	8a2a                	mv	s4,a0
    80201fa8:	85d6                	mv	a1,s5
    80201faa:	854e                	mv	a0,s3
    80201fac:	fffff097          	auipc	ra,0xfffff
    80201fb0:	6e8080e7          	jalr	1768(ra) # 80201694 <translate>
    80201fb4:	1284be03          	ld	t3,296(s1)
    80201fb8:	1304b303          	ld	t1,304(s1)
    80201fbc:	1384b883          	ld	a7,312(s1)
    80201fc0:	1404b803          	ld	a6,320(s1)
    80201fc4:	1504b783          	ld	a5,336(s1)
    80201fc8:	1484b703          	ld	a4,328(s1)
    80201fcc:	608c                	ld	a1,0(s1)
    80201fce:	86aa                	mv	a3,a0
    80201fd0:	8652                	mv	a2,s4
    80201fd2:	f9040513          	addi	a0,s0,-112
    80201fd6:	f9c43823          	sd	t3,-112(s0)
    80201fda:	f8643c23          	sd	t1,-104(s0)
    80201fde:	fb143023          	sd	a7,-96(s0)
    80201fe2:	fb043423          	sd	a6,-88(s0)
    80201fe6:	faf43c23          	sd	a5,-72(s0)


    // map Trampline
    struct Map_Area target_Trampline;
    target_Trampline = target_mem_set.Trampline;
    start_va = __restore;
    80201fea:	fffffa17          	auipc	s4,0xfffff
    80201fee:	07ca0a13          	addi	s4,s4,124 # 80201066 <__restore>
    end_va = start_va + 1024;
    80201ff2:	fffffa97          	auipc	s5,0xfffff
    80201ff6:	474a8a93          	addi	s5,s5,1140 # 80201466 <schedule+0xc6>
    push_Map_Area(return_memory_set.UserStackHigh, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));
    80201ffa:	fae43823          	sd	a4,-80(s0)
    80201ffe:	00000097          	auipc	ra,0x0
    80202002:	92a080e7          	jalr	-1750(ra) # 80201928 <push_Map_Area>
    return_memory_set.Trampline = new_Map_Area(start_va, end_va, 0, 0b0101);
    80202006:	8656                	mv	a2,s5
    80202008:	85d2                	mv	a1,s4
    8020200a:	15848513          	addi	a0,s1,344
    8020200e:	4715                	li	a4,5
    80202010:	4681                	li	a3,0
    80202012:	00000097          	auipc	ra,0x0
    80202016:	86e080e7          	jalr	-1938(ra) # 80201880 <new_Map_Area>
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.Trampline, return_memory_set.page_table, start_va, end_va); 
    8020201a:	1584be03          	ld	t3,344(s1)
    8020201e:	1604b303          	ld	t1,352(s1)
    80202022:	1684b883          	ld	a7,360(s1)
    80202026:	1704b803          	ld	a6,368(s1)
    8020202a:	1804b783          	ld	a5,384(s1)
    8020202e:	608c                	ld	a1,0(s1)
    80202030:	1784b703          	ld	a4,376(s1)
    80202034:	86d6                	mv	a3,s5
    80202036:	8652                	mv	a2,s4
    80202038:	f9040513          	addi	a0,s0,-112
    8020203c:	f9c43823          	sd	t3,-112(s0)
    80202040:	f8643c23          	sd	t1,-104(s0)
    80202044:	fb143023          	sd	a7,-96(s0)
    80202048:	fb043423          	sd	a6,-88(s0)
    8020204c:	faf43c23          	sd	a5,-72(s0)
    80202050:	fae43823          	sd	a4,-80(s0)
    80202054:	00000097          	auipc	ra,0x0
    80202058:	8d4080e7          	jalr	-1836(ra) # 80201928 <push_Map_Area>


    // map Kernel_Stack
    struct Map_Area target_Kernel_Stack;
    target_Kernel_Stack = target_mem_set.Kernel_Stack;
    8020205c:	19093a03          	ld	s4,400(s2)
    80202060:	18893a83          	ld	s5,392(s2)
    start_va = target_Kernel_Stack.start_addr;
    end_va = target_Kernel_Stack.end_addr;
    permission = target_Kernel_Stack.permission;
    return_memory_set.Kernel_Stack = new_Map_Area(start_va, end_va, 1, permission);
    80202064:	1b093703          	ld	a4,432(s2)
    80202068:	8652                	mv	a2,s4
    8020206a:	4685                	li	a3,1
    8020206c:	85d6                	mv	a1,s5
    8020206e:	18848513          	addi	a0,s1,392
    80202072:	00000097          	auipc	ra,0x0
    80202076:	80e080e7          	jalr	-2034(ra) # 80201880 <new_Map_Area>
    // 下面这行代码还有大bug，因为copy的地址不一定连续，要改进push_Map_Area这个函数
    push_Map_Area(return_memory_set.Kernel_Stack, return_memory_set.page_table, translate(target_root_ppn, start_va), translate(target_root_ppn, end_va));  
    8020207a:	85d6                	mv	a1,s5
    8020207c:	854e                	mv	a0,s3
    8020207e:	fffff097          	auipc	ra,0xfffff
    80202082:	616080e7          	jalr	1558(ra) # 80201694 <translate>
    80202086:	892a                	mv	s2,a0
    80202088:	85d2                	mv	a1,s4
    8020208a:	854e                	mv	a0,s3
    8020208c:	fffff097          	auipc	ra,0xfffff
    80202090:	608080e7          	jalr	1544(ra) # 80201694 <translate>
    80202094:	1884be03          	ld	t3,392(s1)
    80202098:	1904b303          	ld	t1,400(s1)
    8020209c:	1984b883          	ld	a7,408(s1)
    802020a0:	1a04b803          	ld	a6,416(s1)
    802020a4:	1a84b703          	ld	a4,424(s1)
    802020a8:	1b04b783          	ld	a5,432(s1)
    802020ac:	608c                	ld	a1,0(s1)
    802020ae:	86aa                	mv	a3,a0
    802020b0:	864a                	mv	a2,s2
    802020b2:	f9040513          	addi	a0,s0,-112
    802020b6:	f9c43823          	sd	t3,-112(s0)
    802020ba:	f8643c23          	sd	t1,-104(s0)
    802020be:	fb143023          	sd	a7,-96(s0)
    802020c2:	fb043423          	sd	a6,-88(s0)
    802020c6:	fae43823          	sd	a4,-80(s0)
    802020ca:	faf43c23          	sd	a5,-72(s0)
    802020ce:	00000097          	auipc	ra,0x0
    802020d2:	85a080e7          	jalr	-1958(ra) # 80201928 <push_Map_Area>

    return return_memory_set;    
    
}
    802020d6:	70a6                	ld	ra,104(sp)
    802020d8:	7406                	ld	s0,96(sp)
    802020da:	6946                	ld	s2,80(sp)
    802020dc:	69a6                	ld	s3,72(sp)
    802020de:	6a06                	ld	s4,64(sp)
    802020e0:	7ae2                	ld	s5,56(sp)
    802020e2:	8526                	mv	a0,s1
    802020e4:	64e6                	ld	s1,88(sp)
    802020e6:	6165                	addi	sp,sp,112
    802020e8:	8082                	ret

00000000802020ea <load_elf>:

extern void __alltraps();
extern void __restore(uint64 a0, uint64 a1);


struct User_MemorySet load_elf(uint64 elf_source){
    802020ea:	7131                	addi	sp,sp,-192
    802020ec:	f922                	sd	s0,176(sp)
    802020ee:	f526                	sd	s1,168(sp)
    802020f0:	0180                	addi	s0,sp,192
    802020f2:	f14a                	sd	s2,160(sp)
    802020f4:	ed4e                	sd	s3,152(sp)
    802020f6:	e952                	sd	s4,144(sp)
    802020f8:	e556                	sd	s5,136(sp)
    802020fa:	e15a                	sd	s6,128(sp)
    802020fc:	fcde                	sd	s7,120(sp)
    802020fe:	f8e2                	sd	s8,112(sp)
    80202100:	f4e6                	sd	s9,104(sp)
    80202102:	f0ea                	sd	s10,96(sp)
    80202104:	ecee                	sd	s11,88(sp)
    80202106:	fd06                	sd	ra,184(sp)
    80202108:	8b2e                	mv	s6,a1
    8020210a:	8c2a                	mv	s8,a0
    struct User_MemorySet user_memory_set;

    user_memory_set.page_table = new_pagetable();
    8020210c:	fffff097          	auipc	ra,0xfffff
    80202110:	3b4080e7          	jalr	948(ra) # 802014c0 <new_pagetable>
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;
    80202114:	001b4783          	lbu	a5,1(s6)
    80202118:	000b4a83          	lbu	s5,0(s6)
    8020211c:	036b5b83          	lhu	s7,54(s6)
    80202120:	f4f43423          	sd	a5,-184(s0)
    80202124:	002b4783          	lbu	a5,2(s6)
    80202128:	038b5903          	lhu	s2,56(s6)
    user_memory_set.page_table = new_pagetable();
    8020212c:	00ac3023          	sd	a0,0(s8)
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;
    80202130:	f4f43823          	sd	a5,-176(s0)
    80202134:	003b4783          	lbu	a5,3(s6)

    // check the magic of elf file
    for (int i = 0; i < 4; i++){
    80202138:	4481                	li	s1,0
    8020213a:	4d91                	li	s11,4
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;
    8020213c:	f4f43023          	sd	a5,-192(s0)
    80202140:	020b3783          	ld	a5,32(s6)
        if (i == 0){
            if (ehdr.e_ident[i] != 0x7f){
                panic("[kernel] Wrong elf magic");
            }
        }
        if (i == 1){
    80202144:	4d05                	li	s10,1
            if (ehdr.e_ident[i] != 'E'){
                panic("[kernel] Wrong elf magic");
            }
        }
        if (i == 2){
    80202146:	4989                	li	s3,2
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;
    80202148:	f4f43c23          	sd	a5,-168(s0)
            if (ehdr.e_ident[i] != 'L'){
                panic("[kernel] Wrong elf magic");
    8020214c:	00001c97          	auipc	s9,0x1
    80202150:	234c8c93          	addi	s9,s9,564 # 80203380 <digits+0x2e8>
            if (ehdr.e_ident[i] != 0x7f){
    80202154:	07f00a13          	li	s4,127
        if (i == 0){
    80202158:	c4e9                	beqz	s1,80202222 <load_elf+0x138>
        if (i == 1){
    8020215a:	01a48e63          	beq	s1,s10,80202176 <load_elf+0x8c>
        if (i == 2){
    8020215e:	31349463          	bne	s1,s3,80202466 <load_elf+0x37c>
            if (ehdr.e_ident[i] != 'L'){
    80202162:	f5043783          	ld	a5,-176(s0)
    80202166:	04c00713          	li	a4,76
                panic("[kernel] Wrong elf magic");
    8020216a:	8566                	mv	a0,s9
            if (ehdr.e_ident[i] != 'L'){
    8020216c:	30e79f63          	bne	a5,a4,8020248a <load_elf+0x3a0>
    for (int i = 0; i < 4; i++){
    80202170:	448d                	li	s1,3
        if (i == 1){
    80202172:	ffa496e3          	bne	s1,s10,8020215e <load_elf+0x74>
            if (ehdr.e_ident[i] != 'E'){
    80202176:	f4843783          	ld	a5,-184(s0)
    8020217a:	04500713          	li	a4,69
    8020217e:	0ae79463          	bne	a5,a4,80202226 <load_elf+0x13c>
    for (int i = 0; i < 4; i++){
    80202182:	2485                	addiw	s1,s1,1
    80202184:	fdb49ae3          	bne	s1,s11,80202158 <load_elf+0x6e>
        }
    }

    uint16 ph_count = ehdr.e_phnum;

    uint64 ptr_ph_table = elf_source + ehdr.e_phoff;
    80202188:	f5843783          	ld	a5,-168(s0)


    Elf64_Phdr phdr = *(Elf64_Phdr *)ptr_ph_table;
    uint64 base_address = phdr.p_paddr;

    for (int i = 0; i < ph_count; i++){
    8020218c:	00090d9b          	sext.w	s11,s2
    80202190:	4981                	li	s3,0
    uint64 ptr_ph_table = elf_source + ehdr.e_phoff;
    80202192:	00fb04b3          	add	s1,s6,a5
    for (int i = 0; i < ph_count; i++){
    80202196:	0a090263          	beqz	s2,8020223a <load_elf+0x150>
                push_Map_Area(user_memory_set.rodata, user_memory_set.page_table, copy_start, copy_end);
            }else if (i == 2){
                user_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
                push_Map_Area(user_memory_set.data, user_memory_set.page_table, copy_start, copy_end);
            }else if (i == 3){
                user_memory_set.bss = new_Map_Area(start_va, end_va, 1, permission);
    8020219a:	098c0793          	addi	a5,s8,152
    8020219e:	f4f43423          	sd	a5,-184(s0)
                user_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
    802021a2:	068c0793          	addi	a5,s8,104
    802021a6:	f4f43823          	sd	a5,-176(s0)
                user_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
    802021aa:	038c0793          	addi	a5,s8,56
        if (phdr.p_type == 1){   // LOAD
    802021ae:	4d05                	li	s10,1
            }else if (i == 2){
    802021b0:	4909                	li	s2,2
                user_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
    802021b2:	f4f43c23          	sd	a5,-168(s0)
                user_memory_set.text = new_Map_Area(start_va, end_va, 1, permission);
    802021b6:	008c0a93          	addi	s5,s8,8
    802021ba:	a029                	j	802021c4 <load_elf+0xda>
    for (int i = 0; i < ph_count; i++){
    802021bc:	2985                	addiw	s3,s3,1
                push_Map_Area(user_memory_set.bss, user_memory_set.page_table, copy_start, copy_end);
            }
        }
        ptr_ph_table += ehdr.e_phentsize;
    802021be:	94de                	add	s1,s1,s7
    for (int i = 0; i < ph_count; i++){
    802021c0:	07b98d63          	beq	s3,s11,8020223a <load_elf+0x150>
        if (phdr.p_type == 1){   // LOAD
    802021c4:	4098                	lw	a4,0(s1)
    802021c6:	ffa71be3          	bne	a4,s10,802021bc <load_elf+0xd2>
            uint64 copy_start = phdr.p_offset + elf_source;
    802021ca:	0084bc83          	ld	s9,8(s1)
        Elf64_Phdr phdr = *(Elf64_Phdr *)ptr_ph_table;
    802021ce:	688c                	ld	a1,16(s1)
            uint64 end_va = start_va + phdr.p_memsz;
    802021d0:	7490                	ld	a2,40(s1)
            uint64 permission = 0b1000 | flags;   
    802021d2:	0044e703          	lwu	a4,4(s1)
            uint64 copy_end = copy_start + phdr.p_filesz;
    802021d6:	7094                	ld	a3,32(s1)
            uint64 copy_start = phdr.p_offset + elf_source;
    802021d8:	9cda                	add	s9,s9,s6
            uint64 end_va = start_va + phdr.p_memsz;
    802021da:	962e                	add	a2,a2,a1
            uint64 permission = 0b1000 | flags;   
    802021dc:	00876713          	ori	a4,a4,8
            uint64 copy_end = copy_start + phdr.p_filesz;
    802021e0:	00dc8a33          	add	s4,s9,a3
            if (i == 0){ // map text
    802021e4:	22098863          	beqz	s3,80202414 <load_elf+0x32a>
            }else if (i == 1){
    802021e8:	2ba98763          	beq	s3,s10,80202496 <load_elf+0x3ac>
            }else if (i == 2){
    802021ec:	2d298b63          	beq	s3,s2,802024c2 <load_elf+0x3d8>
            }else if (i == 3){
    802021f0:	478d                	li	a5,3
    802021f2:	fcf995e3          	bne	s3,a5,802021bc <load_elf+0xd2>
                user_memory_set.bss = new_Map_Area(start_va, end_va, 1, permission);
    802021f6:	f4843503          	ld	a0,-184(s0)
    802021fa:	4685                	li	a3,1
    802021fc:	fffff097          	auipc	ra,0xfffff
    80202200:	684080e7          	jalr	1668(ra) # 80201880 <new_Map_Area>
                push_Map_Area(user_memory_set.bss, user_memory_set.page_table, copy_start, copy_end);
    80202204:	000c3583          	ld	a1,0(s8)
    80202208:	098c3283          	ld	t0,152(s8)
    8020220c:	0a0c3f83          	ld	t6,160(s8)
    80202210:	0a8c3f03          	ld	t5,168(s8)
    80202214:	0b0c3e83          	ld	t4,176(s8)
    80202218:	0b8c3e03          	ld	t3,184(s8)
    8020221c:	0c0c3703          	ld	a4,192(s8)
    80202220:	ac31                	j	8020243c <load_elf+0x352>
            if (ehdr.e_ident[i] != 0x7f){
    80202222:	014a8763          	beq	s5,s4,80202230 <load_elf+0x146>
                panic("[kernel] Wrong elf magic");
    80202226:	8566                	mv	a0,s9
    80202228:	ffffe097          	auipc	ra,0xffffe
    8020222c:	086080e7          	jalr	134(ra) # 802002ae <panic>
    for (int i = 0; i < 4; i++){
    80202230:	2485                	addiw	s1,s1,1
    80202232:	f5b48be3          	beq	s1,s11,80202188 <load_elf+0x9e>
        if (i == 0){
    80202236:	f095                	bnez	s1,8020215a <load_elf+0x70>
    80202238:	b7ed                	j	80202222 <load_elf+0x138>

    // Then, map user stack low and user stack high(trap context)
    // low
    uint64 start_va = UserStack_LOW_0;
    uint64 end_va = start_va + USER_STACK_SIZE;
    user_memory_set.UserStackLow = new_Map_Area(0x80800000, 0x80800000 + USER_STACK_SIZE - 4, 1, 0b1011);
    8020223a:	20200637          	lui	a2,0x20200
    8020223e:	3ff60613          	addi	a2,a2,1023 # 202003ff <n+0x202003df>
    80202242:	10100593          	li	a1,257
    80202246:	0f8c0513          	addi	a0,s8,248
    8020224a:	472d                	li	a4,11
    8020224c:	060a                	slli	a2,a2,0x2
    8020224e:	05de                	slli	a1,a1,0x17
    80202250:	4685                	li	a3,1
    80202252:	fffff097          	auipc	ra,0xfffff
    80202256:	62e080e7          	jalr	1582(ra) # 80201880 <new_Map_Area>
    push_Map_Area(user_memory_set.UserStackLow, user_memory_set.page_table, start_va, end_va);
    8020225a:	0f8c3e83          	ld	t4,248(s8)
    8020225e:	100c3e03          	ld	t3,256(s8)
    80202262:	108c3303          	ld	t1,264(s8)
    80202266:	110c3883          	ld	a7,272(s8)
    8020226a:	118c3803          	ld	a6,280(s8)
    8020226e:	000c3583          	ld	a1,0(s8)
    80202272:	120c3703          	ld	a4,288(s8)
    80202276:	f6040513          	addi	a0,s0,-160
    8020227a:	001c7697          	auipc	a3,0x1c7
    8020227e:	3be68693          	addi	a3,a3,958 # 803c9638 <kernel_frame_end>
    80202282:	001c6617          	auipc	a2,0x1c6
    80202286:	3b660613          	addi	a2,a2,950 # 803c8638 <UserStack_LOW_0>
    8020228a:	f7d43023          	sd	t4,-160(s0)
    8020228e:	f7c43423          	sd	t3,-152(s0)
    80202292:	f6643823          	sd	t1,-144(s0)
    80202296:	f7143c23          	sd	a7,-136(s0)
    8020229a:	f9043023          	sd	a6,-128(s0)
    8020229e:	f8e43423          	sd	a4,-120(s0)
    802022a2:	fffff097          	auipc	ra,0xfffff
    802022a6:	686080e7          	jalr	1670(ra) # 80201928 <push_Map_Area>
    
    // High
    start_va = UserStack_HIGH_0;
    end_va = start_va + 1024;
    user_memory_set.UserStackHigh = new_Map_Area(0x80900000, 0x80900000 + 1024, 1, 0b0011);
    802022aa:	008095b7          	lui	a1,0x809
    802022ae:	05a2                	slli	a1,a1,0x8
    802022b0:	40058613          	addi	a2,a1,1024 # 809400 <n+0x8093e0>
    802022b4:	128c0513          	addi	a0,s8,296
    802022b8:	470d                	li	a4,3
    802022ba:	4685                	li	a3,1
    802022bc:	fffff097          	auipc	ra,0xfffff
    802022c0:	5c4080e7          	jalr	1476(ra) # 80201880 <new_Map_Area>
    push_Map_Area(user_memory_set.UserStackHigh, user_memory_set.page_table, start_va, end_va);
    802022c4:	128c3e83          	ld	t4,296(s8)
    802022c8:	130c3e03          	ld	t3,304(s8)
    802022cc:	138c3303          	ld	t1,312(s8)
    802022d0:	140c3883          	ld	a7,320(s8)
    802022d4:	148c3803          	ld	a6,328(s8)
    802022d8:	000c3583          	ld	a1,0(s8)
    802022dc:	150c3703          	ld	a4,336(s8)
    802022e0:	f6040513          	addi	a0,s0,-160
    802022e4:	001c5697          	auipc	a3,0x1c5
    802022e8:	35468693          	addi	a3,a3,852 # 803c7638 <KernerlStack>
    802022ec:	001c5617          	auipc	a2,0x1c5
    802022f0:	f4c60613          	addi	a2,a2,-180 # 803c7238 <UserStack_HIGH_0>
    802022f4:	f7d43023          	sd	t4,-160(s0)
    802022f8:	f7c43423          	sd	t3,-152(s0)
    802022fc:	f6643823          	sd	t1,-144(s0)
    80202300:	f7143c23          	sd	a7,-136(s0)
    80202304:	f9043023          	sd	a6,-128(s0)
    80202308:	f8e43423          	sd	a4,-120(s0)
    8020230c:	fffff097          	auipc	ra,0xfffff
    80202310:	61c080e7          	jalr	1564(ra) # 80201928 <push_Map_Area>



    start_va = __restore;
    end_va = start_va + 1024;
    user_memory_set.Trampline = new_Map_Area(start_va, end_va, 0, 0b0101);
    80202314:	158c0513          	addi	a0,s8,344
    80202318:	4715                	li	a4,5
    8020231a:	4681                	li	a3,0
    8020231c:	fffff617          	auipc	a2,0xfffff
    80202320:	14a60613          	addi	a2,a2,330 # 80201466 <schedule+0xc6>
    80202324:	fffff597          	auipc	a1,0xfffff
    80202328:	d4258593          	addi	a1,a1,-702 # 80201066 <__restore>
    8020232c:	fffff097          	auipc	ra,0xfffff
    80202330:	554080e7          	jalr	1364(ra) # 80201880 <new_Map_Area>
    push_Map_Area(user_memory_set.Trampline, user_memory_set.page_table, start_va, end_va);
    80202334:	158c3e83          	ld	t4,344(s8)
    80202338:	160c3e03          	ld	t3,352(s8)
    8020233c:	168c3303          	ld	t1,360(s8)
    80202340:	170c3883          	ld	a7,368(s8)
    80202344:	178c3803          	ld	a6,376(s8)
    80202348:	000c3583          	ld	a1,0(s8)
    8020234c:	180c3703          	ld	a4,384(s8)
    80202350:	f6040513          	addi	a0,s0,-160
    80202354:	fffff697          	auipc	a3,0xfffff
    80202358:	11268693          	addi	a3,a3,274 # 80201466 <schedule+0xc6>
    8020235c:	fffff617          	auipc	a2,0xfffff
    80202360:	d0a60613          	addi	a2,a2,-758 # 80201066 <__restore>
    80202364:	f7d43023          	sd	t4,-160(s0)
    80202368:	f7c43423          	sd	t3,-152(s0)
    8020236c:	f6643823          	sd	t1,-144(s0)
    80202370:	f7143c23          	sd	a7,-136(s0)
    80202374:	f9043023          	sd	a6,-128(s0)
    80202378:	f8e43423          	sd	a4,-120(s0)
    8020237c:	fffff097          	auipc	ra,0xfffff
    80202380:	5ac080e7          	jalr	1452(ra) # 80201928 <push_Map_Area>


    // map kernel stack
    start_va = KernerlStack;
    end_va = start_va + KERNEL_STACK_SIZE;
    user_memory_set.Kernel_Stack = new_Map_Area(0x80700000, 0x80700000 + KERNEL_STACK_SIZE - 4, 1, 0b0011);
    80202384:	201c0637          	lui	a2,0x201c0
    80202388:	3ff60613          	addi	a2,a2,1023 # 201c03ff <n+0x201c03df>
    8020238c:	008075b7          	lui	a1,0x807
    80202390:	188c0513          	addi	a0,s8,392
    80202394:	060a                	slli	a2,a2,0x2
    80202396:	05a2                	slli	a1,a1,0x8
    80202398:	470d                	li	a4,3
    8020239a:	4685                	li	a3,1
    8020239c:	fffff097          	auipc	ra,0xfffff
    802023a0:	4e4080e7          	jalr	1252(ra) # 80201880 <new_Map_Area>
    push_Map_Area(user_memory_set.Kernel_Stack, user_memory_set.page_table, start_va, end_va);
    802023a4:	000c3583          	ld	a1,0(s8)
    802023a8:	188c3e83          	ld	t4,392(s8)
    802023ac:	190c3e03          	ld	t3,400(s8)
    802023b0:	198c3303          	ld	t1,408(s8)
    802023b4:	1a0c3883          	ld	a7,416(s8)
    802023b8:	1a8c3803          	ld	a6,424(s8)
    802023bc:	1b0c3703          	ld	a4,432(s8)
    802023c0:	f6040513          	addi	a0,s0,-160
    802023c4:	001c6697          	auipc	a3,0x1c6
    802023c8:	27468693          	addi	a3,a3,628 # 803c8638 <UserStack_LOW_0>
    802023cc:	001c5617          	auipc	a2,0x1c5
    802023d0:	26c60613          	addi	a2,a2,620 # 803c7638 <KernerlStack>
    802023d4:	f7d43023          	sd	t4,-160(s0)
    802023d8:	f7c43423          	sd	t3,-152(s0)
    802023dc:	f6643823          	sd	t1,-144(s0)
    802023e0:	f7143c23          	sd	a7,-136(s0)
    802023e4:	f9043023          	sd	a6,-128(s0)
    802023e8:	f8e43423          	sd	a4,-120(s0)
    802023ec:	fffff097          	auipc	ra,0xfffff
    802023f0:	53c080e7          	jalr	1340(ra) # 80201928 <push_Map_Area>

    return user_memory_set;
}
    802023f4:	70ea                	ld	ra,184(sp)
    802023f6:	744a                	ld	s0,176(sp)
    802023f8:	74aa                	ld	s1,168(sp)
    802023fa:	790a                	ld	s2,160(sp)
    802023fc:	69ea                	ld	s3,152(sp)
    802023fe:	6a4a                	ld	s4,144(sp)
    80202400:	6aaa                	ld	s5,136(sp)
    80202402:	6b0a                	ld	s6,128(sp)
    80202404:	7be6                	ld	s7,120(sp)
    80202406:	7ca6                	ld	s9,104(sp)
    80202408:	7d06                	ld	s10,96(sp)
    8020240a:	6de6                	ld	s11,88(sp)
    8020240c:	8562                	mv	a0,s8
    8020240e:	7c46                	ld	s8,112(sp)
    80202410:	6129                	addi	sp,sp,192
    80202412:	8082                	ret
                user_memory_set.text = new_Map_Area(start_va, end_va, 1, permission);
    80202414:	8556                	mv	a0,s5
    80202416:	4685                	li	a3,1
    80202418:	fffff097          	auipc	ra,0xfffff
    8020241c:	468080e7          	jalr	1128(ra) # 80201880 <new_Map_Area>
                push_Map_Area(user_memory_set.text, user_memory_set.page_table, copy_start, copy_end);
    80202420:	000c3583          	ld	a1,0(s8)
    80202424:	008c3283          	ld	t0,8(s8)
    80202428:	010c3f83          	ld	t6,16(s8)
    8020242c:	018c3f03          	ld	t5,24(s8)
    80202430:	020c3e83          	ld	t4,32(s8)
    80202434:	028c3e03          	ld	t3,40(s8)
    80202438:	030c3703          	ld	a4,48(s8)
                push_Map_Area(user_memory_set.bss, user_memory_set.page_table, copy_start, copy_end);
    8020243c:	86d2                	mv	a3,s4
    8020243e:	8666                	mv	a2,s9
    80202440:	f6040513          	addi	a0,s0,-160
    80202444:	f6543023          	sd	t0,-160(s0)
    80202448:	f7f43423          	sd	t6,-152(s0)
    8020244c:	f7e43823          	sd	t5,-144(s0)
    80202450:	f7d43c23          	sd	t4,-136(s0)
    80202454:	f9c43023          	sd	t3,-128(s0)
    80202458:	f8e43423          	sd	a4,-120(s0)
    8020245c:	fffff097          	auipc	ra,0xfffff
    80202460:	4cc080e7          	jalr	1228(ra) # 80201928 <push_Map_Area>
    80202464:	bba1                	j	802021bc <load_elf+0xd2>
        if (i == 3){
    80202466:	478d                	li	a5,3
    80202468:	dcf494e3          	bne	s1,a5,80202230 <load_elf+0x146>
            if (ehdr.e_ident[i] != 'F'){
    8020246c:	f4043783          	ld	a5,-192(s0)
    80202470:	04600713          	li	a4,70
    80202474:	d0e78ae3          	beq	a5,a4,80202188 <load_elf+0x9e>
                panic("[kernel] Wrong elf magic");
    80202478:	00001517          	auipc	a0,0x1
    8020247c:	f0850513          	addi	a0,a0,-248 # 80203380 <digits+0x2e8>
    80202480:	ffffe097          	auipc	ra,0xffffe
    80202484:	e2e080e7          	jalr	-466(ra) # 802002ae <panic>
    80202488:	b301                	j	80202188 <load_elf+0x9e>
                panic("[kernel] Wrong elf magic");
    8020248a:	ffffe097          	auipc	ra,0xffffe
    8020248e:	e24080e7          	jalr	-476(ra) # 802002ae <panic>
    for (int i = 0; i < 4; i++){
    80202492:	448d                	li	s1,3
    80202494:	b9f9                	j	80202172 <load_elf+0x88>
                user_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
    80202496:	f5843503          	ld	a0,-168(s0)
    8020249a:	4685                	li	a3,1
    8020249c:	fffff097          	auipc	ra,0xfffff
    802024a0:	3e4080e7          	jalr	996(ra) # 80201880 <new_Map_Area>
                push_Map_Area(user_memory_set.rodata, user_memory_set.page_table, copy_start, copy_end);
    802024a4:	000c3583          	ld	a1,0(s8)
    802024a8:	038c3283          	ld	t0,56(s8)
    802024ac:	040c3f83          	ld	t6,64(s8)
    802024b0:	048c3f03          	ld	t5,72(s8)
    802024b4:	050c3e83          	ld	t4,80(s8)
    802024b8:	058c3e03          	ld	t3,88(s8)
    802024bc:	060c3703          	ld	a4,96(s8)
    802024c0:	bfb5                	j	8020243c <load_elf+0x352>
                user_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
    802024c2:	f5043503          	ld	a0,-176(s0)
    802024c6:	4685                	li	a3,1
    802024c8:	fffff097          	auipc	ra,0xfffff
    802024cc:	3b8080e7          	jalr	952(ra) # 80201880 <new_Map_Area>
                push_Map_Area(user_memory_set.data, user_memory_set.page_table, copy_start, copy_end);
    802024d0:	000c3583          	ld	a1,0(s8)
    802024d4:	068c3283          	ld	t0,104(s8)
    802024d8:	070c3f83          	ld	t6,112(s8)
    802024dc:	078c3f03          	ld	t5,120(s8)
    802024e0:	080c3e83          	ld	t4,128(s8)
    802024e4:	088c3e03          	ld	t3,136(s8)
    802024e8:	090c3703          	ld	a4,144(s8)
    802024ec:	bf81                	j	8020243c <load_elf+0x352>

00000000802024ee <__switch>:
    802024ee:	00253423          	sd	sp,8(a0)
    802024f2:	14102373          	csrr	t1,sepc
    802024f6:	00653023          	sd	t1,0(a0)
    802024fa:	ed00                	sd	s0,24(a0)
    802024fc:	f104                	sd	s1,32(a0)
    802024fe:	03253423          	sd	s2,40(a0)
    80202502:	03353823          	sd	s3,48(a0)
    80202506:	03453c23          	sd	s4,56(a0)
    8020250a:	05553023          	sd	s5,64(a0)
    8020250e:	05653423          	sd	s6,72(a0)
    80202512:	05753823          	sd	s7,80(a0)
    80202516:	05853c23          	sd	s8,88(a0)
    8020251a:	07953023          	sd	s9,96(a0)
    8020251e:	07a53423          	sd	s10,104(a0)
    80202522:	07b53823          	sd	s11,112(a0)
    80202526:	0005b083          	ld	ra,0(a1) # 807000 <n+0x806fe0>
    8020252a:	6d80                	ld	s0,24(a1)
    8020252c:	7184                	ld	s1,32(a1)
    8020252e:	0285b903          	ld	s2,40(a1)
    80202532:	0305b983          	ld	s3,48(a1)
    80202536:	0385ba03          	ld	s4,56(a1)
    8020253a:	0405ba83          	ld	s5,64(a1)
    8020253e:	0485bb03          	ld	s6,72(a1)
    80202542:	0505bb83          	ld	s7,80(a1)
    80202546:	0585bc03          	ld	s8,88(a1)
    8020254a:	0605bc83          	ld	s9,96(a1)
    8020254e:	0685bd03          	ld	s10,104(a1)
    80202552:	0705bd83          	ld	s11,112(a1)
    80202556:	0085b103          	ld	sp,8(a1)
    8020255a:	8082                	ret
