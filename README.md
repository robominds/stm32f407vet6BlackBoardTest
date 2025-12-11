# *** Generated and debugged on hardware completely with Github Copilot ***

# STM32F407 Black Board LED Blink - Bare Metal Program

This is a complete bare metal program for the STM32F407VET6 Black Board that blinks an LED without any HAL libraries.

## Project Structure

- **startup.c** - ARM Cortex-M4 startup code with interrupt vector table
- **main.c** - Main application code (LED blinking logic)
- **stm32f407.h** - Register definitions for STM32F407 peripherals
- **stm32f407.ld** - Linker script for memory layout
- **Makefile** - Build configuration

## LED Configuration

The program uses **PA6 (GPIO Port A, Pin 6)** which is connected to the LED on the STM32F407 Black Board.

## Building

### Prerequisites

Install the ARM embedded toolchain:

```bash
# macOS (using Homebrew)
brew install arm-none-eabi-gcc

# Ubuntu/Debian
sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi

# Other systems: Download from https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/downloads
```

### Compile and Link

```bash
make
```

This will generate:
- `firmware.elf` - Executable image
- `firmware.hex` - Intel HEX format (for programming)
- `firmware.bin` - Binary format (for programming)

## Flashing to the Board

### Using STM32CubeProgrammer (GUI)

1. Connect the STM32F407 Black Board via USB
2. Open STM32CubeProgrammer
3. Select the ST-Link interface
4. Click "Open file" and select `firmware.hex` or `firmware.bin`
5. Click "Download"

### Using OpenOCD (Command Line)

```bash
openocd -f interface/stlink-v2.cfg -f target/stm32f4x.cfg \
  -c "program firmware.elf verify reset exit"
```

### Using stm32flash Tool

```bash
stm32flash -w firmware.bin -v -g 0x0 /dev/ttyUSB0
```

## Hardware Connections

- **USB/JTAG**: Connect ST-Link v2 for programming
- **LED**: Connected to PB0 (already on the board)
- **GND**: Common ground

## Program Behavior

- LED blinks with a 500ms ON / 500ms OFF pattern
- Blink cycle: 1 second
- No dependencies on HAL or standard libraries

## Code Structure

### startup.c
- Initializes the Cortex-M4 processor
- Sets up interrupt vectors
- Copies initialized data from FLASH to RAM
- Clears BSS section
- Calls main()

### main.c
- Enables GPIOB clock via RCC
- Configures PB0 as an output pin
- Implements a simple delay function
- Contains the main blink loop

### stm32f407.h
- Register definitions for RCC and GPIO
- Macro definitions for easy access

## Debugging

Generate a disassembly listing:

```bash
make disassemble
```

Check program size:

```bash
make size
```

## Clean Build

```bash
make clean
```

## Notes

- Clock runs at default 16 MHz internal oscillator on startup
- Delay function is approximate and not precise
- For production, use System Timer (SysTick) for precise timing
- Can be extended with more peripherals (UART, Timers, etc.)
