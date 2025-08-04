#define VIDEO_MEMORY 0xB8000

void clear_screen() {
    volatile char *video = (volatile char*)VIDEO_MEMORY;
    for(int i = 0; i < 80 * 25 * 2; i += 2) {
        video[i] = ' ';
        video[i+1] = 0x07;  // Gris sobre negro
    }
}

void print(const char *str) {
    volatile char *video = (volatile char*)VIDEO_MEMORY;
    while(*str) {
        *video++ = *str++;
        *video++ = 0x0F;  // Blanco sobre negro
    }
}

void kernel_main() {
    clear_screen();
    print("PandaOS ejecutandose correctamente!");
    while(1);
}