

#define __module_name__ 	"main"

#include "printf.h"
#include "panic.h"

void main() {
    printf("Hello, World!\n");
    panic("Stop!\n");
    while (1) {}
}
