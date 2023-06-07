; FIND THE GREATEST OF THREE NUMBERS

section .data
	nl db "", 10
	nllen equ $-nl

	ask db 'Enter: '
	asklen equ $-ask

	show db 'Largest: '
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
	c resb 1
	largest resb 1


section .text
	global _start
_start:

	write ask, asklen
	read a, 2
	write ask, asklen
	read b, 2
	write ask, asklen
	read c, 2

	mov al, [a]
	mov bl, [b]
	mov cl, [c]

	cmp al, bl
	je E
	jg a_greater
	jl b_greater

	a_greater:
		cmp al, cl
		je E
		jg a_greatest
		jl c_greatest
	
	b_greater:
		cmp bl, cl
		je E
		jg b_greatest
		jl c_greatest
	
	a_greatest:
		write show, showlen
		write a, 1
		endl
		jmp exit
	
	b_greatest:
		write show, showlen
		write b, 1
		endl
		jmp exit
	
	c_greatest:
		write show, showlen
		write c, 1
		endl
		jmp exit
	
	E:
		write eq, eqlen
		endl
	
	exit:
	; EXIT CALL
	mov eax, 1
	mov ebx, 0
	int 80h