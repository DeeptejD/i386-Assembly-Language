section .data
    nl db "", 10
    nllen equ $-nl 

    ask db 'Enter: '
    asklen equ $-ask

    show db 'Factors: '
    showlen equ $-show

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
    a resb 2
    count resb 1
    temp resb 1

section .text
    global _start
_start:
    
    write ask, asklen
    read a, 3

    mov al, [a + 0]
    sub al, '0'
    ; mov [temp], al
    ; write temp, 1
    ; endl
    mov bl, 10
    ; mov [temp], al
    ; write temp, 1
    ; endl
    mul bl
    mov bl, [a + 1];
    sub bl, '0'
    add al, bl

    add al, '0'
    mov [temp], al
    write temp, 2
    endl
    mov al, [temp]
    sub al, '0'
    mov [temp], al

    mov [temp], al
    mov byte[count], 0

    check:
        inc byte[count]
        mov al, [count]
        cmp al, 10
        jge done

        mov al, [temp]
        mov bl, [count]
        xor ah, ah
        div bl
        cmp ah, 0
        je found
        jmp check
    
    found:
        mov al, [count]
        add al, '0'
        mov [count], al
        write count, 1
        write space, spacelen
        mov al, [count]
        sub al, '0'
        mov [count], al
        jmp check
    
    done:
; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h