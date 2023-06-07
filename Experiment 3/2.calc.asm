section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter number: '
    asklen equ $-ask

    _sum db 'Sum: '
    _sumlen equ $-_sum

    _diff db 'Diff: '
    _difflen equ $-_diff

    _pro db 'Product: '
    _prolen equ $-_pro

    _quo db 'Quotient: '
    _quolen equ $-_quo

    _rem db 'Remainder: '
    _remlen equ $-_rem


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
    a resb 9
    b resb 9
    sum resb 9
    diff resb 9
    prod resb 9
    quo resb 9
    rem resb 9

section .text
    global _start
_start:

    write ask, asklen
    read a, 9
    write ask, asklen
    read b, 9

    ; SUM
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [sum], al

    write _sum, _sumlen
    write sum, 9
    endl

    ; DIFF
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    sub al, bl
    add al, '0'
    mov [diff], al

    write _diff, _difflen
    write diff, 9
    endl

    ; PRODUCT
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    mul bl
    add al, '0'
    mov [prod], al

    write _pro, _prolen
    write prod, 9
    endl

    ; DIVISION
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    div bl
    add al, '0'
    add ah, '0'
    mov [quo], al
    mov [rem], ah

    write _quo, _quolen
    write quo, 9
    endl
    write _rem, _remlen
    write rem, 9
    endl

    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h