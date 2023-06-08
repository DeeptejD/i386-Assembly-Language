section .data
	msg1 db'Enter number 1',10
	msg1l equ $- msg1

	msg2 db'Enter number 2',10
	msg2l equ $- msg2
	
	msg3 db'Not Congruent',10
	msg3l equ $- msg3

	msg4 db'Congruent',10
	msg4l equ $- msg4
	
	nl db'',10
	nll equ $- nl

section .bss
	a resb 1
	b resb 1
	count resb 1
	trash resb 1
	
	div1 resb 1
	div2 resb 1

	temp resb 1

%macro write 2
	mov eax , 4
	mov ebx , 1
	mov ecx , %1
	mov edx , %2
	int 80h
%endmacro

%macro read 2
	mov eax , 3
	mov ebx , 2
	mov ecx , %1
	mov edx , %2
	int 80h

	mov eax , 3
	mov ebx, 2
	mov ecx , trash
	mov edx , 1
	int 80h
%endmacro

section .text
global _start
_start :
	write msg1 , msg1l
	read a , 1
	write msg2 , msg2l
	read b , 1

	mov al , [a]
	mov bl , [b]
	sub al , '0'
	sub bl , '0'

	mov [a] , al 
	mov [b] , bl

	mov cl , 2
	
	mov al , [a]
	mov bl , [b]

	cmp al , bl
	jg init
		
	mov dl , [b]
	jmp chk			

	init:
	mov dl , [a]

	chk:
	cmp cl , dl
	je NOT
	mov al , [a]
	mov ah , 0
	mov bl , cl
	div bl
	mov [div1] , ah
	
	mov al , [b]
	mov ah , 0
	mov bl , cl
	div bl
	mov [div2] , ah

	mov al , byte[div1]
	mov bl , byte[div2]
	
	cmp al , bl
	je YES
	inc cl
	jmp chk

	YES:
		add cl , '0'
		mov [temp] , cl
		write temp , 1
		write nl , nll
		write msg4 , msg4l
		jmp end
	

	NOT:
		write msg3 , msg3l

	end:		
		mov eax , 1
		mov ebx , 0
		int 80h


	























