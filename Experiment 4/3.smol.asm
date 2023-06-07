; SMALLEST OF TWO NUMBERS

section .data
	nl db "", 10
	nllen equ $-nl

	ask db 'Enter: '
	asklen equ $-ask

	show db 'Smallest: '
	showlen equ $-show

	eq db 'Equal'
	eqlen equ $-eq

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
	a resb 1
	b resb 1


section .text
	global _start
_start:

	write ask, asklen
	read a, 2
	write ask, asklen
	read b, 2

	mov al, [a]
	mov bl, [b]

	cmp al, bl
	je equal
	jl a_less
	jg b_less

	a_less:
		write show, showlen
		write a, 1
		endl
		jmp exit
	
	b_less:
		write show, showlen
		write b, 1
		endl
		jmp exit
	
	equal:
		write eq, eqlen
		endl

	exit:
	; EXIT CALL
	mov eax, 1
	mov ebx, 0
	int 80h