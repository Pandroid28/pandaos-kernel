.set MAGIC,    0x1BADB002
.set FLAGS,    (1 << 0 | 1 << 1)  # Alinear módulos y proveer info de memoria
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .text
.global _start
_start:
    mov $stack_top, %esp
    call kernel_main
    cli
1:  hlt
    jmp 1b

.section .bss
.align 16
stack_bottom:
.skip 16384  # 16KB de pila
stack_top: