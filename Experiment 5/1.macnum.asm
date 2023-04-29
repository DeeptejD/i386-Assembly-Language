; a) Write an assembly language program to implement the write system call to display a number using macros.
; 211105017 Deeptej Dhauskar

%macro write 2
    mov eax, 4
    mov ebx, 1
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

%macro return 0
    mov eax, 1
    int 80h
%endmacro

section .data
    num db '5'
    numlen equ $-num

    nl db "", 10
    nllen equ $-nl

section .text
    global _start
_start:
    write num, numlen
    newline
    return