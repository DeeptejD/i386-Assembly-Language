section .data
    sys_write equ 4     ; equ directive
    sys_exit equ 1
    stdin equ 0
    stdout equ 1
    read1 db "Enter numbers: ", 10
    numlen1 equ $-read1

    print db "The sum ", 9
    printlen equ $-print
section .bss
    num1 resb 9
    num2 resb 9
    num3 resb 9
    num4 resb 9

section .text
    global _start
_start:
    mov eax, sys_write
    mov ebx, stdout
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

    ; READ NUMBER 2
    mov eax, 3
    mov ebx, 2
    mov ecx, num4
    mov edx, 9
    int 80h

    ; ADDITION OF NUMBERS
    mov eax, [num1]
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0' 
    add eax, ebx
    mov ebx, [num4]
    sub ebx, '0'
    add eax, ebx
    
    ; cmp eax, 9
    
    ; jnz ans
    
    ; add eax, 'A'
    ; sub eax, 10
    
    ; ans:
    
    add eax, '0' 
    mov [num3], eax

    mov eax, sys_write
    mov ebx, stdout
    mov ecx, print
    mov edx, printlen
    int 80h

    ; PRINT THE SUM
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, num3
    mov edx, 9
    int 80h

    mov eax, sys_exit
    mov ebx, stdin
    int 80h
