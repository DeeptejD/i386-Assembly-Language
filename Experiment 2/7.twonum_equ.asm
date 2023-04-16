section .data
    askNum1 db "Enter first number: ", 10
    askNum2 db "Enter second number: ", 10
    askLen1 equ $-askNum1
    askLen2 equ $-askNum2
    printNum db "The numbers are: ", 10
    printlen equ $-printNum
section .bss
    num1 resb 5
    num2 resb 5
section .text
    global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, askNum1
    mov edx, askLen1
    int 80h

    mov eax, 3
    mov ebx, 2
    mov ecx, num1
    mov edx, 5
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, askNum2
    mov edx, askLen2
    int 80h

    mov eax, 3
    mov ebx, 2
    mov ecx, num2
    mov edx, 5
    int 80h    

    mov eax, 4
    mov ebx, 1
    mov ecx, printNum
    mov edx, printlen
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, num1
    mov edx, 5
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, num2
    mov edx, 5
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h