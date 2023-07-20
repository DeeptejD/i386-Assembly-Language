; selection sort

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
    i resb 1
    istop resb 1
    j resb 1
    jstop resb 1
    counter resb 1
    minindex resb 1


section .text
    global _start
_start:
    write asknum, asknumlen
    read num, 2

    mov al, [num]
    sub al, '0'
    mov [num], al

    write ask, asklen
    endl
    mov esi, array
    mov byte[counter], 0

    input:
        mov al, [num]
        mov bl, [counter]
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
    
    mov al, 0
    mov [i], al
    mov al, [num]
    sub al, 1
    mov [istop], al

    outerloop:
        mov al, [i]
        mov bl, [istop]
        je afterouterloop

        mov al, [i]
        mov [minindex], al

        mov esi, array
        mov al, [i]
        inc al
        mov [j], al
        mov al, [num]
        mov [jstop], al

        innerloop:
            mov al, [j]
            mov bl, [jstop]
            cmp al, bl
            je afterinnerloop
            
            mov al, [esi + j]
            mov bl, [esi + minindex]

            cmp al, bl
            jge inner_cont

            mov al, [esi + j]
            mov bl, [esi + minindex]
            mov [esi + j], bl
            mov [esi + minindex], al

            inner_cont:
            inc byte[j]
            jmp innerloop
        
        afterinnerloop:
            inc byte[i]
            jmp outerloop
    afterouterloop:
        pushad
        call display
        popad        

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
        je stop_disp

        write esi, 1
        write space, spacelen
        inc esi
        inc byte[counter]
    jmp disp_loop

    stop_disp:
    endl
ret