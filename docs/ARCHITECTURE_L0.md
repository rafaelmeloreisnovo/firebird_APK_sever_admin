# RAFCODEΦ / Firebird Admin — L0 architecture and PIRC-2 gate

## Current observed state (N0 at bootstrap)
The target repository main at `fc021a01826e893db542edcde91c8abef9c75662` contained only `README.md` stating `Uso comercial restrito`. A restrictive statement is not a verified grant of rights or a license audit. No original server/APK functionality existed here to preserve; the independent Firebird-derived producer is `rafaelmeloreisnovo/firebird_rafcodephi`.

## Execution boundaries (design, not passed runtime)
- L0: original C11 module without headers/libc/malloc/heap/syscalls/OS APIs; compile as relocatable ET_REL for ARMv7, AArch64 and x86_64. No executable entry point, link validation or device execution claimed.
- L1: future OS-specific adapters for memory, files, sockets, TLS, time and errors. System calls and kernel behavior belong to the OS boundary; their compatibility and security must be proven per target.
- L2: future Android adapter (manifest, Activity or NativeActivity, package ABI splits, signing). A normal Java Android Activity requires a class and ART; Java source is not silicon-native machine code. JNI is one integration choice, not an intrinsic L0 dependency. No Android implementation is currently included.
- L3: future Firebird protocol/server integration. No Firebird engine, authentication, SQL storage, wire protocol or third-party source imported. Server-grade TLS cannot be silently replaced with an unvalidated authorial cipher.
- Build adapters: hosted Clang, binutils, shell, Actions checkout/upload provider components. These are external tools by contract; compiler object output does not prove reproducible toolchain provenance.
- Distribution: one APK *container* can include multiple `lib/<abi>/...` native objects once linked into legitimate shared libraries; these are not one CPU-independent machine executable. The loader selects compatible ABI; OS families additionally require their own adapters. A universal pure native single binary across architectures is not claimed.

## ABI/dependency table
| Component | Runtime dependency | Build dependency | Authority | State |
|---|---|---|---|---|
| `src/raf_l0.c` | none declared (object scope only) | C compiler + ELF toolchain | this repo | SOURCE_IMPLEMENTED; CI N5 |
| Host falsifiers | hosted process/CRT/sanitizers | Clang and OS | test harness | NOT_RUN in repository until CI readback |
| Cross-target objects | no runtime loaded | Clang target backends + binutils | CI adapter | NOT_RUN until exact-head CI |
| Java/ART | ART/Android, if selected | JDK/Android SDK | Android provider | NOT_IMPLEMENTED |
| NDK/Gradle/AndroidX | TBD; not core requirements | TBD for Android delivery | respective owners | TOKEN_VAZIO |
| OpenSSL/TLS | required security boundary TBD | version/license TBD | upstream + OS | BLOCKED; no ad-hoc cipher |
| Firebird engine/server | Firebird license/protocol/engine TBD | source and tools TBD | external/provenance | BLOCKED; no copied code |
| QEMU emulator | not core | optional hosted validation | emulator provider | NOT_USED |
| Signed APK/device E2E | Android OS + compatible ABI | packaging/signing/device | Android adapter | NOT_BUILT/NOT_RUN |

## Adversarial falsifiers and evidence promotion
1. Return distinctions: NULL+zero length, NULL+nonzero length, non-NULL empty, ASCII four spaces, four zero bytes and arbitrary bytes must remain different as declared. A number zero is a different input *type*, not a synonym for an empty text buffer. Four Unicode whitespace code points are not necessarily four ASCII 0x20 bytes.
2. ASan/UBSan host tests must run; no exceptions accepted as PASS.
3. Every ABI object must report expected ELF class/machine, ET_REL and zero undefined runtime symbols. Object success is not link success. Check assembly/stack/latency/device only when separately implemented.
4. Missing compiler, false ET_REL/class/machine, sanitizer failure, undefined symbol or missing artifact => CI FAIL. Binary reproducibility/security claims remain N5 without controlled toolchain and hardware.
5. `raf_l0_fold32` uses a simple public non-cryptographic rolling hash pattern, NOT secure hashing, integrity attestation or authentication; caller must guarantee valid 0..length readable buffer and valid output storage. All memory extent outside the provided contract is a typed risk.
6. Variants must not silently narrow from ARM32/ARM64 to only one ABI. Compare exact-head and previous head before promotion; no merge without independent review.

## Minimal rollback
Branch/draft PR only, no main changes. Close PR to stop proposal. On later merge, use a compensating commit with an append-only correction receipt; do not erase evidence.

## R3 / N5
F_ok: bounded source, proposed host gate, draft route. F_gap: no linked ELF, Android APK, full server, OS adapters, license approval, physical device, security review, signed release, provider enforcement. F_next: exact-head CI readback; linker and Android package as separate governed milestones.
claim_allowed=false.
