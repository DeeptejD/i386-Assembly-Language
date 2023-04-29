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

%macro newline 0
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

%macro space 0
    mov eax, 4
    mov ebx, 1
    mov ecx, s
    mov edx, slen
    int 80h
%endmacro

%macro return 0
    mov eax, 1
    int 80h
%endmacro

section .data
    ask db "Enter name: "
    asklen equ $-ask

    s db " "
    slen equ $-s

section .bss
    name resb 9
    count resb 9

section .text
    global _start
_start:
    write ask, asklen
    read name, 9

    mov byte [count], '1'

loop:
    write count, 9
    space
    write name, 9
    inc byte [count]
    cmp byte [count], '9'
    jle loop

    return
