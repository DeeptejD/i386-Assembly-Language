section .data
    nl db "", 10
    nllen equ $-nl 

    ask db 'Enter: '
    asklen equ $-ask

    showfact db 'Factoial : '
    showfactlen equ $-showfact

    showF db 'Factors: '
    showFlen equ $-showF

    space db ' '
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
    a resb 1
    count resb 1
    factorial resb 1


section .text
    global _start
_start:
    
    write ask, asklen
    read a, 2

    mov al, [a]
    sub al, '0'
    mov [a], al

    cmp al, 3
    jle factjmp
    jmp factors

    factjmp:
        call fact_procedure
    jmp exit
    
    factors:
        call F_pro

exit:
; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h

fact_procedure:
    mov byte[factorial], 1
    mov al, [a]
    cmp al, 0
    jz is_zero

    mov byte[count], 0

    factorial_loop:
        inc byte[count]
        mov al, [count]
        mov bl, [a]
        cmp al, bl
        jg exit_factorial

        mov al, [factorial]
        mov bl, [count]
        mul bl
        mov [factorial], al
    jmp factorial_loop

    is_zero:

    exit_factorial:
        write showfact, showfactlen
        mov al, [factorial]
        add al, '0'
        mov [factorial], al
        write factorial, 1
        endl
ret

F_pro:
    write showF, showFlen
    mov byte[count], 0

    factors_loop:
        inc byte[count]
        mov al, [a]
        mov bl, [count]
        xor ah, ah
        div bl
        cmp ah, 0
        je found_factor
        jmp factors_loop
    
    found_factor:
        mov al, [count]
        add al, '0'
        mov [count], al
        write count, 1
        write space, spacelen
        mov al, [count]
        sub al, '0'
        mov [count], al
        jmp factors_loop
ret