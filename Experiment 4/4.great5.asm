; CHECK IF THE ENTERED NUMBER IS GREATER, SMALLER OR EQUAL TO 5

section .data
	nl db "", 10
	nllen equ $-nl

	ask db 'Enter: '
	asklen equ $-ask

	eq db ' is Equal to 5'
	eqlen equ $-eq

	yes db ' is greater than 5'
	yeslen equ $-yes

	no db ' is less than 5'
	nolen equ $-no


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


section .text
	global _start
_start:

	write ask, asklen
	read a, 2

	mov al, [a]
	cmp al, '5'
	je equal
	jl less
	jg greater

	less:
		write a, 1
		write no, nolen
		endl
		jmp exit
	
	greater:
		write a, 1
		write yes, yeslen
		endl
		jmp exit
	
	equal:
		write a, 1
		write eq, eqlen
		endl

	exit:
	; EXIT CALL
	mov eax, 1
	mov ebx, 0
	int 80h