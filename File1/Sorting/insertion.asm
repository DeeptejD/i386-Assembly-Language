; insertion sort
section .data
    nl db "", 10
    nllen equ $-nl 

    asknum db 'Enter the number of elements: '
    asknumlen equ $-asknum

    ask db 'Enter the elements'
    asklen equ $-ask

    show db 'Array: '
    showlen equ $-show

    sorted db 'Sorted Array: '
    sortedlen equ $-sorted

    space db ' '
    spacelen equ $-space

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
    temp resb 1
    counter resb 1
    key resb 1
    i resb 1
    istop resb 1
    j resb 1
    jstop resb 1

section .text
    global _start
_start:
    write asknum, asknumlen
    read num, 2
    mov al, [num]
    sub al, '0'
    mov [num], al

    write ask, asklen
    mov esi, array
    mov byte[counter], 0

    input:
        mov al, [counter]
        mov bl, [num]
        cmp al, bl
        je cont

        read esi, 2

        inc esi
        inc byte[counter]
        jmp input
    
    cont:
        pushad
        call display
        popad
    
    mov esi, array
    mov al, 1
    mov [i], al
    mov al, [num]
    mov [istop], al

    mov al, 0
    mov [jstop], al

    outerloop:
        mov al, [i]
        mov bl, [istop]
        cmp al, bl
        je afterouterloop

        mov al, [i]
        sub al, 1
        mov [j], al

        mov al, [esi + i]
        mov [key], al

        innerloop:
            mov al, [j]
            mov bl, [jstop]
            jl afterinnerloop

                mov al, [esi + j]
                mov bl, [key]
                cmp al, bl
                jl lesserthan

            lesserthan:
                mov [key], al
            
            dec byte[j]
            jmp innerloop
        
        afterinnerloop:
            mov al, [key]
            mov [esi + 1], al
    afterouterloop:
        write sorted, sortedlen
        pushad
        call display
        popad
    endl

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h

display:
    mov esi, array
    mov byte[counter], 0

    disp_loop:
        mov al, [counter]
        mov bl, [num]
        cmp al, bl
        je return
        
        write esi, 1
        write space, spacelen
        
        inc esi
        inc byte[counter]
    jmp disp_loop
    return:
    endl
ret