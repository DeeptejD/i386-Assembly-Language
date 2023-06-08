; NUMBER OF ELEMENTS GREATER THAN AND LESS THAN 5

section .data
	nl db "", 10
	nllen equ $-nl

	asksize db 'Enter size: '
	asksizelen equ $-asksize

	ask db 'Enter: '
	asklen equ $-ask

	showabove db 'Number of elements greater than 5: '
	showabovelen equ $-showabove

	showbelow db 'Number of elements less than 5: '
	showbelowlen equ $-showbelow

	showeq db 'Number of elements equal to 5: '
	showeqlen equ $-showeq

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
	high resb 1
	low resb 1
	same resb 1
	element resb 1


section .text
	global _start
_start:
	write asksize, asksizelen
	read n, 2

	write ask, asklen

	mov byte [count], 0
	mov byte [high], 0
	mov byte [low], 0
	mov byte [same], 0

	mov esi, array

	input:
		read element, 2
		mov eax, [element]

		mov [esi], eax

		inc byte[count]
		inc esi

		mov al, [count]
		mov bl, [n]
		sub bl, '0'
		cmp al, bl
		jl input
	
	mov esi, array
	mov byte [count], 0

	check:
		mov al, [esi]
		mov bl, '5'
		cmp al, bl
		jl lessthan
		jg greaterthan
		je equalto

	lessthan:
		inc byte[low]
		jmp cont
	
	greaterthan:
		inc byte[high]
		jmp cont
	
	equalto:
		inc byte[same]

	cont:

		inc byte[count]
		inc esi

		mov al, [count]
		mov bl, [n]
		sub bl, '0'
		cmp al, bl
		jl check

	add byte[high], '0'
	add byte[low], '0'
	add byte[same], '0'

	write showabove, showabovelen
	write high, 1
	endl
	write showbelow, showbelowlen
	write low, 1
	endl
	write showeq, showeqlen
	write same, 1
	endl

	; EXIT CALL
	mov eax, 1
	mov ebx, 0
	int 80h