; odd even

%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1 
    mov edx, %2
    int 80h
%endmacro

section .data
	asknum db 'Enter the number of elements: '
	asknumlen equ $-asknum
	
	ask db 'Enter elements of the array: '
	asklen equ $-ask
	
	showe db 'Even: '
	showelen equ $-showe
	
	showo db 'Odd: '
	showolen equ $-showo
	
	nl db '', 10
	nllen equ $-nl
	
	array times 10 dw 0
	len equ 10

section .bss
	num resb 10
	i resb 10
	el resb 10
	rem resb 5
	neven resb 5
	nodd resb 5
	
section .text
	global _start
_start:
	write asknum, asknumlen
	read num, 10
	
	write ask, asklen
	
	mov byte[neven], 0
	mov byte[nodd], 0
	mov byte[i], 0
	
	mov esi, array
	
	input:
		read el, 2
		mov ebx, [el]
		mov [esi], ebx
		
		inc esi
		inc byte[i]
		
		mov al, [i]
		mov bl, [num]
		sub bl, '0'
		
		cmp al, bl
		jl input
		
	mov byte[i], 0
	mov esi, array
	
	check:
		mov al, [esi]
		mov bl, '2'
		sub bl, '0'
		div bl
		
		cmp ah, 0
		JE even
		JMP odd
		
	even:
		inc byte[neven]
		jmp loop
	
	odd:
		inc byte[nodd]
		jmp loop
	
	loop:
		inc esi
		inc byte[i]
		
		mov al, [i]
		mov bl, [num]
		sub bl, '0'
		cmp al, bl
		JL check
		JE output
		
	output:
		add [neven], byte '0'
		add [nodd], byte '0'
		
		write showe, showelen
		write neven, 5
		
		write nl, nllen
		
		write showo, showolen
		write nodd, 5
		
		write nl, nllen
		
	mov eax, 1
	int 80h

