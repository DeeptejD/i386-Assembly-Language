%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro return 0
    mov eax, 1
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro newline 0
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

section .data
    ask db "Enter: "
    asklen equ $-ask

    nl db "", 10
    nllen equ $-nl

section .bss
    num1 resb 9
    num2 resb 9

section .text
    global _start
_start:
    write ask, asklen
    read num1, 9
    write num1, 9
    write ask, asklen
    read num2, 9
    write num2, 9
    newline
    return