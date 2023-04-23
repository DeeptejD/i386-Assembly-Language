; READ A NUMBER AND PRINT NEXT 5 NUMBERS USING Increment OPERATOR
section .data
    askUser db "Enter number: ", 10
    askUserLen equ $-askUser

    nl db "", 10
    nllen equ $-nl

    write db "The numbers are: ", 10
    writelen equ $-write

section .bss
    num resb 9

section .text
    global _start

_start: 
    mov eax, 4
	mov ebx, 1
	mov ecx, askUser
	mov edx, askUserLen
	int 80h

    mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 9
	int 80h

    mov eax, 4
	mov ebx, 1
	mov ecx, write
	mov edx, writelen
	int 80h

    ; Increment number and display ---------->
    mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 9
	int 80h
    
    ; FIRST Increment
    mov eax, [num]
    inc eax
    mov [num], eax

    mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 9
	int 80h

    ;SECOND Increment
    mov eax, [num]
    inc eax
    mov [num], eax

    mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 9
	int 80h

    ; THRID Increment
    mov eax, [num]
    inc eax
    mov [num], eax

    mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 9
	int 80h

    ; FOURTH Increment
    mov eax, [num]
    inc eax
    mov [num], eax

    mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 9
	int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
