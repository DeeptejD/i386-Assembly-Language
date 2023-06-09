; SUM OF THRE NUMBERS

section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    show db 'Sum: '
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
    a resb 1
    b resb 1
    c resb 1
    sum resb 1

section .text
    global _start
_start:

    write ask, asklen
    read a, 2
    write ask, asklen
    read b, 2
    write ask, asklen
    read c, 2

    ; ADDITION
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    add al, bl
    mov bl, [c]
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [sum], al

    write show, showlen
    write sum, 1
    endl

    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h