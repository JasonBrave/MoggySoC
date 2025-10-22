#include <stdint.h>

struct UARTLiteRegs {
	volatile uint32_t rx_fifo;
	volatile uint32_t tx_fifo;
	volatile uint32_t stat_reg;
	volatile uint32_t ctrl_reg;
} *const uartlite_regs = (struct UARTLiteRegs *)0x80000000;

void putstring(const char *s) {
	while (*s) {
		uartlite_regs->tx_fifo = *s;
		s++;
	}
}

void fwmain(void) {
	for (;;) {
		putstring("MoggySoC\n");
	}
}
