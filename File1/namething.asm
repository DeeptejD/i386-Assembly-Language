section .data
    nl db "", 10
    nllen equ $-nl 

    ask db 'Enter: '
    asklen equ $-ask

    name times 100 db 0


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
    len resb 1
    a resb 1
    b resb 1
    cap resb 1
    count resb 1

section .text
    global _start
_start:
    write ask, asklen
    read name, 100
    write ask, asklen
    read a, 2
    mov al, [a]
    write ask, asklen
    read b, 2

    cmp al, '3'
    jl aisless
    jmp else

    aisless:
        cmp bl, '3'
        jl bisless
        jmp else
    
    bisless:
        mov al, [a]
        mov bl, [b]
        sub al, '0'
        sub bl, '0'
        add al, bl
        mov [cap], al
        

        mov byte[count], 0

        yesloop:
            inc byte[count]
            mov al, [count]
            mov bl, [cap]
            cmp al, bl
            jg done

            write name, 100
            endl
            jmp yesloop
        
        else:
            mov al, [a]
            sub al, '0'
            mov bl, [b]
            sub bl, '0'
            sub al, bl
            cmp al, 0
            mov [cap], al

            mov byte[count], 0

        noloop:
            inc byte[count]
            mov al, [count]
            mov bl, [cap]
            cmp al, bl
            jg done

            write name, 100
            endl
            jmp noloop

        done:
    

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h