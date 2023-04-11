SECTION .DATA

string db 

SECTION .TEXT

GLOBAL _start

_start:
	mov eax , 4
	mov ebx,1 
	mov ecx,star
	mov edx ,9
	int 80h

	mov eax,1
	mov ebx,0
	int 80h
 
