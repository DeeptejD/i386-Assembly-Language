%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1 
    mov edx, %2
    int 80h
%endmacro

section .data
    askmin db "Enter the minuend: "
    askminlen equ $-askmin

    asksub db "Enter the subtrahend: "
    asksublen equ $-asksub

    show db "The Diff: "
    showlen equ $-show

    nl db '', 10
    nllen equ $-nl
section .bss
    num1 resb 5
    num2 resb 5
    diff resb 5

section .text
    global _start

_start:
    write askmin, askminlen
    read num1, 5
    write asksub, asksublen
    read num2, 5

    mov esi, 2
    mov ecx, 3
    clc

    sub_loop:

    mov al, [num1 + esi]
    sbb al, [num2 + esi]
    aas
    pushf
    or al, 30h
    popf

    ; or al, 30h
    mov [diff + esi], al
    
    dec esi
    loop sub_loop

    write show, showlen
    write diff, 5

    write nl, nllen

    mov eax, 1
    int 80h

