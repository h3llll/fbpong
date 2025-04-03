section .text
    global _start      ; Make _start visible to the linker
    extern main        ; Declare main, since it's in C

_start:
    call main          ; Call main()
    mov rdi, rax       ; Set exit code to the return value of main (rax)
    mov rax, 60        ; Syscall number for exit (60)
    syscall            ; Invoke the exit syscall
