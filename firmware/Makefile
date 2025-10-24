OBJS := \
    fwboot.o \
	fwmain.o

CFLAGS := -ffreestanding -march=rv32i

fw.hex: fw.bin
	./bin2hex.py

fw.bin: fw.elf
	riscv32-elf-objcopy -O binary --only-section=.text fw.elf fw.bin

fw.elf: $(OBJS) firmware.ld
	riscv32-elf-ld -T firmware.ld $(OBJS) -o fw.elf

fwboot.o: fwboot.S
	riscv32-elf-as fwboot.S -o fwboot.o -march=rv32im -mabi=ilp32

%.o: %.c
	riscv32-elf-gcc $(CFLAGS) -c $< -o $@ -O2 -march=rv32im -mabi=ilp32

.PHONY: clean
clean:
	rm -rf *.o *.elf *.bin *.hex
