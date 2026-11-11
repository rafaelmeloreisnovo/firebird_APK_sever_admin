# AGENTS.md — firebird_APK_sever_admin

Role: producer for this repository ONLY. RAFAELIA START HERE Ω V2.2 is the router; RafGitTools is a separate tool/CI producer; Mapa governs federation, not this repository's implementation.

## Authority & non-negotiable gates
1. Read `001_PONTEIRO/START_HERE.md`, then only task-relevant sources.
2. Bind exact branch/commit/path and current CI evidence; unknown = `TOKEN_VAZIO`.
3. Preserve original README, historical receipts, third-party license and provenance.
4. Do not import Firebird, OpenSSL, NDK, JDK, Android, QEMU, or other vendor code without explicit purpose, origin, permission and dependency boundary.
5. `SOURCE != ARTIFACT != EXECUTION != EVIDENCE != CLAIM`; `IMPLEMENTED_UNTESTED != PASS`.
6. Core `src/raf_l0.c` must compile without libc, headers, heap, syscalls or platform APIs; no FFI promises.
7. Hosted scripts, GitHub Actions, Clang and ELF inspectors are build tools, NOT freestanding runtime.
8. Test both host behavior and ABI-specific object header/symbols. ET_REL does not prove a bootable or runnable ELF. No APK until Android package, manifests, launcher, signing and device tests exist.
9. Never auto-merge, auto-publish, deploy a server, invent a commercial license or infer physical-device results.
10. Every material change: falsifier → minimal branch delta → CI exact-head → receipt → rollback via closing draft PR (without merge).

Current state on bootstrap: producer repo originally held README only. This branch contains a scoped prototype and pipeline; CI/device/release state must be independently read.
