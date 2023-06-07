section .data
    ip db 50
    iplen equ $-ip

    nl db "", 10
    nllen equ $-nl

    inpstr db "Input string: "
    inplen equ $-inpstr

    opstr db "Reversed string: "
    opstrlen equ $-opstr

    is db "Pallindrome"
    islen equ $-is

    isnot db "Not a pallindrome"
    isnotlen equ $-isnot

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

%macro endl 0
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

section .bss
    input resb 50 ; reserve space for input string
    op resb 50

section .text
    global _start
_start:
    write inpstr, inplen

    ; Read input from user
    read input, 50

    mov esi, input
    mov ecx, 0

    count:
        cmp byte [esi+ecx], 0
        je rev

        inc ecx
        jmp count

    rev:
        mov ebx, 0

    revloop:
        cmp ecx, 0
        je check

        dec ecx
        mov al, [esi+ecx]
        mov [op+ebx], al
        inc ebx
        jmp revloop
    

    check:
        write op, 50
        endl
        mov ecx, 0
        mov esi, input
        mov edi, op

        checkloop:
            cmp byte [edi + ecx], 0
            je ispal

            mov al, [esi + ecx]
            cmp byte[edi + ecx], al
            jne notpal

            inc ecx
            jmp checkloop
    
    ispal:
        write is, islen
        endl
        jmp exit
    
    notpal:
        write isnot, isnotlen
        endl
    
    exit:
        mov eax,1 
        int 80h

