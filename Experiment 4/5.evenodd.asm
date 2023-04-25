section .data
	ask db 'Enter a number: '
	asklen equ $-ask
	
	even db 'Even'
	evenlen equ $-even

	odd db 'Odd'
	oddlen equ $-odd

section .bss
	num1 resb 4

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
	mov bl, '2'
	sub bl, '0'
	div bl
	cmp ah, 0
	
	JE L1
	JMP L2
	
	L1:
	mov eax, 4
	mov ebx, 1
	mov ecx, even
	mov edx, evenlen
	int 80h
	JMP L3
	
	L2:
	mov eax, 4
	mov ebx, 1
	mov ecx, odd
	mov edx, oddlen
	int 80h
	
	L3:
	mov eax, 1
	int 80h
