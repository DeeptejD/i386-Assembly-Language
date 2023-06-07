; FIB USING PROCEDURES

section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    show db 'Fibonacci: '
    showlen equ $-show

    space db ' '
    spacelen equ $-space

; DECLARE VARIABLES
section .bss
    i resb 1
    n resb 1
    a resb 1
    b resb 1
    c resb 1


section .text
    global _start
_start:
    mov ecx, ask
    mov edx, asklen
    call write

    mov ecx, n
    mov edx, 1
    call read

    mov ecx, show
    mov edx, showlen
    call write

    call fib
    call endl

    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h

write:
    mov eax, 4
    mov ebx, 1
    int 80h
ret

read:
    mov eax, 3
    mov ebx, 2
    int 80h
ret

endl:
    mov ecx, nl
    mov edx, nllen
    call write
    int 80h
ret

formula:
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [c], al
ret

makespace:
    mov ecx, space
    mov edx, spacelen
    call write
ret

fib:
    mov [i], byte '0'
    mov [a], byte '0'
    mov [b], byte '1'

    mov al, [n]
    cmp al, '0'
    je exit

    mov ecx, a
    mov edx, 1
    call write
    call makespace
    inc byte[i]

    mov al, [i]
    cmp al, byte[n]
    je exit

    mov ecx, b
    mov edx, 1
    call write
    call makespace

    inc byte[i]
    mov al, [i]
    cmp al, byte[n]
    je exit

    loop:
        call formula
        mov ecx, c
        mov edx, 1
        call write
        call makespace

        mov al, [b]
        mov [a], al
        mov al, [c]
        mov [b], al

        inc byte[i]
        mov al, [i]
        cmp al, byte[n]
        je exit
        jmp loop
    exit:
ret