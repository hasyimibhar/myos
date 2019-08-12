start: os-image
	qemu-system-x86_64 --curses os-image

os-image: boot_sect.bin kernel.bin
	cat boot_sect.bin kernel.bin > os-image

boot_sect.bin:
	nasm -f bin boot_sect.asm -o boot_sect.bin

kernel.bin: kernel.o
	ld -o kernel.bin -Ttext 0x1000 --oformat binary kernel.o

kernel.o:
	gcc -ffreestanding -c kernel.c -o kernel.o

clean:
	rm -f *.o
	rm -f *.bin
	rm -f os-image
