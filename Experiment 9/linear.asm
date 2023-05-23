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
    asknum db 'Enter the number of elements: ';
    asknumlen equ $-asknum

    ask db 'Enter'
    asklen equ $-ask

    cont db 'Array: '
    contlen equ $-cont

    search db 'Enter element to be searched: '
    slen equ $-search

    found db 'Element found at index: '
    foundlen equ $-found

    nfound db 'Element not found'
    nfoundlen equ $-nfound

    array times 10 dw 0
    len equ 10

    nl db '', 10
    nllen equ $-nl

section .bss
    num resb 5
    i resb 5
    el resb 5
    temp resb 5
    pos resb 5

section .text
    global _start
_start:
    ; enter length of array
    write asknum, asknumlen
    read num, 5

    write ask, asklen
    write nl, nllen

    mov byte[i], 0
    mov esi, array

    input:  
        read temp, 2
        mov ebx, [temp]
        mov [esi], ebx

        inc esi
        inc byte[i]

        mov al, [i]
        mov bl, [num]
        sub bl, '0'
        cmp al, bl
        JE e_in
        jmp input

    e_in:
        write search, slen
        read el, 5

    ; displaying contents of the array
    write cont, contlen

    mov byte[i], 0
    mov esi, array
    mov ecx, len

    display:
        mov ebx, [esi]
        mov [temp], ebx
        write temp, 1
        write nl, nllen
        inc esi
        inc byte[i]

        mov al, [i]
        mov bl, [num]
        sub bl, '0'
        cmp al, bl
        jl display
    
    mov byte[i], 0
    mov esi, array

    check:  
        mov ebx, [esi]
        mov [temp], ebx
        mov bl, [temp]
        mov al, [el]

        cmp al, bl
        je f
        jmp nf

    f:
        inc byte[i]
        mov al, [i]
        add al, '0'
        mov [pos], al
        dec byte[pos]
        write found, foundlen
        write pos, 5
        write nl, nllen
        jmp return

    nf:
        inc esi
        inc byte[i]

        mov al, [i]
        mov bl, [num]
        sub bl, '0'
        cmp al, bl
        jl check
        je fail

        fail:
            write nfound, nfoundlen
            write nl, nllen
            jmp return
    
    return:
        mov eax, 1
        int 80h




