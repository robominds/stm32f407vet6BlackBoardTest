.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.thumb

/* Vector table */
.section .vectors, "a", %progbits
.align 8

.word   _estack                     /* 0: Initial Stack Pointer */
.word   Reset_Handler               /* 1: Reset */
.word   Default_Handler             /* 2: NMI */
.word   Default_Handler             /* 3: HardFault */
.word   Default_Handler             /* 4: MemManage */
.word   Default_Handler             /* 5: BusFault */
.word   Default_Handler             /* 6: UsageFault */
.word   0                           /* 7: Reserved */
.word   0                           /* 8: Reserved */
.word   0                           /* 9: Reserved */
.word   0                           /* 10: Reserved */
.word   Default_Handler             /* 11: SVCall */
.word   Default_Handler             /* 12: Debug Monitor */
.word   0                           /* 13: Reserved */
.word   Default_Handler             /* 14: PendSV */
.word   Default_Handler             /* 15: SysTick */

/* External interrupts: 82 entries for STM32F4 */
.rept 82
    .word Default_Handler
.endr

/* Code section */
.text
.thumb
.align 2

.global Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    /* Enable FPU CP10/CP11 */
    ldr     r0, =0xE000ED88
    ldr     r1, [r0]
    orr     r1, r1, #(0xF << 20)
    str     r1, [r0]
    dsb
    isb

    /* Point VTOR to flash base */
    ldr     r0, =0xE000ED08
    ldr     r1, =0x08000000
    str     r1, [r0]
    dsb
    isb

    /* Copy .data from flash (ldata) to RAM (sdata..edata) */
    ldr     r0, =_ldata
    ldr     r1, =_sdata
    ldr     r2, =_edata
1:
    cmp     r1, r2
    bcc     2f
    b       3f
2:
    ldr     r3, [r0], #4
    str     r3, [r1], #4
    b       1b

3:  /* Zero .bss (sbss..ebss) */
    ldr     r1, =_sbss
    ldr     r2, =_ebss
    movs    r3, #0
4:
    cmp     r1, r2
    bcc     5f
    b       6f
5:
    str     r3, [r1], #4
    b       4b

6:  /* Call main */
    bl      main

7:  /* If main returns, loop */
    b       7b

.size Reset_Handler, .-Reset_Handler

/* Default handler */
.global Default_Handler
.type Default_Handler, %function
Default_Handler:
    b       Default_Handler
.size Default_Handler, .-Default_Handler

/* Weak aliases for all exception handlers to Default_Handler */
.weak NMI_Handler
.weak HardFault_Handler
.weak MemManage_Handler
.weak BusFault_Handler
.weak UsageFault_Handler
.weak SVC_Handler
.weak DebugMon_Handler
.weak PendSV_Handler
.weak SysTick_Handler

