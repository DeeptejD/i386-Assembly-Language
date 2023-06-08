;Factors of numbers
%macro in 2
mov eax,3
mov ebx,2
mov ecx,%1
mov edx,%2
int 80h
%endmacro

%macro out 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

section .data


section .bss
num resb 4
i resb 4


section .text
global _start
_start:
    in num, 4
    mov byte[i],1
    jmp l1


print:
    add byte[i],'0'
    out i,4
    sub byte[i],'0'
    jmp next


l1:
    mov al,[num]
    sub al,'0'
    mov bl,[i]
    div bl
    cmp ah,0
    je print

next:
    inc byte[i]
    mov al,[i]
    mov bl,[num]
    sub bl,'0'
    cmp al,bl
    jle l1

mov eax,1
mov ebx,0
int 80h