#include <stdarg.h>

#include "console.h"
#include "printf.h"

static char digits[] = "0123456789abcdef";



void printf(char *fmt, ...){
	char c;
	va_list ap;
	va_start(ap, fmt);
	char integer = 'x';
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
		if (c != '%'){
			consputc(c);
			continue;
		}
		c = fmt[++i];
		switch(c){
			case 'd':
				integer = digits[va_arg(ap, int)];
				consputc(integer);
		}
	}
}