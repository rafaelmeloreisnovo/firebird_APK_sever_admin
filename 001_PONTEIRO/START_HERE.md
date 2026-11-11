# START HERE — Firebird APK Server Admin / RAFAELIA Ω V2.2

STATE: BOOTSTRAP_DRAFT_HOLD; claim_allowed=false. Exact-head CI and device evidence are not embedded assertions.

## μREAD routes
- Current source: `src/raf_l0.c` (bounded original L0 primitive, not Firebird protocol).
- Host test: `tests/raf_l0_host_test.c`.
- Hosted L0 CI gate: `scripts/verify_l0.sh` and `.github/workflows/l0-freestanding.yml`.
- Linked L1 Linux: `docs/ARCHITECTURE_L1_LINUX.md` → `src/raf_l0_selfcheck.c` → `src/platform/linux/*_start.S` → `scripts/verify_linked_linux.sh`.
- Authority/limitations/ABI/dependency ledger: `docs/ARCHITECTURE_L0.md`.
- Cross-repository dispatcher: `rafaelmeloreisnovo/RafGitTools` PR #820 (historical draft route, not automatically merged authority).
- Source predecessor: `rafaelmeloreisnovo/firebird_rafcodephi` (separate upstream-derived codebase; no copying in this branch).
- Historical base commit: `fc021a01826e893db542edcde91c8abef9c75662` (README only).
- Drive router: START HERE — RAFAELIA Ω CANONICAL V2.2 DISPATCH.

## Dispatcher
INTENT → CURRENT_STATE → μREAD(depth1) → SOURCE_MIN → AUTHORITY → ACT → GATE → RECEIPT → R3.
Block if SOURCE/AUTHORITY/EXECUTION_TARGET/EVIDENCE_RULE missing. Preserve N5/TOKEN_VAZIO. Never treat new source, compiled object or a successful job as an Android APK.

Rollback: close the draft PR; baseline main remains unchanged unless someone merges it.
