# RAFCODEΦ L1 — static Linux ELF, auditable boundary

## Status
This is a Linux-specific execution adapter, not an Android APK and not Firebird. L0 remains in `src/raf_l0.c` with its own object and sanitizer gates. New `src/raf_l0_selfcheck.c` is a bounded in-binary smoke test, not a server or product authentication test.

## Technical contract
- Three **distinct** ELF executables are statically linked: armv7-linux-gnueabi, aarch64-linux-gnu and x86_64-linux-gnu.
- Each native assembly `_start` invokes `raf_l0_selfcheck` and exits via precisely one Linux OS-boundary syscall. Runtime has no libc, heap/malloc, GC, JNI, SSL, Java or dynamic loader in this scope.
- Zero exit status is only a deterministic smoke-test receipt for these inputs. It does not prove complete memory safety, robustness, correct Firebird protocol behavior, or security.
- Expected static ELF ET_EXEC and machine/class are checked with `readelf`, `nm -u` empty. Interpreter and DYNAMIC segments forbidden.
- QEMU user-mode emulates ARM Linux binaries on hosted Ubuntu. This is **not** physical ARM, Android/Bionic compatibility, kernel portability, or a single universal native binary.
- Build uses external Clang/LLD, GitHub Actions, QEMU installed on the runner, system package transport and shell. These are hosted test/build tools, NOT L0 dependencies.
- CPU instructions and syscalls are hardware/OS contracts owned by their upstream ecosystems. Third-party licenses must be reviewed before distribution/merging external implementations.
- Do not implement proprietary cryptography or vendor Firebird source on these assumptions. Real TLS, authentication, protocol, persistence and SQL engine require separate security and rights gates.

## Exact falsifiers
1. Host x86 runtime must exit 0 and QEMU ARMv7/AArch64 must exit 0. A QEMU installation failure, absent executable or nonzero exit fails the job, not a SKIP/PASS.
2. Every ELF is static ET_EXEC with correct ELF class/machine, no PT_INTERP/PT_DYNAMIC, no undefined symbols; this validates declared output scope only.
3. L0 host sanitizers/object validation from the preceding job must remain green.
4. Preserve old CI evidence on earlier HEADs; inspect exact commit and downloadable artifact digest before promotion.
5. Any real Android compatibility claim requires Android Bionic/loader, ABI/device checks and an installable signed APK separately.

## Reconstruct & rollback
`sh scripts/verify_linked_linux.sh` is the hosted gate; user-mode QEMU must be provisioned. CI uploads binaries and scoped receipts, not APK. Branch/PR is DRAFT/HOLD; close without merging to rollback the proposal. No vendor code imported.
`SOURCE != ARTIFACT != EXECUTION != EVIDENCE != CLAIM`; `TOKEN_VAZIO != 0`; `claim_allowed=false`.
