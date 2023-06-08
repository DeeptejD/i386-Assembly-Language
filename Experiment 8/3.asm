; FIND THE NUMBER OF ODD AND EVEN NUMBERS

section .data
	nl db "", 10
	nllen equ $-nl

	asksize db 'Enter size: '
	asksizelen equ $-asksize

	ask db 'Enter elements: '
	asklen equ $-ask

	showeven db 'Even: '
	showevenlen equ $-showeven

	showodd db 'Odd: '
	showoddlen equ $-showodd

	array times 100 db 0


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
	count resb 1
	n resb 1
	element resb 1
	nodd resb 1
	neven resb 1


section .text
	global _start
_start:

	write asksize, asksizelen
	read n, 2

	write ask, asklen
	endl

	mov byte[count], 0
	mov byte[nodd], 0
	mov byte[neven], 0

	mov esi, array

	input:
		read element, 2
		mov ebx, [element]
		mov [esi], ebx

		inc esi
		inc byte[count]

		mov al, [count]
		mov bl, [n]
		sub bl, '0'

		cmp al, bl
		jl input
	
	mov byte[count], 0
	mov esi, array

	check:
		mov al, [esi]
		mov bl, '2'
		sub bl, '0'
		div bl

		cmp ah, 0
		je inc_even
		jmp inc_odd
	
	inc_even:
		inc byte[neven]
		jmp cont
	
	inc_odd:
		inc byte[nodd]
		jmp cont
	
	cont:
		inc esi
		inc byte[count]

		mov al, [count]
		mov bl, [n]
		sub bl, '0'

		cmp al, bl
		jl check
		je op
	
	op:
		add [neven], byte '0'
		add [nodd], byte '0'

		write showeven, showevenlen
		write neven, 1
		endl
		write showodd, showoddlen
		write nodd, 1
		endl

	; EXIT CALL
	mov eax, 1
	mov ebx, 0
	int 80h