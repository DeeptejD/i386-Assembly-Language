; 211105017@Deeptej
section .data
    ask db 'Enter: '
    asklen equ $-ask

    show db 'Fibonacci: '
    showlen equ $-show

    nl db '', 10
    nllen equ $-nl

section .bss
    num resb 5
    n1 resb 5
    n2 resb 5
    n3 resb 5
    n4 resb 5

section .text
    global _start
_start:

    mov ecx, ask
    mov edx, asklen
    call print

    mov ecx, num
    mov edx, 5
    call read

    mov ecx, show
    mov edx, showlen
    call print

    call fib

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

newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
ret

formula:
    mov eax, [n2]
    sub eax, '0'

    mov ebx, [n3]
    sub ebx, '0'

    add eax, ebx ; adding n2 and n3 to give next term
    add eax, '0'

    mov [n4], eax
ret

fib:
    ; init first 3 terms
    mov byte[n1], '0'
    mov byte[n2], '0'
    mov byte[n3], '1'

    mov al, byte[n1]
    cmp al, byte[num]
    JL L1
    JMP L4

L1:
    ; printing the first term
    mov ecx, n2
    mov edx, 5
    call print

    inc byte[n1]
    mov al, [n1]

    cmp al, byte[num]
    JL L2
    JMP L4

L2:
    ; printing the second term
    mov ecx, n3
    mov edx,5
    call print

    inc byte[n1]
    mov al, [n1]

    cmp al, byte[num]
    JL L3
    JMP L4

L3:
    ; calculating the third term
    call formula

    mov ecx, n4
    mov edx, 5
    call print ; prints the next term

    mov al, [n3]
    mov [n2], al

    mov al, [n4]
    mov [n3], al

    inc byte[n1]

    mov al, [n1]
    cmp al, byte[num]

    JL L3
    JMP L4

L4:
    call newline
ret