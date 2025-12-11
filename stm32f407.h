/* STM32F407 Register Definitions */
#ifndef STM32F407_H
#define STM32F407_H

typedef unsigned int uint32_t;

/* RCC - Reset and Clock Control */
#define RCC_BASE 0x40023800
#define RCC_AHB1ENR (*(volatile uint32_t *)(RCC_BASE + 0x30))
#define RCC_AHB1ENR_GPIOAEN (1 << 0)  /* GPIOA Clock Enable */

/* GPIO - Port A */
#define GPIOA_BASE 0x40020000
#define GPIOA_MODER (*(volatile uint32_t *)(GPIOA_BASE + 0x00))
#define GPIOA_OTYPER (*(volatile uint32_t *)(GPIOA_BASE + 0x04))
#define GPIOA_OSPEEDR (*(volatile uint32_t *)(GPIOA_BASE + 0x08))
#define GPIOA_PUPDR (*(volatile uint32_t *)(GPIOA_BASE + 0x0C))
#define GPIOA_IDR (*(volatile uint32_t *)(GPIOA_BASE + 0x10))
#define GPIOA_ODR (*(volatile uint32_t *)(GPIOA_BASE + 0x14))
#define GPIOA_BSRR (*(volatile uint32_t *)(GPIOA_BASE + 0x18))

/* Pin PA6 - LED on Black Board */
#define LED_PIN 6

#endif /* STM32F407_H */
