#!/bin/bash
~/Documents/qemu-stm32/qemu_stm32/arm-softmmu/qemu-system-arm -machine stm32-p103 \
-kernel main.bin --nographic -S -gdb tcp::1234 &
QEMUINSTANCE=$!

ddd --debugger arm-none-eabi-gdb main.elf

kill $!
