#include <stdarg.h>

#include "console.h"
#include "printf.h"
#include "types.h"

static char digits[] = "0123456789abcdef";



void printf(char *fmt, ...){
	char c;
	uint64 print_num = 0;
	va_list ap;
	va_start(ap, fmt);
	char buf[16];
	int index = 0;
	uint64 integer = 0;
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
		if (c != '%'){
			consputc(c);
			continue;
		}
		c = fmt[++i];
		switch(c){
			case 'd':
				integer = va_arg(ap, int);
				print_num = 0;
				if (integer == 0){
					consputc('0');
				}
				index = 0;
				while (integer > 0) {
					print_num = integer % 10;
					buf[index] = print_num;
					index += 1;
					integer /= 10;
				}
				index -= 1;
				while (index >= 0){
					consputc(digits[buf[index]]);
					index -= 1;
				}
				break;
			case 'x':
				consputc('0');
				consputc('x');
				integer = va_arg(ap, int);
				print_num = 0;
				if (integer == 0){
					consputc('0');
				}
				index = 0;
				while (integer > 0) {
					print_num = integer % 16;
					buf[index] = print_num;
					index += 1;
					integer /= 16;
				}
				index -= 1;
				while (index >= 0){
					consputc(digits[buf[index]]);
					index -= 1;
				}
				break;
			case 'c':
				buf[0] = va_arg(ap, int);
				consputc(buf[0]);
				break;
		}
	}
}