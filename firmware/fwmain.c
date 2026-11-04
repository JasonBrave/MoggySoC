#include <stdint.h>

#include "printf.h"

volatile uint8_t *const led_output = (volatile uint8_t *)0x80000014;

uint32_t data_section_a = 12;
uint16_t data_section_b = 23;

const uint32_t rodata_section_a = 34;
const uint16_t rodata_section_b = 45;

uint32_t bss_section_a;
uint16_t bss_section_b;

void putchar(char c) {
	*led_output = c;
}

uint32_t get_mvendorid(void);

void fwmain(void) {
	uint8_t ch = 'Z';

	printf("mvendorid = %x\n", get_mvendorid());

	for (;;) {
		if (ch == 'Z') {
			ch = 'A';
		} else {
			ch += 1;
		}
		putchar(ch);
	}
}
