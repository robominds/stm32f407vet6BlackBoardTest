# STM32F407 Black Board LED Blink - Build Configuration

## Supported Tools

- **Compiler**: arm-none-eabi-gcc (GNU ARM Embedded Toolchain)
- **Linker**: arm-none-eabi-ld
- **Build System**: Make

## Installation Instructions

### macOS

```bash
brew install arm-none-eabi-gcc
```

### Linux (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi gdb-arm-none-eabi
```

### Linux (Fedora/RHEL)

```bash
sudo dnf install arm-none-eabi-gcc arm-none-eabi-binutils arm-none-eabi-gdb
```

### Windows

Download from: https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/downloads

Or use MSYS2:
```bash
pacman -S mingw-w64-x86_64-arm-none-eabi-gcc
```

## Building

```bash
make
```

## Output Files

- **firmware.elf** - Linked executable (for debugging)
- **firmware.hex** - Intel HEX format (for some programmers)
- **firmware.bin** - Binary image (for ST-Link and other tools)

## Flashing Tools

### OpenOCD (Recommended)

```bash
# macOS
brew install open-ocd

# Linux
sudo apt-get install openocd

# Flash
openocd -f interface/stlink-v2.cfg -f target/stm32f4x.cfg \
  -c "program firmware.elf verify reset exit"
```

### STM32CubeProgrammer

Download from: https://www.st.com/en/development-tools/stm32cubeprog.html

### pyOCD (Python-based)

```bash
pip install pyocd
pyocd flash firmware.elf
```

## Verification

After flashing, the LED should blink at approximately 1 Hz (500ms on, 500ms off).

## Troubleshooting

### "arm-none-eabi-gcc: command not found"
Ensure the ARM toolchain is installed and in your PATH.

### "cannot open linker script"
Make sure you're running `make` from the project directory.

### LED not blinking
- Check USB connection and power
- Verify ST-Link drivers are installed
- Ensure firmware was flashed correctly (check memory in debugger)
- Try pressing the reset button on the board
