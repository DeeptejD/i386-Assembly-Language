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

    show db "The Sum: "
    showlen equ $-show
section .bss
    num1 resb 9
    num2 resb 9
    sum resb 9

section .text
    global _start

_start:
    write ask, asklen

    read num1
    read num2 

    mov esi, 2
    mov ecx, 3
    clc

add_loop:
    mov al, [num1 + esi]
    adc al, [num2 + esi]  
    aaa ;ascii adjust after addition
    pushf
    or al, 30h
    popf

    mov [sum + esi], al
    dec esi
    loop add_loop

    ; print the sum
    write show, showlen
    write sum, 9

    ; exits
    mov eax, 1
    mov ebx, 0
    int 80h