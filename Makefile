ARM_TARGET_LIB_FLOAT_ABI = hard
ARM_TARGET_LIB_OPTIMIZE = O2

# Compiler flags
CFLAGS = -mcpu=cortex-m4 \
         -mthumb \
         -mfloat-abi=soft \
         -g -O0 \
         -Wall \
         -ffunction-sections \
         -fdata-sections \
         -fno-builtin \
         -fno-common

# Linker flags
LDFLAGS = -mcpu=cortex-m4 \
          -mthumb \
          -mfloat-abi=soft \
          -Tstm32f407.ld \
          -Wl,--gc-sections \
          -Wl,-Map=firmware.map \
          -nostartfiles \
          -nodefaultlibs

# Toolchain
CC = arm-none-eabi-gcc
LD = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
OBJDUMP = arm-none-eabi-objdump
SIZE = arm-none-eabi-size

# Source files
C_SOURCES = main.c
ASM_SOURCES = startup_stm32f407.s
OBJECTS = $(C_SOURCES:.c=.o) $(ASM_SOURCES:.s=.o)

# Output files
TARGET = firmware.elf
HEX_FILE = firmware.hex
BIN_FILE = firmware.bin

# Default target
all: $(TARGET) $(HEX_FILE) $(BIN_FILE) size

# Build rules
$(TARGET): $(OBJECTS)
	$(LD) $(OBJECTS) $(LDFLAGS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -c $< -o $@

$(HEX_FILE): $(TARGET)
	$(OBJCOPY) -O ihex $< $@

$(BIN_FILE): $(TARGET)
	$(OBJCOPY) -O binary $< $@

size: $(TARGET)
	$(SIZE) $(TARGET)

clean:
	rm -f $(OBJECTS) $(TARGET) $(HEX_FILE) $(BIN_FILE) firmware.map *.o

disassemble: $(TARGET)
	$(OBJDUMP) -d $< > firmware.dis

.PHONY: all clean disassemble size
