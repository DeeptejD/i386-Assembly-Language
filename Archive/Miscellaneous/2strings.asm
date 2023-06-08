section .data   
    sys_write equ 4     ;use this instead of mentioning the numbers below (eax, 4)
    sys_exit equ 1      ; (ebx, 1)
    stdin equ 1         ; (eax, 1), before exiting the program
    stdout equ 0        ; (ebx, 0), before exiting the program
    
    msq1 db 'hello', 10 
    msq2 db 'welcome', 10   
    msqlen1 equ $-msq1
    msqlen2 equ $-msq2

section .text
    global _start
_start:
    mov eax, sys_write      ; string 1
    mov ebx, stdin  
    mov ecx, msq1   
    mov edx, msqlen1
    int 80h

    mov eax, sys_write      ; string 2
    mov ebx, stdin
    mov ecx, msq2
    mov edx, msqlen2
    ; int 80h

    mov eax, sys_exit
    mov ebx, stdin
    int 80h