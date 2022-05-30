
target/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_entry>:
    80200000:	00100513          	li	a0,1
    80200004:	00036117          	auipc	sp,0x36
    80200008:	ffc10113          	addi	sp,sp,-4 # 80236000 <bitmap>
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
    80200020:	88a080e7          	jalr	-1910(ra) # 802008a6 <get_frame>
    80200024:	0005091b          	sext.w	s2,a0
    uint32 frame2 = get_frame();
    80200028:	00001097          	auipc	ra,0x1
    8020002c:	87e080e7          	jalr	-1922(ra) # 802008a6 <get_frame>
    80200030:	0005049b          	sext.w	s1,a0
    uint32 frame3 = get_frame();
    80200034:	00001097          	auipc	ra,0x1
    80200038:	872080e7          	jalr	-1934(ra) # 802008a6 <get_frame>
    free_frame(frame1);
    8020003c:	854a                	mv	a0,s2
    8020003e:	00001097          	auipc	ra,0x1
    80200042:	990080e7          	jalr	-1648(ra) # 802009ce <free_frame>
    free_frame(frame2);
    80200046:	8526                	mv	a0,s1
    80200048:	00001097          	auipc	ra,0x1
    8020004c:	986080e7          	jalr	-1658(ra) # 802009ce <free_frame>
    uint32 frame4 = get_frame();
}
    80200050:	6442                	ld	s0,16(sp)
    80200052:	60e2                	ld	ra,24(sp)
    80200054:	64a2                	ld	s1,8(sp)
    80200056:	6902                	ld	s2,0(sp)
    80200058:	6105                	addi	sp,sp,32
    uint32 frame4 = get_frame();
    8020005a:	00001317          	auipc	t1,0x1
    8020005e:	84c30067          	jr	-1972(t1) # 802008a6 <get_frame>

0000000080200062 <main>:
void main(int num_core) {
    80200062:	1141                	addi	sp,sp,-16
    80200064:	e406                	sd	ra,8(sp)
    80200066:	e022                	sd	s0,0(sp)
    80200068:	0800                	addi	s0,sp,16
    8020006a:	85aa                	mv	a1,a0
    printf("[kernel] num of cores: %d \n", num_core);  // 通过寄存器entry.S中设置的寄存器a0来传这个num_core参数
    8020006c:	00002517          	auipc	a0,0x2
    80200070:	f9450513          	addi	a0,a0,-108 # 80202000 <etext>
    80200074:	00000097          	auipc	ra,0x0
    80200078:	0a6080e7          	jalr	166(ra) # 8020011a <printf>
    initmalloc();
    8020007c:	00001097          	auipc	ra,0x1
    80200080:	2aa080e7          	jalr	682(ra) # 80201326 <initmalloc>
    test_alloc();
    80200084:	00000097          	auipc	ra,0x0
    80200088:	f8c080e7          	jalr	-116(ra) # 80200010 <test_alloc>
    map_kernel();
    8020008c:	00001097          	auipc	ra,0x1
    80200090:	66a080e7          	jalr	1642(ra) # 802016f6 <map_kernel>
    activate_mm();
    80200094:	00002097          	auipc	ra,0x2
    80200098:	864080e7          	jalr	-1948(ra) # 802018f8 <activate_mm>
    printf("[kernel] ok to activate mm! Back to Kernel!\n");
    8020009c:	00002517          	auipc	a0,0x2
    802000a0:	f8450513          	addi	a0,a0,-124 # 80202020 <etext+0x20>
    802000a4:	00000097          	auipc	ra,0x0
    802000a8:	076080e7          	jalr	118(ra) # 8020011a <printf>
    test_page_table();
    802000ac:	00001097          	auipc	ra,0x1
    802000b0:	230080e7          	jalr	560(ra) # 802012dc <test_page_table>
    TASK_MANAGER.number_of_apps = 0; 
    802000b4:	00038797          	auipc	a5,0x38
    802000b8:	0607b623          	sd	zero,108(a5) # 80238120 <TASK_MANAGER+0x1ff8>
    init_all_apps(); // 初始化App，包括初始化其trap上下文，将trap上下文放到用户栈中。
    802000bc:	00000097          	auipc	ra,0x0
    802000c0:	660080e7          	jalr	1632(ra) # 8020071c <init_all_apps>
    run_next_app(1);
    802000c4:	4505                	li	a0,1
    802000c6:	00000097          	auipc	ra,0x0
    802000ca:	68c080e7          	jalr	1676(ra) # 80200752 <run_next_app>
}
    802000ce:	6402                	ld	s0,0(sp)
    802000d0:	60a2                	ld	ra,8(sp)
    panic("[kernel] If this is printed, sth must get wrong!\n");
    802000d2:	00002517          	auipc	a0,0x2
    802000d6:	f7e50513          	addi	a0,a0,-130 # 80202050 <etext+0x50>
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
    80200168:	00002997          	auipc	s3,0x2
    8020016c:	f2098993          	addi	s3,s3,-224 # 80202088 <digits>
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


struct trap_context new_trap_cx(uint64 spec, uint64 kernel_satp, uint64 trap_handler, uint64 user_stack_sp, uint64 kernel_stack_top){
    802002e0:	7169                	addi	sp,sp,-304
    802002e2:	f622                	sd	s0,296(sp)
    802002e4:	1a00                	addi	s0,sp,304
    802002e6:	ed040813          	addi	a6,s0,-304
    802002ea:	fd040893          	addi	a7,s0,-48
    struct trap_context new_trap_context;

    for (int i = 0; i < 32; i++){      // 先将寄存器0初始化
        new_trap_context.general_register[i] = 0;
    802002ee:	00083023          	sd	zero,0(a6)
    for (int i = 0; i < 32; i++){      // 先将寄存器0初始化
    802002f2:	0821                	addi	a6,a6,8
    802002f4:	ff089de3          	bne	a7,a6,802002ee <new_trap_cx+0xe>
    }

    new_trap_context.general_register[2] = user_stack_sp;
    802002f8:	eee43023          	sd	a4,-288(s0)
    new_trap_context.spec = spec;    // 设为用户程序的入口
    new_trap_context.kernel_satp = kernel_satp;   
    new_trap_context.trap_handler = trap_handler;
    new_trap_context.kernel_stack = kernel_stack_top;

    return new_trap_context;
    802002fc:	fef43423          	sd	a5,-24(s0)
    80200300:	fcb43823          	sd	a1,-48(s0)
    80200304:	fcc43c23          	sd	a2,-40(s0)
    80200308:	fed43023          	sd	a3,-32(s0)
    8020030c:	ed040793          	addi	a5,s0,-304
    80200310:	872a                	mv	a4,a0
    80200312:	ff040893          	addi	a7,s0,-16
    80200316:	0007b803          	ld	a6,0(a5)
    8020031a:	678c                	ld	a1,8(a5)
    8020031c:	6b90                	ld	a2,16(a5)
    8020031e:	6f94                	ld	a3,24(a5)
    80200320:	01073023          	sd	a6,0(a4)
    80200324:	e70c                	sd	a1,8(a4)
    80200326:	eb10                	sd	a2,16(a4)
    80200328:	ef14                	sd	a3,24(a4)
    8020032a:	02078793          	addi	a5,a5,32
    8020032e:	02070713          	addi	a4,a4,32
    80200332:	ff1792e3          	bne	a5,a7,80200316 <new_trap_cx+0x36>
    80200336:	7432                	ld	s0,296(sp)
    80200338:	6155                	addi	sp,sp,304
    8020033a:	8082                	ret

000000008020033c <return_to_user>:

extern void __restore(uint64 a0, uint64 a1);
extern struct task_manager TASK_MANAGER;


void return_to_user(){
    8020033c:	1101                	addi	sp,sp,-32
    8020033e:	e822                	sd	s0,16(sp)
    80200340:	e426                	sd	s1,8(sp)
    80200342:	ec06                	sd	ra,24(sp)
    80200344:	1000                	addi	s0,sp,32
    uint64 a1 = root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn);    // 用户satp
    80200346:	00038497          	auipc	s1,0x38
    8020034a:	de248493          	addi	s1,s1,-542 # 80238128 <heap>
    8020034e:	d184b503          	ld	a0,-744(s1)
    80200352:	00001097          	auipc	ra,0x1
    80200356:	594080e7          	jalr	1428(ra) # 802018e6 <root_ppn_to_token>
    uint64 a0 = TASK_MANAGER.processing_tcb.memoryset.UserStackHigh.start_addr;      // 用户栈顶
    __restore(a0, a1);
}
    8020035a:	6442                	ld	s0,16(sp)
    8020035c:	60e2                	ld	ra,24(sp)
    uint64 a1 = root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn);    // 用户satp
    8020035e:	85aa                	mv	a1,a0
    __restore(a0, a1);
    80200360:	e404b503          	ld	a0,-448(s1)
}
    80200364:	64a2                	ld	s1,8(sp)
    80200366:	6105                	addi	sp,sp,32
    __restore(a0, a1);
    80200368:	00001317          	auipc	t1,0x1
    8020036c:	8b030067          	jr	-1872(t1) # 80200c18 <__restore>

0000000080200370 <trap_handler>:


