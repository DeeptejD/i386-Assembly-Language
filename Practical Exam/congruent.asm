; CONGRUENT NUMBERS

section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    yes db 'congruent number'
    yeslen equ $-yes

    no db 'not a congruent number'
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
    b resb 1
    rem1 resb 1
    rem2 resb 1


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

    mov [a], al
    mov [b], bl

    mov cl, 2

    mov al, [a]
    mov bl, [b]

    cmp al, bl
    jg a_greater

    mov dl, [b]
    jmp check

    a_greater:
        mov dl, [a]
    
    check:
        cmp cl, dl
        je isnot
        xor eax, eax
        mov al, [a]
        mov bl, cl
        div bl
        mov [rem1], ah

        xor eax, eax
        mov al, [b]
        mov bl, cl
        div bl
        mov [rem2], ah

        mov al, [rem1]
        mov bl, [rem2]

        cmp al, bl
        je is
        inc cl
        jmp check
    
    is:
        write yes, yeslen
        endl
        jmp exit
    
    isnot:
        write no, nolen
        endl

    exit:
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h