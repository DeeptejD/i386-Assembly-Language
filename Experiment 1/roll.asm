SECTION .bss
roll_no resb 9
sys_in equ 3
sys_read equ 2

SECTION .DATA
hello db 'Enter your roll number',10
hellolen equ $-hello

SECTION .TEXT
GLOBAL _start

_start:
	mov eax , 4
	mov ebx,1 
	mov ecx,hello
	mov edx , hellolen
	int 80h
	
	mov eax ,sys_in
	mov ebx ,sys_read
	mov ecx , roll_no
	mov edx ,9
	int 80h

	mov eax , 4
	mov ebx,1 
	mov ecx,roll_no
	mov edx , 9
	int 80h

	mov eax,1
	mov ebx,0
	int 80h

