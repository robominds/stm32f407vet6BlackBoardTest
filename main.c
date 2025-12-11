int main(void) {
    volatile unsigned int *rcc_ahb1 = (unsigned int *)0x40023830;
    volatile unsigned int *gpio_a_mode = (unsigned int *)0x40020000;
    volatile unsigned int *gpio_a_otype = (unsigned int *)0x40020004;
    volatile unsigned int *gpio_a_ospeed = (unsigned int *)0x40020008;
    volatile unsigned int *gpio_a_pupd = (unsigned int *)0x4002000C;
    volatile unsigned int *gpio_a_bsrr = (unsigned int *)0x40020018;

    // Enable GPIOA clock
    *rcc_ahb1 |= (1 << 0);

    // Configure PA6 and PA7 as outputs, push-pull, medium speed, no pull
    *gpio_a_mode &= ~(0xF << 12);  // Clear MODER bits for pins 6 and 7
    *gpio_a_mode |= (0x5 << 12);   // Set both to output mode (01b)
    *gpio_a_otype &= ~((1 << 6) | (1 << 7)); // push-pull
    *gpio_a_ospeed &= ~(0xF << 12);
    *gpio_a_ospeed |= (0xA << 12); // medium speed
    *gpio_a_pupd &= ~(0xF << 12);  // no pull-up/pull-down

    while (1) {
        // Active-low friendly: drive low to turn on, high to turn off
        *gpio_a_bsrr = (1 << (6 + 16)) | (1 << (7 + 16)); // reset -> low/on
        for (volatile int i = 0; i < 300000; i++);
        *gpio_a_bsrr = (1 << 6) | (1 << 7);               // set -> high/off
        for (volatile int i = 0; i < 300000; i++);
    }

    return 0;
}
