OBJS := \
    fwboot.o \
	fwmain.o \
	printf.o \
	csr_helper.o

CFLAGS := -ffreestanding -march=rv32imc -msmall-data-limit=0

fw.hex: fw.bin
	./bin2hex.py

fw.bin: fw.elf
	riscv32-elf-objcopy -O binary fw.elf fw.bin

fw.elf: $(OBJS) firmware.ld
	riscv32-elf-ld -T firmware.ld $(OBJS) -o fw.elf

fwboot.o: fwboot.S
	riscv32-elf-as fwboot.S -o fwboot.o -march=rv32imc_zicsr -mabi=ilp32

csr_helper.o: csr_helper.S
	riscv32-elf-as csr_helper.S -o csr_helper.o -march=rv32imc_zicsr -mabi=ilp32

%.o: %.c
	riscv32-elf-gcc $(CFLAGS) -c $< -o $@ -O2 -mabi=ilp32

.PHONY: clean
clean:
	rm -rf *.o *.elf *.bin *.hex
