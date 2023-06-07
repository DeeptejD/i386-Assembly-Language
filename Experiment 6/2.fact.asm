; FACT USING PROCEDURES

section .data
    nl db "", 10
    nllen equ $-nl

    ask db 'Enter: '
    asklen equ $-ask

    show db 'Factorial: '
    showlen equ $-show

    space db ' '
    spacelen equ $-space

; DECLARE VARIABLES
section .bss
    temp resb 1
    fact resb 1
    n resb 1


section .text
    global _start
_start:

    mov ecx, ask
    mov edx, asklen
    call write
   
    mov ecx, n
    mov edx, 1
    call read
    
    call factorial

    mov ecx, show
    mov edx, showlen
    call write

    mov ecx, fact
    mov edx, 1
    call write

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

factorial:
    mov [temp], byte '1'
    mov [fact], byte '1'
    cmp [n], byte '0'
    je exit

    loop:
        mov al, [fact]
        mov bl, [temp]
        sub al, '0'
        sub bl, '0'
        mul bl
        add al, '0'
        mov [fact], al
        inc byte[temp]
        mov al, [temp]
        cmp al, [n]
        jle loop

    exit:
ret