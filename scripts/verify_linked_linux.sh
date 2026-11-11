#!/bin/sh
# Hosted compiler/QEMU adapter, never part of L0 or evidence of physical HW.
set -eu
cd "$(dirname "$0")/.."
mkdir -p out/linked-linux
CC=${CC:-clang}
for tool in "$CC" ld.lld readelf nm sha256sum qemu-arm qemu-aarch64 timeout
do
    if ! command -v "$tool" >/dev/null 2>&1; then
        printf 'MISSING_HOST_TOOL=%s\n' "$tool" >&2
        exit 127
    fi
done
for entry in 'armv7a-linux-gnueabi armv7 armv7_start.S' \
             'aarch64-linux-gnu aarch64 aarch64_start.S' \
             'x86_64-linux-gnu x86_64 x86_64_start.S'
do
    set -- $entry
    target=$1
    abi=$2
    asm=$3
    elf="out/linked-linux/raf_${abi}"
    "$CC" -target "$target" -std=c11 -Oz -ffreestanding \
      -fno-builtin -fno-stack-protector -fno-unwind-tables \
      -fno-asynchronous-unwind-tables -fno-pic -fno-pie \
      -nostdlib -static -fuse-ld=lld -Wall -Wextra -Werror \
      -Wl,-e,_start -Wl,--no-undefined -Wl,-z,noexecstack \
      -Wl,--build-id=none src/raf_l0.c src/raf_l0_selfcheck.c \
      "src/platform/linux/$asm" -o "$elf"
    readelf -W -h "$elf" > "out/linked-linux/header_${abi}.txt"
    readelf -W -l "$elf" > "out/linked-linux/program_${abi}.txt"
    grep -Eq 'Type:[[:space:]]*EXEC' "out/linked-linux/header_${abi}.txt"
    case "$abi" in
      armv7) grep -Eq 'Class:[[:space:]]*ELF32' "out/linked-linux/header_${abi}.txt"
             grep -Eq 'Machine:[[:space:]]*ARM' "out/linked-linux/header_${abi}.txt" ;;
      aarch64) grep -Eq 'Class:[[:space:]]*ELF64' "out/linked-linux/header_${abi}.txt"
               grep -Eq 'Machine:[[:space:]]*AArch64' "out/linked-linux/header_${abi}.txt" ;;
      x86_64) grep -Eq 'Class:[[:space:]]*ELF64' "out/linked-linux/header_${abi}.txt"
              grep -Eq 'Machine:[[:space:]]*Advanced Micro Devices X86-64' "out/linked-linux/header_${abi}.txt" ;;
    esac
    if grep -Eq 'INTERP|DYNAMIC' "out/linked-linux/program_${abi}.txt"; then
      echo "FAIL: unexpected dynamic interpreter/dependency for $abi" >&2
      exit 4
    fi
    nm -u "$elf" > "out/linked-linux/undefined_${abi}.txt"
    test ! -s "out/linked-linux/undefined_${abi}.txt"
    case "$abi" in
      armv7) timeout 20s qemu-arm "$elf" ;;
      aarch64) timeout 20s qemu-aarch64 "$elf" ;;
      x86_64) timeout 20s "$elf" ;;
    esac
    printf '%s=PASS_EXIT_0\n' "$abi" >> "out/linked-linux/runtime-results.txt"
done
sha256sum src/raf_l0.c src/raf_l0_selfcheck.c \
  out/linked-linux/raf_armv7 out/linked-linux/raf_aarch64 \
  out/linked-linux/raf_x86_64 > out/linked-linux/sha256.txt
{
    printf 'scope=LINKED_STATIC_LINUX_ELF_PLUS_QEMU_USER_MODE_ONLY\n'
    printf 'x86_64=HOST_EXIT_0\n'
    printf 'armv7=QEMU_USER_EXIT_0\n'
    printf 'aarch64=QEMU_USER_EXIT_0\n'
    printf 'elf_type=EXEC\n'
    printf 'undefined_symbols=0\n'
    printf 'dynamic_loader=ABSENT\n'
    printf 'physical_arm_device=NOT_RUN\n'
    printf 'android_apk=NOT_BUILT\n'
    printf 'firebird_engine=NOT_LINKED\n'
    printf 'claim_allowed=false\n'
} > out/linked-linux/receipt.txt
cat out/linked-linux/receipt.txt
