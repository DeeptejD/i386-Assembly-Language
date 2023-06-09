section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    show db 'deeptej'
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
    n resb 1
    count resb 1
    temp resb 1


section .text
    global _start
_start:

    write ask, asklen
    read n, 2

    ; CHECK EVEN ODD
    mov al, [n]
    sub al, '0'
    mov [n], al

    mov byte[count], 0

    xor eax, eax
    mov al, [n]
    mov bl, 2
    div bl
    cmp ah, 0
    jne isodd

    iseven:
        mov bl, 2
        mov al, [n]
        mul bl
        mov [count], al
        inc byte[count]
        jmp print
    
    isodd:
        xor eax, eax
        mov bl, 2
        mov al, [n]
        div bl
        mov [count], al
        inc byte[count]
        jmp print
    
    print:  
        dec byte[count]
        mov al, [count]
        cmp al, 0
        je end

        mov al, [count]
        add al, '0'
        mov [temp], al
        write temp, 1
        endl 
        write show, showlen
        endl
        jmp print

    end:
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h