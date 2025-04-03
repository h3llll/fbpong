section .text
    global sys_write
    global sys_openat
    global sys_mmap
    global sys_ioctl
    global sys_exit
    global memcpy
    global sys_getpagesize
    ; i use pure syscall and i wanted to make memcpy in asm because optimization
read        equ     0 
write       equ     1 
openat      equ     257
close       equ     3 
poll        equ     7
mmap        equ     9
munmap      equ     11 
ioctl       equ     16 
nanosleep   equ     35
exit        equ     60
getpagesize equ     203    

sys_write:
    mov  rax, write
    syscall
    ret

sys_openat:
    mov  rax, openat
    syscall
    ret

sys_mmap:
    mov  rax, mmap
    syscall
    ret

sys_ioctl:
    mov  rax, ioctl
    syscall
    ret

sys_exit:
    mov  rax, exit
    syscall
    ret 

sys_munmap:
    mov  rax, munmap
    syscall
    ret

sys_getpagesize:
    mov rax, getpagesize
    syscall
    ret

memcpy:
    test rdx, rdx   ; rdx is the third argument register, 
                    ; i think using test this way it outputs the value of rdx 
                    ; note : performs bitwise operation (fast assembly moment)
    
    jz   .done      ; and this jumps if the value of rdx is zero
                    ; which is helt somewhere after i used test
                    ; register later

    mov  rcx, rdx   ; moves rdx to rcx, rdx is the number of bytes to copy
                    ; argument and r**c**x is the loop counter register,
                    ; because we'll loop later to copy the bytes to 
                    ; the destination argument pointer

    shr  rcx, 3     ; shifts rcx 3 bytes to the right which devides 
                    ; by 8 apparently.. (assembly fast moment)
                    ; note : (shr: SHift Right)

    rep  movsq      ; repeats movsq for n times if n is the value in rcx
                    ; note : (rep: REPeat)

                    ; note : (movsq: MOVe SeQuence) (which also copies 8 bytes)
                    ; at a time

    mov  rcx, rdx   ; moves back rdx to rcx, since we devided rcx by 8 earlier
                    ; we need to care about the leftover bytes if the byte 
                    ; amount wasn't perfectly splittable to sequences of 8's

    and  rcx, 7     ; performs bitwise and (assembly fast moment) to get the
                    ; remainder of rcx after dividing by 8, simply % 8
    
    test rcx, rcx   ; legit same as above usage
    jz   .done      

    rep movsb       ; i think movsb is just movsq but moves 1 byte instead of 8

.done: 
    ret             ; returns, lol

