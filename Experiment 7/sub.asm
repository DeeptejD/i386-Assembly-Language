%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 1
    mov eax, 3
    mov ebx, 2
    mov ecx, %1 
    mov edx, 9
    int 80h
%endmacro

section .data
    ask db "Enter a number: "
    asklen equ $-ask

    show db "The Diff: "
    showlen equ $-show
section .bss
    num1 resb 9
    num2 resb 9
    diff resb 9

section .text
    global _start

_start:
    write ask, asklen

    read num1
    read num2 

    mov esi, 2
    mov ecx, 3
    clc

    sub_loop:

    mov al, [n1 + esi]
    sbb al, [n1 + esi]
    aas
    pushf
    or al, 30h
    popf

    mov [diff + esi], al
    dec esi
    loop sub_loop

    write show, showlen
    write diff, 5

    mov eax, 1
    int 80h

