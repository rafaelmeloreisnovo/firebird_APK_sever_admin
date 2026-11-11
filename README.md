# firebird_APK_sever_admin
Uso comercial restrito

## L0/L1 — proposta isolada
Este repositório começou apenas com este README. O protótipo na branch de trabalho NÃO é um Firebird server, APK ou release.

- Entrada canônica: [001_PONTEIRO/START_HERE.md](001_PONTEIRO/START_HERE.md)
- Arquitetura L0 e limites: [docs/ARCHITECTURE_L0.md](docs/ARCHITECTURE_L0.md)
- Linux L1 link/exec (sem libc): [docs/ARCHITECTURE_L1_LINUX.md](docs/ARCHITECTURE_L1_LINUX.md)
- Núcleo C11 freestanding: [src/raf_l0.c](src/raf_l0.c)
- Objetos ELF L0: `sh scripts/verify_l0.sh`
- ELF estáticos Linux L1 com QEMU user-mode ARM: `sh scripts/verify_linked_linux.sh` (QEMU no host de teste).

`Java/ART != C/ASM freestanding`. ARMv7, AArch64 e x86_64 são binários nativos distintos; o futuro APK é contêiner multi-ABI. Nenhum código Firebird/OpenSSL importado nesta proposta. A fronteira Linux inclui syscall de saída somente no adaptador ASM, não no núcleo. Android/device/TLS/licenças ainda dependem de gates separados.
