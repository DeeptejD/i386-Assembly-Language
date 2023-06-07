section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    show db 'The numbers'
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

; CHANGE THIS TO THE NUMBER OF DIGITS OF THE NUMBER
size equ 5

; DECLARE VARIABLES
section .bss
    num1 resb size
    num2 resb size

section .text
    global _start
_start:

    write ask, asklen
    read num1, size
    write ask, asklen
    read num2, size
    write show, showlen
    endl
    write num1, size
    write num2, size


; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h