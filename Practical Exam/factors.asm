; FIND THE FACTORS OF A NUMBER

section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter number: '
    asklen equ $-ask

    show db 'Factors: '
    showlen equ $-show

    ; array times 100 db 0


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
    num resb 1
    count resb 1
    temp resb 1
    ; arr_count resb 1


section .text
    global _start
_start:

    write ask, asklen
    read num, 2

    mov byte [count], 0

    loop:
        inc byte [count]
        mov al, [count]
        mov bl, [num]
        sub bl, '0'
        cmp al, bl
        jg exit

        xor eax, eax
        mov al, [num]
        sub al, '0'
        mov bl, [count]
        div bl
        cmp ah, 0
        je foundfactor
        jmp loop
        

    foundfactor:
        mov al, [count]
        mov [temp], al
        add [temp], byte '0'
        write temp, 1
        endl
        jmp loop

    exit:
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h