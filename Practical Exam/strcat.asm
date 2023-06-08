; CONCATENATE TWO STRING
section .data
    nl db "", 10
    nllen equ $-nl

    askroll db 'Enter roll number: '
    askrolllen equ $-askroll

    askname db 'Enter name: '
    asknamelen equ $-askname

    show db 'Concatenated string: '
    showlen equ $-show

    name times 100 db 0
    roll times 100 db 0


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
    
    write askname, asknamelen
    read name, 100
    ; write name, 100
    ; endl

    write askroll, askrolllen
    read roll, 100
    ; write roll, 100
    ; endl

    mov byte [len], 0

    mov esi, name
    move:
        mov al, [esi + 1]
        cmp al, 0
        je cat

        inc byte [len]
        inc esi
        jmp move
    
    cat:
    mov edi, roll
    
    catloop:
        mov al, [edi + 1]
        cmp al, 0
        je done

        inc byte[len]
        mov bl, [edi]
        mov [esi], bl
        inc esi
        inc edi
        jmp catloop
    
    done:
        
        write show, showlen
        write name, 100
        endl
    ; EXIT CALL
    mov eax, 1
    mov ebx, 0
    int 80h