#Assembly file for myOS to preset CPU instruction kernel is loaded by bootloader

.set MAGIC, 0x1badb002  # magical number so bootloader recognize kernel
.set FLAGS, (1<<0 | 1<<1)
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot     # before bootloader runs kernel, it will store multiboot structure (like size of your RAM, etc.)
    .long MAGIC
    .long FLAGS
    .long CHECKSUM

.section .text          # read-only section

.extern kernelMain      # refers to kernelMain in kernel.cpp file

.global loader


loader:
    mov $kernel_stack, %esp     # assign kernel stack pointer to register esp
    push %eax           #push register ax value (multiboot struct) to kernelMain
    push %ebx           #push register bx value (magic number) to kernelMain
    call kernelMain
    
    
_stop:
    cli
    hlt
    jmp _stop

.section .bss           # statically allocated variables with no value section
.space 2*1024*1024;     # 2 MiB of space for kernel stack which register ESP points at
kernel_stack: 