.weak WWDG_IRQHandler
.weak PVD_IRQHandler
.weak TAMP_STAMP_IRQHandler
.weak RTC_WKUP_IRQHandler
.weak FLASH_IRQHandler
.weak RCC_IRQHandler
.weak EXTI0_IRQHandler
.weak EXTI1_IRQHandler
.weak EXTI2_IRQHandler
.weak EXTI3_IRQHandler
.weak EXTI4_IRQHandler
.weak DMA1_Stream0_IRQHandler
.weak DMA1_Stream1_IRQHandler
.weak DMA1_Stream2_IRQHandler
.weak DMA1_Stream3_IRQHandler
.weak DMA1_Stream4_IRQHandler
.weak DMA1_Stream5_IRQHandler
.weak DMA1_Stream6_IRQHandler
.weak ADC_IRQHandler
.weak CAN1_TX_IRQHandler
.weak CAN1_RX0_IRQHandler
.weak CAN1_RX1_IRQHandler
.weak CAN1_SCE_IRQHandler
.weak EXTI9_5_IRQHandler
.weak TIM1_BRK_TIM9_IRQHandler
.weak TIM1_UP_TIM10_IRQHandler
.weak TIM1_TRG_COM_TIM11_IRQHandler
.weak TIM1_CC_IRQHandler
.weak TIM2_IRQHandler
.weak TIM3_IRQHandler
.weak TIM4_IRQHandler
.weak I2C1_EV_IRQHandler
.weak I2C1_ER_IRQHandler
.weak I2C2_EV_IRQHandler
.weak I2C2_ER_IRQHandler
.weak SPI1_IRQHandler
.weak SPI2_IRQHandler
.weak USART1_IRQHandler
.weak USART2_IRQHandler
.weak USART3_IRQHandler
.weak EXTI15_10_IRQHandler
.weak RTC_Alarm_IRQHandler
.weak OTG_FS_WKUP_IRQHandler
.weak TIM8_BRK_TIM12_IRQHandler
.weak TIM8_UP_TIM13_IRQHandler
.weak TIM8_TRG_COM_TIM14_IRQHandler
.weak TIM8_CC_IRQHandler
.weak DMA1_Stream7_IRQHandler
.weak FSMC_IRQHandler
.weak SDIO_IRQHandler
.weak TIM5_IRQHandler
.weak SPI3_IRQHandler
.weak UART4_IRQHandler
.weak UART5_IRQHandler
.weak TIM6_DAC_IRQHandler
.weak TIM7_IRQHandler
.weak DMA2_Stream0_IRQHandler
.weak DMA2_Stream1_IRQHandler
.weak DMA2_Stream2_IRQHandler
.weak DMA2_Stream3_IRQHandler
.weak DMA2_Stream4_IRQHandler
.weak ETH_IRQHandler
.weak ETH_WKUP_IRQHandler
.weak CAN2_TX_IRQHandler
.weak CAN2_RX0_IRQHandler
.weak CAN2_RX1_IRQHandler
.weak CAN2_SCE_IRQHandler
.weak OTG_FS_IRQHandler
.weak DMA2_Stream5_IRQHandler
.weak DMA2_Stream6_IRQHandler
.weak DMA2_Stream7_IRQHandler
.weak USART6_IRQHandler
.weak I2C3_EV_IRQHandler
.weak I2C3_ER_IRQHandler
.weak OTG_HS_EP1_OUT_IRQHandler
.weak OTG_HS_EP1_IN_IRQHandler
.weak OTG_HS_WKUP_IRQHandler
.weak OTG_HS_IRQHandler
.weak DCMI_IRQHandler
.weak CRYP_IRQHandler
.weak HASH_RNG_IRQHandler
.weak FPU_IRQHandler

NMI_Handler                 = Default_Handler
HardFault_Handler           = Default_Handler
MemManage_Handler           = Default_Handler
BusFault_Handler            = Default_Handler
UsageFault_Handler          = Default_Handler
SVC_Handler                 = Default_Handler
DebugMon_Handler            = Default_Handler
PendSV_Handler              = Default_Handler
SysTick_Handler             = Default_Handler

