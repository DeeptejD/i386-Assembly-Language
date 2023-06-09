; VOLUME OF A CONE
section .data
    nl db "", 10
    nllen equ $-nl

    askrad db 'Enter Radius: '
    askradlen equ $-askrad

    askh db 'Enter Height: '
    askhlen equ $-askh

    show db 'Volume (approx) : '
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
    r resb 1
    h resb 1
    vol resb 1


section .text
    global _start
_start:

    write askrad, askradlen
    read r, 2
    write askh, askhlen
    read h, 2
    
    mov al, [r]
    sub al, '0'
    mov [r], al

    mov al, [h]
    sub al, '0'
    mov [h], al

    mov byte [vol], 1

    mov al, [vol]

    mov bl, 22
    mul bl
    mov bl, 7
    div bl
    mov bl, [r]
    mul bl
    mul bl
    mov bl, [h]
    mul bl
    mov bl, 3
    div bl
    add al, '0'
    mov [vol], al

    write show, showlen
    write vol, 1
    endl

    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h