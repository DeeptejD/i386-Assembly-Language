; ENTER ELEMENTS IN AN ARRAY AND DISPLAY

section .data
    nl db "", 10
    nllen equ $-nl

    asksize db 'Enter the numbe of elements: '
    asksizelen equ $-asksize

    ask db 'Enter elements'
    asklen equ $-ask

    show db 'The elements in the array are'
    showlen equ $-show

    array times 100 db 0

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
    count resb 1
    n resb 1
    element resb 1


section .text
    global _start
_start:

    write asksize, asksizelen
    read n, 2

    mov byte[count], 0
    mov esi, array
    write ask, asklen
    endl
    input:
        read element, 2
        mov eax, [element]
        mov [esi], eax

        inc esi
        inc byte [count]
        
        mov al, [count]
        mov bl, [n]
        sub bl, '0'
        cmp al, bl
        jl input
    
    mov esi, array
    mov byte[count], 0

    write show, showlen
    endl
    output:
        write esi , 1
        endl
        inc esi
        inc byte [count]

        mov al, [count]
        mov bl, [n]
        sub bl, '0'
        cmp al, bl
        jl output


    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h