WWDG_IRQHandler             = Default_Handler
PVD_IRQHandler              = Default_Handler
TAMP_STAMP_IRQHandler       = Default_Handler
RTC_WKUP_IRQHandler         = Default_Handler
FLASH_IRQHandler            = Default_Handler
RCC_IRQHandler              = Default_Handler
EXTI0_IRQHandler            = Default_Handler
EXTI1_IRQHandler            = Default_Handler
EXTI2_IRQHandler            = Default_Handler
EXTI3_IRQHandler            = Default_Handler
EXTI4_IRQHandler            = Default_Handler
DMA1_Stream0_IRQHandler     = Default_Handler
DMA1_Stream1_IRQHandler     = Default_Handler
DMA1_Stream2_IRQHandler     = Default_Handler
DMA1_Stream3_IRQHandler     = Default_Handler
DMA1_Stream4_IRQHandler     = Default_Handler
DMA1_Stream5_IRQHandler     = Default_Handler
DMA1_Stream6_IRQHandler     = Default_Handler
ADC_IRQHandler              = Default_Handler
CAN1_TX_IRQHandler          = Default_Handler
CAN1_RX0_IRQHandler         = Default_Handler
CAN1_RX1_IRQHandler         = Default_Handler
CAN1_SCE_IRQHandler         = Default_Handler
EXTI9_5_IRQHandler          = Default_Handler
TIM1_BRK_TIM9_IRQHandler    = Default_Handler
TIM1_UP_TIM10_IRQHandler    = Default_Handler
TIM1_TRG_COM_TIM11_IRQHandler = Default_Handler
TIM1_CC_IRQHandler          = Default_Handler
TIM2_IRQHandler             = Default_Handler
TIM3_IRQHandler             = Default_Handler
TIM4_IRQHandler             = Default_Handler
I2C1_EV_IRQHandler          = Default_Handler
I2C1_ER_IRQHandler          = Default_Handler
I2C2_EV_IRQHandler          = Default_Handler
I2C2_ER_IRQHandler          = Default_Handler
SPI1_IRQHandler             = Default_Handler
SPI2_IRQHandler             = Default_Handler
USART1_IRQHandler           = Default_Handler
USART2_IRQHandler           = Default_Handler
USART3_IRQHandler           = Default_Handler
EXTI15_10_IRQHandler        = Default_Handler
RTC_Alarm_IRQHandler        = Default_Handler
OTG_FS_WKUP_IRQHandler      = Default_Handler
TIM8_BRK_TIM12_IRQHandler   = Default_Handler
TIM8_UP_TIM13_IRQHandler    = Default_Handler
TIM8_TRG_COM_TIM14_IRQHandler = Default_Handler
TIM8_CC_IRQHandler          = Default_Handler
DMA1_Stream7_IRQHandler     = Default_Handler
FSMC_IRQHandler             = Default_Handler
SDIO_IRQHandler             = Default_Handler
TIM5_IRQHandler             = Default_Handler
SPI3_IRQHandler             = Default_Handler
UART4_IRQHandler            = Default_Handler
UART5_IRQHandler            = Default_Handler
TIM6_DAC_IRQHandler         = Default_Handler
TIM7_IRQHandler             = Default_Handler
DMA2_Stream0_IRQHandler     = Default_Handler
DMA2_Stream1_IRQHandler     = Default_Handler
DMA2_Stream2_IRQHandler     = Default_Handler
DMA2_Stream3_IRQHandler     = Default_Handler
DMA2_Stream4_IRQHandler     = Default_Handler
ETH_IRQHandler              = Default_Handler
ETH_WKUP_IRQHandler         = Default_Handler
CAN2_TX_IRQHandler          = Default_Handler
CAN2_RX0_IRQHandler         = Default_Handler
CAN2_RX1_IRQHandler         = Default_Handler
CAN2_SCE_IRQHandler         = Default_Handler
OTG_FS_IRQHandler           = Default_Handler
DMA2_Stream5_IRQHandler     = Default_Handler
DMA2_Stream6_IRQHandler     = Default_Handler
DMA2_Stream7_IRQHandler     = Default_Handler
USART6_IRQHandler           = Default_Handler
I2C3_EV_IRQHandler          = Default_Handler
I2C3_ER_IRQHandler          = Default_Handler
OTG_HS_EP1_OUT_IRQHandler   = Default_Handler
OTG_HS_EP1_IN_IRQHandler    = Default_Handler
OTG_HS_WKUP_IRQHandler      = Default_Handler
OTG_HS_IRQHandler           = Default_Handler
DCMI_IRQHandler             = Default_Handler
CRYP_IRQHandler             = Default_Handler
HASH_RNG_IRQHandler         = Default_Handler
FPU_IRQHandler              = Default_Handler
