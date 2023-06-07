section .data
    ip db 50 ; maximum input length
    iplen equ $-ip

    op times 50 db 0 ; maximum output length

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

section .text
    global _start
_start:
    write inpstr, inplen

    ; Read input from user
    read input, 50

    ; Calculate input length
    mov esi, input
    mov ecx, 0

    count:
        cmp byte[esi+ecx], 0
        je rev

        inc ecx
        jmp count

    rev:
        mov edi, ecx
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
        write opstr, opstrlen
        write op, edi
        endl
        mov ecx, edi
        checkloop:
            cmp ecx, 0
            je ispal

            dec ecx
            mov al, [esi + ecx]
            cmp al, [op+ecx]
            je checkloop
            jne notpal
        
    ispal:
        write is, islen
        endl
        jmp exit
    
    notpal:
        write isnot, isnotlen
        endl
        
    exit:
    ; Terminate the program
    mov eax, 1
    xor ebx, ebx
    int 80h