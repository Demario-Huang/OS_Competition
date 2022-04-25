cargo build --release
rust-objcopy --strip-all target/riscv64gc-unknown-none-elf/release/hello_world -O binary target/riscv64gc-unknown-none-elf/release/hello_world.bin
rust-objcopy --strip-all target/riscv64gc-unknown-none-elf/release/power -O binary target/riscv64gc-unknown-none-elf/release/power.bin
rust-objcopy --strip-all target/riscv64gc-unknown-none-elf/release/init_proc -O binary target/riscv64gc-unknown-none-elf/release/init_proc.bin
rust-objcopy --strip-all target/riscv64gc-unknown-none-elf/release/bash -O binary target/riscv64gc-unknown-none-elf/release/bash.bin
qemu-riscv64 ./target/riscv64gc-unknown-none-elf/release/hello_world
qemu-riscv64 ./target/riscv64gc-unknown-none-elf/release/power
qemu-riscv64 ./target/riscv64gc-unknown-none-elf/release/init_proc
qemu-riscv64 ./target/riscv64gc-unknown-none-elf/release/bash
