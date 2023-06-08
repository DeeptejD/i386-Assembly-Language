;joshua
%macro read 2
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

%macro write 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

section .data
	ask db 'enter', 10
	asklen equ $-ask

	tell db 'two numbers are: ', 10
	tellen equ $-tell

	arr times 10 dw 0
	arrl equ $-arr

	nl db '', 10
	nll equ $-nl

section .bss
	n resb 2
	nlen equ $-n
	i resb 2
	ilen equ $-i
	v resb 2
	; vlen equ $-v

section .text
	global _start
_start:
	write ask, asklen
	read n, nlen

	write ask, asklen

	mov al, [n]
	sub al, '0'
	mov [n], al
	
	mov esi, arr

	mov byte [i], 0

	loop1:
		mov al, [i]
		mov bl, [n]
		cmp al, bl
		JGE out1

		read v, 2

		xor ebx, ebx
		mov ebx, [v]
		mov [esi], ebx

		inc esi
		inc byte [i]
		JMP loop1
	
	out1:
		mov byte [i], 0
		mov esi, arr

		loop2:
			xor eax, eax
			xor ebx, ebx
			mov al, [i]
			mov bl, [n]
			cmp al, bl
			jge out2
			
			write esi, 1
			write nl, nll

	inc esi
	inc byte [i]
	JMP loop2

	out2:

	mov eax, 1
	mov ebx, 0
	int 80h