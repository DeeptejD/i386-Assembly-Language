section .data
	ask db 'Enter a number: '
	asklen equ $-ask

	tell db 'The smaller number is:'
	telllen equ $-tell

	eq db 'equal'
	eqlen equ $-eq

section .bss
	num1 resb 4
	num2 resb 4
	small resb 4

section .text
	global_start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, ask
	mov edx, asklen
	int 80h

	;input first number
	mov eax, 3
	mov ebx, 2
	mov ecx, num1
	int 80h

	;print the input message
	mov eax, 4
	mov ebx, 1
	mov ecx, ask
	mov edx, asklen
	int 80h

	;input second number
	mov eax, 3
	mov ebx, 2
	mov ecx, num2
	int 80h

	;print the output message
	mov eax, 4
	mov ebx, 1
	mov ecx, tell
	mov edx, telllen
	int 80h

	;compare the two numbers
	mov eax, [num1]
	mov ebx, [num2]
	cmp eax, ebx

	JE E
	JG L1 ;checks whether num1 > num2
	JMP L2

	L1:
	mov [small], ebx
	JMP PRINT

	L2:
	mov [small], eax
	JMP PRINT

	E:
	mov [small], eax
	mov eax, 4
	mov ebx, 1
	mov ecx, eq
	mov edx, eqlen
	int 80h	

	PRINT:
	mov eax, 4
	mov ebx, 1
	mov ecx, small
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
