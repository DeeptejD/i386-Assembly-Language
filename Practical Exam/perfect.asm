; PERFECT NUMBER
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
    count resb 1
    sum resb 1
    n resb 1
    temp resb 1

section .text
    global _start
_start:

    write ask, asklen
    read n, 2

    mov byte[count], 0
    mov byte[sum], 0

    aliquot_sum:
        inc byte[count]
        mov al, [count]
        mov bl, [n]
        sub bl, '0'
        cmp al, bl
        jge op

        xor eax, eax
        mov al, [n]
        sub al, '0'
        mov bl, [count]
        div bl
        cmp ah, 0
        je foundfactor
        jmp aliquot_sum
    
    foundfactor:
        mov al, [count]
        add [sum], al
        jmp aliquot_sum
    
    op:
        add [sum], byte '0'
        write sum, 1
        endl
        write n, 1
        endl
        xor eax, eax
        xor ebx, ebx
        mov al, [sum]
        mov bl, [n]
        cmp al, bl
        je is
        jmp isnot

    is:
        write n, 1
        write yes, yeslen
        endl
        jmp exit
    
    isnot:
        write n, 1
        write no, nolen
        endl
    
    exit:
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h