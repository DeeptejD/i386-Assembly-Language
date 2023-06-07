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
    num1 resb 1
    num2 resb 1
    res resb 1

section .text
    global _start
_start:

    write ask, asklen
    read num1, 2        ; i've added 2 cuz, while taking input this shit takes the enter as the input for the next read stmt, trust me its crazy, so 2, 1 byte for the actual number and 1 for the enter
    write ask, asklen
    read num2, 2
    sub [num1], byte '0'
    sub [num2], byte '0'

    mov al, [num1]
    mov bl, [num2]
    add al, bl
    add al, '0'
    mov [res], al

    write show, showlen
    write res, 2
    endl

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h