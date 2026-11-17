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

uint32_t get_mstatus(void);
uint32_t get_misa(void);
uint32_t get_mcycle(void);
uint32_t get_mcycleh(void);
uint32_t get_mvendorid(void);
uint32_t get_marchid(void);
uint32_t get_mimpid(void);
uint32_t get_mhartid(void);

extern void main(void);

void fwmain(void) {
	uint8_t ch = 'Z';

	printf("mstatus = %x\n", get_mstatus());
	printf("misa = %x\n", get_misa());
	printf("mcycle = %x\n", get_mcycle());
	printf("mcycleh = %x\n", get_mcycleh());
	printf("mvendorid = %x\n", get_mvendorid());
	printf("marchid = %x\n", get_marchid());
	printf("mimpid = %x\n", get_mimpid());
	printf("mhartid = %x\n", get_mhartid());

	main();

	for (;;) {}
}
