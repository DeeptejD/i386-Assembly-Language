section .data
    ask db "Enter: "
    asklen equ $-ask

    sum_ db "Sum is: "
    sumlen equ $-sum_

    diff_ db "Diff is: "
    difflen equ $-diff_

    prdt_ db "Prdt is: "
    prdtlen equ $-prdt_

    quo_ db "Quotient: "
    quolen equ $-quo_

    rem_ db "Remainder: "
    remlen equ $-rem_

    nl db "", 10
    nllen equ $-nl

section .bss
    num1 resb 5
    num2 resb 5
    sum resb 5
    diff resb 5
    pro resb 5
    quot resb 5
    rem resb 5

section .text
    global _start
_start:
    mov ecx, ask
    mov edx, asklen
    call print

    mov ecx, num1
    mov edx, 5
    call read

    mov ecx, ask
    mov edx, asklen
    call print

    mov ecx, num2
    mov edx, 5
    call read

    call addition

    mov ecx, sum_
    mov edx, sumlen
    call print

    mov ecx, sum
    mov edx, 5
    call print

    call newline

    call subtract

    mov ecx, diff_
    mov edx, difflen
    call print

    mov ecx, diff
    mov edx, 5
    call print

    call newline

    call multiply

    mov ecx, prdt_
    mov edx, prdtlen
    call print

    mov ecx, pro
    mov edx, 5
    call print
    
    call newline

    call divide 
    mov ecx, quo_
    mov edx, quolen
    call print

    mov ecx, quot
    mov edx, 5
    call print

    call newline

    mov ecx, rem_
    mov edx, remlen
    call print

    mov ecx, rem
    mov edx, 5
    call print

    call newline

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

addition:
    mov al, [num1]
    sub al, '0'

    mov bl, [num2]
    sub bl, '0'

    add al, bl

    add al, '0'

    mov [sum], al
ret

subtract:
    mov eax, [num1]
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0'
    sub eax, ebx
    add eax, '0'
    mov [diff], eax
ret

multiply:
    mov al,[num1]
    sub al, '0'

    mov bl, [num2]
    sub bl, '0'

    mul bl
    add al, '0'

    mov [pro], al
ret

divide:
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'

    div bl
    add al, '0'
    mov [quot], al
    add ah, '0'
    mov [rem], ah
ret