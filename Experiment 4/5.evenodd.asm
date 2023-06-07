; CHECK IF A NUMBER IS EVEN OR ODD

section .data
	nl db "", 10
	nllen equ $-nl

	ask db 'Enter: '
	asklen equ $-ask

	yes db ' is an Even number'
	yeslen equ $-yes

	no db ' is on Odd number'
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
	sub al, '0'
	mov bl, 2
	div bl
	cmp ah, 0
	je true
	jmp false

	true:
		write a, 1
		write yes, yeslen
		endl
		jmp exit
	
	false:
		write a, 1
		write no, nolen
		endl
		jmp exit
	
	exit:
	; EXIT CALL
	mov eax, 1
	mov ebx, 0
	int 80h	