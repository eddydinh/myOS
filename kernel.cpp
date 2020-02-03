/* C++ kernel file for myOS */
void printf(char* str){
    
    
    unsigned short* VideoMemory = (unsigned short*)0xb8000; // Starting from this address, video card will display whatever characters stored here. However, character bytes are preceded by color info bytes.
    
    for(int i = 0; str[i] != '\0'; i++)
        VideoMemory[i] = (VideoMemory[i] & 0xff00) | str[i]; // Copy color info bytes OR character bytes from the program and put it in RAM starting from 0xb8000
}

//Note: extern "C" tells gpp to not modify kernelMain function's name
extern "C" void kernelMain(void* multiboot_structure, unsigned int magic_number)
{
    printf("Greetings Eddy! --- Welcome to your OS!");
    
    while(1);
    
}
