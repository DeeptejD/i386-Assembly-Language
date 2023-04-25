section .data
	ask db 'Enter a number:'
	asklen equ $-ask

	is db 'The entered number is greater than 5'
	islen equ $-is
	
	isnot db 'The entered number is not greater than 5'
	isnotlen equ $-isnot
	
	equal db 'The entered number is equal to 5'
	eqlen equ $-equal
	
section .bss
	num1 resb 4
	;five resb 4
	
section .text
	global_start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, ask
	mov edx, asklen
	int 80h
	
	mov eax, 3
	mov ebx, 2
	mov ecx, num1
	int 80h
	
	mov al, [num1]
	sub al, '0'
	mov bl, '5'
	sub bl, '0'
	cmp al, bl
	
	JE L1
	JG L2
	JMP L3
	
	L1:
	mov eax, 4
	mov ebx, 1
	mov ecx, equal
	mov edx, eqlen
	int 80h
	JMP L4
	
	L2:
	mov eax, 4
	mov ebx, 1
	mov ecx, is
	mov edx, islen
	int 80h
	JMP L4
	
	L3:
	mov eax, 4
	mov ebx, 1
	mov ecx, isnot
	mov edx, isnotlen
	int 80h
	JMP L4
	
	L4:
	mov eax, 1
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 80h
	
