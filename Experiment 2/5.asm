section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    show db 'The number: '
    showlen equ $-show


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
    num resb size

; CHANGE SIZE TO THE NUMBER OF THE NUMBER
size equ 4

section .text
    global _start
_start:

    write ask, asklen
    read num, size
    write show, showlen
    write num, size

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h