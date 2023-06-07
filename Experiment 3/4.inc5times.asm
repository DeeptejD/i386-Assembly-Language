; READ A NUMBER AND PRINT NEXT 5 NUMBERS USING INCREMENT OPERATOR
section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    show db 'The next 5 numbers'
    showlen equ $-show

    space db '-> '
    spacelen equ $-space


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
    num resb 1
    count resb 1


section .text
    global _start
_start:

    write ask, asklen
    read num, 2

    write num, 1
    endl
    write show, showlen
    endl
    mov byte [count], '0'
    loop:
        inc byte [count]
        mov al, [count]
        cmp al, '6'
        je exit
        inc byte[num]
        write count, 1
        write space, spacelen
        write num, 1
        endl
    jmp loop

    exit:
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h