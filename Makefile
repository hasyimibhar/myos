C_SOURCES = $(wildcard kernel/*.c)
OBJ = $(C_SOURCES:.c=.o)

all: os-image

run: all
	qemu-system-x86_64 --curses os-image

run-graphic:
	qemu-system-x86_64 os-image

os-image: boot/boot_sect.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c
	gcc -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf64 -o $@

%.bin: %.asm
	nasm $< -f bin -I 'boot/' -o $@

clean:
	rm -f *.o *.bin os-image
	rm -f kernel/*.o boot/*.bin

