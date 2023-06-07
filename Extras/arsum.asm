%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1 
    mov edx, %2
    int 80h
%endmacro

section data
    asksize db "Enter size: "
    asksizelen equ $-asksize

    ask db "Enter: "
    asklen equ $-ask

    nl db "", 10
    nllen equ $-nl

    show db "Sum: "
    showlen equ $-show

    array times 10 db 0
    len equ 10

section .bss
    num resb 9
    n resb 1

section .text
    write asksize, asksizelen
    read num, 9

    write ask, asklen

    input:
        mov ebx, 0
        mov esi, array
        input_loop:
            cmp ebx, num
            je calc
            