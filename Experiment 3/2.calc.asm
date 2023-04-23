section .data
    read1 db "Enter numbers: ", 10
    numlen1 equ $-read1

    nl db "", 10
    nllen equ $-nl

    printSum db "The sum ", 9
    Slen equ $-printSum
    
    printDiff db "The difference ", 9
    Dlen equ $-printDiff

    printProd db "The product ", 9
    Plen equ $-printProd

    printQuo db "The quotient ", 9
    Qlen equ $-printQuo

    printrem db "The remainder ", 9
    remlen equ $-printrem
section .bss
    num1 resb 9
    num2 resb 9
    num3 resb 9
    num4 resb 9

section .text
    global _start:
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, read1
    mov edx, numlen1
    int 80h

     ; READ NUMBER 1
    mov eax, 3
    mov ebx, 2
    mov ecx, num1
    mov edx, 9
    int 80h

    ; READ NUMBER 2
    mov eax, 3
    mov ebx, 2
    mov ecx, num2
    mov edx, 9
    int 80h

    ; ADDITION OF NUMBERS -------------->
    mov eax, [num1]
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0' 
    add eax, ebx
    add eax, '0' 
    mov [num3], eax

    ; PRINT SUM
    mov eax, 4
    mov ebx, 1
    mov ecx, printSum
    mov edx, Slen
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, num3
    mov edx, 9
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h

    ; DIFFERENCE OF NUMBERS -------------->
    mov eax, [num1]
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0' 
    sub eax, ebx
    add eax, '0' 
    mov [num3], eax

    ; PRINT DIFFERENCE
    mov eax, 4
    mov ebx, 1
    mov ecx, printDiff
    mov edx, Dlen
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, num3
    mov edx, 9
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h

    ; PRODUCT OF NUMBERS -------------->
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0' 
    mul bl
    add al, '0' 
    mov [num3], al

    ; PRINT PRODUCT
    mov eax, 4
    mov ebx, 1
    mov ecx, printProd
    mov edx, Plen
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, num3
    mov edx, 9
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h

    ; DIVISION OF NUMBERS -------------->
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0' 
    div bl
    add al, '0' 
    add ah, '0'
    mov [num3], al
    mov [num4], ah
    

    ; PRINT QUOTIENT
    mov eax, 4
    mov ebx, 1
    mov ecx, printQuo
    mov edx, Qlen
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, num3
    mov edx, 9
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, printrem
    mov edx, remlen
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, num4
    mov edx, 9
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
