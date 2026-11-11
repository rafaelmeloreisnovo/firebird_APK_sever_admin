/* Linux ARM EABI OS boundary: syscall exit r7=1; not generic Android. */
.syntax unified
.text
.p2align 2
.global _start
.type _start,%function
_start:
    bl raf_l0_selfcheck
    mov r7, #1
    svc #0
1:  b 1b
.size _start, . - _start
.section .note.GNU-stack,"",%progbits
