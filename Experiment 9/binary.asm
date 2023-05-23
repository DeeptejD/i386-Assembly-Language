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
    mov eax, 3
    mov ebx, 2
    mov ecx, trash
    mov edx, 1
    int 80h
%endmacro

%macro endl 0
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

%macro return 0
    mov eax, 1
    int 80h
%endmacro

section .data
    asknum db 'Enter the number of elements: ';
    asknumlen equ $-asknum

    ask db 'Enter the elements'
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

    space db ''

section .bss
    n resb 4
    num resb 4
    arr resb 10
    index resb 4
    lb resb 1
    ub resb 1
    mid resb 1
    trash resb 1

section .text
    global _start
_start:
    write asknum, asknumlen
    endl
    read n, 1
    sub [n], byte '0'

    write ask, asklen
    endl
    mov eax, arr
    mov edx, [n]
    call input

    write cont, contlen
    endl
    mov eax, arr
    mov edx, [n]
    call display

    write search, slen
    read num, 1

    mov eax, arr
    mov edx, [n]
    mov edi, [num]
    call binsearch

    endl
    return

; procedures start here

input:
    ; eax -> address of array
    ; edx -> size

    mov ecx, 0

    repin:
        cmp ecx, edx
        jge after_in

        mov esi, eax
        add esi, ecx
        pushad
        read esi, 1
        popad

        inc ecx
        jmp repin
    after_in:
        ret

display:
    mov ecx, 0
    repdis:
        cmp ecx, edx
        jge after_dis

        mov esi, eax
        add esi, ecx

        pushad
        write esi, 1
        endl
        popad

        inc ecx
        jmp repdis
    after_dis:
        endl
        ret

binsearch:
    ; eax = address of arr
    ; edx = size
    ; edi = number to be searched

    and edi, 000fh
    mov [lb], byte 0
    mov [ub], dl

    repsearch:
        pushad
        mov al, [lb]

        add al, [ub]
        cbw
        mov bl, 2
        div bl
        mov [mid], al
        popad
        
        mov cl, [lb]
        mov dl, [ub]

        cmp cl, dl
        jg after_search

    ; exit loop if lb > ub

        mov edx, [mid]
        and edx, 000fh
        mov esi, dword[eax + edx]
        and esi, 000fh

        cmp edi, esi

        je matched
        jl lower

    upper:
        mov bl, [mid]
        add bl, 1
        mov [lb], bl
        jmp repsearch
    
    lower:
        mov bl, [mid]
        sub bl, 1
        mov [ub], bl
        jmp repsearch

    matched:
        add edx, '0'
        mov [index], edx

        pushad
        write found, foundlen
        write index, 1

        popad
        ret

    after_search:
        write nfound, nfoundlen
        endl
        ret
    

    
