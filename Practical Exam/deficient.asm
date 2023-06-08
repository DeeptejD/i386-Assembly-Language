; FIND IF A NUMBER IS DEFICIENT OR NOT AND PRINT ITS DEFICIENCY

section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    yes db ' is a deficient number'
    yeslen equ $-yes

    no db ' is not a deficient number'
    nolen equ $-no

    show db 'The deficiency is: '
    showlen equ $-show

    showfactors db 'Factors: '
    showfactlen equ $-showfactors

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
    count resb 1
    sum resb 1
    n resb 1
    deficiency resb 1
    temp resb 1


section .text
    global _start
_start:

    write ask, asklen
    read n, 2

    mov byte [count], 0
    mov byte [sum], 0
    mov byte [deficiency], 0

    write showfactors, showfactlen

    aliquot_sum:
        inc byte[count]
        mov al, [count]
        mov bl, [n]
        sub bl, '0'
        cmp al, bl
        jge check

        xor eax, eax
        xor ebx, ebx
        mov al, [n]
        sub al, '0'
        mov bl, [count]
        div bl
        cmp ah, 0
        je foundfactor
        jmp aliquot_sum

        foundfactor:
            mov al, [count]
            mov [temp], al
            add [temp], byte '0'
            write temp, 1
            write space, 1
            mov al, [count]
            add [sum], al
            jmp aliquot_sum
        
        check:
            mov al, [sum]
            mov bl, [n]
            sub bl, '0'
            cmp al, bl
            je not_def
            jmp calc_def
        
        calc_def:
            endl
            write n, 1
            write yes, yeslen
            endl
            mov al, [n]
            sub al, '0'
            mov bl, [sum]
            sub al, bl
            mov [deficiency], al
            jmp op
        
        not_def:
            endl
            write n, 1
            write no, nolen
            endl

        op:
            add [deficiency], byte '0'
            write show, showlen
            write deficiency, 1
            endl
            

    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h