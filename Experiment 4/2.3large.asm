section .data
	ask db 'Enter a number: '
	asklen equ $-ask

	tell db 'The larger number is:'
	telllen equ $-tell

	eq db 'equal'
	eqlen equ $-eq

section .bss
	num1 resb 4
	num2 resb 4
	num3 resb 4
	large resb 4

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

	;print the input message
	mov eax, 4
	mov ebx, 1
	mov ecx, ask
	mov edx, asklen
	int 80h

	;input second number
	mov eax, 3
	mov ebx, 2
	mov ecx, num3
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
	mov ecx, [num3]
	cmp eax, ebx
	
	JE E
	JG L1  ;num1 > num2
	JMP L2 ;num2 > num1

	L1:
	cmp eax, ecx
	JE E
	JG L3 ;num1>num3
	JMP L4 ;num3>num1

	L2:
	cmp ebx, ecx
	JE E
	JG L5 ;num2>num3
	JMP L4 ;num3>num2
	
	L3:
	mov [large], eax
	JMP PRINT

	L4:
	mov [large], ecx
	JMP PRINT

	L5:
	mov [large], ebx
	JMP PRINT

	E:
	mov [large], eax
	mov eax, 4
	mov ebx, 1
	mov ecx, eq
	mov edx, eqlen
	int 80h	

	PRINT:
	mov eax, 4
	mov ebx, 1
	mov ecx, large
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
