.global _start
.section .text.start, "ax", @progbits

_intr_vector_table:

.skip 0x80, 0x0

_start:
	nop
	nop
	nop
	j _start
