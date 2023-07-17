section .data
    nl db "", 10
    nllen equ $-nl 

    asksize db 'Entert the number of elements: '
    asksizelen equ $-asksize

    ask db 'Enter the elements'
    asklen equ $-ask

    space db ' '
    spacelen equ $-space

    showarray db 'Array: '
    showarraylen equ $-showarray

    aski db 'Enter the element to be searched: '
    askilen equ $-aski

    f db 'Element found at index: '
    flen equ $-f

    nf db 'Element not found'
    nflen equ $-nf

    array times 10 dw 0


; WRITE MACRO
%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

; READ MACRO
%macro read 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

; NEWLINE MACRO
%macro endl 0
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro


; DECLARE VARIABLES
section .bss
    num resb 1
    element resb 1
    counter resb 1
    temp resb 1
    pos resb 1


section .text
    global _start
_start:
    
    ; ask size
    write asksize, asksizelen
    read num, 2

    write ask, asklen
    endl

    ; input loop
    mov byte[counter], 0
    mov esi, array

    input:
        read temp, 2
        mov al, [temp]
        mov [esi], al

        inc esi
        inc byte[counter]

        mov al, [counter]
        mov bl, [num]

        sub bl, '0'

        cmp al, bl

        je ask_element
        jmp input

    ask_element:
        write aski, askilen
        read element, 2
    
    display:
        write showarray, showarraylen
        mov esi, array
        mov byte[counter], 0

        displ_loop:
            write esi, 1
            write space, spacelen

            inc esi
            inc byte[counter]

            mov al, [counter]
            mov bl, [num]
            sub bl, '0'

            cmp al, bl
            je check
            jmp displ_loop
    
    check:
        endl
        mov esi, array
        mov byte[counter], 0

        check_loop:
            mov al, [esi]
            mov bl, [element]
            sub al, '0'
            sub bl, '0'
            cmp al, bl
            je found
            jmp notfound
        
    found:
        write f, flen
        add bl, '0'
        mov al, [counter]
        add al, '0'
        mov [counter], al
        write counter, 1
        endl
        jmp exit

    notfound:
        inc esi
        inc byte[counter]

        mov al, [num]
        sub al, '0'
        mov bl, [counter]

        cmp al, bl

        je failure
        jmp check_loop
    
    failure:
        write nf, nflen
        endl
        jmp exit


; EXIT CALL
    exit:
    mov eax, 1
    mov ebx, 0
    int 80h