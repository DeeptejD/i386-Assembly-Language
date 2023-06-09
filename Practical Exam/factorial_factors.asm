; FIND THE FACTORIAL OF NUMBERS LESS THAN 3 AND FACTORS FOR GREATER THAN 3
section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    showfact db 'Factorial: '
    showfactlen equ $-showfact

    showfactor db 'Factors: '
    showfactorslen equ $-showfactor

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
    n resb 1
    fact resb 1
    count resb 1
    temp resb 1

section .text
    global _start
_start:

    write ask, asklen
    read n, 2

    ; converted input to a number
    mov al, [n]
    sub al, '0'
    mov [n], al
    mov al, [n]

    cmp al, 3
    jle factorial
    jmp factors

    factorial:
        call fact_procedure
        jmp exit
    
    factors:
        call F
        jmp exit
    
    exit:
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h

fact_procedure:
    mov byte [fact], 1
    mov al, [n]
    cmp al, 0
    jz is_zero

    mov al, [n]
    mov byte[count], 0

    fact_loop:
        inc byte[count]
        mov al, [count]
        mov bl, [n]
        cmp al, bl
        jg end_factorial

        mov al, [fact]
        mov bl, [count]
        mul bl
        mov [fact], al
        jmp fact_loop

    is_zero:
        jmp end_factorial
    
    end_factorial:
        write showfact, showfactlen
        mov al, [fact]
        add al, '0'
        mov [fact], al
        write fact, 1
        endl
ret

F:
    mov al, [n]
    mov byte [count], 0

    factors_loop:
        inc byte[count]
        mov al, [count]
        mov bl, [n]
        cmp al, bl
        jg end_factors

        xor eax, eax
        mov al, [n]
        mov bl, [count]
        div bl
        cmp ah, 0
        je found_factor
        jmp factors_loop

        found_factor:
            mov al, [count]
            add al, '0'
            mov [temp], al
            write temp, 1
            write space, spacelen
            jmp factors_loop
        
        end_factors:
ret