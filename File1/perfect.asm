; a number is said to be a perfect number if it is equal to the sum of its positive divisors, except the number itself
section .data
    nl db "", 10
    nllen equ $-nl 

    ask db 'Enter: '
    asklen equ $-ask

    yes db ' is a perfect number'
    yeslen equ $-yes

    no db ' is not a perfect number'
    nolen equ $-no


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
    sum resb 1
    count resb 1


section .text
    global _start
_start:
    
    write ask, asklen
    read a, 2

    mov al, [a]
    sub al, '0'
    mov [a], al

    mov byte[count], 0
    mov byte[sum], 0

    aliquot_sum:
        inc byte[count]
        mov al, [count]
        mov bl, [a]
        cmp al, bl
        jge op

        xor eax, eax
        mov al, [a]
        mov bl, [count]
        div bl
        cmp ah, 0
        je fact_found
        jmp aliquot_sum

        fact_found:
            mov al, [sum]
            mov bl, [count]
            add al, bl
            mov [sum], al
            jmp aliquot_sum 

    op:
        mov al, [a]
        mov bl, [sum]
        cmp al, bl
        je is
        jmp isnot

    is:
        mov al, [a]
        add al, '0'
        mov [a], al
        write a, 1
        write yes, yeslen
        endl
        jmp exit
    
    isnot:
        mov al, [a]
        add al, '0'
        mov [a], al
        write a, 1
        write no, nolen
        endl
    
    exit:


; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h