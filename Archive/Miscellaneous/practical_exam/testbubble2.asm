section .data
    nl db "", 10
    nllen equ $-nl 

    asknum db 'Enter the number of elements: '
    asknumlen equ $-asknum

    ask db 'Enter the elements'
    asklen equ $-ask

    show db 'Array: '
    showlen equ $-show

    space db ' '
    spacelen equ $-space

    pass db 'Pass: '
    passlen equ $-pass

    colon db ': '
    colonlen equ $-colon

    srtd db 'Sorted array'
    srtdlen equ $-srtd

    array times 10 dw 0

    disp1 db 'First display'
    disp1len equ $-disp1

    disp2 db 'display in the outer loop'
    disp2len equ $-disp2

    innerprint db 'Entered inner loop'
    innerprintlen equ $-innerprint


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
    i resb 1
    istop resb 1    
    j resb 1
    jstop resb 1
    counter resb 1    
    temp resb 1

section .text
    global _start
_start:
    
    write asknum, asknumlen
    read num, 2
    mov al, [num]
    sub al, '0'
    mov [num], al

; INPUT
    mov byte[counter], 0
    mov esi, array
    
    input:
        mov al, [counter]
        mov bl, [num]
        cmp al, bl
        je cont

        read temp, 2
        mov al, [temp]
        mov [esi], al

        inc esi
        inc byte[counter]
        jmp input
    
    cont:
        ; write disp1, disp1len
        endl
        pushad
        call display
        popad
        endl

    sort:
        mov al, 0
        mov [i], al
        mov al, [num]
        sub al, 1
        mov [istop], al

        outerloop:
            mov al, [i]
            mov bl, [istop]
            cmp al, bl
            je afterouterloop

            mov al, 0
            mov [j], al
            mov bl, [num]
            sub bl, 1
            mov al, [i]
            sub bl, al
            mov [jstop], bl

            mov esi, array
            mov byte[counter], 0

            innerloop:
                mov al, [j]
                mov bl, [jstop]
                cmp al, bl
                je afterinnerloop

                mov al, [esi]
                mov bl, [esi + 1]
                cmp al, bl
                jle inc_j
                
                mov [esi], bl
                mov [esi + 1], al

                inc_j:
                    inc esi
                    inc byte[j]
                    jmp innerloop
            afterinnerloop:
                inc esi
                inc byte[i]
                jmp outerloop
        afterouterloop:
            write srtd, srtdlen
            endl
            pushad
            call display
            popad
            endl

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h


; PROCEDURES

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
ret