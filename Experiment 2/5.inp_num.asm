section .data
    sys_write equ 4     ; equ directive
    sys_exit equ 1
    stdin equ 0
    stdout equ 1
    read1 db "Enter number: ", 10
    numlen1 equ $-read1

section .bss
    num resb 9

section .text
    global _start
_start:
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, read1
    mov edx, numlen1
    int 80h
    
    ; READ NUMBER 
    mov eax, 3
    mov ebx, 2
    mov ecx, num
    mov edx, 9
    int 80h

    mov eax, sys_write
    mov ebx, stdout
    mov ecx, num
    mov edx, 9
    int 80h

    mov eax, sys_exit
    mov ebx, stdin
    int 80h