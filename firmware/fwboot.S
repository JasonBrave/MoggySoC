.global _start
.section .text.start, "ax", @progbits

_intr_vector_table:

.skip 0x80, 0x0

_start:
	# Copy .text to ITCM
	la t0, _text_load
	la t1, _text_begin
	la t2, _text_end
_text_copy_loop:
	addi sp, t0, 0
	lw x8, 0(sp)
	lw x9, 4(sp)
	lw x10, 8(sp)
	lw x11, 12(sp)
	lw x12, 16(sp)
	lw x13, 20(sp)
	lw x14, 24(sp)
	lw x15, 28(sp)
	addi sp, t1, 0
	sw x8, 0(sp)
	sw x9, 4(sp)
	sw x10, 8(sp)
	sw x11, 12(sp)
	sw x12, 16(sp)
	sw x13, 20(sp)
	sw x14, 24(sp)
	sw x15, 28(sp)
	addi t0, t0, 32
	addi t1, t1, 32
	bne t1, t2, _text_copy_loop

	# Copy .rodata to DTCM
	la t0, _rodata_load
	la t1, _rodata_begin
	la t2, _rodata_end
_rodata_copy_loop:
	addi sp, t0, 0
	lw x8, 0(sp)
	lw x9, 4(sp)
	lw x10, 8(sp)
	lw x11, 12(sp)
	lw x12, 16(sp)
	lw x13, 20(sp)
	lw x14, 24(sp)
	lw x15, 28(sp)
	addi sp, t1, 0
	sw x8, 0(sp)
	sw x9, 4(sp)
	sw x10, 8(sp)
	sw x11, 12(sp)
	sw x12, 16(sp)
	sw x13, 20(sp)
	sw x14, 24(sp)
	sw x15, 28(sp)
	addi t0, t0, 32
	addi t1, t1, 32
	bne t1, t2, _rodata_copy_loop

	# Copy .data to DTCM
	la t0, _data_load
	la t1, _data_begin
	la t2, _data_end
_data_copy_loop:
	addi sp, t0, 0
	lw x8, 0(sp)
	lw x9, 4(sp)
	lw x10, 8(sp)
	lw x11, 12(sp)
	lw x12, 16(sp)
	lw x13, 20(sp)
	lw x14, 24(sp)
	lw x15, 28(sp)
	addi sp, t1, 0
	sw x8, 0(sp)
	sw x9, 4(sp)
	sw x10, 8(sp)
	sw x11, 12(sp)
	sw x12, 16(sp)
	sw x13, 20(sp)
	sw x14, 24(sp)
	sw x15, 28(sp)
	addi t0, t0, 32
	addi t1, t1, 32
	bne t1, t2, _data_copy_loop

_start_fwmain:
	# Set up stack pointer
	la sp, _stack_top

	# Jump to C code
	call fwmain
	j .
	nop