// 先简单处理sys_write和exit两种系统调用
void trap_handler(){
    80200370:	7149                	addi	sp,sp,-368
    80200372:	f2a2                	sd	s0,352(sp)
    80200374:	f686                	sd	ra,360(sp)
    80200376:	eea6                	sd	s1,344(sp)
    80200378:	eaca                	sd	s2,336(sp)
    8020037a:	e6ce                	sd	s3,328(sp)
    8020037c:	e2d2                	sd	s4,320(sp)
    8020037e:	1a80                	addi	s0,sp,368
// Supervisor Trap Cause
static inline uint64
r_scause()
{
	uint64 x;
	asm volatile("csrr %0, scause" : "=r" (x) );
    80200380:	142025f3          	csrr	a1,scause
// Supervisor Trap Value
static inline uint64
r_stval()
{
	uint64 x;
	asm volatile("csrr %0, stval" : "=r" (x) );
    80200384:	143027f3          	csrr	a5,stval
    uint64 scause = r_scause();   // 获取中断的原因
    uint64 stval = r_stval();
    if (scause != 8){
    80200388:	47a1                	li	a5,8
    8020038a:	0af59363          	bne	a1,a5,80200430 <trap_handler+0xc0>
        printf("the scause now is %d\n", scause);
    }
    if (scause == EXCP_ENV_CALL){
            // 先找到trap上下文中用户程序传递过来的参数
        uint64 user_high_sp = TASK_MANAGER.processing_tcb.memoryset.UserStackHigh.start_addr;
    8020038e:	00038797          	auipc	a5,0x38
    80200392:	d9a78793          	addi	a5,a5,-614 # 80238128 <heap>
        
        uint64 phy_user_high_sp = translate(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn, user_high_sp);
    80200396:	e407b583          	ld	a1,-448(a5)
    8020039a:	d187b503          	ld	a0,-744(a5)
    8020039e:	00001097          	auipc	ra,0x1
    802003a2:	eaa080e7          	jalr	-342(ra) # 80201248 <translate>
    802003a6:	84aa                	mv	s1,a0

        struct trap_context current_trap_cx = *((struct trap_context *)phy_user_high_sp);
    802003a8:	87aa                	mv	a5,a0
    802003aa:	eb040713          	addi	a4,s0,-336
    802003ae:	12050813          	addi	a6,a0,288
    802003b2:	6388                	ld	a0,0(a5)
    802003b4:	678c                	ld	a1,8(a5)
    802003b6:	6b90                	ld	a2,16(a5)
    802003b8:	6f94                	ld	a3,24(a5)
    802003ba:	e308                	sd	a0,0(a4)
    802003bc:	e70c                	sd	a1,8(a4)
    802003be:	eb10                	sd	a2,16(a4)
    802003c0:	ef14                	sd	a3,24(a4)
    802003c2:	02078793          	addi	a5,a5,32
    802003c6:	02070713          	addi	a4,a4,32
    802003ca:	ff0794e3          	bne	a5,a6,802003b2 <trap_handler+0x42>
    802003ce:	0884ba03          	ld	s4,136(s1)
    802003d2:	0584b983          	ld	s3,88(s1)
    802003d6:	0604b903          	ld	s2,96(s1)
        uint64 x17 = current_trap_cx.general_register[17];
        uint64 x10 = current_trap_cx.general_register[10];
        uint64 x11 = current_trap_cx.general_register[11];
        uint64 x12 = current_trap_cx.general_register[12];
        uint64 args[3];
        args[0] = x10;
    802003da:	68bc                	ld	a5,80(s1)
        args[1] = x11;
        args[2] = x12;
        uint64 return_value = syscall(x17, args);
    802003dc:	e9840593          	addi	a1,s0,-360
    802003e0:	8552                	mv	a0,s4
        args[0] = x10;
    802003e2:	e8f43c23          	sd	a5,-360(s0)
        args[1] = x11;
    802003e6:	eb343023          	sd	s3,-352(s0)
        args[2] = x12;
    802003ea:	eb243423          	sd	s2,-344(s0)
        uint64 return_value = syscall(x17, args);
    802003ee:	00000097          	auipc	ra,0x0
    802003f2:	690080e7          	jalr	1680(ra) # 80200a7e <syscall>
        if (return_value > 0){
    802003f6:	cd29                	beqz	a0,80200450 <trap_handler+0xe0>
            current_trap_cx.general_register[10] = return_value;
            *((struct trap_context *)phy_user_high_sp) = current_trap_cx;
    802003f8:	f0a43023          	sd	a0,-256(s0)
    802003fc:	f1343423          	sd	s3,-248(s0)
    80200400:	f1243823          	sd	s2,-240(s0)
    80200404:	f3443c23          	sd	s4,-200(s0)
    80200408:	eb040793          	addi	a5,s0,-336
    8020040c:	8526                	mv	a0,s1
    8020040e:	fd040813          	addi	a6,s0,-48
    80200412:	638c                	ld	a1,0(a5)
    80200414:	6790                	ld	a2,8(a5)
    80200416:	6b94                	ld	a3,16(a5)
    80200418:	6f98                	ld	a4,24(a5)
    8020041a:	e10c                	sd	a1,0(a0)
    8020041c:	e510                	sd	a2,8(a0)
    8020041e:	e914                	sd	a3,16(a0)
    80200420:	ed18                	sd	a4,24(a0)
    80200422:	02078793          	addi	a5,a5,32
    80200426:	02050513          	addi	a0,a0,32
    8020042a:	ff0794e3          	bne	a5,a6,80200412 <trap_handler+0xa2>
    8020042e:	a00d                	j	80200450 <trap_handler+0xe0>
        printf("the scause now is %d\n", scause);
    80200430:	00002517          	auipc	a0,0x2
    80200434:	c7050513          	addi	a0,a0,-912 # 802020a0 <digits+0x18>
    80200438:	00000097          	auipc	ra,0x0
    8020043c:	ce2080e7          	jalr	-798(ra) # 8020011a <printf>
        }
    }else{
        printf("[kernel] unrecognized scause!\n");
    80200440:	00002517          	auipc	a0,0x2
    80200444:	c7850513          	addi	a0,a0,-904 # 802020b8 <digits+0x30>
    80200448:	00000097          	auipc	ra,0x0
    8020044c:	cd2080e7          	jalr	-814(ra) # 8020011a <printf>
    }
    return_to_user();
    80200450:	00000097          	auipc	ra,0x0
    80200454:	eec080e7          	jalr	-276(ra) # 8020033c <return_to_user>
    80200458:	70b6                	ld	ra,360(sp)
    8020045a:	7416                	ld	s0,352(sp)
    8020045c:	64f6                	ld	s1,344(sp)
    8020045e:	6956                	ld	s2,336(sp)
    80200460:	69b6                	ld	s3,328(sp)
    80200462:	6a16                	ld	s4,320(sp)
    80200464:	6175                	addi	sp,sp,368
    80200466:	8082                	ret
	...

000000008020046a <load>:
extern uint64 _num_app;
extern struct task_manager TASK_MANAGER;



struct User_MemorySet load(uint64 app_index){
    8020046a:	1101                	addi	sp,sp,-32
    8020046c:	e822                	sd	s0,16(sp)
    8020046e:	e426                	sd	s1,8(sp)
    80200470:	ec06                	sd	ra,24(sp)
    80200472:	1000                	addi	s0,sp,32

    uint64 num_of_apps = *(uint64 *)(&_num_app);

    uint64 start_addr = *(uint64 *)(&_num_app + app_index);
    80200474:	00003797          	auipc	a5,0x3
    80200478:	b8c78793          	addi	a5,a5,-1140 # 80203000 <_num_app>
    8020047c:	058e                	slli	a1,a1,0x3
    8020047e:	95be                	add	a1,a1,a5

    // 将elf文件解析开
    struct User_MemorySet new_mem_set = load_elf(start_addr);
    80200480:	618c                	ld	a1,0(a1)
struct User_MemorySet load(uint64 app_index){
    80200482:	84aa                	mv	s1,a0
    struct User_MemorySet new_mem_set = load_elf(start_addr);
    80200484:	00001097          	auipc	ra,0x1
    80200488:	496080e7          	jalr	1174(ra) # 8020191a <load_elf>

    return new_mem_set;
}
    8020048c:	60e2                	ld	ra,24(sp)
    8020048e:	6442                	ld	s0,16(sp)
    80200490:	8526                	mv	a0,s1
    80200492:	64a2                	ld	s1,8(sp)
    80200494:	6105                	addi	sp,sp,32
    80200496:	8082                	ret

0000000080200498 <zero_init>:

void zero_init(uint64 start, uint64 end){
    80200498:	1141                	addi	sp,sp,-16
    8020049a:	e422                	sd	s0,8(sp)
    8020049c:	0800                	addi	s0,sp,16
    for (uint64 i = start; i <= end; i++){
    8020049e:	00a5e763          	bltu	a1,a0,802004ac <zero_init+0x14>
        *(char*)i = 0;
    802004a2:	00050023          	sb	zero,0(a0)
    for (uint64 i = start; i <= end; i++){
    802004a6:	0505                	addi	a0,a0,1
    802004a8:	fea5fde3          	bgeu	a1,a0,802004a2 <zero_init+0xa>
    }
}
    802004ac:	6422                	ld	s0,8(sp)
    802004ae:	0141                	addi	sp,sp,16
    802004b0:	8082                	ret

00000000802004b2 <memmove>:
#include "string.h"
#include "console.h"



void memmove(uint64 dst, uint64 src, int size){
    802004b2:	1141                	addi	sp,sp,-16
    802004b4:	e422                	sd	s0,8(sp)
    802004b6:	0800                	addi	s0,sp,16
    int cpy_index = 0;

    while (cpy_index < size){
    802004b8:	02c05263          	blez	a2,802004dc <memmove+0x2a>
    802004bc:	367d                	addiw	a2,a2,-1
    802004be:	1602                	slli	a2,a2,0x20
    802004c0:	00158693          	addi	a3,a1,1
    802004c4:	9201                	srli	a2,a2,0x20
    802004c6:	96b2                	add	a3,a3,a2
    802004c8:	8d0d                	sub	a0,a0,a1
        *(char*)(dst + cpy_index) = *(char*)(src + cpy_index);    // 一个一个byte的复制过去
    802004ca:	0005c703          	lbu	a4,0(a1)
    802004ce:	00b507b3          	add	a5,a0,a1
    802004d2:	0585                	addi	a1,a1,1
    802004d4:	00e78023          	sb	a4,0(a5)
    while (cpy_index < size){
    802004d8:	fed599e3          	bne	a1,a3,802004ca <memmove+0x18>
        cpy_index ++;
    }
}
    802004dc:	6422                	ld	s0,8(sp)
    802004de:	0141                	addi	sp,sp,16
    802004e0:	8082                	ret

00000000802004e2 <memcpy>:

void memcpy(uint64 dst, uint64 src, int size){
    802004e2:	1141                	addi	sp,sp,-16
    802004e4:	e422                	sd	s0,8(sp)
    802004e6:	0800                	addi	s0,sp,16
    while (cpy_index < size){
    802004e8:	02c05263          	blez	a2,8020050c <memcpy+0x2a>
    802004ec:	367d                	addiw	a2,a2,-1
    802004ee:	1602                	slli	a2,a2,0x20
    802004f0:	00158693          	addi	a3,a1,1
    802004f4:	9201                	srli	a2,a2,0x20
    802004f6:	96b2                	add	a3,a3,a2
    802004f8:	8d0d                	sub	a0,a0,a1
        *(char*)(dst + cpy_index) = *(char*)(src + cpy_index);    // 一个一个byte的复制过去
    802004fa:	0005c703          	lbu	a4,0(a1)
    802004fe:	00b507b3          	add	a5,a0,a1
    80200502:	0585                	addi	a1,a1,1
    80200504:	00e78023          	sb	a4,0(a5)
    while (cpy_index < size){
    80200508:	fed599e3          	bne	a1,a3,802004fa <memcpy+0x18>
    memmove(dst, src, size);
    8020050c:	6422                	ld	s0,8(sp)
    8020050e:	0141                	addi	sp,sp,16
    80200510:	8082                	ret

0000000080200512 <init_app>:
extern void __alltraps();
extern struct task_manager TASK_MANAGER;
extern uint64 _num_app;


void init_app(uint64 pid){
    80200512:	81010113          	addi	sp,sp,-2032
    80200516:	7e813023          	sd	s0,2016(sp)
    8020051a:	7f010413          	addi	s0,sp,2032
    8020051e:	7e113423          	sd	ra,2024(sp)
    80200522:	7d213823          	sd	s2,2000(sp)
    80200526:	7d313423          	sd	s3,1992(sp)
    8020052a:	7d413023          	sd	s4,1984(sp)
    8020052e:	7b513c23          	sd	s5,1976(sp)
    80200532:	7b613823          	sd	s6,1968(sp)
    80200536:	7b713423          	sd	s7,1960(sp)
    8020053a:	7b813023          	sd	s8,1952(sp)
    8020053e:	79913c23          	sd	s9,1944(sp)
    80200542:	7c913c23          	sd	s1,2008(sp)

    // 初始化进程管理
    // 第一步：初始化app的地址空间
    struct User_MemorySet current_mem_set = load(pid + 1);    // 将应用程序load到主内存中
    80200546:	b0040a93          	addi	s5,s0,-1280
    8020054a:	00150593          	addi	a1,a0,1
    8020054e:	8556                	mv	a0,s5
void init_app(uint64 pid){
    80200550:	c9010113          	addi	sp,sp,-880
    struct User_MemorySet current_mem_set = load(pid + 1);    // 将应用程序load到主内存中
    80200554:	00000097          	auipc	ra,0x0
    80200558:	f16080e7          	jalr	-234(ra) # 8020046a <load>
    8020055c:	b0043983          	ld	s3,-1280(s0)
    80200560:	b0843b03          	ld	s6,-1272(s0)
    80200564:	c9043a03          	ld	s4,-880(s0)
    uint64 kernel_stack_top = current_mem_set.Kernel_Stack.end_addr;

    // 第二步：初始化进程上下文
    struct task_context app_task_context = new_task_cx(current_mem_set.text.start_addr, kernel_stack_top, current_mem_set.page_table.root_ppn);
    80200568:	86ce                	mv	a3,s3
    8020056a:	85da                	mv	a1,s6
    8020056c:	8652                	mv	a2,s4
    8020056e:	8c840513          	addi	a0,s0,-1848
    struct User_MemorySet current_mem_set = load(pid + 1);    // 将应用程序load到主内存中
    80200572:	c0043c03          	ld	s8,-1024(s0)
    80200576:	c2843b83          	ld	s7,-984(s0)
    struct task_context app_task_context = new_task_cx(current_mem_set.text.start_addr, kernel_stack_top, current_mem_set.page_table.root_ppn);
    8020057a:	00000097          	auipc	ra,0x0
    8020057e:	6f8080e7          	jalr	1784(ra) # 80200c72 <new_task_cx>

    // 第三步：初始化TCB
    struct task_control_block app_tcb = new_task_control_block(app_task_context,  kernel_stack_top);
    80200582:	777d                	lui	a4,0xfffff
    80200584:	7a070713          	addi	a4,a4,1952 # fffffffffffff7a0 <ebss+0xffffffff7fda47a0>
    80200588:	cb840c93          	addi	s9,s0,-840
    8020058c:	8c840793          	addi	a5,s0,-1848
    80200590:	9722                	add	a4,a4,s0
    80200592:	9e040913          	addi	s2,s0,-1568
    80200596:	0007b803          	ld	a6,0(a5)
    8020059a:	6788                	ld	a0,8(a5)
    8020059c:	6b8c                	ld	a1,16(a5)
    8020059e:	6f90                	ld	a2,24(a5)
    802005a0:	7394                	ld	a3,32(a5)
    802005a2:	01073023          	sd	a6,0(a4)
    802005a6:	e708                	sd	a0,8(a4)
    802005a8:	eb0c                	sd	a1,16(a4)
    802005aa:	ef10                	sd	a2,24(a4)
    802005ac:	f314                	sd	a3,32(a4)
    802005ae:	02878793          	addi	a5,a5,40
    802005b2:	02870713          	addi	a4,a4,40
    802005b6:	fef910e3          	bne	s2,a5,80200596 <init_app+0x84>
    802005ba:	77fd                	lui	a5,0xfffff
    802005bc:	7a078593          	addi	a1,a5,1952 # fffffffffffff7a0 <ebss+0xffffffff7fda47a0>
    802005c0:	8652                	mv	a2,s4
    802005c2:	95a2                	add	a1,a1,s0
    802005c4:	8566                	mv	a0,s9
    802005c6:	00000097          	auipc	ra,0x0
    802005ca:	708080e7          	jalr	1800(ra) # 80200cce <new_task_control_block>
    app_tcb.memoryset = current_mem_set;
    802005ce:	84d6                	mv	s1,s5
    802005d0:	cc040793          	addi	a5,s0,-832
    802005d4:	6088                	ld	a0,0(s1)
    802005d6:	648c                	ld	a1,8(s1)
    802005d8:	6890                	ld	a2,16(s1)
    802005da:	6c94                	ld	a3,24(s1)
    802005dc:	7098                	ld	a4,32(s1)
    802005de:	e388                	sd	a0,0(a5)
    802005e0:	e78c                	sd	a1,8(a5)
    802005e2:	eb90                	sd	a2,16(a5)
    802005e4:	ef94                	sd	a3,24(a5)
    802005e6:	f398                	sd	a4,32(a5)
    802005e8:	02848493          	addi	s1,s1,40
    802005ec:	02878793          	addi	a5,a5,40
    802005f0:	ff9492e3          	bne	s1,s9,802005d4 <init_app+0xc2>
    app_tcb.user_token = root_ppn_to_token(current_mem_set.page_table.root_ppn);
    802005f4:	854e                	mv	a0,s3
    802005f6:	00001097          	auipc	ra,0x1
    802005fa:	2f0080e7          	jalr	752(ra) # 802018e6 <root_ppn_to_token>

    // 第四步：将初始化好的TCB放入task manager中
    add_task_control_block(app_tcb);
    802005fe:	fa040713          	addi	a4,s0,-96
    80200602:	77fd                	lui	a5,0xfffff
    80200604:	76fd                	lui	a3,0xfffff
    80200606:	97ba                	add	a5,a5,a4
    80200608:	4a868713          	addi	a4,a3,1192 # fffffffffffff4a8 <ebss+0xffffffff7fda44a8>
    8020060c:	9722                	add	a4,a4,s0
    8020060e:	e31c                	sd	a5,0(a4)
    80200610:	631c                	ld	a5,0(a4)
    app_tcb.user_token = root_ppn_to_token(current_mem_set.page_table.root_ppn);
    80200612:	caa43c23          	sd	a0,-840(s0)
    add_task_control_block(app_tcb);
    80200616:	f9840713          	addi	a4,s0,-104
    8020061a:	51078793          	addi	a5,a5,1296 # fffffffffffff510 <ebss+0xffffffff7fda4510>
    8020061e:	6088                	ld	a0,0(s1)
    80200620:	648c                	ld	a1,8(s1)
    80200622:	6890                	ld	a2,16(s1)
    80200624:	6c94                	ld	a3,24(s1)
    80200626:	e388                	sd	a0,0(a5)
    80200628:	e78c                	sd	a1,8(a5)
    8020062a:	eb90                	sd	a2,16(a5)
    8020062c:	ef94                	sd	a3,24(a5)
    8020062e:	02048493          	addi	s1,s1,32
    80200632:	02078793          	addi	a5,a5,32
    80200636:	fee494e3          	bne	s1,a4,8020061e <init_app+0x10c>
    8020063a:	6098                	ld	a4,0(s1)
    8020063c:	757d                	lui	a0,0xfffff
    8020063e:	fa040693          	addi	a3,s0,-96
    80200642:	51050513          	addi	a0,a0,1296 # fffffffffffff510 <ebss+0xffffffff7fda4510>
    80200646:	9536                	add	a0,a0,a3
    80200648:	e398                	sd	a4,0(a5)
    8020064a:	00000097          	auipc	ra,0x0
    8020064e:	7b4080e7          	jalr	1972(ra) # 80200dfe <add_task_control_block>
	asm volatile("csrr %0, satp" : "=r" (x) );
    80200652:	18002673          	csrr	a2,satp
    uint64 app_entry = current_mem_set.text.start_addr;  // app执行的第一条指令位置
    uint64 kernel_satp = r_satp();   
    uint64 app_trap_handler = trap_handler;


    struct trap_context app_trap_context = new_trap_cx(app_entry, kernel_satp, app_trap_handler, user_low_sp, kernel_stack_top);
    80200656:	00000697          	auipc	a3,0x0
    8020065a:	d1a68693          	addi	a3,a3,-742 # 80200370 <trap_handler>
    8020065e:	87d2                	mv	a5,s4
    80200660:	8762                	mv	a4,s8
    80200662:	85da                	mv	a1,s6
    80200664:	854a                	mv	a0,s2
    80200666:	00000097          	auipc	ra,0x0
    8020066a:	c7a080e7          	jalr	-902(ra) # 802002e0 <new_trap_cx>


    // 第二步: 将trap上下文放在用户栈高位栈顶：
    uint64 user_high_sp = current_mem_set.UserStackHigh.start_addr;
    uint64 phy_user_high_sp = translate(current_mem_set.page_table.root_ppn, user_high_sp);
    8020066e:	85de                	mv	a1,s7
    80200670:	854e                	mv	a0,s3
    80200672:	00001097          	auipc	ra,0x1
    80200676:	bd6080e7          	jalr	-1066(ra) # 80201248 <translate>
    *((struct trap_context *)phy_user_high_sp) = app_trap_context;
    8020067a:	87ca                	mv	a5,s2
    8020067c:	638c                	ld	a1,0(a5)
    8020067e:	6790                	ld	a2,8(a5)
    80200680:	6b94                	ld	a3,16(a5)
    80200682:	6f98                	ld	a4,24(a5)
    80200684:	e10c                	sd	a1,0(a0)
    80200686:	e510                	sd	a2,8(a0)
    80200688:	e914                	sd	a3,16(a0)
    8020068a:	ed18                	sd	a4,24(a0)
    8020068c:	02078793          	addi	a5,a5,32
    80200690:	02050513          	addi	a0,a0,32
    80200694:	ff5794e3          	bne	a5,s5,8020067c <init_app+0x16a>
	asm volatile("csrw stvec, %0" : : "r" (x));
    80200698:	00000797          	auipc	a5,0x0
    8020069c:	52478793          	addi	a5,a5,1316 # 80200bbc <__alltraps>
    802006a0:	10579073          	csrw	stvec,a5


    // 第三步: 将stvec修改成__alltraps的位置
    w_stvec(__alltraps);    

}
    802006a4:	37010113          	addi	sp,sp,880
    802006a8:	7e813083          	ld	ra,2024(sp)
    802006ac:	7e013403          	ld	s0,2016(sp)
    802006b0:	7d813483          	ld	s1,2008(sp)
    802006b4:	7d013903          	ld	s2,2000(sp)
    802006b8:	7c813983          	ld	s3,1992(sp)
    802006bc:	7c013a03          	ld	s4,1984(sp)
    802006c0:	7b813a83          	ld	s5,1976(sp)
    802006c4:	7b013b03          	ld	s6,1968(sp)
    802006c8:	7a813b83          	ld	s7,1960(sp)
    802006cc:	7a013c03          	ld	s8,1952(sp)
    802006d0:	79813c83          	ld	s9,1944(sp)
    802006d4:	7f010113          	addi	sp,sp,2032
    802006d8:	8082                	ret

00000000802006da <scheduler>:

uint64 scheduler(){
    802006da:	1101                	addi	sp,sp,-32
    802006dc:	e822                	sd	s0,16(sp)
    802006de:	e426                	sd	s1,8(sp)
    802006e0:	e04a                	sd	s2,0(sp)
    802006e2:	ec06                	sd	ra,24(sp)
    802006e4:	1000                	addi	s0,sp,32

    // 先采用FIFO的schedule策略

    uint64 current_pid = TASK_MANAGER.processing_tcb.pid;

    uint64 next_pid = (current_pid + 1) % MAX_NUM_OF_APPS;
    802006e6:	00038497          	auipc	s1,0x38
    802006ea:	a324b483          	ld	s1,-1486(s1) # 80238118 <TASK_MANAGER+0x1ff0>
    802006ee:	0485                	addi	s1,s1,1
    802006f0:	47a9                	li	a5,10
    802006f2:	02f4f4b3          	remu	s1,s1,a5

    while(!check_valid(next_pid)){
        next_pid = (next_pid + 1) % MAX_NUM_OF_APPS;
    802006f6:	4929                	li	s2,10
    while(!check_valid(next_pid)){
    802006f8:	a019                	j	802006fe <scheduler+0x24>
        next_pid = (next_pid + 1) % MAX_NUM_OF_APPS;
    802006fa:	0327f4b3          	remu	s1,a5,s2
    while(!check_valid(next_pid)){
    802006fe:	8526                	mv	a0,s1
    80200700:	00000097          	auipc	ra,0x0
    80200704:	6e2080e7          	jalr	1762(ra) # 80200de2 <check_valid>
        next_pid = (next_pid + 1) % MAX_NUM_OF_APPS;
    80200708:	00148793          	addi	a5,s1,1
    while(!check_valid(next_pid)){
    8020070c:	d57d                	beqz	a0,802006fa <scheduler+0x20>
    }

    return next_pid;

}
    8020070e:	60e2                	ld	ra,24(sp)
    80200710:	6442                	ld	s0,16(sp)
    80200712:	6902                	ld	s2,0(sp)
    80200714:	8526                	mv	a0,s1
    80200716:	64a2                	ld	s1,8(sp)
    80200718:	6105                	addi	sp,sp,32
    8020071a:	8082                	ret

000000008020071c <init_all_apps>:


void init_all_apps(){
    8020071c:	1101                	addi	sp,sp,-32
    8020071e:	e822                	sd	s0,16(sp)
    80200720:	e04a                	sd	s2,0(sp)
    80200722:	ec06                	sd	ra,24(sp)
    80200724:	e426                	sd	s1,8(sp)
    80200726:	1000                	addi	s0,sp,32
    
    uint64 num_of_apps = *(uint64 *)(&_num_app);
    80200728:	00003917          	auipc	s2,0x3
    8020072c:	8d893903          	ld	s2,-1832(s2) # 80203000 <_num_app>

    for (int i = 0; i < num_of_apps; i++){
    80200730:	00090b63          	beqz	s2,80200746 <init_all_apps+0x2a>
    80200734:	4481                	li	s1,0
        init_app(i);
    80200736:	8526                	mv	a0,s1
    80200738:	0485                	addi	s1,s1,1
    8020073a:	00000097          	auipc	ra,0x0
    8020073e:	dd8080e7          	jalr	-552(ra) # 80200512 <init_app>
    for (int i = 0; i < num_of_apps; i++){
    80200742:	ff249ae3          	bne	s1,s2,80200736 <init_all_apps+0x1a>
    }
    
}
    80200746:	60e2                	ld	ra,24(sp)
    80200748:	6442                	ld	s0,16(sp)
    8020074a:	64a2                	ld	s1,8(sp)
    8020074c:	6902                	ld	s2,0(sp)
    8020074e:	6105                	addi	sp,sp,32
    80200750:	8082                	ret

0000000080200752 <run_next_app>:

void run_next_app(int init){

    if (init == 1){
    80200752:	4785                	li	a5,1
    80200754:	04f50d63          	beq	a0,a5,802007ae <run_next_app+0x5c>
void run_next_app(int init){
    80200758:	1141                	addi	sp,sp,-16
    8020075a:	e022                	sd	s0,0(sp)
    8020075c:	e406                	sd	ra,8(sp)
    8020075e:	0800                	addi	s0,sp,16
        TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[0];
        return_to_user();
        return 0;
    }

    uint64 pid = scheduler();
    80200760:	00000097          	auipc	ra,0x0
    80200764:	f7a080e7          	jalr	-134(ra) # 802006da <scheduler>
    TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[pid];
    80200768:	2e800713          	li	a4,744
    8020076c:	02e50733          	mul	a4,a0,a4
    80200770:	00036517          	auipc	a0,0x36
    80200774:	9b850513          	addi	a0,a0,-1608 # 80236128 <TASK_MANAGER>
    80200778:	00037797          	auipc	a5,0x37
    8020077c:	6c078793          	addi	a5,a5,1728 # 80237e38 <TASK_MANAGER+0x1d10>
    80200780:	953a                	add	a0,a0,a4
    80200782:	2e050813          	addi	a6,a0,736
    80200786:	610c                	ld	a1,0(a0)
    80200788:	6510                	ld	a2,8(a0)
    8020078a:	6914                	ld	a3,16(a0)
    8020078c:	6d18                	ld	a4,24(a0)
    8020078e:	e38c                	sd	a1,0(a5)
    80200790:	e790                	sd	a2,8(a5)
    80200792:	eb94                	sd	a3,16(a5)
    80200794:	ef98                	sd	a4,24(a5)
    80200796:	02050513          	addi	a0,a0,32
    8020079a:	02078793          	addi	a5,a5,32
    8020079e:	ff0514e3          	bne	a0,a6,80200786 <run_next_app+0x34>
    802007a2:	6118                	ld	a4,0(a0)

}
    802007a4:	60a2                	ld	ra,8(sp)
    802007a6:	6402                	ld	s0,0(sp)
    TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[pid];
    802007a8:	e398                	sd	a4,0(a5)
}
    802007aa:	0141                	addi	sp,sp,16
    802007ac:	8082                	ret
        TASK_MANAGER.processing_tcb = TASK_MANAGER.TASK_MANAGER_CONTAINER[0];
    802007ae:	00036797          	auipc	a5,0x36
    802007b2:	97a78793          	addi	a5,a5,-1670 # 80236128 <TASK_MANAGER>
    802007b6:	00037717          	auipc	a4,0x37
    802007ba:	68270713          	addi	a4,a4,1666 # 80237e38 <TASK_MANAGER+0x1d10>
    802007be:	00036817          	auipc	a6,0x36
    802007c2:	c4a80813          	addi	a6,a6,-950 # 80236408 <TASK_MANAGER+0x2e0>
    802007c6:	6388                	ld	a0,0(a5)
    802007c8:	678c                	ld	a1,8(a5)
    802007ca:	6b90                	ld	a2,16(a5)
    802007cc:	6f94                	ld	a3,24(a5)
    802007ce:	e308                	sd	a0,0(a4)
    802007d0:	e70c                	sd	a1,8(a4)
    802007d2:	eb10                	sd	a2,16(a4)
    802007d4:	ef14                	sd	a3,24(a4)
    802007d6:	02078793          	addi	a5,a5,32
    802007da:	02070713          	addi	a4,a4,32
    802007de:	ff0794e3          	bne	a5,a6,802007c6 <run_next_app+0x74>
    802007e2:	639c                	ld	a5,0(a5)
    802007e4:	e31c                	sd	a5,0(a4)
        return_to_user();
    802007e6:	00000317          	auipc	t1,0x0
    802007ea:	b5630067          	jr	-1194(t1) # 8020033c <return_to_user>

00000000802007ee <initframe>:
#include "console.h"

extern uint32 ekernel;


void initframe(){
    802007ee:	1141                	addi	sp,sp,-16
    802007f0:	e422                	sd	s0,8(sp)
  uint32  kernel_end = &ekernel;
    802007f2:	0005b797          	auipc	a5,0x5b
    802007f6:	80e78793          	addi	a5,a5,-2034 # 8025b000 <ebss>
void initframe(){
    802007fa:	0800                	addi	s0,sp,16
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
    802007fc:	7fe006b7          	lui	a3,0x7fe00
    80200800:	9ebd                	addw	a3,a3,a5
  uint32 remain =  (kernel_end - BASE_ADDRESS) % PAGE_SIZE;
    80200802:	17d2                	slli	a5,a5,0x34
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
    80200804:	00c6d71b          	srliw	a4,a3,0xc
    80200808:	00c6d69b          	srliw	a3,a3,0xc
  if (remain > 0) kernel_frame++;
    8020080c:	c399                	beqz	a5,80200812 <initframe+0x24>
    8020080e:	0017069b          	addiw	a3,a4,1
  uint32 kernel_bit_end = kernel_frame / 8;
    80200812:	0036d61b          	srliw	a2,a3,0x3
    80200816:	0036d59b          	srliw	a1,a3,0x3
  uint32 kernel_bit_offset = kernel_frame % 8;
    8020081a:	0076f813          	andi	a6,a3,7

  for (uint32 i = 0; i < kernel_bit_end; i++){
    8020081e:	00035517          	auipc	a0,0x35
    80200822:	7e250513          	addi	a0,a0,2018 # 80236000 <bitmap>
    80200826:	c60d                	beqz	a2,80200850 <initframe+0x62>
    80200828:	fff5871b          	addiw	a4,a1,-1
    8020082c:	1702                	slli	a4,a4,0x20
    8020082e:	00035617          	auipc	a2,0x35
    80200832:	7d360613          	addi	a2,a2,2003 # 80236001 <bitmap+0x1>
    80200836:	00035517          	auipc	a0,0x35
    8020083a:	7ca50513          	addi	a0,a0,1994 # 80236000 <bitmap>
    8020083e:	9301                	srli	a4,a4,0x20
    80200840:	9732                	add	a4,a4,a2
    80200842:	87aa                	mv	a5,a0
    bitmap[i] = 255; // 0x11111111
    80200844:	567d                	li	a2,-1
    80200846:	00c78023          	sb	a2,0(a5)
  for (uint32 i = 0; i < kernel_bit_end; i++){
    8020084a:	0785                	addi	a5,a5,1
    8020084c:	fee79de3          	bne	a5,a4,80200846 <initframe+0x58>
  }
  bitmap[kernel_bit_end] = (uint8)(255 >> (8-kernel_bit_offset)); // 0x11111111 >> kernel_bit_offset
    80200850:	47a1                	li	a5,8
    80200852:	1582                	slli	a1,a1,0x20
    80200854:	4107873b          	subw	a4,a5,a6
    80200858:	9181                	srli	a1,a1,0x20
    8020085a:	0ff00793          	li	a5,255
    8020085e:	40e7d7bb          	sraw	a5,a5,a4
    80200862:	95aa                	add	a1,a1,a0
    80200864:	00f58023          	sb	a5,0(a1)
  Isinit = 1;
  kernel_frame_end = kernel_frame;
}
    80200868:	6422                	ld	s0,8(sp)
  Isinit = 1;
    8020086a:	4785                	li	a5,1
    8020086c:	0005a717          	auipc	a4,0x5a
    80200870:	daf70c23          	sb	a5,-584(a4) # 8025a624 <Isinit>
  kernel_frame_end = kernel_frame;
    80200874:	0005a797          	auipc	a5,0x5a
    80200878:	dad7a623          	sw	a3,-596(a5) # 8025a620 <kernel_frame_end>
}
    8020087c:	0141                	addi	sp,sp,16
    8020087e:	8082                	ret

0000000080200880 <If_bitmap_is_set>:

uint32 If_bitmap_is_set(uint32 frame_number){
    80200880:	1141                	addi	sp,sp,-16
    80200882:	e422                	sd	s0,8(sp)
    uint32 byte_number = frame_number / 8;
    uint32 bit_number = frame_number % 8;
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200884:	0035571b          	srliw	a4,a0,0x3
uint32 If_bitmap_is_set(uint32 frame_number){
    80200888:	0800                	addi	s0,sp,16
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    8020088a:	00035797          	auipc	a5,0x35
    8020088e:	77678793          	addi	a5,a5,1910 # 80236000 <bitmap>
    80200892:	97ba                	add	a5,a5,a4
    80200894:	0007c783          	lbu	a5,0(a5)
}
    80200898:	6422                	ld	s0,8(sp)
    uint32 bit_number = frame_number % 8;
    8020089a:	891d                	andi	a0,a0,7
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    8020089c:	40a7d53b          	sraw	a0,a5,a0
}
    802008a0:	8905                	andi	a0,a0,1
    802008a2:	0141                	addi	sp,sp,16
    802008a4:	8082                	ret

00000000802008a6 <get_frame>:

uint32 get_frame(){
    802008a6:	1141                	addi	sp,sp,-16
    802008a8:	e422                	sd	s0,8(sp)
    802008aa:	0800                	addi	s0,sp,16
  if (!Isinit){
    802008ac:	0005a897          	auipc	a7,0x5a
    802008b0:	d7888893          	addi	a7,a7,-648 # 8025a624 <Isinit>
    802008b4:	0008c783          	lbu	a5,0(a7)
    802008b8:	cfbd                	beqz	a5,80200936 <get_frame+0x90>
    802008ba:	0005a517          	auipc	a0,0x5a
    802008be:	d6652503          	lw	a0,-666(a0) # 8025a620 <kernel_frame_end>
    802008c2:	2505                	addiw	a0,a0,1
    initframe();
  }
  uint32 start_free_frame = kernel_frame_end + 1; // protection of kernel

  // search for valid free frame
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    802008c4:	7ff00793          	li	a5,2047
    802008c8:	0ea7ef63          	bltu	a5,a0,802009c6 <get_frame+0x120>
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    802008cc:	00035617          	auipc	a2,0x35
    802008d0:	73460613          	addi	a2,a2,1844 # 80236000 <bitmap>
    802008d4:	0035579b          	srliw	a5,a0,0x3
    802008d8:	97b2                	add	a5,a5,a2
    802008da:	0007c703          	lbu	a4,0(a5)
    uint32 bit_number = frame_number % 8;
    802008de:	00757693          	andi	a3,a0,7
    uint32 byte_number = frame_number / 8;
    802008e2:	0035579b          	srliw	a5,a0,0x3
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    802008e6:	40d755bb          	sraw	a1,a4,a3
    if (If_bitmap_is_set(index)) {
    802008ea:	8985                	andi	a1,a1,1
    802008ec:	e185                	bnez	a1,8020090c <get_frame+0x66>
      continue;
    } else {
      // update the frame
      uint32 byte_number = index / 8;
      uint32 bit_number = index % 8;
      bitmap[byte_number] |= (1 << bit_number);
    802008ee:	4585                	li	a1,1
    802008f0:	00d596bb          	sllw	a3,a1,a3
    802008f4:	97b2                	add	a5,a5,a2
    802008f6:	8f55                	or	a4,a4,a3
    802008f8:	00e78023          	sb	a4,0(a5)
      return index + (0x80200000 / 4096);
    }
  }

  return -1; // invalid
}
    802008fc:	6422                	ld	s0,8(sp)
      return index + (0x80200000 / 4096);
    802008fe:	000807b7          	lui	a5,0x80
    80200902:	2007879b          	addiw	a5,a5,512
    80200906:	9d3d                	addw	a0,a0,a5
}
    80200908:	0141                	addi	sp,sp,16
    8020090a:	8082                	ret
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    8020090c:	0015079b          	addiw	a5,a0,1
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200910:	0037d71b          	srliw	a4,a5,0x3
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    80200914:	8007859b          	addiw	a1,a5,-2048
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200918:	9732                	add	a4,a4,a2
    uint32 bit_number = frame_number % 8;
    8020091a:	0077f693          	andi	a3,a5,7
  for (uint32 index = start_free_frame; index < BITMAP_SIZE; index++) {
    8020091e:	0007851b          	sext.w	a0,a5
    80200922:	c1d5                	beqz	a1,802009c6 <get_frame+0x120>
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    80200924:	00074703          	lbu	a4,0(a4)
    uint32 byte_number = frame_number / 8;
    80200928:	0037d79b          	srliw	a5,a5,0x3
    return (bitmap[byte_number] & (1 << bit_number)) != 0;
    8020092c:	40d755bb          	sraw	a1,a4,a3
    if (If_bitmap_is_set(index)) {
    80200930:	8985                	andi	a1,a1,1
    80200932:	ddd5                	beqz	a1,802008ee <get_frame+0x48>
    80200934:	bfe1                	j	8020090c <get_frame+0x66>
  uint32  kernel_end = &ekernel;
    80200936:	0005a797          	auipc	a5,0x5a
    8020093a:	6ca78793          	addi	a5,a5,1738 # 8025b000 <ebss>
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
    8020093e:	7fe006b7          	lui	a3,0x7fe00
    80200942:	9ebd                	addw	a3,a3,a5
    80200944:	00c6d71b          	srliw	a4,a3,0xc
  uint32 remain =  (kernel_end - BASE_ADDRESS) % PAGE_SIZE;
    80200948:	17d2                	slli	a5,a5,0x34
  uint32 kernel_frame = (kernel_end - BASE_ADDRESS)/PAGE_SIZE;
    8020094a:	00c6d69b          	srliw	a3,a3,0xc
  if (remain > 0) kernel_frame++;
    8020094e:	0017051b          	addiw	a0,a4,1
    80200952:	c781                	beqz	a5,8020095a <get_frame+0xb4>
    80200954:	86aa                	mv	a3,a0
    80200956:	0027051b          	addiw	a0,a4,2
  uint32 kernel_bit_end = kernel_frame / 8;
    8020095a:	0036d79b          	srliw	a5,a3,0x3
    8020095e:	0036d81b          	srliw	a6,a3,0x3
  uint32 kernel_bit_offset = kernel_frame % 8;
    80200962:	0076f313          	andi	t1,a3,7
  for (uint32 i = 0; i < kernel_bit_end; i++){
    80200966:	cbb9                	beqz	a5,802009bc <get_frame+0x116>
    80200968:	fff8071b          	addiw	a4,a6,-1
    8020096c:	02071593          	slli	a1,a4,0x20
    80200970:	9181                	srli	a1,a1,0x20
    80200972:	00035617          	auipc	a2,0x35
    80200976:	68e60613          	addi	a2,a2,1678 # 80236000 <bitmap>
    8020097a:	00035717          	auipc	a4,0x35
    8020097e:	68770713          	addi	a4,a4,1671 # 80236001 <bitmap+0x1>
    80200982:	972e                	add	a4,a4,a1
    80200984:	87b2                	mv	a5,a2
    bitmap[i] = 255; // 0x11111111
    80200986:	55fd                	li	a1,-1
    80200988:	00b78023          	sb	a1,0(a5)
  for (uint32 i = 0; i < kernel_bit_end; i++){
    8020098c:	0785                	addi	a5,a5,1
    8020098e:	fef71de3          	bne	a4,a5,80200988 <get_frame+0xe2>
  bitmap[kernel_bit_end] = (uint8)(255 >> (8-kernel_bit_offset)); // 0x11111111 >> kernel_bit_offset
    80200992:	4721                	li	a4,8
    80200994:	02081793          	slli	a5,a6,0x20
    80200998:	406705bb          	subw	a1,a4,t1
    8020099c:	9381                	srli	a5,a5,0x20
    8020099e:	0ff00713          	li	a4,255
    802009a2:	97b2                	add	a5,a5,a2
    802009a4:	40b7573b          	sraw	a4,a4,a1
    802009a8:	00e78023          	sb	a4,0(a5)
  Isinit = 1;
    802009ac:	4785                	li	a5,1
    802009ae:	00f88023          	sb	a5,0(a7)
  kernel_frame_end = kernel_frame;
    802009b2:	0005a797          	auipc	a5,0x5a
    802009b6:	c6d7a723          	sw	a3,-914(a5) # 8025a620 <kernel_frame_end>
}
    802009ba:	b729                	j	802008c4 <get_frame+0x1e>
    802009bc:	00035617          	auipc	a2,0x35
    802009c0:	64460613          	addi	a2,a2,1604 # 80236000 <bitmap>
    802009c4:	b7f9                	j	80200992 <get_frame+0xec>
}
    802009c6:	6422                	ld	s0,8(sp)
  return -1; // invalid
    802009c8:	557d                	li	a0,-1
}
    802009ca:	0141                	addi	sp,sp,16
    802009cc:	8082                	ret

00000000802009ce <free_frame>:

void free_frame(uint32 frame_number){
    802009ce:	1141                	addi	sp,sp,-16
  frame_number = frame_number-0x80200000/4096;
    802009d0:	fff80637          	lui	a2,0xfff80
void free_frame(uint32 frame_number){
    802009d4:	e422                	sd	s0,8(sp)
  for (uint32 index = 0; index < PAGE_SIZE; index+=32) {
    uint32 * addr = (uint32*)(BASE_ADDRESS + frame_number * PAGE_SIZE + index);
    802009d6:	00c5179b          	slliw	a5,a0,0xc
void free_frame(uint32 frame_number){
    802009da:	0800                	addi	s0,sp,16
  frame_number = frame_number-0x80200000/4096;
    802009dc:	e006061b          	addiw	a2,a2,-512
    802009e0:	6685                	lui	a3,0x1
    802009e2:	9e29                	addw	a2,a2,a0
  for (uint32 index = 0; index < PAGE_SIZE; index+=32) {
    802009e4:	9ebd                	addw	a3,a3,a5
    uint32 * addr = (uint32*)(BASE_ADDRESS + frame_number * PAGE_SIZE + index);
    802009e6:	02079713          	slli	a4,a5,0x20
    802009ea:	9301                	srli	a4,a4,0x20
    *addr = 0;
    802009ec:	00072023          	sw	zero,0(a4)
  for (uint32 index = 0; index < PAGE_SIZE; index+=32) {
    802009f0:	0207879b          	addiw	a5,a5,32
    802009f4:	fef699e3          	bne	a3,a5,802009e6 <free_frame+0x18>
  }
  // modify the bitmap
  uint32 byte_number = frame_number / 8;
  uint32 bit_number = frame_number % 8;
  bitmap[byte_number] &= ~(1 << bit_number);
    802009f8:	0036579b          	srliw	a5,a2,0x3
    802009fc:	00035717          	auipc	a4,0x35
    80200a00:	60470713          	addi	a4,a4,1540 # 80236000 <bitmap>
    80200a04:	973e                	add	a4,a4,a5
    80200a06:	00074683          	lbu	a3,0(a4)
  uint32 bit_number = frame_number % 8;
    80200a0a:	8a1d                	andi	a2,a2,7
  bitmap[byte_number] &= ~(1 << bit_number);
    80200a0c:	4785                	li	a5,1
    80200a0e:	00c797bb          	sllw	a5,a5,a2
    80200a12:	fff7c793          	not	a5,a5
    80200a16:	8ff5                	and	a5,a5,a3
    80200a18:	00f70023          	sb	a5,0(a4)
}
    80200a1c:	6422                	ld	s0,8(sp)
    80200a1e:	0141                	addi	sp,sp,16
    80200a20:	8082                	ret

0000000080200a22 <sys_exit>:
        printf("[kernel] Not supported system call: %d\n", type);
    }
    return 0;
}

void sys_exit(uint64 exit_code){
    80200a22:	1141                	addi	sp,sp,-16
    80200a24:	e022                	sd	s0,0(sp)
    80200a26:	e406                	sd	ra,8(sp)
    80200a28:	0800                	addi	s0,sp,16
    80200a2a:	85aa                	mv	a1,a0
    printf("[kernel] The application end with exit code: %d\n", exit_code);
    80200a2c:	00001517          	auipc	a0,0x1
    80200a30:	6ac50513          	addi	a0,a0,1708 # 802020d8 <digits+0x50>
    80200a34:	fffff097          	auipc	ra,0xfffff
    80200a38:	6e6080e7          	jalr	1766(ra) # 8020011a <printf>
 
    if (TASK_MANAGER.processing_tcb.pid + 1 < 4){
    80200a3c:	00037517          	auipc	a0,0x37
    80200a40:	6dc53503          	ld	a0,1756(a0) # 80238118 <TASK_MANAGER+0x1ff0>
    80200a44:	00150713          	addi	a4,a0,1
    80200a48:	478d                	li	a5,3
    80200a4a:	00e7ef63          	bltu	a5,a4,80200a68 <sys_exit+0x46>

        free_task_control_block(TASK_MANAGER.processing_tcb.pid);
    80200a4e:	2501                	sext.w	a0,a0
    80200a50:	00000097          	auipc	ra,0x0
    80200a54:	448080e7          	jalr	1096(ra) # 80200e98 <free_task_control_block>

    }else{
        panic("finish running all the apps!\n");
    }

}
    80200a58:	6402                	ld	s0,0(sp)
    80200a5a:	60a2                	ld	ra,8(sp)
        run_next_app(0);
    80200a5c:	4501                	li	a0,0
}
    80200a5e:	0141                	addi	sp,sp,16
        run_next_app(0);
    80200a60:	00000317          	auipc	t1,0x0
    80200a64:	cf230067          	jr	-782(t1) # 80200752 <run_next_app>
}
    80200a68:	6402                	ld	s0,0(sp)
    80200a6a:	60a2                	ld	ra,8(sp)
        panic("finish running all the apps!\n");
    80200a6c:	00001517          	auipc	a0,0x1
    80200a70:	6a450513          	addi	a0,a0,1700 # 80202110 <digits+0x88>
}
    80200a74:	0141                	addi	sp,sp,16
        panic("finish running all the apps!\n");
    80200a76:	00000317          	auipc	t1,0x0
    80200a7a:	83830067          	jr	-1992(t1) # 802002ae <panic>

0000000080200a7e <syscall>:
uint64 syscall(uint64 type, uint64 args[3]){
    80200a7e:	1101                	addi	sp,sp,-32
    80200a80:	e822                	sd	s0,16(sp)
    80200a82:	e426                	sd	s1,8(sp)
    80200a84:	ec06                	sd	ra,24(sp)
    80200a86:	e04a                	sd	s2,0(sp)
    80200a88:	1000                	addi	s0,sp,32
    if (type == SYSCALL_WRITE){
    80200a8a:	04000793          	li	a5,64
uint64 syscall(uint64 type, uint64 args[3]){
    80200a8e:	84ae                	mv	s1,a1
    if (type == SYSCALL_WRITE){
    80200a90:	02f50e63          	beq	a0,a5,80200acc <syscall+0x4e>
    else if (type == SYSCALL_EXIT){
    80200a94:	05d00793          	li	a5,93
    80200a98:	08f50863          	beq	a0,a5,80200b28 <syscall+0xaa>
    else if (type == SYSCALL_YIELD){
    80200a9c:	07c00793          	li	a5,124
    80200aa0:	0af50063          	beq	a0,a5,80200b40 <syscall+0xc2>
    else if (type == SYSCALL_GET_TIME){
    80200aa4:	0a900793          	li	a5,169
    80200aa8:	06f50263          	beq	a0,a5,80200b0c <syscall+0x8e>
        printf("[kernel] Not supported system call: %d\n", type);
    80200aac:	85aa                	mv	a1,a0
    80200aae:	00001517          	auipc	a0,0x1
    80200ab2:	68250513          	addi	a0,a0,1666 # 80202130 <digits+0xa8>
    80200ab6:	fffff097          	auipc	ra,0xfffff
    80200aba:	664080e7          	jalr	1636(ra) # 8020011a <printf>
}
    80200abe:	60e2                	ld	ra,24(sp)
    80200ac0:	6442                	ld	s0,16(sp)
    80200ac2:	64a2                	ld	s1,8(sp)
    80200ac4:	6902                	ld	s2,0(sp)
    return 0;
    80200ac6:	4501                	li	a0,0
}
    80200ac8:	6105                	addi	sp,sp,32
    80200aca:	8082                	ret
        args[1] = translate(root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn), args[1]);
    80200acc:	00037517          	auipc	a0,0x37
    80200ad0:	37453503          	ld	a0,884(a0) # 80237e40 <TASK_MANAGER+0x1d18>
    80200ad4:	00001097          	auipc	ra,0x1
    80200ad8:	e12080e7          	jalr	-494(ra) # 802018e6 <root_ppn_to_token>
    80200adc:	648c                	ld	a1,8(s1)
    80200ade:	00000097          	auipc	ra,0x0
    80200ae2:	76a080e7          	jalr	1898(ra) # 80201248 <translate>

uint64 sys_write(uint64 fd, char* buf, uint64 length) {
    if (fd == 1){    // means STDOUT
    80200ae6:	6098                	ld	a4,0(s1)
        args[1] = translate(root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn), args[1]);
    80200ae8:	e488                	sd	a0,8(s1)
    if (fd == 1){    // means STDOUT
    80200aea:	4785                	li	a5,1
        args[1] = translate(root_ppn_to_token(TASK_MANAGER.processing_tcb.memoryset.page_table.root_ppn), args[1]);
    80200aec:	892a                	mv	s2,a0
    if (fd == 1){    // means STDOUT
    80200aee:	fcf718e3          	bne	a4,a5,80200abe <syscall+0x40>
        sys_write(args[0], args[1], args[2]);
    80200af2:	6884                	ld	s1,16(s1)
        for (int i = 0; i < length; i++){
    80200af4:	d4e9                	beqz	s1,80200abe <syscall+0x40>
    80200af6:	94aa                	add	s1,s1,a0
            consputc(buf[i]);
    80200af8:	00094503          	lbu	a0,0(s2)
    80200afc:	0905                	addi	s2,s2,1
    80200afe:	fffff097          	auipc	ra,0xfffff
    80200b02:	5e6080e7          	jalr	1510(ra) # 802000e4 <consputc>
        for (int i = 0; i < length; i++){
    80200b06:	ff2499e3          	bne	s1,s2,80200af8 <syscall+0x7a>
    80200b0a:	bf55                	j	80200abe <syscall+0x40>
r_time()
{
	uint64 x;
	// asm volatile("csrr %0, time" : "=r" (x) );
	// this instruction will trap in SBI
	asm volatile("rdtime %0" : "=r" (x) );
    80200b0c:	c0102573          	rdtime	a0
}
    80200b10:	60e2                	ld	ra,24(sp)
    80200b12:	6442                	ld	s0,16(sp)
        return r_time() / 10000000;
    80200b14:	009897b7          	lui	a5,0x989
    80200b18:	68078793          	addi	a5,a5,1664 # 989680 <n+0x989660>
}
    80200b1c:	64a2                	ld	s1,8(sp)
    80200b1e:	6902                	ld	s2,0(sp)
        return r_time() / 10000000;
    80200b20:	02f55533          	divu	a0,a0,a5
}
    80200b24:	6105                	addi	sp,sp,32
    80200b26:	8082                	ret
        sys_exit(args[0]);
    80200b28:	6188                	ld	a0,0(a1)
    80200b2a:	00000097          	auipc	ra,0x0
    80200b2e:	ef8080e7          	jalr	-264(ra) # 80200a22 <sys_exit>
}
    80200b32:	60e2                	ld	ra,24(sp)
    80200b34:	6442                	ld	s0,16(sp)
    80200b36:	64a2                	ld	s1,8(sp)
    80200b38:	6902                	ld	s2,0(sp)
    return 0;
    80200b3a:	4501                	li	a0,0
}
    80200b3c:	6105                	addi	sp,sp,32
    80200b3e:	8082                	ret
    return length;
}

void sys_yield(){

    run_next_app(0);
    80200b40:	4501                	li	a0,0
    80200b42:	00000097          	auipc	ra,0x0
    80200b46:	c10080e7          	jalr	-1008(ra) # 80200752 <run_next_app>
}
    80200b4a:	60e2                	ld	ra,24(sp)
    80200b4c:	6442                	ld	s0,16(sp)
    80200b4e:	64a2                	ld	s1,8(sp)
    80200b50:	6902                	ld	s2,0(sp)
    return 0;
    80200b52:	4501                	li	a0,0
}
    80200b54:	6105                	addi	sp,sp,32
    80200b56:	8082                	ret

0000000080200b58 <sys_write>:
uint64 sys_write(uint64 fd, char* buf, uint64 length) {
    80200b58:	7179                	addi	sp,sp,-48
    80200b5a:	f022                	sd	s0,32(sp)
    80200b5c:	e84a                	sd	s2,16(sp)
    80200b5e:	f406                	sd	ra,40(sp)
    80200b60:	ec26                	sd	s1,24(sp)
    80200b62:	e44e                	sd	s3,8(sp)
    80200b64:	1800                	addi	s0,sp,48
    if (fd == 1){    // means STDOUT
    80200b66:	4785                	li	a5,1
uint64 sys_write(uint64 fd, char* buf, uint64 length) {
    80200b68:	8932                	mv	s2,a2
    if (fd == 1){    // means STDOUT
    80200b6a:	00f50a63          	beq	a0,a5,80200b7e <sys_write+0x26>
}
    80200b6e:	70a2                	ld	ra,40(sp)
    80200b70:	7402                	ld	s0,32(sp)
    80200b72:	64e2                	ld	s1,24(sp)
    80200b74:	69a2                	ld	s3,8(sp)
    80200b76:	854a                	mv	a0,s2
    80200b78:	6942                	ld	s2,16(sp)
    80200b7a:	6145                	addi	sp,sp,48
    80200b7c:	8082                	ret
        for (int i = 0; i < length; i++){
    80200b7e:	da65                	beqz	a2,80200b6e <sys_write+0x16>
    80200b80:	84ae                	mv	s1,a1
    80200b82:	00c589b3          	add	s3,a1,a2
            consputc(buf[i]);
    80200b86:	0004c503          	lbu	a0,0(s1)
    80200b8a:	0485                	addi	s1,s1,1
    80200b8c:	fffff097          	auipc	ra,0xfffff
    80200b90:	558080e7          	jalr	1368(ra) # 802000e4 <consputc>
        for (int i = 0; i < length; i++){
    80200b94:	ff3499e3          	bne	s1,s3,80200b86 <sys_write+0x2e>
}
    80200b98:	70a2                	ld	ra,40(sp)
    80200b9a:	7402                	ld	s0,32(sp)
    80200b9c:	64e2                	ld	s1,24(sp)
    80200b9e:	69a2                	ld	s3,8(sp)
    80200ba0:	854a                	mv	a0,s2
    80200ba2:	6942                	ld	s2,16(sp)
    80200ba4:	6145                	addi	sp,sp,48
    80200ba6:	8082                	ret

0000000080200ba8 <sys_yield>:
void sys_yield(){
    80200ba8:	1141                	addi	sp,sp,-16
    80200baa:	e422                	sd	s0,8(sp)
    80200bac:	0800                	addi	s0,sp,16


}
    80200bae:	6422                	ld	s0,8(sp)
    run_next_app(0);
    80200bb0:	4501                	li	a0,0
}
    80200bb2:	0141                	addi	sp,sp,16
    run_next_app(0);
    80200bb4:	00000317          	auipc	t1,0x0
    80200bb8:	b9e30067          	jr	-1122(t1) # 80200752 <run_next_app>

0000000080200bbc <__alltraps>:
    80200bbc:	14011173          	csrrw	sp,sscratch,sp
    80200bc0:	e406                	sd	ra,8(sp)
    80200bc2:	ec0e                	sd	gp,24(sp)
    80200bc4:	f416                	sd	t0,40(sp)
    80200bc6:	f81a                	sd	t1,48(sp)
    80200bc8:	fc1e                	sd	t2,56(sp)
    80200bca:	e0a2                	sd	s0,64(sp)
    80200bcc:	e4a6                	sd	s1,72(sp)
    80200bce:	e8aa                	sd	a0,80(sp)
    80200bd0:	ecae                	sd	a1,88(sp)
    80200bd2:	f0b2                	sd	a2,96(sp)
    80200bd4:	f4b6                	sd	a3,104(sp)
    80200bd6:	f8ba                	sd	a4,112(sp)
    80200bd8:	fcbe                	sd	a5,120(sp)
    80200bda:	e142                	sd	a6,128(sp)
    80200bdc:	e546                	sd	a7,136(sp)
    80200bde:	e94a                	sd	s2,144(sp)
    80200be0:	ed4e                	sd	s3,152(sp)
    80200be2:	f152                	sd	s4,160(sp)
    80200be4:	f556                	sd	s5,168(sp)
    80200be6:	f95a                	sd	s6,176(sp)
    80200be8:	fd5e                	sd	s7,184(sp)
    80200bea:	e1e2                	sd	s8,192(sp)
    80200bec:	e5e6                	sd	s9,200(sp)
    80200bee:	e9ea                	sd	s10,208(sp)
    80200bf0:	edee                	sd	s11,216(sp)
    80200bf2:	f1f2                	sd	t3,224(sp)
    80200bf4:	f5f6                	sd	t4,232(sp)
    80200bf6:	f9fa                	sd	t5,240(sp)
    80200bf8:	fdfe                	sd	t6,248(sp)
    80200bfa:	14102373          	csrr	t1,sepc
    80200bfe:	0311                	addi	t1,t1,4
    80200c00:	e21a                	sd	t1,256(sp)
    80200c02:	140023f3          	csrr	t2,sscratch
    80200c06:	e81e                	sd	t2,16(sp)
    80200c08:	62b2                	ld	t0,264(sp)
    80200c0a:	6352                	ld	t1,272(sp)
    80200c0c:	6172                	ld	sp,280(sp)
    80200c0e:	18029073          	csrw	satp,t0
    80200c12:	12000073          	sfence.vma
    80200c16:	8302                	jr	t1

0000000080200c18 <__restore>:
    80200c18:	0000100f          	fence.i
    80200c1c:	18059073          	csrw	satp,a1
    80200c20:	12000073          	sfence.vma
    80200c24:	14051073          	csrw	sscratch,a0
    80200c28:	812a                	mv	sp,a0
    80200c2a:	6312                	ld	t1,256(sp)
    80200c2c:	14131073          	csrw	sepc,t1
    80200c30:	60a2                	ld	ra,8(sp)
    80200c32:	61e2                	ld	gp,24(sp)
    80200c34:	72a2                	ld	t0,40(sp)
    80200c36:	7342                	ld	t1,48(sp)
    80200c38:	73e2                	ld	t2,56(sp)
    80200c3a:	6406                	ld	s0,64(sp)
    80200c3c:	64a6                	ld	s1,72(sp)
    80200c3e:	6546                	ld	a0,80(sp)
    80200c40:	65e6                	ld	a1,88(sp)
    80200c42:	7606                	ld	a2,96(sp)
    80200c44:	76a6                	ld	a3,104(sp)
    80200c46:	7746                	ld	a4,112(sp)
    80200c48:	77e6                	ld	a5,120(sp)
    80200c4a:	680a                	ld	a6,128(sp)
    80200c4c:	68aa                	ld	a7,136(sp)
    80200c4e:	694a                	ld	s2,144(sp)
    80200c50:	69ea                	ld	s3,152(sp)
    80200c52:	7a0a                	ld	s4,160(sp)
    80200c54:	7aaa                	ld	s5,168(sp)
    80200c56:	7b4a                	ld	s6,176(sp)
    80200c58:	7bea                	ld	s7,184(sp)
    80200c5a:	6c0e                	ld	s8,192(sp)
    80200c5c:	6cae                	ld	s9,200(sp)
    80200c5e:	6d4e                	ld	s10,208(sp)
    80200c60:	6dee                	ld	s11,216(sp)
    80200c62:	7e0e                	ld	t3,224(sp)
    80200c64:	7eae                	ld	t4,232(sp)
    80200c66:	7f4e                	ld	t5,240(sp)
    80200c68:	7fee                	ld	t6,248(sp)
    80200c6a:	6142                	ld	sp,16(sp)
    80200c6c:	10200073          	sret
	...

0000000080200c72 <new_task_cx>:

#include "task_context.h"
#include "types.h"


struct task_context new_task_cx(uint64 app_entry, uint64 app_sp, uint64 app_satp){
    80200c72:	7169                	addi	sp,sp,-304
    80200c74:	f622                	sd	s0,296(sp)
    80200c76:	1a00                	addi	s0,sp,304
    80200c78:	ed840793          	addi	a5,s0,-296
    80200c7c:	fd840713          	addi	a4,s0,-40
    struct task_context new_task_context;

    for (int i = 0; i < 32; i++){
        new_task_context.general_register[i] = 0;
    80200c80:	0007b023          	sd	zero,0(a5)
    for (int i = 0; i < 32; i++){
    80200c84:	07a1                	addi	a5,a5,8
    80200c86:	fee79de3          	bne	a5,a4,80200c80 <new_task_cx+0xe>

    new_task_context.ra = app_entry;
    new_task_context.sp = app_sp;
    new_task_context.satp = app_satp;

    return new_task_context;
    80200c8a:	fcb43c23          	sd	a1,-40(s0)
    80200c8e:	fec43023          	sd	a2,-32(s0)
    80200c92:	fed43423          	sd	a3,-24(s0)
    80200c96:	ed840793          	addi	a5,s0,-296
    80200c9a:	872a                	mv	a4,a0
    80200c9c:	ff040313          	addi	t1,s0,-16
    80200ca0:	0007b883          	ld	a7,0(a5)
    80200ca4:	0087b803          	ld	a6,8(a5)
    80200ca8:	6b8c                	ld	a1,16(a5)
    80200caa:	6f90                	ld	a2,24(a5)
    80200cac:	7394                	ld	a3,32(a5)
    80200cae:	01173023          	sd	a7,0(a4)
    80200cb2:	01073423          	sd	a6,8(a4)
    80200cb6:	eb0c                	sd	a1,16(a4)
    80200cb8:	ef10                	sd	a2,24(a4)
    80200cba:	f314                	sd	a3,32(a4)
    80200cbc:	02878793          	addi	a5,a5,40
    80200cc0:	02870713          	addi	a4,a4,40
    80200cc4:	fc679ee3          	bne	a5,t1,80200ca0 <new_task_cx+0x2e>
}
    80200cc8:	7432                	ld	s0,296(sp)
    80200cca:	6155                	addi	sp,sp,304
    80200ccc:	8082                	ret

0000000080200cce <new_task_control_block>:
#include "task_context.h"
#include "types.h"
#include "task_control_block.h"
#include "pid_allocator.h"

struct task_control_block new_task_control_block(struct task_context task_cx, char* Kernel_stack){
    80200cce:	1101                	addi	sp,sp,-32
    80200cd0:	e822                	sd	s0,16(sp)
    80200cd2:	e426                	sd	s1,8(sp)
    80200cd4:	e04a                	sd	s2,0(sp)
    80200cd6:	ec06                	sd	ra,24(sp)
    80200cd8:	1000                	addi	s0,sp,32
    80200cda:	84aa                	mv	s1,a0
    80200cdc:	8932                	mv	s2,a2
    struct task_control_block TCB;
    
    TCB.task_context = task_cx;
    80200cde:	1c050793          	addi	a5,a0,448
    80200ce2:	11858713          	addi	a4,a1,280
    80200ce6:	0005b883          	ld	a7,0(a1)
    80200cea:	0085b803          	ld	a6,8(a1)
    80200cee:	6988                	ld	a0,16(a1)
    80200cf0:	6d90                	ld	a2,24(a1)
    80200cf2:	7194                	ld	a3,32(a1)
    80200cf4:	0117b023          	sd	a7,0(a5)
    80200cf8:	0107b423          	sd	a6,8(a5)
    80200cfc:	eb88                	sd	a0,16(a5)
    80200cfe:	ef90                	sd	a2,24(a5)
    80200d00:	f394                	sd	a3,32(a5)
    80200d02:	02858593          	addi	a1,a1,40
    80200d06:	02878793          	addi	a5,a5,40
    80200d0a:	fce59ee3          	bne	a1,a4,80200ce6 <new_task_control_block+0x18>
    TCB.Kernel_stack = Kernel_stack;
    TCB.pid = alloct_pid();
    80200d0e:	00000097          	auipc	ra,0x0
    80200d12:	050080e7          	jalr	80(ra) # 80200d5e <alloct_pid>
    return TCB;
}
    80200d16:	60e2                	ld	ra,24(sp)
    80200d18:	6442                	ld	s0,16(sp)
    return TCB;
    80200d1a:	2d24bc23          	sd	s2,728(s1)
    TCB.pid = alloct_pid();
    80200d1e:	2ea4b023          	sd	a0,736(s1)
}
    80200d22:	6902                	ld	s2,0(sp)
    80200d24:	8526                	mv	a0,s1
    80200d26:	64a2                	ld	s1,8(sp)
    80200d28:	6105                	addi	sp,sp,32
    80200d2a:	8082                	ret

0000000080200d2c <empty_tcb>:

struct task_control_block empty_tcb(){
    80200d2c:	1141                	addi	sp,sp,-16
    80200d2e:	e422                	sd	s0,8(sp)
    80200d30:	0800                	addi	s0,sp,16
    struct task_control_block empty_tcb;

    return empty_tcb;
    80200d32:	6422                	ld	s0,8(sp)
    80200d34:	0141                	addi	sp,sp,16
    80200d36:	8082                	ret

0000000080200d38 <init_pid_bitmap>:
#include "types.h"
#include "printf.h"
#include "panic.h"


void init_pid_bitmap(){     // 对PID_BITMAP进行0初始化
    80200d38:	1141                	addi	sp,sp,-16
    80200d3a:	e422                	sd	s0,8(sp)
    80200d3c:	0800                	addi	s0,sp,16
    80200d3e:	00035797          	auipc	a5,0x35
    80200d42:	3c278793          	addi	a5,a5,962 # 80236100 <PID_BITMAP>
    80200d46:	00035717          	auipc	a4,0x35
    80200d4a:	3e270713          	addi	a4,a4,994 # 80236128 <TASK_MANAGER>
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
        PID_BITMAP[i] = 0;     // 0 means all are not used.
    80200d4e:	0007a023          	sw	zero,0(a5)
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
    80200d52:	0791                	addi	a5,a5,4
    80200d54:	fee79de3          	bne	a5,a4,80200d4e <init_pid_bitmap+0x16>
    }
}    
    80200d58:	6422                	ld	s0,8(sp)
    80200d5a:	0141                	addi	sp,sp,16
    80200d5c:	8082                	ret

0000000080200d5e <alloct_pid>:

int alloct_pid(){   // find a valid pid, then return it. 
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
    80200d5e:	00035617          	auipc	a2,0x35
    80200d62:	3a260613          	addi	a2,a2,930 # 80236100 <PID_BITMAP>
    80200d66:	87b2                	mv	a5,a2
    80200d68:	4501                	li	a0,0
    80200d6a:	46a9                	li	a3,10
        if (PID_BITMAP[i] == 0){
    80200d6c:	4398                	lw	a4,0(a5)
    80200d6e:	0791                	addi	a5,a5,4
    80200d70:	c715                	beqz	a4,80200d9c <alloct_pid+0x3e>
    for (int i = 0; i < MAX_NUM_OF_APPS; i++){
    80200d72:	2505                	addiw	a0,a0,1
    80200d74:	fed51ce3          	bne	a0,a3,80200d6c <alloct_pid+0xe>
int alloct_pid(){   // find a valid pid, then return it. 
    80200d78:	1141                	addi	sp,sp,-16
    80200d7a:	e022                	sd	s0,0(sp)
    80200d7c:	e406                	sd	ra,8(sp)
    80200d7e:	0800                	addi	s0,sp,16
            PID_BITMAP[i] = 1;
            return i;
        }
    }
    panic("[kernel] All the pids have been used!!");
    80200d80:	00001517          	auipc	a0,0x1
    80200d84:	3d850513          	addi	a0,a0,984 # 80202158 <digits+0xd0>
    80200d88:	fffff097          	auipc	ra,0xfffff
    80200d8c:	526080e7          	jalr	1318(ra) # 802002ae <panic>
    return -100;
}
    80200d90:	60a2                	ld	ra,8(sp)
    80200d92:	6402                	ld	s0,0(sp)
    return -100;
    80200d94:	f9c00513          	li	a0,-100
}
    80200d98:	0141                	addi	sp,sp,16
    80200d9a:	8082                	ret
            PID_BITMAP[i] = 1;
    80200d9c:	00251793          	slli	a5,a0,0x2
    80200da0:	963e                	add	a2,a2,a5
    80200da2:	4785                	li	a5,1
    80200da4:	c21c                	sw	a5,0(a2)
}
    80200da6:	8082                	ret

0000000080200da8 <free_pid>:

void free_pid(int pid){
    80200da8:	1141                	addi	sp,sp,-16
    if (PID_BITMAP[pid] == 1){
    80200daa:	00251793          	slli	a5,a0,0x2
void free_pid(int pid){
    80200dae:	e422                	sd	s0,8(sp)
    if (PID_BITMAP[pid] == 1){
    80200db0:	00035517          	auipc	a0,0x35
    80200db4:	35050513          	addi	a0,a0,848 # 80236100 <PID_BITMAP>
void free_pid(int pid){
    80200db8:	0800                	addi	s0,sp,16
    if (PID_BITMAP[pid] == 1){
    80200dba:	953e                	add	a0,a0,a5
    80200dbc:	4118                	lw	a4,0(a0)
    80200dbe:	4785                	li	a5,1
    80200dc0:	00f71763          	bne	a4,a5,80200dce <free_pid+0x26>
        PID_BITMAP[pid] = 0;
    }
    else {
        panic("[kernel] PID has already been free?");
    }
}
    80200dc4:	6422                	ld	s0,8(sp)
        PID_BITMAP[pid] = 0;
    80200dc6:	00052023          	sw	zero,0(a0)
}
    80200dca:	0141                	addi	sp,sp,16
    80200dcc:	8082                	ret
    80200dce:	6422                	ld	s0,8(sp)
        panic("[kernel] PID has already been free?");
    80200dd0:	00001517          	auipc	a0,0x1
    80200dd4:	3b050513          	addi	a0,a0,944 # 80202180 <digits+0xf8>
}
    80200dd8:	0141                	addi	sp,sp,16
        panic("[kernel] PID has already been free?");
    80200dda:	fffff317          	auipc	t1,0xfffff
    80200dde:	4d430067          	jr	1236(t1) # 802002ae <panic>

0000000080200de2 <check_valid>:

int check_valid(int pid){
    80200de2:	1141                	addi	sp,sp,-16
    80200de4:	e422                	sd	s0,8(sp)
    80200de6:	0800                	addi	s0,sp,16
    return PID_BITMAP[pid];
    80200de8:	6422                	ld	s0,8(sp)
    return PID_BITMAP[pid];
    80200dea:	00251793          	slli	a5,a0,0x2
    80200dee:	00035517          	auipc	a0,0x35
    80200df2:	31250513          	addi	a0,a0,786 # 80236100 <PID_BITMAP>
    80200df6:	953e                	add	a0,a0,a5
    80200df8:	4108                	lw	a0,0(a0)
    80200dfa:	0141                	addi	sp,sp,16
    80200dfc:	8082                	ret

0000000080200dfe <add_task_control_block>:


struct task_manager TASK_MANAGER;


void add_task_control_block(struct task_control_block TCB){   //Add one TCB to TASK_MANAGER_CONTAINER
    80200dfe:	1101                	addi	sp,sp,-32
    80200e00:	e822                	sd	s0,16(sp)
    80200e02:	e426                	sd	s1,8(sp)
    80200e04:	e04a                	sd	s2,0(sp)
    80200e06:	ec06                	sd	ra,24(sp)
    80200e08:	1000                	addi	s0,sp,32

    int pid = TCB.pid;
    80200e0a:	2e052903          	lw	s2,736(a0)
void add_task_control_block(struct task_control_block TCB){   //Add one TCB to TASK_MANAGER_CONTAINER
    80200e0e:	84aa                	mv	s1,a0
    
    if (!check_valid(pid)){
    80200e10:	854a                	mv	a0,s2
    80200e12:	00000097          	auipc	ra,0x0
    80200e16:	fd0080e7          	jalr	-48(ra) # 80200de2 <check_valid>
    80200e1a:	c535                	beqz	a0,80200e86 <add_task_control_block+0x88>
        panic("Cannot add TCB to TASK_MANAGER!\n");
    }

    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = TCB;
    80200e1c:	2e800793          	li	a5,744
    80200e20:	02f90733          	mul	a4,s2,a5
    80200e24:	00035797          	auipc	a5,0x35
    80200e28:	30478793          	addi	a5,a5,772 # 80236128 <TASK_MANAGER>
    80200e2c:	8526                	mv	a0,s1
    80200e2e:	2e048693          	addi	a3,s1,736
    80200e32:	97ba                	add	a5,a5,a4
    80200e34:	00053803          	ld	a6,0(a0)
    80200e38:	650c                	ld	a1,8(a0)
    80200e3a:	6910                	ld	a2,16(a0)
    80200e3c:	6d18                	ld	a4,24(a0)
    80200e3e:	0107b023          	sd	a6,0(a5)
    80200e42:	e78c                	sd	a1,8(a5)
    80200e44:	eb90                	sd	a2,16(a5)
    80200e46:	ef98                	sd	a4,24(a5)
    80200e48:	02050513          	addi	a0,a0,32
    80200e4c:	02078793          	addi	a5,a5,32
    80200e50:	fed512e3          	bne	a0,a3,80200e34 <add_task_control_block+0x36>
    80200e54:	6114                	ld	a3,0(a0)
    TASK_MANAGER.number_of_apps += 1;
    80200e56:	00037717          	auipc	a4,0x37
    80200e5a:	2d270713          	addi	a4,a4,722 # 80238128 <heap>
    printf("[task manager] the pid is %d\n", pid);
}
    80200e5e:	6442                	ld	s0,16(sp)
    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = TCB;
    80200e60:	e394                	sd	a3,0(a5)
    TASK_MANAGER.number_of_apps += 1;
    80200e62:	ff873783          	ld	a5,-8(a4)
}
    80200e66:	60e2                	ld	ra,24(sp)
    80200e68:	64a2                	ld	s1,8(sp)
    printf("[task manager] the pid is %d\n", pid);
    80200e6a:	85ca                	mv	a1,s2
    TASK_MANAGER.number_of_apps += 1;
    80200e6c:	0785                	addi	a5,a5,1
}
    80200e6e:	6902                	ld	s2,0(sp)
    TASK_MANAGER.number_of_apps += 1;
    80200e70:	fef73c23          	sd	a5,-8(a4)
    printf("[task manager] the pid is %d\n", pid);
    80200e74:	00001517          	auipc	a0,0x1
    80200e78:	35c50513          	addi	a0,a0,860 # 802021d0 <digits+0x148>
}
    80200e7c:	6105                	addi	sp,sp,32
    printf("[task manager] the pid is %d\n", pid);
    80200e7e:	fffff317          	auipc	t1,0xfffff
    80200e82:	29c30067          	jr	668(t1) # 8020011a <printf>
        panic("Cannot add TCB to TASK_MANAGER!\n");
    80200e86:	00001517          	auipc	a0,0x1
    80200e8a:	32250513          	addi	a0,a0,802 # 802021a8 <digits+0x120>
    80200e8e:	fffff097          	auipc	ra,0xfffff
    80200e92:	420080e7          	jalr	1056(ra) # 802002ae <panic>
    80200e96:	b759                	j	80200e1c <add_task_control_block+0x1e>

0000000080200e98 <free_task_control_block>:

void free_task_control_block(int pid){
    80200e98:	cf010113          	addi	sp,sp,-784
    80200e9c:	30813023          	sd	s0,768(sp)
    80200ea0:	2f213823          	sd	s2,752(sp)
    80200ea4:	30113423          	sd	ra,776(sp)
    80200ea8:	2e913c23          	sd	s1,760(sp)
    80200eac:	0e00                	addi	s0,sp,784
    80200eae:	892a                	mv	s2,a0

    if (!check_valid(pid)){
    80200eb0:	00000097          	auipc	ra,0x0
    80200eb4:	f32080e7          	jalr	-206(ra) # 80200de2 <check_valid>
    80200eb8:	c141                	beqz	a0,80200f38 <free_task_control_block+0xa0>
        panic("Some thing wrong when free the tcb from TASK_MANAGER!\n");
    }
    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = empty_tcb();
    80200eba:	2e800493          	li	s1,744
    80200ebe:	029904b3          	mul	s1,s2,s1
    80200ec2:	00035797          	auipc	a5,0x35
    80200ec6:	26678793          	addi	a5,a5,614 # 80236128 <TASK_MANAGER>
    80200eca:	cf040513          	addi	a0,s0,-784
    80200ece:	94be                	add	s1,s1,a5
    80200ed0:	00000097          	auipc	ra,0x0
    80200ed4:	e5c080e7          	jalr	-420(ra) # 80200d2c <empty_tcb>
    80200ed8:	cf040713          	addi	a4,s0,-784
    80200edc:	87a6                	mv	a5,s1
    80200ede:	fd040693          	addi	a3,s0,-48
    80200ee2:	00073803          	ld	a6,0(a4)
    80200ee6:	6708                	ld	a0,8(a4)
    80200ee8:	6b0c                	ld	a1,16(a4)
    80200eea:	6f10                	ld	a2,24(a4)
    80200eec:	0107b023          	sd	a6,0(a5)
    80200ef0:	e788                	sd	a0,8(a5)
    80200ef2:	eb8c                	sd	a1,16(a5)
    80200ef4:	ef90                	sd	a2,24(a5)
    80200ef6:	02070713          	addi	a4,a4,32
    80200efa:	02078793          	addi	a5,a5,32
    80200efe:	fed712e3          	bne	a4,a3,80200ee2 <free_task_control_block+0x4a>
    80200f02:	6318                	ld	a4,0(a4)
    free_pid(pid);
    80200f04:	854a                	mv	a0,s2
    TASK_MANAGER.TASK_MANAGER_CONTAINER[pid] = empty_tcb();
    80200f06:	e398                	sd	a4,0(a5)
    free_pid(pid);
    80200f08:	00000097          	auipc	ra,0x0
    80200f0c:	ea0080e7          	jalr	-352(ra) # 80200da8 <free_pid>
    TASK_MANAGER.number_of_apps -= 1;
    80200f10:	00037717          	auipc	a4,0x37
    80200f14:	21870713          	addi	a4,a4,536 # 80238128 <heap>
    80200f18:	ff873783          	ld	a5,-8(a4)
}
    80200f1c:	30813083          	ld	ra,776(sp)
    80200f20:	30013403          	ld	s0,768(sp)
    TASK_MANAGER.number_of_apps -= 1;
    80200f24:	17fd                	addi	a5,a5,-1
    80200f26:	fef73c23          	sd	a5,-8(a4)
}
    80200f2a:	2f813483          	ld	s1,760(sp)
    80200f2e:	2f013903          	ld	s2,752(sp)
    80200f32:	31010113          	addi	sp,sp,784
    80200f36:	8082                	ret
        panic("Some thing wrong when free the tcb from TASK_MANAGER!\n");
    80200f38:	00001517          	auipc	a0,0x1
    80200f3c:	2b850513          	addi	a0,a0,696 # 802021f0 <digits+0x168>
    80200f40:	fffff097          	auipc	ra,0xfffff
    80200f44:	36e080e7          	jalr	878(ra) # 802002ae <panic>
    80200f48:	bf8d                	j	80200eba <free_task_control_block+0x22>

0000000080200f4a <schedule>:

struct task_control_block schedule(int pid){   // give out one task control block
    80200f4a:	7179                	addi	sp,sp,-48
    80200f4c:	f022                	sd	s0,32(sp)
    80200f4e:	e84a                	sd	s2,16(sp)
    80200f50:	e052                	sd	s4,0(sp)
    80200f52:	f406                	sd	ra,40(sp)
    80200f54:	ec26                	sd	s1,24(sp)
    80200f56:	e44e                	sd	s3,8(sp)
    80200f58:	1800                	addi	s0,sp,48
    
    for (int i = pid; i < MAX_NUM_OF_APPS; i++){
    80200f5a:	47a5                	li	a5,9
struct task_control_block schedule(int pid){   // give out one task control block
    80200f5c:	892e                	mv	s2,a1
    80200f5e:	8a2a                	mv	s4,a0
    for (int i = pid; i < MAX_NUM_OF_APPS; i++){
    80200f60:	06b7c563          	blt	a5,a1,80200fca <schedule+0x80>
    80200f64:	84ae                	mv	s1,a1
    80200f66:	49a9                	li	s3,10
    80200f68:	a021                	j	80200f70 <schedule+0x26>
    80200f6a:	2485                	addiw	s1,s1,1
    80200f6c:	05348d63          	beq	s1,s3,80200fc6 <schedule+0x7c>
        if (check_valid(i)){
    80200f70:	8526                	mv	a0,s1
    80200f72:	00000097          	auipc	ra,0x0
    80200f76:	e70080e7          	jalr	-400(ra) # 80200de2 <check_valid>
    80200f7a:	d965                	beqz	a0,80200f6a <schedule+0x20>
            return TASK_MANAGER.TASK_MANAGER_CONTAINER[i];
    80200f7c:	2e800793          	li	a5,744
    80200f80:	02f484b3          	mul	s1,s1,a5
    80200f84:	00035797          	auipc	a5,0x35
    80200f88:	1a478793          	addi	a5,a5,420 # 80236128 <TASK_MANAGER>
    80200f8c:	8752                	mv	a4,s4
    80200f8e:	94be                	add	s1,s1,a5
    80200f90:	2e048513          	addi	a0,s1,736
    80200f94:	608c                	ld	a1,0(s1)
    80200f96:	6490                	ld	a2,8(s1)
    80200f98:	6894                	ld	a3,16(s1)
    80200f9a:	6c9c                	ld	a5,24(s1)
    80200f9c:	e30c                	sd	a1,0(a4)
    80200f9e:	e710                	sd	a2,8(a4)
    80200fa0:	eb14                	sd	a3,16(a4)
    80200fa2:	ef1c                	sd	a5,24(a4)
    80200fa4:	02048493          	addi	s1,s1,32
    80200fa8:	02070713          	addi	a4,a4,32
    80200fac:	fea494e3          	bne	s1,a0,80200f94 <schedule+0x4a>
        }
    }
    for (int i = 0; i <= pid; i++){
        if (check_valid(i)){
            return TASK_MANAGER.TASK_MANAGER_CONTAINER[i];
    80200fb0:	609c                	ld	a5,0(s1)
    80200fb2:	e31c                	sd	a5,0(a4)
        }
    }
    panic("Error when scheduling task!");
    80200fb4:	70a2                	ld	ra,40(sp)
    80200fb6:	7402                	ld	s0,32(sp)
    80200fb8:	64e2                	ld	s1,24(sp)
    80200fba:	6942                	ld	s2,16(sp)
    80200fbc:	69a2                	ld	s3,8(sp)
    80200fbe:	8552                	mv	a0,s4
    80200fc0:	6a02                	ld	s4,0(sp)
    80200fc2:	6145                	addi	sp,sp,48
    80200fc4:	8082                	ret
    for (int i = 0; i <= pid; i++){
    80200fc6:	04094863          	bltz	s2,80201016 <schedule+0xcc>
    80200fca:	4481                	li	s1,0
    80200fcc:	a021                	j	80200fd4 <schedule+0x8a>
    80200fce:	2485                	addiw	s1,s1,1
    80200fd0:	04994363          	blt	s2,s1,80201016 <schedule+0xcc>
        if (check_valid(i)){
    80200fd4:	8526                	mv	a0,s1
    80200fd6:	00000097          	auipc	ra,0x0
    80200fda:	e0c080e7          	jalr	-500(ra) # 80200de2 <check_valid>
    80200fde:	d965                	beqz	a0,80200fce <schedule+0x84>
            return TASK_MANAGER.TASK_MANAGER_CONTAINER[i];
    80200fe0:	2e800793          	li	a5,744
    80200fe4:	02f484b3          	mul	s1,s1,a5
    80200fe8:	00035797          	auipc	a5,0x35
    80200fec:	14078793          	addi	a5,a5,320 # 80236128 <TASK_MANAGER>
    80200ff0:	8752                	mv	a4,s4
    80200ff2:	94be                	add	s1,s1,a5
    80200ff4:	2e048513          	addi	a0,s1,736
    80200ff8:	608c                	ld	a1,0(s1)
    80200ffa:	6490                	ld	a2,8(s1)
    80200ffc:	6894                	ld	a3,16(s1)
    80200ffe:	6c9c                	ld	a5,24(s1)
    80201000:	e30c                	sd	a1,0(a4)
    80201002:	e710                	sd	a2,8(a4)
    80201004:	eb14                	sd	a3,16(a4)
    80201006:	ef1c                	sd	a5,24(a4)
    80201008:	02048493          	addi	s1,s1,32
    8020100c:	02070713          	addi	a4,a4,32
    80201010:	fea494e3          	bne	s1,a0,80200ff8 <schedule+0xae>
    80201014:	bf71                	j	80200fb0 <schedule+0x66>
    panic("Error when scheduling task!");
    80201016:	00001517          	auipc	a0,0x1
    8020101a:	21250513          	addi	a0,a0,530 # 80202228 <digits+0x1a0>
    8020101e:	fffff097          	auipc	ra,0xfffff
    80201022:	290080e7          	jalr	656(ra) # 802002ae <panic>
    80201026:	b779                	j	80200fb4 <schedule+0x6a>

0000000080201028 <get_ppn_2>:
#include "mm/pagetable.h"
#include "mm/framealloc.h"


// 从vpn中提取出二级PPN
uint64 get_ppn_2(uint64 ppn){
    80201028:	1141                	addi	sp,sp,-16
    8020102a:	e422                	sd	s0,8(sp)
    8020102c:	0800                	addi	s0,sp,16
    return (ppn >> 18) & ((1 << 9) - 1);
}
    8020102e:	6422                	ld	s0,8(sp)
    return (ppn >> 18) & ((1 << 9) - 1);
    80201030:	8149                	srli	a0,a0,0x12
}
    80201032:	1ff57513          	andi	a0,a0,511
    80201036:	0141                	addi	sp,sp,16
    80201038:	8082                	ret

000000008020103a <get_ppn_1>:

// 从vpn中提取出一级PPN
uint64 get_ppn_1(uint64 ppn){
    8020103a:	1141                	addi	sp,sp,-16
    8020103c:	e422                	sd	s0,8(sp)
    8020103e:	0800                	addi	s0,sp,16
    return (ppn >> 9) & ((1 << 9) - 1);
}
    80201040:	6422                	ld	s0,8(sp)
    return (ppn >> 9) & ((1 << 9) - 1);
    80201042:	8125                	srli	a0,a0,0x9
}
    80201044:	1ff57513          	andi	a0,a0,511
    80201048:	0141                	addi	sp,sp,16
    8020104a:	8082                	ret

000000008020104c <get_ppn_0>:

// 从vpn中提取出零级PPN
uint64 get_ppn_0(uint64 ppn){
    8020104c:	1141                	addi	sp,sp,-16
    8020104e:	e422                	sd	s0,8(sp)
    80201050:	0800                	addi	s0,sp,16
    return ppn & ((1 << 9) - 1);
}
    80201052:	6422                	ld	s0,8(sp)
    80201054:	1ff57513          	andi	a0,a0,511
    80201058:	0141                	addi	sp,sp,16
    8020105a:	8082                	ret

000000008020105c <to_physical_addr>:

uint64 to_physical_addr(uint64 ppn){
    8020105c:	1141                	addi	sp,sp,-16
    8020105e:	e422                	sd	s0,8(sp)
    80201060:	0800                	addi	s0,sp,16
    return (ppn << 12);
}
    80201062:	6422                	ld	s0,8(sp)
    80201064:	0532                	slli	a0,a0,0xc
    80201066:	0141                	addi	sp,sp,16
    80201068:	8082                	ret

000000008020106a <new_pagetable>:

struct PageTable new_pagetable(){
    8020106a:	1141                	addi	sp,sp,-16
    8020106c:	e022                	sd	s0,0(sp)
    8020106e:	e406                	sd	ra,8(sp)
    80201070:	0800                	addi	s0,sp,16
    struct PageTable new_pt;
    new_pt.root_ppn = get_frame();
    80201072:	00000097          	auipc	ra,0x0
    80201076:	834080e7          	jalr	-1996(ra) # 802008a6 <get_frame>

    return new_pt;
}
    8020107a:	60a2                	ld	ra,8(sp)
    8020107c:	6402                	ld	s0,0(sp)
    8020107e:	1502                	slli	a0,a0,0x20
    80201080:	9101                	srli	a0,a0,0x20
    80201082:	0141                	addi	sp,sp,16
    80201084:	8082                	ret

0000000080201086 <get_PTE>:

uint64 get_PTE(uint64 ppn, uint64 index){
    80201086:	1141                	addi	sp,sp,-16
    80201088:	e422                	sd	s0,8(sp)
    8020108a:	0800                	addi	s0,sp,16

    uint64 phys_addr = to_physical_addr(ppn);
    return (uint64*)(phys_addr+index*8);

}
    8020108c:	6422                	ld	s0,8(sp)
    return (uint64*)(phys_addr+index*8);
    8020108e:	058e                	slli	a1,a1,0x3
    return (ppn << 12);
    80201090:	0532                	slli	a0,a0,0xc
}
    80201092:	952e                	add	a0,a0,a1
    80201094:	0141                	addi	sp,sp,16
    80201096:	8082                	ret

0000000080201098 <check_PTE_valid>:

uint64 check_PTE_valid(uint64 PTE){
    80201098:	1141                	addi	sp,sp,-16
    8020109a:	e422                	sd	s0,8(sp)
    8020109c:	0800                	addi	s0,sp,16
    return PTE & 0x1;
}
    8020109e:	6422                	ld	s0,8(sp)
    802010a0:	8905                	andi	a0,a0,1
    802010a2:	0141                	addi	sp,sp,16
    802010a4:	8082                	ret

00000000802010a6 <set_permission>:

void set_permission(uint64 PTE_addr, uint64 set_bit){
    802010a6:	1141                	addi	sp,sp,-16
    802010a8:	e422                	sd	s0,8(sp)
    802010aa:	0800                	addi	s0,sp,16
    *(uint64*)PTE_addr = *(uint64*)PTE_addr | set_bit;  
    802010ac:	611c                	ld	a5,0(a0)
}
    802010ae:	6422                	ld	s0,8(sp)
    *(uint64*)PTE_addr = *(uint64*)PTE_addr | set_bit;  
    802010b0:	8fcd                	or	a5,a5,a1
    802010b2:	e11c                	sd	a5,0(a0)
}
    802010b4:	0141                	addi	sp,sp,16
    802010b6:	8082                	ret

00000000802010b8 <set_PTE_ppn>:

void set_PTE_ppn(uint64 PTE_addr, uint64 ppn){
    802010b8:	1141                	addi	sp,sp,-16
    802010ba:	e422                	sd	s0,8(sp)
    802010bc:	0800                	addi	s0,sp,16
    *(uint64*)PTE_addr |= (ppn << 10);
    802010be:	611c                	ld	a5,0(a0)
}
    802010c0:	6422                	ld	s0,8(sp)
    *(uint64*)PTE_addr |= (ppn << 10);
    802010c2:	05aa                	slli	a1,a1,0xa
    802010c4:	8fcd                	or	a5,a5,a1
    802010c6:	e11c                	sd	a5,0(a0)
}
    802010c8:	0141                	addi	sp,sp,16
    802010ca:	8082                	ret

00000000802010cc <free_PTE>:

void free_PTE(uint64 PTE_addr){
    802010cc:	1141                	addi	sp,sp,-16
    802010ce:	e422                	sd	s0,8(sp)
    802010d0:	0800                	addi	s0,sp,16
    *(uint64*)PTE_addr = 0;
}
    802010d2:	6422                	ld	s0,8(sp)
    *(uint64*)PTE_addr = 0;
    802010d4:	00053023          	sd	zero,0(a0)
}
    802010d8:	0141                	addi	sp,sp,16
    802010da:	8082                	ret

00000000802010dc <get_PTE_ppn>:


uint64 get_PTE_ppn(uint64 PTE_addr){   // 从PTE中取出其指向的物理页号
    802010dc:	1141                	addi	sp,sp,-16
    802010de:	e422                	sd	s0,8(sp)
    802010e0:	0800                	addi	s0,sp,16
    uint64 PTE = *(uint64*)PTE_addr;
    return (PTE >> 10) & ((1 << 44) - 1);
    802010e2:	6108                	ld	a0,0(a0)
}
    802010e4:	6422                	ld	s0,8(sp)
    802010e6:	8129                	srli	a0,a0,0xa
    802010e8:	0141                	addi	sp,sp,16
    802010ea:	8082                	ret

00000000802010ec <map>:


void map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    802010ec:	7139                	addi	sp,sp,-64
    return (ppn >> 18) & ((1 << 9) - 1);
    802010ee:	0125d793          	srli	a5,a1,0x12
void map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    802010f2:	f04a                	sd	s2,32(sp)
    return (ppn >> 18) & ((1 << 9) - 1);
    802010f4:	1ff7f913          	andi	s2,a5,511
void map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    802010f8:	f822                	sd	s0,48(sp)
    802010fa:	f426                	sd	s1,40(sp)
    802010fc:	ec4e                	sd	s3,24(sp)
    802010fe:	e852                	sd	s4,16(sp)
    80201100:	e456                	sd	s5,8(sp)
    return (ppn << 12);
    80201102:	0532                	slli	a0,a0,0xc
void map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    80201104:	fc06                	sd	ra,56(sp)
    80201106:	0080                	addi	s0,sp,64
    return (uint64*)(phys_addr+index*8);
    80201108:	090e                	slli	s2,s2,0x3
    8020110a:	992a                	add	s2,s2,a0
    uint64 ppn_0 = get_ppn_0(vpn);

    uint64 PTE_addr = get_PTE(root_ppn, ppn_2);
    uint64 next_page_directory;
    
    if (!check_PTE_valid(*(uint64*)PTE_addr)){    // 证明下面的两级页表还没有建好。开始建表
    8020110c:	00093703          	ld	a4,0(s2)
    return (ppn >> 9) & ((1 << 9) - 1);
    80201110:	0095d993          	srli	s3,a1,0x9
void map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    80201114:	8a32                	mv	s4,a2
    return PTE & 0x1;
    80201116:	00177813          	andi	a6,a4,1
void map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags){
    8020111a:	8ab6                	mv	s5,a3
    return (ppn >> 9) & ((1 << 9) - 1);
    8020111c:	1ff9f993          	andi	s3,s3,511
    return ppn & ((1 << 9) - 1);
    80201120:	1ff5f493          	andi	s1,a1,511
    return PTE & 0x1;
    80201124:	00a75513          	srli	a0,a4,0xa
    if (!check_PTE_valid(*(uint64*)PTE_addr)){    // 证明下面的两级页表还没有建好。开始建表
    80201128:	04080663          	beqz	a6,80201174 <map+0x88>
    return (ppn << 12);
    8020112c:	0532                	slli	a0,a0,0xc
    return (uint64*)(phys_addr+index*8);
    8020112e:	00399913          	slli	s2,s3,0x3
    80201132:	992a                	add	s2,s2,a0
        next_page_directory = get_PTE_ppn(PTE_addr);
    }

    // 开始找第一级页表
    PTE_addr = get_PTE(next_page_directory, ppn_1);
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    80201134:	00093703          	ld	a4,0(s2)
    return PTE & 0x1;
    80201138:	00177613          	andi	a2,a4,1
    return (PTE >> 10) & ((1 << 44) - 1);
    8020113c:	00a75513          	srli	a0,a4,0xa
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    80201140:	c635                	beqz	a2,802011ac <map+0xc0>
    return (ppn << 12);
    80201142:	0532                	slli	a0,a0,0xc
    return (uint64*)(phys_addr+index*8);
    80201144:	00349593          	slli	a1,s1,0x3
    80201148:	95aa                	add	a1,a1,a0
        next_page_directory = get_PTE_ppn(PTE_addr);
    }

    // 开始找第0级页表
    PTE_addr = get_PTE(next_page_directory, ppn_0);
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    8020114a:	6198                	ld	a4,0(a1)
    return PTE & 0x1;
    8020114c:	00177613          	andi	a2,a4,1
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    80201150:	ea09                	bnez	a2,80201162 <map+0x76>
        flags = (flags << 1) + 1;    // 左移一位加一：加上valid bit
    80201152:	001a9793          	slli	a5,s5,0x1
    80201156:	0785                	addi	a5,a5,1
    *(uint64*)PTE_addr |= (ppn << 10);
    80201158:	0a2a                	slli	s4,s4,0xa
    8020115a:	0147e7b3          	or	a5,a5,s4
    8020115e:	8fd9                	or	a5,a5,a4
    80201160:	e19c                	sd	a5,0(a1)
        set_permission(PTE_addr, flags); 
        set_PTE_ppn(PTE_addr, ppn);  // 一级页表 -> 零级页表
    }
}
    80201162:	70e2                	ld	ra,56(sp)
    80201164:	7442                	ld	s0,48(sp)
    80201166:	74a2                	ld	s1,40(sp)
    80201168:	7902                	ld	s2,32(sp)
    8020116a:	69e2                	ld	s3,24(sp)
    8020116c:	6a42                	ld	s4,16(sp)
    8020116e:	6aa2                	ld	s5,8(sp)
    80201170:	6121                	addi	sp,sp,64
    80201172:	8082                	ret
    *(uint64*)PTE_addr = *(uint64*)PTE_addr | set_bit;  
    80201174:	00176713          	ori	a4,a4,1
    80201178:	00e93023          	sd	a4,0(s2)
        next_page_directory = get_frame();       // 为一级页表申请了一个frame
    8020117c:	fffff097          	auipc	ra,0xfffff
    80201180:	72a080e7          	jalr	1834(ra) # 802008a6 <get_frame>
    *(uint64*)PTE_addr |= (ppn << 10);
    80201184:	00093783          	ld	a5,0(s2)
        next_page_directory = get_frame();       // 为一级页表申请了一个frame
    80201188:	1502                	slli	a0,a0,0x20
    8020118a:	9101                	srli	a0,a0,0x20
    *(uint64*)PTE_addr |= (ppn << 10);
    8020118c:	00a51713          	slli	a4,a0,0xa
    80201190:	8fd9                	or	a5,a5,a4
    80201192:	00f93023          	sd	a5,0(s2)
    return (ppn << 12);
    80201196:	0532                	slli	a0,a0,0xc
    return (uint64*)(phys_addr+index*8);
    80201198:	00399913          	slli	s2,s3,0x3
    8020119c:	992a                	add	s2,s2,a0
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    8020119e:	00093703          	ld	a4,0(s2)
    return PTE & 0x1;
    802011a2:	00177613          	andi	a2,a4,1
    return (PTE >> 10) & ((1 << 44) - 1);
    802011a6:	00a75513          	srli	a0,a4,0xa
    if (!check_PTE_valid(*(uint64*)PTE_addr)){
    802011aa:	fe41                	bnez	a2,80201142 <map+0x56>
    *(uint64*)PTE_addr = *(uint64*)PTE_addr | set_bit;  
    802011ac:	00176713          	ori	a4,a4,1
    802011b0:	00e93023          	sd	a4,0(s2)
        next_page_directory = get_frame();    // 为零级页表申请了一个frame
    802011b4:	fffff097          	auipc	ra,0xfffff
    802011b8:	6f2080e7          	jalr	1778(ra) # 802008a6 <get_frame>
    *(uint64*)PTE_addr |= (ppn << 10);
    802011bc:	00093783          	ld	a5,0(s2)
        next_page_directory = get_frame();    // 为零级页表申请了一个frame
    802011c0:	1502                	slli	a0,a0,0x20
    802011c2:	9101                	srli	a0,a0,0x20
    *(uint64*)PTE_addr |= (ppn << 10);
    802011c4:	00a51713          	slli	a4,a0,0xa
    802011c8:	8fd9                	or	a5,a5,a4
    802011ca:	00f93023          	sd	a5,0(s2)
}
    802011ce:	bf95                	j	80201142 <map+0x56>

00000000802011d0 <unmap>:
    return (ppn >> 18) & ((1 << 9) - 1);
    802011d0:	0125d793          	srli	a5,a1,0x12


void unmap(struct PageTable pg, uint64 vpn){
    802011d4:	1141                	addi	sp,sp,-16
    return (ppn >> 18) & ((1 << 9) - 1);
    802011d6:	1ff7f793          	andi	a5,a5,511
void unmap(struct PageTable pg, uint64 vpn){
    802011da:	e422                	sd	s0,8(sp)
    return (uint64*)(phys_addr+index*8);
    802011dc:	078e                	slli	a5,a5,0x3
void unmap(struct PageTable pg, uint64 vpn){
    802011de:	0800                	addi	s0,sp,16
    return (ppn << 12);
    802011e0:	0532                	slli	a0,a0,0xc
    return (uint64*)(phys_addr+index*8);
    802011e2:	953e                	add	a0,a0,a5
    uint64 ppn_1 = get_ppn_1(vpn);
    uint64 ppn_0 = get_ppn_0(vpn);

    uint64 first_PTE_addr = get_PTE(root_ppn, ppn_2);

    if (check_PTE_valid(*(uint64*)first_PTE_addr)){    
    802011e4:	6118                	ld	a4,0(a0)
    return PTE & 0x1;
    802011e6:	00177793          	andi	a5,a4,1
    if (check_PTE_valid(*(uint64*)first_PTE_addr)){    
    802011ea:	c7a9                	beqz	a5,80201234 <unmap+0x64>
    return (ppn >> 9) & ((1 << 9) - 1);
    802011ec:	0095d793          	srli	a5,a1,0x9
    802011f0:	1ff7f793          	andi	a5,a5,511
    return (PTE >> 10) & ((1 << 44) - 1);
    802011f4:	8329                	srli	a4,a4,0xa
    return (ppn << 12);
    802011f6:	0732                	slli	a4,a4,0xc
    return (uint64*)(phys_addr+index*8);
    802011f8:	078e                	slli	a5,a5,0x3
    *(uint64*)PTE_addr = 0;
    802011fa:	00053023          	sd	zero,0(a0)
    return (uint64*)(phys_addr+index*8);
    802011fe:	97ba                	add	a5,a5,a4
     
        uint64 next_page_directory = get_PTE_ppn(first_PTE_addr);            
        uint64 second_PTE_addr = get_PTE(next_page_directory, ppn_1);
        free_PTE(first_PTE_addr);  

        if (check_PTE_valid(*(uint64*)second_PTE_addr)){
    80201200:	6398                	ld	a4,0(a5)
    return PTE & 0x1;
    80201202:	00177693          	andi	a3,a4,1
        if (check_PTE_valid(*(uint64*)second_PTE_addr)){
    80201206:	c69d                	beqz	a3,80201234 <unmap+0x64>
    return (PTE >> 10) & ((1 << 44) - 1);
    80201208:	8329                	srli	a4,a4,0xa
    return ppn & ((1 << 9) - 1);
    8020120a:	1ff5f593          	andi	a1,a1,511
    return (ppn << 12);
    8020120e:	0732                	slli	a4,a4,0xc
    return (uint64*)(phys_addr+index*8);
    80201210:	058e                	slli	a1,a1,0x3
    *(uint64*)PTE_addr = 0;
    80201212:	0007b023          	sd	zero,0(a5)
    return (uint64*)(phys_addr+index*8);
    80201216:	95ba                	add	a1,a1,a4
            
            next_page_directory = get_PTE_ppn(second_PTE_addr);            
            uint64 third_PTE_addr = get_PTE(next_page_directory, ppn_0);
            free_PTE(second_PTE_addr);

            if (check_PTE_valid(*(uint64*)third_PTE_addr)){
    80201218:	6188                	ld	a0,0(a1)
    return PTE & 0x1;
    8020121a:	00157793          	andi	a5,a0,1
            if (check_PTE_valid(*(uint64*)third_PTE_addr)){
    8020121e:	cb99                	beqz	a5,80201234 <unmap+0x64>
            panic("Wrong in unmapping!\n");
        }  
    }else{
        panic("Wrong in unmapping!\n");
    }
}
    80201220:	6422                	ld	s0,8(sp)
    return (PTE >> 10) & ((1 << 44) - 1);
    80201222:	8129                	srli	a0,a0,0xa
    *(uint64*)PTE_addr = 0;
    80201224:	0005b023          	sd	zero,0(a1)
                free_frame(corresponding_frame);
    80201228:	2501                	sext.w	a0,a0
}
    8020122a:	0141                	addi	sp,sp,16
                free_frame(corresponding_frame);
    8020122c:	fffff317          	auipc	t1,0xfffff
    80201230:	7a230067          	jr	1954(t1) # 802009ce <free_frame>
}
    80201234:	6422                	ld	s0,8(sp)
                panic("Wrong in unmapping!\n");
    80201236:	00001517          	auipc	a0,0x1
    8020123a:	01250513          	addi	a0,a0,18 # 80202248 <digits+0x1c0>
}
    8020123e:	0141                	addi	sp,sp,16
                panic("Wrong in unmapping!\n");
    80201240:	fffff317          	auipc	t1,0xfffff
    80201244:	06e30067          	jr	110(t1) # 802002ae <panic>

0000000080201248 <translate>:
    return (ppn >> 18) & ((1 << 9) - 1);
    80201248:	01e5d793          	srli	a5,a1,0x1e

uint64 translate(uint64 root_ppn, uint64 vir_addr){
    8020124c:	1101                	addi	sp,sp,-32
    return (ppn >> 18) & ((1 << 9) - 1);
    8020124e:	1ff7f793          	andi	a5,a5,511
uint64 translate(uint64 root_ppn, uint64 vir_addr){
    80201252:	e822                	sd	s0,16(sp)
    80201254:	e04a                	sd	s2,0(sp)
    80201256:	ec06                	sd	ra,24(sp)
    80201258:	e426                	sd	s1,8(sp)
    8020125a:	1000                	addi	s0,sp,32
    return (ppn << 12);
    8020125c:	0532                	slli	a0,a0,0xc
    uint64 ppn_0 = get_ppn_0(vpn);

    uint64 first_PTE_addr = get_PTE(root_ppn, ppn_2);
    uint64 corresponding_frame;

    if (check_PTE_valid(*(uint64*)first_PTE_addr)){    
    8020125e:	078e                	slli	a5,a5,0x3
    80201260:	97aa                	add	a5,a5,a0
    80201262:	6398                	ld	a4,0(a5)
    uint64 offset = vir_addr & 0b111111111111;
    80201264:	03459913          	slli	s2,a1,0x34
    80201268:	03495913          	srli	s2,s2,0x34
    return PTE & 0x1;
    8020126c:	00177793          	andi	a5,a4,1
    if (check_PTE_valid(*(uint64*)first_PTE_addr)){    
    80201270:	c7a1                	beqz	a5,802012b8 <translate+0x70>
    return (ppn >> 9) & ((1 << 9) - 1);
    80201272:	0155d793          	srli	a5,a1,0x15
    80201276:	1ff7f793          	andi	a5,a5,511
    return (PTE >> 10) & ((1 << 44) - 1);
    8020127a:	8329                	srli	a4,a4,0xa
    return (ppn << 12);
    8020127c:	0732                	slli	a4,a4,0xc
     
        uint64 next_page_directory = get_PTE_ppn(first_PTE_addr);            
        uint64 second_PTE_addr = get_PTE(next_page_directory, ppn_1);

        if (check_PTE_valid(*(uint64*)second_PTE_addr)){
    8020127e:	078e                	slli	a5,a5,0x3
    80201280:	97ba                	add	a5,a5,a4
    80201282:	639c                	ld	a5,0(a5)
    return PTE & 0x1;
    80201284:	0017f713          	andi	a4,a5,1
        if (check_PTE_valid(*(uint64*)second_PTE_addr)){
    80201288:	cb05                	beqz	a4,802012b8 <translate+0x70>
    uint64 vpn = vir_addr >> 12;
    8020128a:	81b1                	srli	a1,a1,0xc
    return ppn & ((1 << 9) - 1);
    8020128c:	1ff5f593          	andi	a1,a1,511
    return (PTE >> 10) & ((1 << 44) - 1);
    80201290:	83a9                	srli	a5,a5,0xa
    return (ppn << 12);
    80201292:	07b2                	slli	a5,a5,0xc
            
            next_page_directory = get_PTE_ppn(second_PTE_addr);            
            uint64 third_PTE_addr = get_PTE(next_page_directory, ppn_0);

            if (check_PTE_valid(*(uint64*)third_PTE_addr)){
    80201294:	058e                	slli	a1,a1,0x3
    80201296:	95be                	add	a1,a1,a5
    80201298:	619c                	ld	a5,0(a1)
    return PTE & 0x1;
    8020129a:	0017f713          	andi	a4,a5,1
            if (check_PTE_valid(*(uint64*)third_PTE_addr)){
    8020129e:	cf09                	beqz	a4,802012b8 <translate+0x70>
        }  
    }else{
        panic("Wrong in translate!\n");
    }
    return corresponding_frame << 12 | offset;
}
    802012a0:	60e2                	ld	ra,24(sp)
    802012a2:	6442                	ld	s0,16(sp)
    return (PTE >> 10) & ((1 << 44) - 1);
    802012a4:	00a7d493          	srli	s1,a5,0xa
    return corresponding_frame << 12 | offset;
    802012a8:	00c49513          	slli	a0,s1,0xc
}
    802012ac:	01256533          	or	a0,a0,s2
    802012b0:	64a2                	ld	s1,8(sp)
    802012b2:	6902                	ld	s2,0(sp)
    802012b4:	6105                	addi	sp,sp,32
    802012b6:	8082                	ret
                panic("Wrong in translate!\n");
    802012b8:	00001517          	auipc	a0,0x1
    802012bc:	fa850513          	addi	a0,a0,-88 # 80202260 <digits+0x1d8>
    802012c0:	fffff097          	auipc	ra,0xfffff
    802012c4:	fee080e7          	jalr	-18(ra) # 802002ae <panic>
}
    802012c8:	60e2                	ld	ra,24(sp)
    802012ca:	6442                	ld	s0,16(sp)
    return corresponding_frame << 12 | offset;
    802012cc:	00c49513          	slli	a0,s1,0xc
}
    802012d0:	01256533          	or	a0,a0,s2
    802012d4:	64a2                	ld	s1,8(sp)
    802012d6:	6902                	ld	s2,0(sp)
    802012d8:	6105                	addi	sp,sp,32
    802012da:	8082                	ret

00000000802012dc <test_page_table>:

void test_page_table(){
    802012dc:	1101                	addi	sp,sp,-32
    802012de:	ec06                	sd	ra,24(sp)
    802012e0:	e822                	sd	s0,16(sp)
    802012e2:	e426                	sd	s1,8(sp)
    802012e4:	1000                	addi	s0,sp,32
    new_pt.root_ppn = get_frame();
    802012e6:	fffff097          	auipc	ra,0xfffff
    802012ea:	5c0080e7          	jalr	1472(ra) # 802008a6 <get_frame>
    802012ee:	0005049b          	sext.w	s1,a0
    struct PageTable test_page_table = new_pagetable();

    uint64 root_ppn = test_page_table.root_ppn;

    uint64 test_frame = get_frame();
    802012f2:	fffff097          	auipc	ra,0xfffff
    802012f6:	5b4080e7          	jalr	1460(ra) # 802008a6 <get_frame>
    802012fa:	862a                	mv	a2,a0
    new_pt.root_ppn = get_frame();
    802012fc:	1482                	slli	s1,s1,0x20
    802012fe:	9081                	srli	s1,s1,0x20

    map(test_page_table, 1, test_frame, 0b1111);   // map(struct PageTable pg, uint64 vpn, uint64 ppn, uint64 flags)
    80201300:	1602                	slli	a2,a2,0x20
    80201302:	8526                	mv	a0,s1
    80201304:	4585                	li	a1,1
    80201306:	46bd                	li	a3,15
    80201308:	9201                	srli	a2,a2,0x20
    8020130a:	00000097          	auipc	ra,0x0
    8020130e:	de2080e7          	jalr	-542(ra) # 802010ec <map>

    unmap(test_page_table, 1);    // unmap(struct PageTable pg, uint64 vpn)
}
    80201312:	6442                	ld	s0,16(sp)
    80201314:	60e2                	ld	ra,24(sp)
    unmap(test_page_table, 1);    // unmap(struct PageTable pg, uint64 vpn)
    80201316:	8526                	mv	a0,s1
}
    80201318:	64a2                	ld	s1,8(sp)
    unmap(test_page_table, 1);    // unmap(struct PageTable pg, uint64 vpn)
    8020131a:	4585                	li	a1,1
}
    8020131c:	6105                	addi	sp,sp,32
    unmap(test_page_table, 1);    // unmap(struct PageTable pg, uint64 vpn)
    8020131e:	00000317          	auipc	t1,0x0
    80201322:	eb230067          	jr	-334(t1) # 802011d0 <unmap>

0000000080201326 <initmalloc>:
#include "types.h"
#include "printf.h"
#include "panic.h"


void initmalloc(){
    80201326:	1141                	addi	sp,sp,-16
    80201328:	e022                	sd	s0,0(sp)
    8020132a:	e406                	sd	ra,8(sp)
    8020132c:	0800                	addi	s0,sp,16
  uint8 * heap_start = &heap;
  printf("[kernel] heap start is %x \n", heap_start);
    8020132e:	00037597          	auipc	a1,0x37
    80201332:	dfa58593          	addi	a1,a1,-518 # 80238128 <heap>
    80201336:	00001517          	auipc	a0,0x1
    8020133a:	f4250513          	addi	a0,a0,-190 # 80202278 <digits+0x1f0>
    8020133e:	fffff097          	auipc	ra,0xfffff
    80201342:	ddc080e7          	jalr	-548(ra) # 8020011a <printf>
  for (uint32 index = 0; index < MAX_SIZE/8; index++) {
    80201346:	00037797          	auipc	a5,0x37
    8020134a:	de278793          	addi	a5,a5,-542 # 80238128 <heap>
    8020134e:	0003b717          	auipc	a4,0x3b
    80201352:	dda70713          	addi	a4,a4,-550 # 8023c128 <heap+0x4000>
    heap[index] = 0x0; // initialize the heap data
    80201356:	00078023          	sb	zero,0(a5)
  for (uint32 index = 0; index < MAX_SIZE/8; index++) {
    8020135a:	0785                	addi	a5,a5,1
    8020135c:	fee79de3          	bne	a5,a4,80201356 <initmalloc+0x30>
  }
  printf("[kernel] heap end is %x \n", heap_start + MAX_SIZE);
}
    80201360:	6402                	ld	s0,0(sp)
    80201362:	60a2                	ld	ra,8(sp)
  printf("[kernel] heap end is %x \n", heap_start + MAX_SIZE);
    80201364:	00057597          	auipc	a1,0x57
    80201368:	dc458593          	addi	a1,a1,-572 # 80258128 <kernel_memorySet>
    8020136c:	00001517          	auipc	a0,0x1
    80201370:	f2c50513          	addi	a0,a0,-212 # 80202298 <digits+0x210>
}
    80201374:	0141                	addi	sp,sp,16
  printf("[kernel] heap end is %x \n", heap_start + MAX_SIZE);
    80201376:	fffff317          	auipc	t1,0xfffff
    8020137a:	da430067          	jr	-604(t1) # 8020011a <printf>

000000008020137e <kmalloc>:

void * kmalloc(uint32 size){
  if (size > MAX_SIZE/2){ // if greater than 64kb, then the allocation is not allowed
    8020137e:	67c1                	lui	a5,0x10
    80201380:	04a7e963          	bltu	a5,a0,802013d2 <kmalloc+0x54>
    80201384:	00001817          	auipc	a6,0x1
    80201388:	fa480813          	addi	a6,a6,-92 # 80202328 <memomap>
    8020138c:	8742                	mv	a4,a6
    8020138e:	4685                	li	a3,1
    panic("[kernel] kmalloc falied, size is too large!\n");
  } else {
    uint8 * heap_start = &heap;
    uint32 index = 0;
    for (uint8 i = 0; i <8; i++) {
    80201390:	4781                	li	a5,0
    80201392:	45a1                	li	a1,8
    80201394:	a019                	j	8020139a <kmalloc+0x1c>
    80201396:	00074683          	lbu	a3,0(a4)
    8020139a:	0017861b          	addiw	a2,a5,1
      if (size <= memomap[i]) {
    8020139e:	00a6fc63          	bgeu	a3,a0,802013b6 <kmalloc+0x38>
    for (uint8 i = 0; i <8; i++) {
    802013a2:	0ff67793          	andi	a5,a2,255
    802013a6:	0705                	addi	a4,a4,1
    802013a8:	feb797e3          	bne	a5,a1,80201396 <kmalloc+0x18>
        index = i;
        break;
      }
    }
    usedmap[index] = 1;
    if(index == 0) return (void*) heap_start; 
    802013ac:	00037517          	auipc	a0,0x37
    802013b0:	d7c50513          	addi	a0,a0,-644 # 80238128 <heap>
    else return (void*) heap_start + 1024 * memomap[index];
  }
}
    802013b4:	8082                	ret
        index = i;
    802013b6:	0007871b          	sext.w	a4,a5
    if(index == 0) return (void*) heap_start; 
    802013ba:	dbed                	beqz	a5,802013ac <kmalloc+0x2e>
    else return (void*) heap_start + 1024 * memomap[index];
    802013bc:	983a                	add	a6,a6,a4
    802013be:	00084503          	lbu	a0,0(a6)
    802013c2:	00037797          	auipc	a5,0x37
    802013c6:	d6678793          	addi	a5,a5,-666 # 80238128 <heap>
    802013ca:	00a5151b          	slliw	a0,a0,0xa
    802013ce:	953e                	add	a0,a0,a5
    802013d0:	8082                	ret
void * kmalloc(uint32 size){
    802013d2:	1141                	addi	sp,sp,-16
    802013d4:	e022                	sd	s0,0(sp)
    802013d6:	e406                	sd	ra,8(sp)
    802013d8:	0800                	addi	s0,sp,16
    panic("[kernel] kmalloc falied, size is too large!\n");
    802013da:	00001517          	auipc	a0,0x1
    802013de:	ede50513          	addi	a0,a0,-290 # 802022b8 <digits+0x230>
    802013e2:	fffff097          	auipc	ra,0xfffff
    802013e6:	ecc080e7          	jalr	-308(ra) # 802002ae <panic>
}
    802013ea:	60a2                	ld	ra,8(sp)
    802013ec:	6402                	ld	s0,0(sp)
    802013ee:	0141                	addi	sp,sp,16
    802013f0:	8082                	ret

00000000802013f2 <kfree>:

void  kfree(void * addr){
  uint8 * heap_start = &heap;
  uint8 * allocated_start = (uint8*) addr;
  uint32 memo = (allocated_start - heap_start) / 1024;
    802013f2:	00037797          	auipc	a5,0x37
    802013f6:	d3678793          	addi	a5,a5,-714 # 80238128 <heap>
    802013fa:	40f50733          	sub	a4,a0,a5
    802013fe:	43f75793          	srai	a5,a4,0x3f
    80201402:	3ff7f793          	andi	a5,a5,1023
void  kfree(void * addr){
    80201406:	1141                	addi	sp,sp,-16
  uint32 memo = (allocated_start - heap_start) / 1024;
    80201408:	9fb9                	addw	a5,a5,a4
void  kfree(void * addr){
    8020140a:	e422                	sd	s0,8(sp)
        break;
      }
    }
  }
  usedmap[index] = 0;
  for (uint32 i = 0; i < memo*1024; i++){
    8020140c:	c007f793          	andi	a5,a5,-1024
void  kfree(void * addr){
    80201410:	0800                	addi	s0,sp,16
  for (uint32 i = 0; i < memo*1024; i++){
    80201412:	0007871b          	sext.w	a4,a5
    80201416:	cf01                	beqz	a4,8020142e <kfree+0x3c>
    80201418:	37fd                	addiw	a5,a5,-1
    8020141a:	1782                	slli	a5,a5,0x20
    8020141c:	00150713          	addi	a4,a0,1
    80201420:	9381                	srli	a5,a5,0x20
    80201422:	97ba                	add	a5,a5,a4
    *(allocated_start + i) = 0x0;
    80201424:	00050023          	sb	zero,0(a0)
  for (uint32 i = 0; i < memo*1024; i++){
    80201428:	0505                	addi	a0,a0,1
    8020142a:	fef51de3          	bne	a0,a5,80201424 <kfree+0x32>
  }
    8020142e:	6422                	ld	s0,8(sp)
    80201430:	0141                	addi	sp,sp,16
    80201432:	8082                	ret

0000000080201434 <new_Map_Area>:
#include "mm/pagetable.h"
#include "mm/framealloc.h"
#include "mm/MapArea.h"
#include "console.h"

struct Map_Area new_Map_Area(uint64 start_addr, uint64 end_addr, uint64 map_type, uint64 permissions){
    80201434:	1141                	addi	sp,sp,-16
    80201436:	e422                	sd	s0,8(sp)
    80201438:	0800                	addi	s0,sp,16
    uint64 start_vpn = (start_addr) / PAGE_SIZE;
    uint64 end_vpn = (end_addr) / PAGE_SIZE;

    if (((end_addr) % PAGE_SIZE) > 0) end_vpn += 1;
    8020143a:	03461893          	slli	a7,a2,0x34
    new_map_area.vpn_start = start_vpn;
    new_map_area.vpn_end = end_vpn;
    new_map_area.map_type = map_type;
    new_map_area.permission = permissions;
    return new_map_area;
}
    8020143e:	6422                	ld	s0,8(sp)
    uint64 end_vpn = (end_addr) / PAGE_SIZE;
    80201440:	00c65813          	srli	a6,a2,0xc
    if (((end_addr) % PAGE_SIZE) > 0) end_vpn += 1;
    80201444:	011038b3          	snez	a7,a7
    uint64 start_vpn = (start_addr) / PAGE_SIZE;
    80201448:	00c5d313          	srli	t1,a1,0xc
    if (((end_addr) % PAGE_SIZE) > 0) end_vpn += 1;
    8020144c:	9846                	add	a6,a6,a7
    return new_map_area;
    8020144e:	e10c                	sd	a1,0(a0)
    80201450:	e510                	sd	a2,8(a0)
    80201452:	00653823          	sd	t1,16(a0)
    80201456:	01053c23          	sd	a6,24(a0)
    8020145a:	f114                	sd	a3,32(a0)
    8020145c:	f518                	sd	a4,40(a0)
}
    8020145e:	0141                	addi	sp,sp,16
    80201460:	8082                	ret

0000000080201462 <copy_to_frame>:

void copy_to_frame(uint64 ppn, uint64 copy_start, uint64 copy_end){
    80201462:	1101                	addi	sp,sp,-32
    80201464:	e822                	sd	s0,16(sp)
    80201466:	e426                	sd	s1,8(sp)
    80201468:	e04a                	sd	s2,0(sp)
    8020146a:	ec06                	sd	ra,24(sp)
    8020146c:	1000                	addi	s0,sp,32
    8020146e:	8932                	mv	s2,a2
    80201470:	84ae                	mv	s1,a1
    uint64 phys_addr_start = to_physical_addr(ppn);
    80201472:	00000097          	auipc	ra,0x0
    80201476:	bea080e7          	jalr	-1046(ra) # 8020105c <to_physical_addr>
    if (copy_end == 0){
    8020147a:	02090563          	beqz	s2,802014a4 <copy_to_frame+0x42>
        for (int i = 0; i < PAGE_SIZE; i++){
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
        }
    }else{
        for (int i = 0; i < copy_end - copy_start; i++){
    8020147e:	85a6                	mv	a1,s1
    80201480:	8d05                	sub	a0,a0,s1
    80201482:	00990b63          	beq	s2,s1,80201498 <copy_to_frame+0x36>
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
    80201486:	0005c703          	lbu	a4,0(a1)
    8020148a:	00b507b3          	add	a5,a0,a1
    8020148e:	0585                	addi	a1,a1,1
    80201490:	00e78023          	sb	a4,0(a5)
        for (int i = 0; i < copy_end - copy_start; i++){
    80201494:	feb919e3          	bne	s2,a1,80201486 <copy_to_frame+0x24>
        }
    }
}
    80201498:	60e2                	ld	ra,24(sp)
    8020149a:	6442                	ld	s0,16(sp)
    8020149c:	64a2                	ld	s1,8(sp)
    8020149e:	6902                	ld	s2,0(sp)
    802014a0:	6105                	addi	sp,sp,32
    802014a2:	8082                	ret
    802014a4:	6605                	lui	a2,0x1
    if (copy_end == 0){
    802014a6:	87a6                	mv	a5,s1
    802014a8:	9626                	add	a2,a2,s1
    802014aa:	8d05                	sub	a0,a0,s1
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
    802014ac:	0007c683          	lbu	a3,0(a5)
    802014b0:	00f50733          	add	a4,a0,a5
    802014b4:	0785                	addi	a5,a5,1
    802014b6:	00d70023          	sb	a3,0(a4)
        for (int i = 0; i < PAGE_SIZE; i++){
    802014ba:	fef619e3          	bne	a2,a5,802014ac <copy_to_frame+0x4a>
}
    802014be:	60e2                	ld	ra,24(sp)
    802014c0:	6442                	ld	s0,16(sp)
    802014c2:	64a2                	ld	s1,8(sp)
    802014c4:	6902                	ld	s2,0(sp)
    802014c6:	6105                	addi	sp,sp,32
    802014c8:	8082                	ret

00000000802014ca <push_Map_Area>:

void push_Map_Area(struct Map_Area map_area, struct PageTable pg, uint64 copy_start, uint64 copy_end){
    802014ca:	7119                	addi	sp,sp,-128
    802014cc:	f8a2                	sd	s0,112(sp)
    802014ce:	f0ca                	sd	s2,96(sp)
    802014d0:	ecce                	sd	s3,88(sp)
    802014d2:	e8d2                	sd	s4,80(sp)
    802014d4:	f466                	sd	s9,40(sp)
    802014d6:	fc86                	sd	ra,120(sp)
    802014d8:	f4a6                	sd	s1,104(sp)
    802014da:	e4d6                	sd	s5,72(sp)
    802014dc:	e0da                	sd	s6,64(sp)
    802014de:	fc5e                	sd	s7,56(sp)
    802014e0:	f862                	sd	s8,48(sp)
    802014e2:	f06a                	sd	s10,32(sp)
    802014e4:	ec6e                	sd	s11,24(sp)
    802014e6:	0100                	addi	s0,sp,128
    uint64 map_type = map_area.map_type;
    802014e8:	711c                	ld	a5,32(a0)
    uint64 vpn_start = map_area.vpn_start;
    802014ea:	01053c83          	ld	s9,16(a0)
    uint64 vpn_end = map_area.vpn_end;
    802014ee:	01853983          	ld	s3,24(a0)
    uint64 permission = map_area.permission;
    802014f2:	02853a03          	ld	s4,40(a0)
void push_Map_Area(struct Map_Area map_area, struct PageTable pg, uint64 copy_start, uint64 copy_end){
    802014f6:	892e                	mv	s2,a1

    if (map_type == 0){    // 进行Identical的映射
    802014f8:	ef8d                	bnez	a5,80201532 <push_Map_Area+0x68>
        for (uint64 vpn = vpn_start; vpn <= vpn_end; vpn++){
    802014fa:	0199ed63          	bltu	s3,s9,80201514 <push_Map_Area+0x4a>
            map(pg, vpn, vpn, permission);
    802014fe:	8666                	mv	a2,s9
    80201500:	85e6                	mv	a1,s9
    80201502:	86d2                	mv	a3,s4
        for (uint64 vpn = vpn_start; vpn <= vpn_end; vpn++){
    80201504:	0c85                	addi	s9,s9,1
            map(pg, vpn, vpn, permission);
    80201506:	854a                	mv	a0,s2
    80201508:	00000097          	auipc	ra,0x0
    8020150c:	be4080e7          	jalr	-1052(ra) # 802010ec <map>
        for (uint64 vpn = vpn_start; vpn <= vpn_end; vpn++){
    80201510:	ff99f7e3          	bgeu	s3,s9,802014fe <push_Map_Area+0x34>
            map(pg, vpn_end, target_ppn, permission);
        }
    }else{
        panic("Wrong in pushing MapArea!");
    }
}
    80201514:	70e6                	ld	ra,120(sp)
    80201516:	7446                	ld	s0,112(sp)
    80201518:	74a6                	ld	s1,104(sp)
    8020151a:	7906                	ld	s2,96(sp)
    8020151c:	69e6                	ld	s3,88(sp)
    8020151e:	6a46                	ld	s4,80(sp)
    80201520:	6aa6                	ld	s5,72(sp)
    80201522:	6b06                	ld	s6,64(sp)
    80201524:	7be2                	ld	s7,56(sp)
    80201526:	7c42                	ld	s8,48(sp)
    80201528:	7ca2                	ld	s9,40(sp)
    8020152a:	7d02                	ld	s10,32(sp)
    8020152c:	6de2                	ld	s11,24(sp)
    8020152e:	6109                	addi	sp,sp,128
    80201530:	8082                	ret
    }else if (map_type == 1){    // 进行Framed映射
    80201532:	4705                	li	a4,1
    80201534:	0ce79363          	bne	a5,a4,802015fa <push_Map_Area+0x130>
    80201538:	8d32                	mv	s10,a2
    8020153a:	8b36                	mv	s6,a3
        for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    8020153c:	073cf963          	bgeu	s9,s3,802015ae <push_Map_Area+0xe4>
    80201540:	6b85                	lui	s7,0x1
    80201542:	017607b3          	add	a5,a2,s7
    80201546:	f8f43423          	sd	a5,-120(s0)
    8020154a:	8c3e                	mv	s8,a5
    8020154c:	8be6                	mv	s7,s9
            copy_start += PAGE_SIZE;
    8020154e:	6a85                	lui	s5,0x1
            uint64 target_ppn = get_frame();
    80201550:	fffff097          	auipc	ra,0xfffff
    80201554:	356080e7          	jalr	854(ra) # 802008a6 <get_frame>
    80201558:	02051d93          	slli	s11,a0,0x20
    8020155c:	020ddd93          	srli	s11,s11,0x20
    uint64 phys_addr_start = to_physical_addr(ppn);
    80201560:	856e                	mv	a0,s11
    80201562:	00000097          	auipc	ra,0x0
    80201566:	afa080e7          	jalr	-1286(ra) # 8020105c <to_physical_addr>
    8020156a:	84ea                	mv	s1,s10
    8020156c:	41a50533          	sub	a0,a0,s10
            *(char*)(phys_addr_start + i) = *(char*)(copy_start + i);
    80201570:	0004c703          	lbu	a4,0(s1)
    80201574:	009507b3          	add	a5,a0,s1
    80201578:	0485                	addi	s1,s1,1
    8020157a:	00e78023          	sb	a4,0(a5)
        for (int i = 0; i < PAGE_SIZE; i++){
    8020157e:	ff8499e3          	bne	s1,s8,80201570 <push_Map_Area+0xa6>
            map(pg, vpn, target_ppn, permission);
    80201582:	85de                	mv	a1,s7
    80201584:	86d2                	mv	a3,s4
    80201586:	866e                	mv	a2,s11
    80201588:	854a                	mv	a0,s2
        for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    8020158a:	0b85                	addi	s7,s7,1
            map(pg, vpn, target_ppn, permission);
    8020158c:	00000097          	auipc	ra,0x0
    80201590:	b60080e7          	jalr	-1184(ra) # 802010ec <map>
            copy_start += PAGE_SIZE;
    80201594:	9d56                	add	s10,s10,s5
        for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    80201596:	01548c33          	add	s8,s1,s5
    8020159a:	fb799be3          	bne	s3,s7,80201550 <push_Map_Area+0x86>
    8020159e:	f8843783          	ld	a5,-120(s0)
    802015a2:	fff98d13          	addi	s10,s3,-1
    802015a6:	419d0d33          	sub	s10,s10,s9
    802015aa:	0d32                	slli	s10,s10,0xc
    802015ac:	9d3e                	add	s10,s10,a5
        if (copy_end > copy_start){
    802015ae:	f76d73e3          	bgeu	s10,s6,80201514 <push_Map_Area+0x4a>
            uint64 target_ppn = get_frame();
    802015b2:	fffff097          	auipc	ra,0xfffff
    802015b6:	2f4080e7          	jalr	756(ra) # 802008a6 <get_frame>
    802015ba:	02051493          	slli	s1,a0,0x20
    802015be:	9081                	srli	s1,s1,0x20
            copy_to_frame(target_ppn, copy_start, copy_end);
    802015c0:	865a                	mv	a2,s6
    802015c2:	85ea                	mv	a1,s10
    802015c4:	8526                	mv	a0,s1
    802015c6:	00000097          	auipc	ra,0x0
    802015ca:	e9c080e7          	jalr	-356(ra) # 80201462 <copy_to_frame>
}
    802015ce:	7446                	ld	s0,112(sp)
    802015d0:	70e6                	ld	ra,120(sp)
    802015d2:	6aa6                	ld	s5,72(sp)
    802015d4:	6b06                	ld	s6,64(sp)
    802015d6:	7be2                	ld	s7,56(sp)
    802015d8:	7c42                	ld	s8,48(sp)
    802015da:	7ca2                	ld	s9,40(sp)
    802015dc:	7d02                	ld	s10,32(sp)
    802015de:	6de2                	ld	s11,24(sp)
            map(pg, vpn_end, target_ppn, permission);
    802015e0:	86d2                	mv	a3,s4
    802015e2:	8626                	mv	a2,s1
}
    802015e4:	6a46                	ld	s4,80(sp)
    802015e6:	74a6                	ld	s1,104(sp)
            map(pg, vpn_end, target_ppn, permission);
    802015e8:	85ce                	mv	a1,s3
    802015ea:	854a                	mv	a0,s2
}
    802015ec:	69e6                	ld	s3,88(sp)
    802015ee:	7906                	ld	s2,96(sp)
    802015f0:	6109                	addi	sp,sp,128
            map(pg, vpn_end, target_ppn, permission);
    802015f2:	00000317          	auipc	t1,0x0
    802015f6:	afa30067          	jr	-1286(t1) # 802010ec <map>
}
    802015fa:	7446                	ld	s0,112(sp)
    802015fc:	70e6                	ld	ra,120(sp)
    802015fe:	74a6                	ld	s1,104(sp)
    80201600:	7906                	ld	s2,96(sp)
    80201602:	69e6                	ld	s3,88(sp)
    80201604:	6a46                	ld	s4,80(sp)
    80201606:	6aa6                	ld	s5,72(sp)
    80201608:	6b06                	ld	s6,64(sp)
    8020160a:	7be2                	ld	s7,56(sp)
    8020160c:	7c42                	ld	s8,48(sp)
    8020160e:	7ca2                	ld	s9,40(sp)
    80201610:	7d02                	ld	s10,32(sp)
    80201612:	6de2                	ld	s11,24(sp)
        panic("Wrong in pushing MapArea!");
    80201614:	00001517          	auipc	a0,0x1
    80201618:	cd450513          	addi	a0,a0,-812 # 802022e8 <digits+0x260>
}
    8020161c:	6109                	addi	sp,sp,128
        panic("Wrong in pushing MapArea!");
    8020161e:	fffff317          	auipc	t1,0xfffff
    80201622:	c9030067          	jr	-880(t1) # 802002ae <panic>

0000000080201626 <free_Map_Area>:

void free_Map_Area(struct Map_Area map_area, struct PageTable pg){
    80201626:	7179                	addi	sp,sp,-48
    80201628:	f022                	sd	s0,32(sp)
    8020162a:	ec26                	sd	s1,24(sp)
    8020162c:	e44e                	sd	s3,8(sp)
    8020162e:	f406                	sd	ra,40(sp)
    80201630:	e84a                	sd	s2,16(sp)
    80201632:	1800                	addi	s0,sp,48
    uint64 vpn_start = map_area.vpn_start;
    80201634:	6904                	ld	s1,16(a0)
    uint64 vpn_end = map_area.vpn_end;
    80201636:	01853983          	ld	s3,24(a0)

    for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    8020163a:	0134fc63          	bgeu	s1,s3,80201652 <free_Map_Area+0x2c>
    8020163e:	892e                	mv	s2,a1
        unmap(pg, vpn);
    80201640:	85a6                	mv	a1,s1
    80201642:	854a                	mv	a0,s2
    for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    80201644:	0485                	addi	s1,s1,1
        unmap(pg, vpn);
    80201646:	00000097          	auipc	ra,0x0
    8020164a:	b8a080e7          	jalr	-1142(ra) # 802011d0 <unmap>
    for (uint64 vpn = vpn_start; vpn < vpn_end; vpn++){
    8020164e:	fe9999e3          	bne	s3,s1,80201640 <free_Map_Area+0x1a>
    }
}
    80201652:	70a2                	ld	ra,40(sp)
    80201654:	7402                	ld	s0,32(sp)
    80201656:	64e2                	ld	s1,24(sp)
    80201658:	6942                	ld	s2,16(sp)
    8020165a:	69a2                	ld	s3,8(sp)
    8020165c:	6145                	addi	sp,sp,48
    8020165e:	8082                	ret

0000000080201660 <test_map_area>:


void test_map_area(){
    80201660:	7119                	addi	sp,sp,-128
    80201662:	fc86                	sd	ra,120(sp)
    80201664:	f8a2                	sd	s0,112(sp)
    80201666:	f4a6                	sd	s1,104(sp)
    80201668:	0100                	addi	s0,sp,128
    8020166a:	f0ca                	sd	s2,96(sp)
    return new_map_area;
    8020166c:	000807b7          	lui	a5,0x80
    80201670:	20078713          	addi	a4,a5,512 # 80200 <n+0x801e0>
    80201674:	30078793          	addi	a5,a5,768
    80201678:	fcf43423          	sd	a5,-56(s0)
    8020167c:	40100493          	li	s1,1025
    80201680:	4785                	li	a5,1
    80201682:	00803937          	lui	s2,0x803
    80201686:	04d6                	slli	s1,s1,0x15
    80201688:	0922                	slli	s2,s2,0x8
    8020168a:	fcf43823          	sd	a5,-48(s0)
    8020168e:	47bd                	li	a5,15
    80201690:	fa943823          	sd	s1,-80(s0)
    80201694:	fb243c23          	sd	s2,-72(s0)
    80201698:	fce43023          	sd	a4,-64(s0)
    8020169c:	fcf43c23          	sd	a5,-40(s0)
    struct Map_Area MA = new_Map_Area(0X80200000, 0X80300000, 1, 0b1111);
    struct PageTable PG = new_pagetable();
    802016a0:	00000097          	auipc	ra,0x0
    802016a4:	9ca080e7          	jalr	-1590(ra) # 8020106a <new_pagetable>


    push_Map_Area(MA, PG, 0x80200000, 0x80300000);
    802016a8:	fb043783          	ld	a5,-80(s0)
    struct PageTable PG = new_pagetable();
    802016ac:	85aa                	mv	a1,a0
    push_Map_Area(MA, PG, 0x80200000, 0x80300000);
    802016ae:	86ca                	mv	a3,s2
    802016b0:	f8f43023          	sd	a5,-128(s0)
    802016b4:	fb843783          	ld	a5,-72(s0)
    802016b8:	8626                	mv	a2,s1
    802016ba:	f8040513          	addi	a0,s0,-128
    802016be:	f8f43423          	sd	a5,-120(s0)
    802016c2:	fc043783          	ld	a5,-64(s0)
    802016c6:	f8f43823          	sd	a5,-112(s0)
    802016ca:	fc843783          	ld	a5,-56(s0)
    802016ce:	f8f43c23          	sd	a5,-104(s0)
    802016d2:	fd043783          	ld	a5,-48(s0)
    802016d6:	faf43023          	sd	a5,-96(s0)
    802016da:	fd843783          	ld	a5,-40(s0)
    802016de:	faf43423          	sd	a5,-88(s0)
    802016e2:	00000097          	auipc	ra,0x0
    802016e6:	de8080e7          	jalr	-536(ra) # 802014ca <push_Map_Area>
    802016ea:	70e6                	ld	ra,120(sp)
    802016ec:	7446                	ld	s0,112(sp)
    802016ee:	74a6                	ld	s1,104(sp)
    802016f0:	7906                	ld	s2,96(sp)
    802016f2:	6109                	addi	sp,sp,128
    802016f4:	8082                	ret

00000000802016f6 <map_kernel>:
extern uint32 sdata;
extern uint32 edata;
extern uint32 sbss_with_stack;
extern uint32 ebss;

void map_kernel(){
    802016f6:	711d                	addi	sp,sp,-96
    802016f8:	ec86                	sd	ra,88(sp)
    802016fa:	e8a2                	sd	s0,80(sp)
    802016fc:	e4a6                	sd	s1,72(sp)
    802016fe:	1080                	addi	s0,sp,96
    80201700:	e0ca                	sd	s2,64(sp)
    80201702:	fc4e                	sd	s3,56(sp)

    kernel_memorySet.page_table = new_pagetable();
    80201704:	00057497          	auipc	s1,0x57
    80201708:	a2448493          	addi	s1,s1,-1500 # 80258128 <kernel_memorySet>
    8020170c:	00000097          	auipc	ra,0x0
    80201710:	95e080e7          	jalr	-1698(ra) # 8020106a <new_pagetable>

    // map .text
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201714:	fffff917          	auipc	s2,0xfffff
    80201718:	8ec90913          	addi	s2,s2,-1812 # 80200000 <_entry>
    8020171c:	00001997          	auipc	s3,0x1
    80201720:	8e498993          	addi	s3,s3,-1820 # 80202000 <etext>
    80201724:	4715                	li	a4,5
    kernel_memorySet.page_table = new_pagetable();
    80201726:	e088                	sd	a0,0(s1)
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201728:	864e                	mv	a2,s3
    8020172a:	85ca                	mv	a1,s2
    8020172c:	fa040513          	addi	a0,s0,-96
    80201730:	4681                	li	a3,0
    80201732:	00000097          	auipc	ra,0x0
    80201736:	d02080e7          	jalr	-766(ra) # 80201434 <new_Map_Area>
    8020173a:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.text, kernel_memorySet.page_table, &stext, &etext);
    8020173e:	608c                	ld	a1,0(s1)
    80201740:	86ce                	mv	a3,s3
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201742:	e49c                	sd	a5,8(s1)
    80201744:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.text, kernel_memorySet.page_table, &stext, &etext);
    80201748:	864a                	mv	a2,s2
    8020174a:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    8020174e:	e89c                	sd	a5,16(s1)
    80201750:	fb043783          	ld	a5,-80(s0)

    // map .rodata
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    80201754:	00001917          	auipc	s2,0x1
    80201758:	8ac90913          	addi	s2,s2,-1876 # 80202000 <etext>
    8020175c:	00002997          	auipc	s3,0x2
    80201760:	8a498993          	addi	s3,s3,-1884 # 80203000 <_num_app>
    kernel_memorySet.text = new_Map_Area(&stext, &etext, 0, 0b0101);
    80201764:	ec9c                	sd	a5,24(s1)
    80201766:	fb843783          	ld	a5,-72(s0)
    8020176a:	f09c                	sd	a5,32(s1)
    8020176c:	fc043783          	ld	a5,-64(s0)
    80201770:	f49c                	sd	a5,40(s1)
    80201772:	fc843783          	ld	a5,-56(s0)
    80201776:	f89c                	sd	a5,48(s1)
    push_Map_Area(kernel_memorySet.text, kernel_memorySet.page_table, &stext, &etext);
    80201778:	00000097          	auipc	ra,0x0
    8020177c:	d52080e7          	jalr	-686(ra) # 802014ca <push_Map_Area>
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    80201780:	4705                	li	a4,1
    80201782:	864e                	mv	a2,s3
    80201784:	85ca                	mv	a1,s2
    80201786:	fa040513          	addi	a0,s0,-96
    8020178a:	4681                	li	a3,0
    8020178c:	00000097          	auipc	ra,0x0
    80201790:	ca8080e7          	jalr	-856(ra) # 80201434 <new_Map_Area>
    80201794:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.rodata, kernel_memorySet.page_table, &srodata, &erodata);
    80201798:	608c                	ld	a1,0(s1)
    8020179a:	86ce                	mv	a3,s3
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    8020179c:	fc9c                	sd	a5,56(s1)
    8020179e:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.rodata, kernel_memorySet.page_table, &srodata, &erodata);
    802017a2:	864a                	mv	a2,s2
    802017a4:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    802017a8:	e0bc                	sd	a5,64(s1)
    802017aa:	fb043783          	ld	a5,-80(s0)

    // map .data
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    802017ae:	00002917          	auipc	s2,0x2
    802017b2:	85290913          	addi	s2,s2,-1966 # 80203000 <_num_app>
    802017b6:	0002d997          	auipc	s3,0x2d
    802017ba:	84a98993          	addi	s3,s3,-1974 # 8022e000 <boot_stack>
    kernel_memorySet.rodata = new_Map_Area(&srodata, &erodata, 0, 0b0001);
    802017be:	e4bc                	sd	a5,72(s1)
    802017c0:	fb843783          	ld	a5,-72(s0)
    802017c4:	e8bc                	sd	a5,80(s1)
    802017c6:	fc043783          	ld	a5,-64(s0)
    802017ca:	ecbc                	sd	a5,88(s1)
    802017cc:	fc843783          	ld	a5,-56(s0)
    802017d0:	f0bc                	sd	a5,96(s1)
    push_Map_Area(kernel_memorySet.rodata, kernel_memorySet.page_table, &srodata, &erodata);
    802017d2:	00000097          	auipc	ra,0x0
    802017d6:	cf8080e7          	jalr	-776(ra) # 802014ca <push_Map_Area>
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    802017da:	470d                	li	a4,3
    802017dc:	864e                	mv	a2,s3
    802017de:	85ca                	mv	a1,s2
    802017e0:	fa040513          	addi	a0,s0,-96
    802017e4:	4681                	li	a3,0
    802017e6:	00000097          	auipc	ra,0x0
    802017ea:	c4e080e7          	jalr	-946(ra) # 80201434 <new_Map_Area>
    802017ee:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.data, kernel_memorySet.page_table, &sdata, &edata);
    802017f2:	608c                	ld	a1,0(s1)
    802017f4:	86ce                	mv	a3,s3
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    802017f6:	f4bc                	sd	a5,104(s1)
    802017f8:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.data, kernel_memorySet.page_table, &sdata, &edata);
    802017fc:	864a                	mv	a2,s2
    802017fe:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    80201802:	f8bc                	sd	a5,112(s1)
    80201804:	fb043783          	ld	a5,-80(s0)

    // map .bss
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201808:	0002c917          	auipc	s2,0x2c
    8020180c:	7f890913          	addi	s2,s2,2040 # 8022e000 <boot_stack>
    80201810:	00059997          	auipc	s3,0x59
    80201814:	7f098993          	addi	s3,s3,2032 # 8025b000 <ebss>
    kernel_memorySet.data = new_Map_Area(&sdata, &edata, 0, 0b0011);
    80201818:	fcbc                	sd	a5,120(s1)
    8020181a:	fb843783          	ld	a5,-72(s0)
    8020181e:	e0dc                	sd	a5,128(s1)
    80201820:	fc043783          	ld	a5,-64(s0)
    80201824:	e4dc                	sd	a5,136(s1)
    80201826:	fc843783          	ld	a5,-56(s0)
    8020182a:	e8dc                	sd	a5,144(s1)
    push_Map_Area(kernel_memorySet.data, kernel_memorySet.page_table, &sdata, &edata);
    8020182c:	00000097          	auipc	ra,0x0
    80201830:	c9e080e7          	jalr	-866(ra) # 802014ca <push_Map_Area>
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201834:	470d                	li	a4,3
    80201836:	864e                	mv	a2,s3
    80201838:	85ca                	mv	a1,s2
    8020183a:	fa040513          	addi	a0,s0,-96
    8020183e:	4681                	li	a3,0
    80201840:	00000097          	auipc	ra,0x0
    80201844:	bf4080e7          	jalr	-1036(ra) # 80201434 <new_Map_Area>
    80201848:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.bss, kernel_memorySet.page_table, &sbss_with_stack, &ebss);
    8020184c:	608c                	ld	a1,0(s1)
    8020184e:	86ce                	mv	a3,s3
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201850:	ecdc                	sd	a5,152(s1)
    80201852:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.bss, kernel_memorySet.page_table, &sbss_with_stack, &ebss);
    80201856:	864a                	mv	a2,s2
    80201858:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    8020185c:	f0dc                	sd	a5,160(s1)
    8020185e:	fb043783          	ld	a5,-80(s0)

    // map Avaibable Frames
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    80201862:	40500913          	li	s2,1029
    80201866:	0956                	slli	s2,s2,0x15
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201868:	f4dc                	sd	a5,168(s1)
    8020186a:	fb843783          	ld	a5,-72(s0)
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    8020186e:	00059997          	auipc	s3,0x59
    80201872:	79298993          	addi	s3,s3,1938 # 8025b000 <ebss>
    kernel_memorySet.bss = new_Map_Area(&sbss_with_stack, &ebss, 0, 0b0011);
    80201876:	f8dc                	sd	a5,176(s1)
    80201878:	fc043783          	ld	a5,-64(s0)
    8020187c:	fcdc                	sd	a5,184(s1)
    8020187e:	fc843783          	ld	a5,-56(s0)
    80201882:	e0fc                	sd	a5,192(s1)
    push_Map_Area(kernel_memorySet.bss, kernel_memorySet.page_table, &sbss_with_stack, &ebss);
    80201884:	00000097          	auipc	ra,0x0
    80201888:	c46080e7          	jalr	-954(ra) # 802014ca <push_Map_Area>
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    8020188c:	fff90613          	addi	a2,s2,-1
    80201890:	85ce                	mv	a1,s3
    80201892:	fa040513          	addi	a0,s0,-96
    80201896:	4681                	li	a3,0
    80201898:	471d                	li	a4,7
    8020189a:	00000097          	auipc	ra,0x0
    8020189e:	b9a080e7          	jalr	-1126(ra) # 80201434 <new_Map_Area>
    802018a2:	fa043783          	ld	a5,-96(s0)
    push_Map_Area(kernel_memorySet.Available_Frames, kernel_memorySet.page_table, &ekernel, 0x80A00000);
    802018a6:	608c                	ld	a1,0(s1)
    802018a8:	86ca                	mv	a3,s2
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    802018aa:	e4fc                	sd	a5,200(s1)
    802018ac:	fa843783          	ld	a5,-88(s0)
    push_Map_Area(kernel_memorySet.Available_Frames, kernel_memorySet.page_table, &ekernel, 0x80A00000);
    802018b0:	864e                	mv	a2,s3
    802018b2:	fa040513          	addi	a0,s0,-96
    kernel_memorySet.Available_Frames = new_Map_Area(&ekernel, 0x80A00000-1, 0, 0b0111);
    802018b6:	e8fc                	sd	a5,208(s1)
    802018b8:	fb043783          	ld	a5,-80(s0)
    802018bc:	ecfc                	sd	a5,216(s1)
    802018be:	fb843783          	ld	a5,-72(s0)
    802018c2:	f0fc                	sd	a5,224(s1)
    802018c4:	fc043783          	ld	a5,-64(s0)
    802018c8:	f4fc                	sd	a5,232(s1)
    802018ca:	fc843783          	ld	a5,-56(s0)
    802018ce:	f8fc                	sd	a5,240(s1)
    push_Map_Area(kernel_memorySet.Available_Frames, kernel_memorySet.page_table, &ekernel, 0x80A00000);
    802018d0:	00000097          	auipc	ra,0x0
    802018d4:	bfa080e7          	jalr	-1030(ra) # 802014ca <push_Map_Area>
}
    802018d8:	60e6                	ld	ra,88(sp)
    802018da:	6446                	ld	s0,80(sp)
    802018dc:	64a6                	ld	s1,72(sp)
    802018de:	6906                	ld	s2,64(sp)
    802018e0:	79e2                	ld	s3,56(sp)
    802018e2:	6125                	addi	sp,sp,96
    802018e4:	8082                	ret

00000000802018e6 <root_ppn_to_token>:

uint64 root_ppn_to_token(uint64 root_ppn){
    802018e6:	1141                	addi	sp,sp,-16
    802018e8:	e422                	sd	s0,8(sp)
    802018ea:	0800                	addi	s0,sp,16
    uint64 eight = 8;     // 我的编译器无法让我正常8 << 60，只能这样
    return (eight << 60) | root_ppn;
}
    802018ec:	6422                	ld	s0,8(sp)
    return (eight << 60) | root_ppn;
    802018ee:	57fd                	li	a5,-1
    802018f0:	17fe                	slli	a5,a5,0x3f
}
    802018f2:	8d5d                	or	a0,a0,a5
    802018f4:	0141                	addi	sp,sp,16
    802018f6:	8082                	ret

00000000802018f8 <activate_mm>:

void activate_mm(){
    802018f8:	1141                	addi	sp,sp,-16
    802018fa:	e422                	sd	s0,8(sp)
    802018fc:	0800                	addi	s0,sp,16
    return (eight << 60) | root_ppn;
    802018fe:	577d                	li	a4,-1
    80201900:	00057797          	auipc	a5,0x57
    80201904:	8287b783          	ld	a5,-2008(a5) # 80258128 <kernel_memorySet>
    80201908:	177e                	slli	a4,a4,0x3f
    8020190a:	8fd9                	or	a5,a5,a4
	asm volatile("csrw satp, %0" : : "r" (x));
    8020190c:	18079073          	csrw	satp,a5
sfence_vma()
{
	// the zero, zero means flush all TLB entries.
	// asm volatile("sfence.vma zero, zero");
	#ifdef QEMU
	asm volatile("sfence.vma");
    80201910:	12000073          	sfence.vma
    uint64 kernel_token = root_ppn_to_token(kernel_memorySet.page_table.root_ppn);
    w_satp(kernel_token);
    sfence_vma();
}
    80201914:	6422                	ld	s0,8(sp)
    80201916:	0141                	addi	sp,sp,16
    80201918:	8082                	ret

000000008020191a <load_elf>:

extern void __alltraps();
extern void __restore(uint64 a0, uint64 a1);


struct User_MemorySet load_elf(uint64 elf_source){
    8020191a:	7131                	addi	sp,sp,-192
    8020191c:	f922                	sd	s0,176(sp)
    8020191e:	f526                	sd	s1,168(sp)
    80201920:	0180                	addi	s0,sp,192
    80201922:	f14a                	sd	s2,160(sp)
    80201924:	ed4e                	sd	s3,152(sp)
    80201926:	e952                	sd	s4,144(sp)
    80201928:	e556                	sd	s5,136(sp)
    8020192a:	e15a                	sd	s6,128(sp)
    8020192c:	fcde                	sd	s7,120(sp)
    8020192e:	f8e2                	sd	s8,112(sp)
    80201930:	f4e6                	sd	s9,104(sp)
    80201932:	f0ea                	sd	s10,96(sp)
    80201934:	ecee                	sd	s11,88(sp)
    80201936:	fd06                	sd	ra,184(sp)
    80201938:	8b2e                	mv	s6,a1
    8020193a:	8c2a                	mv	s8,a0
    struct User_MemorySet user_memory_set;

    user_memory_set.page_table = new_pagetable();
    8020193c:	fffff097          	auipc	ra,0xfffff
    80201940:	72e080e7          	jalr	1838(ra) # 8020106a <new_pagetable>
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;
    80201944:	001b4783          	lbu	a5,1(s6)
    80201948:	000b4a83          	lbu	s5,0(s6)
    8020194c:	036b5b83          	lhu	s7,54(s6)
    80201950:	f4f43423          	sd	a5,-184(s0)
    80201954:	002b4783          	lbu	a5,2(s6)
    80201958:	038b5903          	lhu	s2,56(s6)
    user_memory_set.page_table = new_pagetable();
    8020195c:	00ac3023          	sd	a0,0(s8)
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;
    80201960:	f4f43823          	sd	a5,-176(s0)
    80201964:	003b4783          	lbu	a5,3(s6)

    // check the magic of elf file
    for (int i = 0; i < 4; i++){
    80201968:	4481                	li	s1,0
    8020196a:	4d91                	li	s11,4
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;
    8020196c:	f4f43023          	sd	a5,-192(s0)
    80201970:	020b3783          	ld	a5,32(s6)
        if (i == 0){
            if (ehdr.e_ident[i] != 0x7f){
                panic("[kernel] Wrong elf magic");
            }
        }
        if (i == 1){
    80201974:	4d05                	li	s10,1
            if (ehdr.e_ident[i] != 'E'){
                panic("[kernel] Wrong elf magic");
            }
        }
        if (i == 2){
    80201976:	4989                	li	s3,2
    Elf64_Ehdr ehdr = *(Elf64_Ehdr *)elf_source;
    80201978:	f4f43c23          	sd	a5,-168(s0)
            if (ehdr.e_ident[i] != 'L'){
                panic("[kernel] Wrong elf magic");
    8020197c:	00001c97          	auipc	s9,0x1
    80201980:	98cc8c93          	addi	s9,s9,-1652 # 80202308 <digits+0x280>
            if (ehdr.e_ident[i] != 0x7f){
    80201984:	07f00a13          	li	s4,127
        if (i == 0){
    80201988:	c4e9                	beqz	s1,80201a52 <load_elf+0x138>
        if (i == 1){
    8020198a:	01a48e63          	beq	s1,s10,802019a6 <load_elf+0x8c>
        if (i == 2){
    8020198e:	31349763          	bne	s1,s3,80201c9c <load_elf+0x382>
            if (ehdr.e_ident[i] != 'L'){
    80201992:	f5043783          	ld	a5,-176(s0)
    80201996:	04c00713          	li	a4,76
                panic("[kernel] Wrong elf magic");
    8020199a:	8566                	mv	a0,s9
            if (ehdr.e_ident[i] != 'L'){
    8020199c:	32e79263          	bne	a5,a4,80201cc0 <load_elf+0x3a6>
    for (int i = 0; i < 4; i++){
    802019a0:	448d                	li	s1,3
        if (i == 1){
    802019a2:	ffa496e3          	bne	s1,s10,8020198e <load_elf+0x74>
            if (ehdr.e_ident[i] != 'E'){
    802019a6:	f4843783          	ld	a5,-184(s0)
    802019aa:	04500713          	li	a4,69
    802019ae:	0ae79463          	bne	a5,a4,80201a56 <load_elf+0x13c>
    for (int i = 0; i < 4; i++){
    802019b2:	2485                	addiw	s1,s1,1
    802019b4:	fdb49ae3          	bne	s1,s11,80201988 <load_elf+0x6e>
        }
    }

    uint16 ph_count = ehdr.e_phnum;

    uint64 ptr_ph_table = elf_source + ehdr.e_phoff;
    802019b8:	f5843783          	ld	a5,-168(s0)


    Elf64_Phdr phdr = *(Elf64_Phdr *)ptr_ph_table;
    uint64 base_address = phdr.p_paddr;

    for (int i = 0; i < ph_count; i++){
    802019bc:	00090d9b          	sext.w	s11,s2
    802019c0:	4981                	li	s3,0
    uint64 ptr_ph_table = elf_source + ehdr.e_phoff;
    802019c2:	00fb04b3          	add	s1,s6,a5
    for (int i = 0; i < ph_count; i++){
    802019c6:	0a090263          	beqz	s2,80201a6a <load_elf+0x150>
                push_Map_Area(user_memory_set.rodata, user_memory_set.page_table, copy_start, copy_end);
            }else if (i == 2){
                user_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
                push_Map_Area(user_memory_set.data, user_memory_set.page_table, copy_start, copy_end);
            }else if (i == 3){
                user_memory_set.bss = new_Map_Area(start_va, end_va, 1, permission);
    802019ca:	098c0793          	addi	a5,s8,152
    802019ce:	f4f43423          	sd	a5,-184(s0)
                user_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
    802019d2:	068c0793          	addi	a5,s8,104
    802019d6:	f4f43823          	sd	a5,-176(s0)
                user_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
    802019da:	038c0793          	addi	a5,s8,56
        if (phdr.p_type == 1){   // LOAD
    802019de:	4d05                	li	s10,1
            }else if (i == 2){
    802019e0:	4909                	li	s2,2
                user_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
    802019e2:	f4f43c23          	sd	a5,-168(s0)
                user_memory_set.text = new_Map_Area(start_va, end_va, 1, permission);
    802019e6:	008c0a93          	addi	s5,s8,8
    802019ea:	a029                	j	802019f4 <load_elf+0xda>
    for (int i = 0; i < ph_count; i++){
    802019ec:	2985                	addiw	s3,s3,1
                push_Map_Area(user_memory_set.bss, user_memory_set.page_table, copy_start, copy_end);
            }
        }
        ptr_ph_table += ehdr.e_phentsize;
    802019ee:	94de                	add	s1,s1,s7
    for (int i = 0; i < ph_count; i++){
    802019f0:	07b98d63          	beq	s3,s11,80201a6a <load_elf+0x150>
        if (phdr.p_type == 1){   // LOAD
    802019f4:	4098                	lw	a4,0(s1)
    802019f6:	ffa71be3          	bne	a4,s10,802019ec <load_elf+0xd2>
            uint64 copy_start = phdr.p_offset + elf_source;
    802019fa:	0084bc83          	ld	s9,8(s1)
        Elf64_Phdr phdr = *(Elf64_Phdr *)ptr_ph_table;
    802019fe:	688c                	ld	a1,16(s1)
            uint64 end_va = start_va + phdr.p_memsz;
    80201a00:	7490                	ld	a2,40(s1)
            uint64 permission = 0b1000 | flags;   
    80201a02:	0044e703          	lwu	a4,4(s1)
            uint64 copy_end = copy_start + phdr.p_filesz;
    80201a06:	7094                	ld	a3,32(s1)
            uint64 copy_start = phdr.p_offset + elf_source;
    80201a08:	9cda                	add	s9,s9,s6
            uint64 end_va = start_va + phdr.p_memsz;
    80201a0a:	962e                	add	a2,a2,a1
            uint64 permission = 0b1000 | flags;   
    80201a0c:	00876713          	ori	a4,a4,8
            uint64 copy_end = copy_start + phdr.p_filesz;
    80201a10:	00dc8a33          	add	s4,s9,a3
            if (i == 0){ // map text
    80201a14:	22098b63          	beqz	s3,80201c4a <load_elf+0x330>
            }else if (i == 1){
    80201a18:	2ba98a63          	beq	s3,s10,80201ccc <load_elf+0x3b2>
            }else if (i == 2){
    80201a1c:	2d298e63          	beq	s3,s2,80201cf8 <load_elf+0x3de>
            }else if (i == 3){
    80201a20:	478d                	li	a5,3
    80201a22:	fcf995e3          	bne	s3,a5,802019ec <load_elf+0xd2>
                user_memory_set.bss = new_Map_Area(start_va, end_va, 1, permission);
    80201a26:	f4843503          	ld	a0,-184(s0)
    80201a2a:	4685                	li	a3,1
    80201a2c:	00000097          	auipc	ra,0x0
    80201a30:	a08080e7          	jalr	-1528(ra) # 80201434 <new_Map_Area>
                push_Map_Area(user_memory_set.bss, user_memory_set.page_table, copy_start, copy_end);
    80201a34:	000c3583          	ld	a1,0(s8)
    80201a38:	098c3283          	ld	t0,152(s8)
    80201a3c:	0a0c3f83          	ld	t6,160(s8)
    80201a40:	0a8c3f03          	ld	t5,168(s8)
    80201a44:	0b0c3e83          	ld	t4,176(s8)
    80201a48:	0b8c3e03          	ld	t3,184(s8)
    80201a4c:	0c0c3703          	ld	a4,192(s8)
    80201a50:	a40d                	j	80201c72 <load_elf+0x358>
            if (ehdr.e_ident[i] != 0x7f){
    80201a52:	014a8763          	beq	s5,s4,80201a60 <load_elf+0x146>
                panic("[kernel] Wrong elf magic");
    80201a56:	8566                	mv	a0,s9
    80201a58:	fffff097          	auipc	ra,0xfffff
    80201a5c:	856080e7          	jalr	-1962(ra) # 802002ae <panic>
    for (int i = 0; i < 4; i++){
    80201a60:	2485                	addiw	s1,s1,1
    80201a62:	f5b48be3          	beq	s1,s11,802019b8 <load_elf+0x9e>
        if (i == 0){
    80201a66:	f095                	bnez	s1,8020198a <load_elf+0x70>
    80201a68:	b7ed                	j	80201a52 <load_elf+0x138>
    // Then, map user stack low and user stack high(trap context)
    // low
    uint64 start_va = UserStack_LOW_0;
    uint64 end_va = start_va + USER_STACK_SIZE;

    user_memory_set.UserStackLow = new_Map_Area(start_va, end_va, 1, 0b1011);
    80201a6a:	0f8c0513          	addi	a0,s8,248
    80201a6e:	472d                	li	a4,11
    80201a70:	4685                	li	a3,1
    80201a72:	00059617          	auipc	a2,0x59
    80201a76:	bae60613          	addi	a2,a2,-1106 # 8025a620 <kernel_frame_end>
    80201a7a:	00058597          	auipc	a1,0x58
    80201a7e:	ba658593          	addi	a1,a1,-1114 # 80259620 <UserStack_LOW_0>
    80201a82:	00000097          	auipc	ra,0x0
    80201a86:	9b2080e7          	jalr	-1614(ra) # 80201434 <new_Map_Area>
    push_Map_Area(user_memory_set.UserStackLow, user_memory_set.page_table, start_va, end_va);
    80201a8a:	0f8c3e83          	ld	t4,248(s8)
    80201a8e:	100c3e03          	ld	t3,256(s8)
    80201a92:	108c3303          	ld	t1,264(s8)
    80201a96:	110c3883          	ld	a7,272(s8)
    80201a9a:	118c3803          	ld	a6,280(s8)
    80201a9e:	000c3583          	ld	a1,0(s8)
    80201aa2:	120c3703          	ld	a4,288(s8)
    80201aa6:	f6040513          	addi	a0,s0,-160
    80201aaa:	00059697          	auipc	a3,0x59
    80201aae:	b7668693          	addi	a3,a3,-1162 # 8025a620 <kernel_frame_end>
    80201ab2:	00058617          	auipc	a2,0x58
    80201ab6:	b6e60613          	addi	a2,a2,-1170 # 80259620 <UserStack_LOW_0>
    80201aba:	f7d43023          	sd	t4,-160(s0)
    80201abe:	f7c43423          	sd	t3,-152(s0)
    80201ac2:	f6643823          	sd	t1,-144(s0)
    80201ac6:	f7143c23          	sd	a7,-136(s0)
    80201aca:	f9043023          	sd	a6,-128(s0)
    80201ace:	f8e43423          	sd	a4,-120(s0)
    80201ad2:	00000097          	auipc	ra,0x0
    80201ad6:	9f8080e7          	jalr	-1544(ra) # 802014ca <push_Map_Area>
    // High
    start_va = UserStack_HIGH_0;
    end_va = start_va + 1024;


    user_memory_set.UserStackHigh = new_Map_Area(start_va, end_va, 1, 0b0011);
    80201ada:	128c0513          	addi	a0,s8,296
    80201ade:	470d                	li	a4,3
    80201ae0:	4685                	li	a3,1
    80201ae2:	00057617          	auipc	a2,0x57
    80201ae6:	b3e60613          	addi	a2,a2,-1218 # 80258620 <KernerlStack>
    80201aea:	00056597          	auipc	a1,0x56
    80201aee:	73658593          	addi	a1,a1,1846 # 80258220 <UserStack_HIGH_0>
    80201af2:	00000097          	auipc	ra,0x0
    80201af6:	942080e7          	jalr	-1726(ra) # 80201434 <new_Map_Area>
    push_Map_Area(user_memory_set.UserStackHigh, user_memory_set.page_table, start_va, end_va);
    80201afa:	128c3e83          	ld	t4,296(s8)
    80201afe:	130c3e03          	ld	t3,304(s8)
    80201b02:	138c3303          	ld	t1,312(s8)
    80201b06:	140c3883          	ld	a7,320(s8)
    80201b0a:	148c3803          	ld	a6,328(s8)
    80201b0e:	000c3583          	ld	a1,0(s8)
    80201b12:	150c3703          	ld	a4,336(s8)
    80201b16:	f6040513          	addi	a0,s0,-160
    80201b1a:	00057697          	auipc	a3,0x57
    80201b1e:	b0668693          	addi	a3,a3,-1274 # 80258620 <KernerlStack>
    80201b22:	00056617          	auipc	a2,0x56
    80201b26:	6fe60613          	addi	a2,a2,1790 # 80258220 <UserStack_HIGH_0>
    80201b2a:	f7d43023          	sd	t4,-160(s0)
    80201b2e:	f7c43423          	sd	t3,-152(s0)
    80201b32:	f6643823          	sd	t1,-144(s0)
    80201b36:	f7143c23          	sd	a7,-136(s0)
    80201b3a:	f9043023          	sd	a6,-128(s0)
    80201b3e:	f8e43423          	sd	a4,-120(s0)
    80201b42:	00000097          	auipc	ra,0x0
    80201b46:	988080e7          	jalr	-1656(ra) # 802014ca <push_Map_Area>

    start_va = __restore;
    end_va = start_va + 1024;
    user_memory_set.Trampline = new_Map_Area(start_va, end_va, 0, 0b0101);
    80201b4a:	158c0513          	addi	a0,s8,344
    80201b4e:	4715                	li	a4,5
    80201b50:	4681                	li	a3,0
    80201b52:	fffff617          	auipc	a2,0xfffff
    80201b56:	4c660613          	addi	a2,a2,1222 # 80201018 <schedule+0xce>
    80201b5a:	fffff597          	auipc	a1,0xfffff
    80201b5e:	0be58593          	addi	a1,a1,190 # 80200c18 <__restore>
    80201b62:	00000097          	auipc	ra,0x0
    80201b66:	8d2080e7          	jalr	-1838(ra) # 80201434 <new_Map_Area>
    push_Map_Area(user_memory_set.Trampline, user_memory_set.page_table, start_va, end_va);
    80201b6a:	158c3e83          	ld	t4,344(s8)
    80201b6e:	160c3e03          	ld	t3,352(s8)
    80201b72:	168c3303          	ld	t1,360(s8)
    80201b76:	170c3883          	ld	a7,368(s8)
    80201b7a:	178c3803          	ld	a6,376(s8)
    80201b7e:	000c3583          	ld	a1,0(s8)
    80201b82:	180c3703          	ld	a4,384(s8)
    80201b86:	f6040513          	addi	a0,s0,-160
    80201b8a:	fffff697          	auipc	a3,0xfffff
    80201b8e:	48e68693          	addi	a3,a3,1166 # 80201018 <schedule+0xce>
    80201b92:	fffff617          	auipc	a2,0xfffff
    80201b96:	08660613          	addi	a2,a2,134 # 80200c18 <__restore>
    80201b9a:	f7d43023          	sd	t4,-160(s0)
    80201b9e:	f7c43423          	sd	t3,-152(s0)
    80201ba2:	f6643823          	sd	t1,-144(s0)
    80201ba6:	f7143c23          	sd	a7,-136(s0)
    80201baa:	f9043023          	sd	a6,-128(s0)
    80201bae:	f8e43423          	sd	a4,-120(s0)
    80201bb2:	00000097          	auipc	ra,0x0
    80201bb6:	918080e7          	jalr	-1768(ra) # 802014ca <push_Map_Area>


    // map kernel stack
    start_va = KernerlStack;
    end_va = start_va + KERNEL_STACK_SIZE;
    user_memory_set.Kernel_Stack = new_Map_Area(start_va, end_va, 1, 0b0011);
    80201bba:	188c0513          	addi	a0,s8,392
    80201bbe:	470d                	li	a4,3
    80201bc0:	4685                	li	a3,1
    80201bc2:	00058617          	auipc	a2,0x58
    80201bc6:	a5e60613          	addi	a2,a2,-1442 # 80259620 <UserStack_LOW_0>
    80201bca:	00057597          	auipc	a1,0x57
    80201bce:	a5658593          	addi	a1,a1,-1450 # 80258620 <KernerlStack>
    80201bd2:	00000097          	auipc	ra,0x0
    80201bd6:	862080e7          	jalr	-1950(ra) # 80201434 <new_Map_Area>
    push_Map_Area(user_memory_set.Kernel_Stack, user_memory_set.page_table, start_va, end_va);
    80201bda:	000c3583          	ld	a1,0(s8)
    80201bde:	188c3e83          	ld	t4,392(s8)
    80201be2:	190c3e03          	ld	t3,400(s8)
    80201be6:	198c3303          	ld	t1,408(s8)
    80201bea:	1a0c3883          	ld	a7,416(s8)
    80201bee:	1a8c3803          	ld	a6,424(s8)
    80201bf2:	1b0c3703          	ld	a4,432(s8)
    80201bf6:	f6040513          	addi	a0,s0,-160
    80201bfa:	00058697          	auipc	a3,0x58
    80201bfe:	a2668693          	addi	a3,a3,-1498 # 80259620 <UserStack_LOW_0>
    80201c02:	00057617          	auipc	a2,0x57
    80201c06:	a1e60613          	addi	a2,a2,-1506 # 80258620 <KernerlStack>
    80201c0a:	f7d43023          	sd	t4,-160(s0)
    80201c0e:	f7c43423          	sd	t3,-152(s0)
    80201c12:	f6643823          	sd	t1,-144(s0)
    80201c16:	f7143c23          	sd	a7,-136(s0)
    80201c1a:	f9043023          	sd	a6,-128(s0)
    80201c1e:	f8e43423          	sd	a4,-120(s0)
    80201c22:	00000097          	auipc	ra,0x0
    80201c26:	8a8080e7          	jalr	-1880(ra) # 802014ca <push_Map_Area>

    return user_memory_set;
    80201c2a:	70ea                	ld	ra,184(sp)
    80201c2c:	744a                	ld	s0,176(sp)
    80201c2e:	74aa                	ld	s1,168(sp)
    80201c30:	790a                	ld	s2,160(sp)
    80201c32:	69ea                	ld	s3,152(sp)
    80201c34:	6a4a                	ld	s4,144(sp)
    80201c36:	6aaa                	ld	s5,136(sp)
    80201c38:	6b0a                	ld	s6,128(sp)
    80201c3a:	7be6                	ld	s7,120(sp)
    80201c3c:	7ca6                	ld	s9,104(sp)
    80201c3e:	7d06                	ld	s10,96(sp)
    80201c40:	6de6                	ld	s11,88(sp)
    80201c42:	8562                	mv	a0,s8
    80201c44:	7c46                	ld	s8,112(sp)
    80201c46:	6129                	addi	sp,sp,192
    80201c48:	8082                	ret
                user_memory_set.text = new_Map_Area(start_va, end_va, 1, permission);
    80201c4a:	8556                	mv	a0,s5
    80201c4c:	4685                	li	a3,1
    80201c4e:	fffff097          	auipc	ra,0xfffff
    80201c52:	7e6080e7          	jalr	2022(ra) # 80201434 <new_Map_Area>
                push_Map_Area(user_memory_set.text, user_memory_set.page_table, copy_start, copy_end);
    80201c56:	000c3583          	ld	a1,0(s8)
    80201c5a:	008c3283          	ld	t0,8(s8)
    80201c5e:	010c3f83          	ld	t6,16(s8)
    80201c62:	018c3f03          	ld	t5,24(s8)
    80201c66:	020c3e83          	ld	t4,32(s8)
    80201c6a:	028c3e03          	ld	t3,40(s8)
    80201c6e:	030c3703          	ld	a4,48(s8)
                push_Map_Area(user_memory_set.bss, user_memory_set.page_table, copy_start, copy_end);
    80201c72:	86d2                	mv	a3,s4
    80201c74:	8666                	mv	a2,s9
    80201c76:	f6040513          	addi	a0,s0,-160
    80201c7a:	f6543023          	sd	t0,-160(s0)
    80201c7e:	f7f43423          	sd	t6,-152(s0)
    80201c82:	f7e43823          	sd	t5,-144(s0)
    80201c86:	f7d43c23          	sd	t4,-136(s0)
    80201c8a:	f9c43023          	sd	t3,-128(s0)
    80201c8e:	f8e43423          	sd	a4,-120(s0)
    80201c92:	00000097          	auipc	ra,0x0
    80201c96:	838080e7          	jalr	-1992(ra) # 802014ca <push_Map_Area>
    80201c9a:	bb89                	j	802019ec <load_elf+0xd2>
        if (i == 3){
    80201c9c:	478d                	li	a5,3
    80201c9e:	dcf491e3          	bne	s1,a5,80201a60 <load_elf+0x146>
            if (ehdr.e_ident[i] != 'F'){
    80201ca2:	f4043783          	ld	a5,-192(s0)
    80201ca6:	04600713          	li	a4,70
    80201caa:	d0e787e3          	beq	a5,a4,802019b8 <load_elf+0x9e>
                panic("[kernel] Wrong elf magic");
    80201cae:	00000517          	auipc	a0,0x0
    80201cb2:	65a50513          	addi	a0,a0,1626 # 80202308 <digits+0x280>
    80201cb6:	ffffe097          	auipc	ra,0xffffe
    80201cba:	5f8080e7          	jalr	1528(ra) # 802002ae <panic>
    80201cbe:	b9ed                	j	802019b8 <load_elf+0x9e>
                panic("[kernel] Wrong elf magic");
    80201cc0:	ffffe097          	auipc	ra,0xffffe
    80201cc4:	5ee080e7          	jalr	1518(ra) # 802002ae <panic>
    for (int i = 0; i < 4; i++){
    80201cc8:	448d                	li	s1,3
    80201cca:	b9e1                	j	802019a2 <load_elf+0x88>
                user_memory_set.rodata = new_Map_Area(start_va, end_va, 1, permission);
    80201ccc:	f5843503          	ld	a0,-168(s0)
    80201cd0:	4685                	li	a3,1
    80201cd2:	fffff097          	auipc	ra,0xfffff
    80201cd6:	762080e7          	jalr	1890(ra) # 80201434 <new_Map_Area>
                push_Map_Area(user_memory_set.rodata, user_memory_set.page_table, copy_start, copy_end);
    80201cda:	000c3583          	ld	a1,0(s8)
    80201cde:	038c3283          	ld	t0,56(s8)
    80201ce2:	040c3f83          	ld	t6,64(s8)
    80201ce6:	048c3f03          	ld	t5,72(s8)
    80201cea:	050c3e83          	ld	t4,80(s8)
    80201cee:	058c3e03          	ld	t3,88(s8)
    80201cf2:	060c3703          	ld	a4,96(s8)
    80201cf6:	bfb5                	j	80201c72 <load_elf+0x358>
                user_memory_set.data = new_Map_Area(start_va, end_va, 1, permission);
    80201cf8:	f5043503          	ld	a0,-176(s0)
    80201cfc:	4685                	li	a3,1
    80201cfe:	fffff097          	auipc	ra,0xfffff
    80201d02:	736080e7          	jalr	1846(ra) # 80201434 <new_Map_Area>
                push_Map_Area(user_memory_set.data, user_memory_set.page_table, copy_start, copy_end);
    80201d06:	000c3583          	ld	a1,0(s8)
    80201d0a:	068c3283          	ld	t0,104(s8)
    80201d0e:	070c3f83          	ld	t6,112(s8)
    80201d12:	078c3f03          	ld	t5,120(s8)
    80201d16:	080c3e83          	ld	t4,128(s8)
    80201d1a:	088c3e03          	ld	t3,136(s8)
    80201d1e:	090c3703          	ld	a4,144(s8)
    80201d22:	bf81                	j	80201c72 <load_elf+0x358>
