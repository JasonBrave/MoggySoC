.global get_mstatus
.global get_misa
.global get_mcycle
.global get_mcycleh
.global get_mvendorid
.global get_marchid
.global get_mimpid
.global get_mhartid
.section .text, "ax", @progbits

get_mstatus:
	csrr a0, mstatus
	ret

get_misa:
	csrr a0, misa
	ret

get_mcycle:
	csrr a0, mcycle
	ret

get_mcycleh:
	csrr a0, mcycleh
	ret

get_mvendorid:
	csrr a0, mvendorid
	ret

get_marchid:
	csrr a0, marchid
	ret

get_mimpid:
	csrr a0, mimpid
	ret

get_mhartid:
	csrr a0, mhartid
	ret
