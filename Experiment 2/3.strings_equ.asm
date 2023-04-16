sys_exit equ 1
sys_write equ 4
stdout equ 1
stdin equ 0 

section .data
    s1 db 'String 1', 9
    len1 equ $-s1

    s2 db 'String 2', 9
    len2 equ $-s2

section .text
global _start

_start:
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, s1
    mov edx, len1
    int 80h

    mov eax, sys_write
    mov ebx, stdout
    mov ecx, s2
    mov edx, len2
    int 80h

    mov eax, sys_exit
    int 80h
    