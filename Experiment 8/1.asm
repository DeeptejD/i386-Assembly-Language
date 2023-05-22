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

section .data
    asksize db 'Enter size: '
    asksizelen equ $-asksize

    ask db 'Enter'
    asklen equ $-ask

    show db 'Array'
    showlen equ $-show

    array times 10 dw 0
    len equ 10

    nl db '', 10
    nllen equ $-nl

section .bss
    num resb 9
    i resb 9
    element resb 10

section .text
    global _start:
_start:
    write asksize, asksizelen
    read num, 9

    write ask, asklen
    write nl, nllen
    mov byte[i], 0

    mov esi, array

    input:
        read element, 2
        mov ebx, [element]
        mov [esi], ebx

        inc esi
        inc byte[i]

        mov al, [i]
        mov bl, [num]
        sub bl, '0'
        cmp al, bl
        JE exit
        JMP input

    exit:

    write show, showlen
    write nl, nllen
    mov byte[i], 0
    mov esi, array

    output:
        mov ebx, [esi]
        mov [element], ebx
        write element, 1
        write nl, nllen

        inc esi
        inc byte[i]

        mov al, [i]
        mov bl, [num]

        sub bl, '0'
        cmp al, bl
        JL output
    
    mov eax, 1
    int 80h