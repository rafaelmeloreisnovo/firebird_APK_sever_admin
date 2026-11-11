# firebird_APK_sever_admin
Uso comercial restrito

## Bootstrap L0 — proposta isolada
Este repositório começou apenas com este README. O protótipo na branch de trabalho NÃO é um Firebird server, APK ou release.

- Entrada canônica: [001_PONTEIRO/START_HERE.md](001_PONTEIRO/START_HERE.md)
- Arquitetura, autoralidade e fronteiras: [docs/ARCHITECTURE_L0.md](docs/ARCHITECTURE_L0.md)
- Núcleo C11 sem libc/sistema: [src/raf_l0.c](src/raf_l0.c)
- Teste local/CI de objetos ET_REL: `sh scripts/verify_l0.sh`

`Java/ART != C/ASM freestanding`. ARMv7, AArch64 e x86_64 são alvos binários distintos; o futuro APK é contêiner multi-ABI, não um único ELF executável em todas as CPUs. Sem cópia de código Firebird, OpenSSL ou outros terceiros nesta proposta. Licenças e interoperabilidade exigem avaliação antes da implementação.
