#!/bin/sh
# Hosted build adapter: clang, binutils, shell, and GitHub runner are NOT L0.
set -eu
cd "$(dirname "$0")/.."
mkdir -p out
CC=${CC:-clang}
command -v "$CC" >/dev/null
command -v readelf >/dev/null
command -v nm >/dev/null
command -v sha256sum >/dev/null

"$CC" -std=c11 -O1 -g -Wall -Wextra -Werror \
    -fsanitize=address,undefined -fno-omit-frame-pointer \
    src/raf_l0.c tests/raf_l0_host_test.c -o out/l0-host-test
./out/l0-host-test

for entry in 'armv7a-none-eabi armv7' 'aarch64-none-elf arm64' 'x86_64-unknown-none-elf x86_64'
do
    set -- $entry
    target=$1
    abi=$2
    object="out/raf_l0_${abi}.o"
    "$CC" -target "$target" -std=c11 -Oz -ffreestanding \
        -fno-builtin -fno-stack-protector -fno-unwind-tables \
        -fno-asynchronous-unwind-tables -Wall -Wextra -Werror \
        -c src/raf_l0.c -o "$object"
    readelf -h "$object" > "out/elf_${abi}.txt"
    grep -Eq 'Type:[[:space:]]*REL' "out/elf_${abi}.txt"
    case "$abi" in
      armv7)  grep -Eq 'Class:[[:space:]]*ELF32' "out/elf_${abi}.txt"
              grep -Eq 'Machine:[[:space:]]*ARM' "out/elf_${abi}.txt" ;;
      arm64)  grep -Eq 'Class:[[:space:]]*ELF64' "out/elf_${abi}.txt"
              grep -Eq 'Machine:[[:space:]]*AArch64' "out/elf_${abi}.txt" ;;
      x86_64) grep -Eq 'Class:[[:space:]]*ELF64' "out/elf_${abi}.txt"
              grep -Eq 'Machine:[[:space:]]*Advanced Micro Devices X86-64' "out/elf_${abi}.txt" ;;
    esac
    nm -u "$object" > "out/undefined_${abi}.txt"
    test ! -s "out/undefined_${abi}.txt"
done
sha256sum src/raf_l0.c out/raf_l0_*.o > out/sha256.txt
{
    printf 'scope=HOST_SANITIZERS_AND_RELOCATABLE_OBJECTS_ONLY\n'
    printf 'host_falsifiers=PASS\n'
    printf 'targets=armv7a-none-eabi,aarch64-none-elf,x86_64-unknown-none-elf\n'
    printf 'elf_type=ET_REL\n'
    printf 'undefined_symbols=0\n'
    printf 'linked_elf=NOT_RUN\n'
    printf 'android_apk=NOT_BUILT\n'
    printf 'device_e2e=NOT_RUN\n'
    printf 'claim_allowed=false\n'
} > out/receipt.txt
cat out/receipt.txt
