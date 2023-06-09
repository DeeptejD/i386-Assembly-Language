; TOTAL AND CURVED SURFACE AREA OF A CONE
section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter length: '
    asklen equ $-ask

    askr db 'Enter radius: '
    askrlen equ $-askr

    showtsa db 'TSA: '
    showtsalen equ $-showtsa

    showcsa db 'CSA: '
    showcsalen equ $-showcsa


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
    l resb 1
    r resb 1
    tsa resb 1
    csa resb 1



section .text
    global _start
_start:

    write ask, asklen
    read l, 2
    write askr, askrlen
    read r, 2
    mov al, [r]
    sub al, '0'
    mov [r], al
    mov al, [l]
    sub al, '0'
    mov [l], al

    mov byte[tsa], 0
    mov byte[csa], 0

    ; FINDING TSA
    mov al, [r]
    mov bl, [l]
    add al, bl
    mov bl, [r]
    mul bl
    mov bl, 22
    mul bl
    mov bl, 7
    div bl
    add al, '0'
    mov [tsa], al

    ; FINDING CSA
    mov al, [l]
    mov bl, [r]
    mul bl
    mov bl, 22
    mul bl
    mov bl, 7
    div bl
    add al, '0'
    mov [csa], al

    write showtsa, showtsalen
    write tsa, 1
    endl

    write showcsa, showcsalen
    write csa, 1
    endl

    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h