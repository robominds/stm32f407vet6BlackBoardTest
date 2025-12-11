ARM_TARGET_LIB_FLOAT_ABI = hard
ARM_TARGET_LIB_OPTIMIZE = O2

# Compiler flags
CFLAGS = -mcpu=cortex-m4 \
         -mthumb \
         -mfpu=fpv4-sp-d16 \
         -mfloat-abi=hard \
         -O2 \
         -Wall \
         -ffunction-sections \
         -fdata-sections \
         -fno-builtin \
         -fno-common

# Linker flags
LDFLAGS = -mcpu=cortex-m4 \
          -mthumb \
          -mfpu=fpv4-sp-d16 \
          -mfloat-abi=hard \
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
SOURCES = startup.c main.c
OBJECTS = $(SOURCES:.c=.o)

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

$(HEX_FILE): $(TARGET)
	$(OBJCOPY) -O ihex $< $@

$(BIN_FILE): $(TARGET)
	$(OBJCOPY) -O binary $< $@

size: $(TARGET)
	$(SIZE) $(TARGET)

clean:
	rm -f $(OBJECTS) $(TARGET) $(HEX_FILE) $(BIN_FILE) firmware.map

disassemble: $(TARGET)
	$(OBJDUMP) -d $< > firmware.dis

.PHONY: all clean disassemble size
