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
    num1 resb 9
    num2 resb 9
    result resb 9

section .text
    global _start
_start:
    write ask, asklen
    read num1, 9
    write ask, asklen
    read num2, 9

    mov eax, [num1]
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0'

    ; Calculate GCD using Euclidean algorithm
    check:
        cmp ebx, 0
        je end
        mov edx, eax
        mov eax, ebx
        xor edx, edx
        div ebx
        mov ebx, edx
        jmp check

    end:
        add eax, '0'
        mov [result], eax
        write show, showlen
        write result, 9
        endl

        mov eax, 1
        int 80h
