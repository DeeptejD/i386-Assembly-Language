; binary search (assumes data is entered in a sorted manner)

section .data
    nl db "", 10
    nllen equ $-nl 

    asksize db 'Enter the number of elements: '
    asksizelen equ $-asksize

    ask db 'Enter the elements'
    asklen equ $-ask

    aski db 'Enter the element to be searched: '
    askilen equ $-aski

    show db 'Array: '
    showlen equ $-show

    space db ' '
    spacelen equ $-space

    f db 'Element found at index: '
    flen equ $-f

    nf db 'Element not found'
    nflen equ $-nf

    array times 10 dw 0

    showl db 'LB: '
    showllen equ $-showl

    showu db 'UB: '
    showulen equ $-showu

    showm db 'MID: '
    showmlen equ $-showm


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
    counter resb 1
    temp resb 1
    element resb 1
    lb resb 1
    ub resb 1
    mid resb 1

section .text
    global _start
_start:
    write asksize, asksizelen
    read num, 2

    write ask, asklen
    endl

    mov esi, array
    mov byte[counter], 0

    input:
        read temp, 2
        mov al, [temp]
        mov [esi], al

        inc esi
        inc byte[counter]

        mov al, [num]
        sub al, '0'
        mov bl, [counter]

        cmp al, bl

        je ask_element
        jmp input

    ask_element:
        write aski, askilen
        read element, 2
    
    mov byte[counter], 0
    mov esi, array
    
    display:
        mov al, [counter]
        mov bl, [num]
        sub bl, '0'
        cmp al, bl
        je cont
        
        write esi, 1
        write space, spacelen

        inc esi
        inc byte[counter]
        jmp display

    cont:
    endl
    mov al, 0
    mov [lb], al
    mov bl, [num]
    sub bl, '0'
    sub bl, 1
    mov [ub], bl

    check:
        mov al, [lb]
        mov bl, [ub]
        cmp al, bl
        jg failure

        add al, bl
        mov bl, 2
        div bl

        mov [mid], al

        ; THIS CODE IS TO SHOW MID AND ALL THAT
        write showl, showllen
        mov al, [lb]
        add al, '0'
        mov [temp], al
        write temp, 1
        endl
        write showu, showulen
        mov al, [ub]
        add al, '0'
        mov [temp], al
        write temp, 1
        endl
        write showm, showmlen
        mov al, [mid]
        add al, '0'
        mov [temp], al
        write temp, 1
        endl
        endl
        ; CODE TO SHOW MID N ALL ENDS HERE

        mov esi, array
        mov byte[counter], 0
        movesi:
            mov al, [counter]
            mov bl, [mid]
            cmp al, bl
            je midcheck
            
            inc esi
            inc byte[counter]
            jmp movesi
        
        midcheck:
            mov al, [esi]
            sub al, '0'
            mov bl, [element]
            sub bl, '0'
            cmp al, bl
            je found
            jl greater
            jg lesser

    greater:
        mov al, [mid]
        add al, 1
        mov [lb], al
        jmp check
    
    lesser:
        mov al, [mid]
        sub al, 1
        mov [ub], al
        jmp check

    found:
        write f, flen
        mov al, [mid]
        add al, '0'
        mov [temp], al
        write temp, 1
        endl
        jmp exit      


; EXIT CALL
    failure:
        write nf, nflen
        endl

        exit:

        mov eax, 1
        mov ebx, 0
        int 80h

; TEST CASES

; SUCCESSFUL SEARCH

; 7
; 1
; 3
; 5
; 6
; 7
; 8
; 9
; 3


; UNSUCESSFUL SEARCH
; 7
; 1
; 3
; 5
; 6
; 7
; 8
; 9
; 2