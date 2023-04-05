section .data
	hello db 'hello world', 10	
	hellolen equ $-hello		; save the length of string in 'hello'
section .text
	global _start
_start:
	MOV eax, 4			; write register
	MOV ebx, 1			
	MOV ecx, hello			; store the string into register
	MOV edx, hellolen		; store the size of the string
	int 80h			; endline
	MOV eax, 1			; exiting the program (below 2 lines)
	MOV ebx, 0
	int 80h	