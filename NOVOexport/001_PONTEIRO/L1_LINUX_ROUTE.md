# L1 Linux — RAFAELIA μROUTE

`001_PONTEIRO/START_HERE.md` → `docs/ARCHITECTURE_L1_LINUX.md` → `src/raf_l0_selfcheck.c` → `src/platform/linux/{armv7,aarch64,x86_64}_start.S` → `scripts/verify_linked_linux.sh` → CI exact-head runtime receipt.

Authority: this repo only; RafGitTools and Mapa route, they are not test/production proofs. Third-party QEMU/Clang are hosted test dependencies.
Gates: linked ELF ET_EXEC + correct target + no interpreter/imports + QEMU user-mode ARM and native x86 exit zero.
Excluded: physical ARM, Android APK, Java, TLS, Firebird engine, signing. Append-only evidence only; no promotion.
