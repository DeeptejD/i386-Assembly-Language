; REPLACE A WORD IN A GIVEN STRING

section .data
    nl db "", 10
    nllen equ $-nl

    name db 'abc def'
    namelen equ $-name


; WRITE MACRO
%macro write 2
    mov eax, 4
    mov ebx, 1
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
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

; DECLARE VARIABLES
section .bss


section .text
    global _start
_start:

    write name, namelen
    endl

    mov [name], dword 'xyz '

    write name, namelen
    endl


; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h