ASM = nasm
ASM_FLAGS = -I/usr/share/sasm/include/ -f elf32 -g -Fdwarf
CC = gcc
CFLAGS = -g -Wall -m32 -Wno-implicit-function-declaration
LDFLAGS = -m32

.PHONY: all clean

all: num_bits

num_bits: num_bits.o

num_bits.o: num_bits.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

clean:
	-rm -f *~
	-rm -f num_bits.o num_bits
