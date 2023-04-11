section .data
    name db 'abc def', 10
    namelen equ $-name

section .text
    global _start
_start:
    ; the followinf sttmts print the string contained in name 
    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, namelen
    int 80h ; interrupt

    mov [name], dword 'cba'    ; this replaces the first word in the string with given string 'bye'
    mov eax, 4
    mov ebx, 1
    mov ecx, name               ; print string after replacement
    mov edx, namelen
    int 80h

    ; used to exit
    mov eax, 1
    mov ebx, 0
    int 80h

    ; the replacement string must be of the seame length if u want to replace the entire word, if the string to be replaced is longer than the replacing string then only the characters upto the replacing string length are replaced