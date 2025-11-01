#include <stdint.h>

volatile uint32_t *const led_output = (volatile uint32_t *)0x80000008;

void fwmain(void) {
	for (;;) {
		for (int i = 0; i < 100; i++) {}
		*led_output = *led_output + 1;
	}
}
