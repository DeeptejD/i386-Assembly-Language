; MENU DRIVEN CALCULATOR

section .data
    nl db "", 10
    nllen equ $-nl

    header db 'Menu', 0Ah
           db '1. Sum', 0Ah
           db '2. Difference', 0Ah
           db '3. Product', 0Ah
           db '4. Division', 0Ah
           db '5. Quit', 0Ah
    
    headerlen equ $-header

    askchoice db 'Enter choice: '
    askchoicelen equ $-askchoice

    ask db 'Enter: '
    asklen equ $-ask

    showsum db 'Sum: '
    showsumlen equ $-showsum

    showdiff db 'Diff: '
    showdifflen equ $-showdiff

    showpro db 'Product: '
    showprolen equ $-showpro

    showrem db 'Remainder: '
    showremlen equ $-showrem

    showquo db 'Quotient: '
    showquolen equ $-showquo

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
    choice resb 1
    a resb 1
    b resb 1
    ans resb 1
    rem resb 1

section .text
    global _start
_start:

    loop:
        write header, headerlen
        write askchoice, askchoicelen
        read choice, 2
        
        cmp byte [choice], '1'
        je opt1
        cmp byte [choice], '2'
        je opt2
        cmp byte [choice], '3'
        je opt3
        cmp byte [choice], '4'
        je opt4
        cmp byte [choice], '5'
        je opt5

    opt1:
            call SUM
            jmp loop
        
    opt2:
            call DIFF
            jmp loop
        
    opt3:
            call PROD
            jmp loop
        
    opt4:
            call DIVIDE
            jmp loop

    opt5:
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h

SUM:
    write ask, asklen
    read a, 2
    write ask, asklen
    read b, 2
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    add al, bl
    add al, '0'
    mov [ans], al
    write showsum, showsumlen
    write ans, 1
    endl
ret

DIFF:
    write ask, asklen
    read a, 2
    write ask, asklen
    read b, 2
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    sub al, bl
    add al, '0'
    mov [ans], al
    write showdiff, showdifflen
    write ans, 1
    endl
ret

PROD:
    write ask, asklen
    read a, 2
    write ask, asklen
    read b, 2
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    mul bl
    add al, '0'
    mov [ans], al
    write showpro, showprolen
    write ans, 1
    endl
ret

DIVIDE:
    write ask, asklen
    read a, 2
    write ask, asklen
    read b, 2
    xor eax, eax
    xor ebx, ebx
    mov al, [a]
    mov bl, [b]
    sub al, '0'
    sub bl, '0'
    div bl
    add al, '0'
    add ah, '0'
    mov [ans], al
    mov [rem], ah
    write showquo, showquolen
    write ans, 1
    endl
    write showrem, showremlen
    write rem, 1
    endl
ret
