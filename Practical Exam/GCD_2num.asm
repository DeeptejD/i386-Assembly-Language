; GCD OF TWO NUMBERS // WORKING for 2 numbers

section .data
    ask db 'Enter number: '
    asklen equ $-ask

    show db 'GCD: '
    showlen equ $-show

    nl db '', 10
    nllen equ $-nl

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
    mov edx, %1
    int 80h
%endmacro

%macro endl 0
    write nl, nllen
%endmacro

section .bss
    num1 resb 4
    num2 resb 4
    result resb 4

section .text
    global _start
_start:
    write ask, asklen
    read num1, 9
    write ask, asklen
    read num2, 9

    mov al, [num1]
    sub al, '0'
    mov bl ,[num2]
    sub bl, '0'

    check:
        cmp al, bl
        je end
        jb num1_less
        sub al, bl
        jmp check

    num1_less:
        sub bl, al
        jmp check

    end:
        add al, '0'
        mov [result], al
        write show, showlen
        write result, 4
        endl

        mov eax, 1
        int 80h

; Output
; Enter number: 67
; Enter number: 21
; GCD: 2