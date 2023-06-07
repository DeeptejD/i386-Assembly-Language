; PRINT NAME 9 TIMES

section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter name: '
    asklen equ $-ask

    space db ' '
    spacelen equ $-space

    name times 100 db 0

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
     count resb 1


section .text
    global _start
_start:

    write ask, asklen
    read name, 100
    mov [count], byte '1'

    loop:
        write count, 1
        write space, spacelen
        write name, 100
        endl
        mov al, [count]
        cmp al, '9'
        je exit
        inc byte [count]
        jmp loop
    
    exit:
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h