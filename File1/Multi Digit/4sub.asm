section .data
    nl db "", 10
    nllen equ $-nl 

    ask db 'Enter: '
    asklen equ $-ask

    show db 'Diff: '
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
    a resb 4
    b resb 4
    diff resb 4


section .text
    global _start
_start:
    
    write ask, asklen
    read a, 5
    write ask, asklen
    read a, 5

    mov esi, 3
    mov ecx, 4
    clc

    subtract:
        mov al, [a + esi]
        sbb al, [b + esi]
        aas

        pushf
        or al, 30h
        popf

        mov [diff + esi], al
        dec esi
        loop subtract
    

    write show, showlen
    write diff, 4
    endl

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h