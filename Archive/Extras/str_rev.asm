section .data
    ip db "Hello"
    iplen equ $-ip

    op times 6 db 0

    nl db "", 10
    nllen equ $-nl

    inpstr db "Inptu string: "
    inplen equ $-inpstr

    opstr db "Reversed string: "
    opstrlen equ $-opstr

%macro print 2
    mov eax, 4
    mov ebx, 1
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

section .text
    global _start
_start:

    print inpstr, inplen
    print ip, iplen
    endl

    mov esi, ip
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
            je printloop

            dec ecx
            mov al, [esi+ecx]
            mov [op+ebx], al
            inc ebx
            jmp revloop
    
    printloop:
        print opstr, opstrlen
        print op, edi
        endl
    