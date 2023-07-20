section .data
    nl db "", 10
    nllen equ $-nl 

    ask db 'Enter: '
    asklen equ $-ask

    name times 100 db 0

    roll db '2', '1', '1', '1', '0', '5', '0','1', '7'


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


section .text
    global _start
_start:
    
    write ask, asklen
    read name, 100

    mov byte[len], 0
    mov esi, name

    mov:
        mov al, [esi + 1]
        cmp al, 0
        je cat

        inc byte[len]
        inc esi
        jmp mov

    cat:
    mov edi, roll

    catloop:
        mov al, [edi]
        cmp al, 0
        je done

        inc byte[len]
        mov al, [edi]
        mov [esi], al
        inc esi
        inc edi
        jmp catloop

    done:
        write name, 100
        endl      

; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h