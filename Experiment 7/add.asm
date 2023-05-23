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

section .data
    ask db "Enter a number: "
    asklen equ $-ask

    show db "The Sum: "
    showlen equ $-show

    nl db '', 10
    nllen equ $-nl
section .bss
    num1 resb 5
    num2 resb 5
    sum resb 5

section .text
    global _start

_start:
    write ask, asklen
    read num1, 5

    write ask, asklen
    read num2, 5

    mov esi, 2              ; used as an offser to access the third digit from the right in arrays num1 and num2
    mov ecx, 3              ; represents the number of digits to be added

    clc                     ; clears scarry flag so no carry from a prev operation is included

add_loop:                   ; this loop will iterate ecx times
    mov al, [num1 + esi]    ; this moves the current digit of num1 to the al register
    adc al, [num2 + esi]    ; this adds the current digit of num2 to the al register considering the carry flag
    aaa                     ; ascii adjust after addition makes sure the result in al register stays in the valid (0-9) range
    pushf                   ; this saves the flag register and subsequently, the carry flag onto the stack
    or al, 30h              ; 30h is the ascii code for '0' so we perform a logical or operation to set the value of al to the corresponding ascii rep
    popf                    ; restores flags

    mov [sum + esi], al     ; stores the updated sum in the sum arr
    dec esi                 ; moves one digit left
    loop add_loop           ; this checks if esi is zero, if not then loops back to the add_loop

    ; mov esi, 1             
    ; mov al, [sum + esi]
    ; sub al, 1
    ; mov [sum + esi], al

    ; print the sum
    write show, showlen
    write sum, 5

    write nl, nllen

    mov eax, 1
    int 80h