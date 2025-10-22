.global _start
.section .text.start, "ax", @progbits

.skip 0x80, 0x0

_start:
	add x0, x0, x0
	li sp, 0x40010000
	
	jal fwmain
	
	j .
