; DEMONSTRATE EQU DIRECTIVES

sys_exit equ 1
stdout equ 4
sys_write equ 1

section .data
    nl db "", 10
    nllen equ $-nl

    s1 db 'string 1'
    s1len equ $-s1

    s2 db 'string 2'
    s2len equ $-s2


; WRITE MACRO
%macro write 2
    mov eax, stdout
    mov ebx, sys_write
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

; READ MACRO
%macro read 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

; NEWLINE MACRO
%macro endl 0
    mov eax, stdout
    mov ebx, sys_write
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

; DECLARE VARIABLES
section .bss


section .text
    global _start
_start:

    write s1, s1len
    endl
    write s2, s2len
    endl


; EXIT CALL
    mov eax, sys_exit
    mov ebx, 0
    int 80h