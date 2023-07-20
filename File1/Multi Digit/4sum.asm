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
    a resb 4
    b resb 4
    sum resb 4


section .text
    global _start
_start:
    
    write ask, asklen
    read a, 5
    write ask, asklen
    read b, 5

    mov esi, 3
    mov ecx, 4

    add:
        mov al, [a + esi]
        adc al, [b + esi]
        aaa

        pushf
        or al, 30h
        popf

        mov [sum + esi], al
        dec esi
        loop add
    
    write show, showlen
    write sum, 4
    endl

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h