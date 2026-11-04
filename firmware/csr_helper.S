.global get_mvendorid
.section .text, "ax", @progbits

get_mvendorid:
	csrr a0, mvendorid
	ret
