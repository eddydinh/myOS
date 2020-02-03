/* Linker scripts to join kernel.cpp and loader.s into kernel.bin */

ENTRY(loader) /*tell linker that this position of loader.s is entry point of kernel.bin*/
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386:i386)

/* collect and combine sections from .o files */
SECTIONS{
    . = 0x0100000;
    
    /* new text section, read-only*/
    .text :
    {
      *(.multiboot)
      *(.text)   
      *(.rodata)
    }
    
    .data :
    {
     start_ctors = .; /* construction of global objects */
     KEEP(*( .init_array ));
     KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.* )));
     end_ctors = .;
     
     *(.data) /* from .o files */
    }
    
    .bss :
    {
        *(.bss)
    }
    
    /* let linker knows that it is ok to leave these parts */
    /DISCARD/ : 
    {
        *(.fini_array*)
        *(.comment)
    }
}
