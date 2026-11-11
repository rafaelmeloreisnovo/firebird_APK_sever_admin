/* Linux x86-64 OS boundary: SYS_exit only. Not Android. */
.text
.global _start
.type _start,@function
_start:
    andq $-16, %rsp
    call raf_l0_selfcheck
    movl %eax, %edi
    movl $60, %eax
    syscall
1:  jmp 1b
.size _start, . - _start
.section .note.GNU-stack,"",@progbits
