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
	asknum db 'ENter number: '
	asknumlen equ $-asknum
	
	ask db 'Enter: '
	asklen equ $-ask
	
	mfive db 'Above 5: '
	mfivelen equ $-mfive
	
	nmfive db 'Below 5: '
	nmfivelen equ $-nmfive
	
	array times 10 dw 0
	len equ 10
	
	nl db '', 10
	nllen equ $-nl
	
section .bss
	num resb 10
	i resb 10
	el resb 10
	rem resb 5
	h resb 5
	l resb 5
	
section .text
	global _start
_start:
	write asknum, asknumlen
	read num, 10
	
	write ask, asklen
	
	mov byte[h], 0
	mov byte[l], 0
	
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
		mov eax, [esi]
		mov [el], eax
		
		mov al, [el]
		mov bl, '5'
		cmp al, bl
		
		jl below
		jmp above
		
	above:
		inc byte[h]
		jmp loop
	
	below:
		inc byte[l]
		jmp loop
	
	loop:
		inc esi
		inc byte[i]
		
		mov al, [i]
		mov bl, [num]
		sub bl, '0'
		cmp al, bl
		jl check
		je output
	
	output:
		add [h], byte '0'
		add [l], byte '0'
		
		write mfive, mfivelen
		write h, 5
		write nl, nllen
		
		write nmfive, nmfivelen
		write l, 5
		write nl, nllen
		
	mov eax, 1
	int 80h
	
