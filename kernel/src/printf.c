#include "console.h"
#include "printf.h"

char c;
void printf(char *fmt, ...){
    for(int i = 0; (c = fmt[i] & 0xff) != 0; i++){
		consputc(c);
	}
}