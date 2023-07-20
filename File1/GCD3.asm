section .data
    nl db "", 10
    nllen equ $-nl 

    ask db 'Enter number: '
    asklen equ $-ask

    show db 'GCD: '
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
    a resb 1
    b resb 1
    c resb 1
    gcd resb 1


section .text
    global _start
_start:
    
    write ask, asklen
    read a, 2
    write ask, asklen
    read b, 2
    write ask, asklen
    read c, 2

    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'

    call GCD

    mov bl, [c]
    sub bl, '0'

    call GCD

    add al, '0'

    mov [gcd], al
    write show, showlen
    write gcd, 1
    endl

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h

GCD:
    ; check fi any of them is zero
    cmp al, 0
    je al_0

    cmp bl, 0
    je bl_0

    ; check if any of them is 1
    cmp al, 1
    je esc_1

    cmp bl, 1
    je esc_1

    ; put the bigger number in al

    cmp al, bl
    jg al_greater

    xchg al, bl

    al_greater:
        xor ah, ah
        div bl
        cmp ah, 0
        jz exit

        xchg ah, bl
        jmp GCD
    
    al_0:
        mov al, bl
        jmp exit
    
    bl_0:
        jmp exit
    
    esc_1:
        mov al, 1
    
    exit:
ret