section .data
    ask db 'Enter: '
    asklen equ $-ask

    show db 'Factorial: '
    showlen equ $-show

    nl db '', 10
    nllen equ $-nl

section .bss
    num resb 4
    fact resb 4
    temp resb 4

section .text
    global _start
_start:
    ; print input message
    mov ecx, ask
    mov edx, asklen
    call print

    ; input number
    mov ecx, num
    mov edx, 4
    call read

    ; show output message
    mov ecx, show
    mov edx, showlen
    call print

    call Factorial

    ; print a factorial
    mov ecx, fact
    mov edx, 4
    call print

    ; print a newline
    mov ecx, nl
    mov edx, nllen
    call print

    mov eax, 1
    int 80h

print:
    mov eax, 4
    mov ebx, 1
    int 80h
ret

read:
    mov eax, 3
    mov ebx, 2
    int 80h
ret

Factorial:
    mov byte[temp], '1' 
    mov byte[fact], '1' ; mov 1 to the fact ans

    L1:
        mov eax, [fact]
        sub eax, '0'
        mov ebx, [temp]
        sub ebx, '0'
        mul ebx
        add eax, '0'
        mov [fact], eax

        inc byte[temp] 

        mov al, [temp]
        cmp al, byte[num]
        jle L1
ret
