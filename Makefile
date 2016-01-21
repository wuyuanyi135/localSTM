PREFIX = arm-none-eabi-
PLATFORM = -mcpu=cortex-m3 -mthumb

CC = $(PREFIX)gcc
CCFLAGS = -g -c $(PLATFORM)

LD = $(PREFIX)gcc
LDFLAGS = -T stm32_flash.ld --specs=nosys.specs $(PLATFORM)

AS = $(PREFIX)as
ASFLAGS = -g $(PLATFORM)

OBJCOPY = $(PREFIX)objcopy
OBJCOPYFLAGS = -O binary

QEMUPATH = ~/Documents/qemu-stm32/qemu_stm32/arm-softmmu/
QEMUARGS = -machine stm32-p103


main.bin: main.elf
	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@

main.elf: startup.o main.o
	$(LD) $(LDFLAGS) -o $@ $^

main.o: main.c
	$(CC) $(CCFLAGS) $^ -o $@

startup.o: startup.s
	$(AS) $(ASFLAGS) $^ -o $@


.phony: all clean debug d qemu
clean:
	rm -f *.o *.out *.elf

all: main.bin

debug:
	ddd --debugger arm-none-eabi-gdb main.elf

d:
	arm-none-eabi-gdb --tui main.elf

qemu:
	$(QEMUPATH)qemu-system-arm $(QEMUARGS) -kernel main.bin --nographic -gdb tcp::1234  &
	$(eval QEMUINSTANCE=$$!)
	echo $(QEMUINSTANCE)
	kill $(QEMUINSTANCE)
