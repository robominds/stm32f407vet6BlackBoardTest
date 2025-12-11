#include "stm32f407.h"

/* Delay function - approximate delay in milliseconds */
void delay_ms(uint32_t ms) {
    uint32_t i, j;
    for (i = 0; i < ms; i++)
        for (j = 0; j < 8000; j++)
            ;
}

int main(void) {
    /* Enable GPIOA Clock */
    RCC_AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    /* Configure PA6 as output (LED pin on STM32F407 Black Board) */
    /* Set PA6 to output mode (01 in MODER) */
    GPIOA_MODER &= ~(3 << (LED_PIN * 2));  /* Clear bits */
    GPIOA_MODER |= (1 << (LED_PIN * 2));   /* Set to output mode */

    /* Set output type to push-pull (0 in OTYPER) */
    GPIOA_OTYPER &= ~(1 << LED_PIN);

    /* Set output speed to high (11 in OSPEEDR) */
    GPIOA_OSPEEDR |= (3 << (LED_PIN * 2));

    /* No pull-up/pull-down (00 in PUPDR) */
    GPIOA_PUPDR &= ~(3 << (LED_PIN * 2));

    /* Main loop - blink LED */
    while (1) {
        /* Turn on LED (set PA6) */
        GPIOA_BSRR = (1 << LED_PIN);
        delay_ms(500);

        /* Turn off LED (reset PA6) */
        GPIOA_BSRR = (1 << (LED_PIN + 16));
        delay_ms(500);
    }

    return 0;
}
