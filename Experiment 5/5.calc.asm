%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro newline 0
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

%macro return 0
    mov eax, 1
    int 80h
%endmacro

%macro SUM 3
    mov eax, [%1]
    sub eax, '0'
    mov ebx, [%2]
    sub ebx, '0'
    add eax, ebx
    add eax, '0'
    mov [%3], eax
    int 80h
%endmacro

%macro DIFF 3
    mov eax, [%1]
    sub eax, '0'
    mov ebx, [%2]
    sub ebx, '0'
    sub eax, ebx
    add eax, '0'
    mov [%3], eax
%endmacro

%macro PRDT 3
    mov al, [%1]
    sub al, '0'
    mov bl, [%2]
    sub bl, '0'
    mul bl
    add al, '0'
    mov [%3], al
%endmacro

%macro DIVIDE 4
    mov al, [%1]
    sub al, '0'
    mov bl, [%2]
    sub bl, '0'
    div bl
    add al, '0'
    mov [%3], al
    cmp ah, '0'
    mov [%4], ah

%endmacro

section .data
    ask db "Enter: "
    asklen equ $-ask

    read num1, num2

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
    num1 resb 9
    num2 resb 9
    p resb 9
    q resb 9
    r resb 9
    s resb 9
    d resb 9

section .text
    global _start
_start:
    write ask, asklen
    read num1, 9
    write ask, asklen
    read num2, 9

    ;---SUM
    SUM num1, num2, s
    write sum_, sumlen
    write s, 9
    newline

    ;---DIFF
    DIFF num1, num2, d
    write diff_, difflen
    write d, 9
    newline

    ;---PRDT
    PRDT num1, num2, p
    write prdt_, prdtlen
    write p, 9
    newline

    ;---DIV
    DIVIDE  num1, num2, q, r
    write quo_, quolen
    write q, 9
    newline
    write rem_, remlen
    write r, 9
    newline

    return

    
