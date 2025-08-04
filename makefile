# Tools
CC = i686-elf-gcc
AS = i686-elf-as
LD = i686-elf-ld

# Files
BOOT_SRC = src/boot.s
BOOT_OBJ = build/boot.o
KERNEL_SRC = src/kernel.c
KERNEL_OBJ = build/kernel.o
KERNEL_BIN = build/kernel.bin
ISO_DIR = build/iso
ISO_FILE = build/pandaos.iso

# Flags
ASFLAGS = 
CFLAGS = -ffreestanding -m32 -nostdlib -Wall -Wextra
LDFLAGS = -T linker.ld -nostdlib

.PHONY: all clean

all: $(ISO_FILE)

$(ISO_FILE): $(KERNEL_BIN) boot/grub/grub.cfg
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL_BIN) $(ISO_DIR)/boot/kernel.bin
	cp boot/grub/grub.cfg $(ISO_DIR)/boot/grub/
	grub-mkrescue -o $(ISO_FILE) $(ISO_DIR)

$(BOOT_OBJ): $(BOOT_SRC)
	mkdir -p build
	$(AS) $(ASFLAGS) $< -o $@

$(KERNEL_OBJ): $(KERNEL_SRC)
	mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL_BIN): $(BOOT_OBJ) $(KERNEL_OBJ)
	$(LD) $(LDFLAGS) $^ -o $@

clean:
	rm -rf build