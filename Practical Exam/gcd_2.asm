; GCD OF TWO NUMBERS
section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    show db 'GCD: '
    showlen equ $-show

    zero db '0'
    zerolen equ $-zero

    one db '1'
    onelen equ $-one


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
    b resb 1
    gcd resb 1


section .text
    global _start
_start:

    write ask, asklen
    read a, 2
    write ask, asklen
    read b, 2

    mov al, [a]
    mov bl, [b]

    sub al, '0'
    sub bl, '0'

    call GCD

    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h

GCD:
    cmp al, 0
    je escape_0_al
    cmp bl, 0
    je escape_0_bl
    cmp al, 1
    je escape_1
    cmp bl, 1
    je escape_1

    cmp al, bl
    jg a_greater

    xchg al, bl

    a_greater:
        xor ah, ah
        div bl
        cmp ah, 0
        jz exit

        xchg ah, bl
    jmp GCD
    
    exit:
      add al, '0'
        mov [gcd], al

        write show, showlen
        write gcd, 1
        endl

    escape_0_al:
        add bl, '0'
        mov [gcd], bl
        write show, showlen
        write gcd, 1
        endl
        jmp escape
    
    escape_0_bl:
        add al, '0'
        mov [gcd], al
        write show, showlen
        write gcd, 1
        endl
        jmp escape

    escape_1:
        write one, onelen
        endl
        jmp escape

    escape:     
ret