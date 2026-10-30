#include <stdint.h>

volatile uint8_t *const led_output = (volatile uint8_t *)0x80000014;

uint32_t data_section_a = 12;
uint16_t data_section_b = 23;

const uint32_t rodata_section_a = 34;
const uint16_t rodata_section_b = 45;

uint32_t bss_section_a;
uint16_t bss_section_b;

void fwmain(void) {
	uint8_t led = 'Z';

	for (;;) {
		if (led == 'Z') {
			led = 'A';
		} else {
			led += 1;
		}
		*led_output = led;
	}
}
