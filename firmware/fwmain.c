#include <stdint.h>

volatile uint32_t *const led_output = (volatile uint32_t *)0x40000014;

uint32_t data_section_a = 12;
uint16_t data_section_b = 23;

const uint32_t rodata_section_a = 34;
const uint16_t rodata_section_b = 45;

uint32_t bss_section_a;
uint16_t bss_section_b;

void fwmain(void) {
	for (;;) {
		for (uint64_t i = 0; i < 8200ULL * 100ULL; i++) {}
		*led_output = (*led_output + 1) & 0xf;
	}
}
