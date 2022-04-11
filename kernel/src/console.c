#define __module_name__ 	"console"

#include "sbi.h"
#include "console.h"

#define BACKSPACE 0x100

void consputc(int c) {
	if(c == BACKSPACE){
		sbi_console_putchar('\b');
		sbi_console_putchar(' ');
		sbi_console_putchar('\b');
	} else {
		sbi_console_putchar(c);
	}
}