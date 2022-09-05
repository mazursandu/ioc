ASM = nasm
ASM_FLAGS = -I/usr/share/sasm/include/ -f elf32 -g -Fdwarf
CC = gcc
CFLAGS = -g -Wall -m32 -Wno-implicit-function-declaration
LDFLAGS = -m32

.PHONY: all clean

all: num_bits

num_bits: num_bits.o macro.o

num_bits.o: num_bits.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

macro.o: /usr/share/sasm/NASM/macro.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	-rm -f *~
	-rm -f macro.o
	-rm -f num_bits.o num_bits
