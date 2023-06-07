; AREA AND PERIMETER OF A RECTANGLE AND A TRIANGLE
section .data
	nl db "", 10
	nllen equ $-nl

	ask1 db 'Enter length: '
	ask1len equ $-ask1

	ask2 db 'Enter breadth: '
	ask2len equ $-ask2

	ask3 db 'Enter the base: '
	ask3len equ $-ask3

	ask4 db 'Enter height: '
	ask4len equ $-ask4

	ask5 db 'Enter hypotenuse: '
	ask5len equ $-ask5

	showa db 'Area: '
	showalen equ $-showa

	showp db 'Perimeter: '
	showplen equ $-showp




; WRITE MACRO
%macro write 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

; READ MACRO
%macro read 2
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

; NEWLINE MACRO
%macro endl 0
	mov eax, 4
	mov ebx, 1
	mov ecx, nl
	mov edx, nllen
	int 80h
%endmacro

; DECLARE VARIABLES
section .bss
	rl resb 9
	rb resb 9
	rarea resb 9
	rp resb 9

	tb resb 9
	th resb 9
	tarea resb 9
	tp resb 9
	thyp resb 9

section .text
	global _start
_start:

	; GET RECTANGLE
	write ask1, ask1len
	read rl, 9
	write ask2,ask2len
	read rb, 9

	; RECTANGLE AREA
	mov al, [rl]
	mov bl, [rb]
	sub al, '0'
	sub bl, '0'
	mul bl
	add al, '0'
	mov [rarea], al

	; RECTANGLE PERIMETER
	mov al, [rl]
	mov bl, [rb]
	sub al, '0'
	sub bl, '0'
	add al, al
	add al, bl
	add al, bl
	add al, '0'
	mov [rp], al

	; PRINT RECTANGLE
	write showa, showalen
	write rarea, 9
	endl
	write showp, showplen
	write rp, 9
	endl

	; GET TRIANGLE
	write ask3, ask3len
	read tb, 9
	write ask4, ask4len
	read th, 9
	write ask5, ask5len
	read thyp, 9

	; TRIANGLE AREA
	mov al, [tb]
	mov bl, [th]
	sub al, '0'
	sub bl, '0'
	mul bl
	mov bl, 2
	div bl
	add al, '0'
	mov [tarea], al

	;TRIANGLE PERIMETER
	mov al, [tb]
	mov bl, [th]
	sub al, '0'
	sub bl, '0'	
	add al, bl
	mov bl, [thyp]
	sub bl, '0'
	add al, bl
	add al, '0'
	mov [tp], al

	write showa, showalen
	write tarea, 9
	endl
	write showp, showplen
	write tp, 9
	endl

	; EXIT CALL
	mov eax, 1
	mov ebx, 0
	int 80h