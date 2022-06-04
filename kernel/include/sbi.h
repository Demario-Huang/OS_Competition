#ifndef __RISCV_SBI_H
#define __RISCV_SBI_H

#include "types.h"
#include "printf.h"

#define LEGACY_SBI_CALL(eid, arg0) ({ \
	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0); \
	register uintptr_t a7 asm ("a7") = (uintptr_t)(eid); \
	asm volatile ("ecall" \
		      : "+r" (a0) \
		      : "r" (a7) \
		      : "memory"); \
	a0; \
})

// Legacy Extensions
// Only part of these extensions are used
#define SBI_SET_TIMER 			0
#define SBI_CONSOLE_PUTCHAR 	1
#define SBI_CONSOLE_GETCHAR 	2
#define SBI_SHUTDOWN 			8

static inline void sbi_console_putchar(int ch) {
	LEGACY_SBI_CALL(SBI_CONSOLE_PUTCHAR, ch);
}

static inline int sbi_console_getchar(void) {
	return LEGACY_SBI_CALL(SBI_CONSOLE_GETCHAR, 0);
}

static inline void sbi_shutdown(void) {
	LEGACY_SBI_CALL(SBI_SHUTDOWN, 0);
}


struct sbiret {
	long error;
	long value;
};

#define SBI_CALL(eid, fid, arg0, arg1, arg2, arg3) ({ \
	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0); \
	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1); \
	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2); \
	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3); \
	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid); \
	register uintptr_t a7 asm ("a7") = (uintptr_t)(eid); \
	asm volatile ("ecall" \
			: "+r" (a0), "+r" (a1) \
			: "r" (a2), "r" (a3), "r" (a6), "r" (a7) \
			: "memory"); \
	(struct sbiret){.error = (long)a0, .value = (long)a1}; \
})

#define SBI_CALL_0(eid, fid) \
	SBI_CALL(eid, fid, 0, 0, 0, 0)
#define SBI_CALL_1(eid, fid, arg0) \
	SBI_CALL(eid, fid, arg0, 0, 0, 0) 

// Time Extension 

#define TIME_EID 	0x54494d45
#define TIME_SET_TIMER 	0

static inline struct sbiret sbi_set_timer(uint64 stime_value) {
	return SBI_CALL_1(0, TIME_SET_TIMER, stime_value);
}


#endif 