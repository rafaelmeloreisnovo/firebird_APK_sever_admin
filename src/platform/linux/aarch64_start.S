/* Linux AArch64 OS boundary: syscall exit x8=93; not generic Android. */
.text
.p2align 2
.global _start
.type _start,%function
_start:
    bl raf_l0_selfcheck
    mov x8, #93
    svc #0
1:  b 1b
.size _start, . - _start
.section .note.GNU-stack,"",%progbits
