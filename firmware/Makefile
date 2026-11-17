OBJS := \
    fwboot.o \
	fwmain.o \
	printf.o \
	csr_helper.o \
	coremark/coremark/core_main.o \
	coremark/coremark/core_list_join.o \
	coremark/coremark/core_matrix.o \
	coremark/coremark/core_util.o \
	coremark/coremark/core_state.o \
	core_portme.o

CFLAGS := -ffreestanding -march=rv32imc -mabi=ilp32 -msmall-data-limit=0 -I. -Icoremark/coremark -g

fw.hex: fw.bin
	./bin2hex.py

fw.bin: fw.elf
	riscv32-elf-objcopy -O binary fw.elf fw.bin

fw.elf: $(OBJS) firmware.ld
	riscv32-elf-ld -T firmware.ld $(OBJS) $$(riscv32-elf-gcc -ffreestanding -march=rv32imc -mabi=ilp32 -msmall-data-limit=0 -print-libgcc-file-name) -o fw.elf

fwboot.o: fwboot.S
	riscv32-elf-as fwboot.S -o fwboot.o -march=rv32imc_zicsr -mabi=ilp32 -g

csr_helper.o: csr_helper.S
	riscv32-elf-as csr_helper.S -o csr_helper.o -march=rv32imc_zicsr -mabi=ilp32 -g

%.o: %.c
	riscv32-elf-gcc $(CFLAGS) -c $< -o $@ -O2 -mabi=ilp32

.PHONY: clean
clean:
	rm -rf *.o *.elf *.bin *.hex
