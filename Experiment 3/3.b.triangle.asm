section .data
	askUser db "Enter the side of a triangle: ", 10
	askUserLen equ $-askUser
	askUserHeight db "Enter the height of a triangle: ", 10
	askHeightLen equ $-askUserHeight

	displayArea db "The area is : ", 9
	displayAreaLen equ $-displayArea
	displayPeri db "The perimeter is: ", 9
	displayPeriLen equ $-displayPeri

	newLineMsg db 0xA, 0xD			; --- for new line
	newLineLen equ $-newLineMsg

section .bss
	side1 resb 9
	side2 resb 9
	side3 resb 9
	height resb 9
	area resb 9
	inter resb 9
	perimeter resb 9

section .text 
	global _start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, askUser
	mov edx, askUserLen
	int 80h
	
; ---------- Read values from user
	mov eax, 3
	mov ebx, 2
	mov ecx, side1
	mov edx, 9
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, side2
	mov edx, 9
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, side3
	mov edx, 9
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, askUserHeight
	mov edx, askHeightLen
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, height
	mov edx, 9
	int 80h

; -------- Calculate area of triangle
	mov al, [side1]
	sub al, '0'
	mov bl, [height]
	sub bl, '0'
	mul bl
	add al, '0'	
	mov [inter], al
	
	mov al, [inter]
	sub al, '0' 
	mov bl, '2'
	sub bl, '0'
	div bl
	add al, '0'
	mov [area], al

	mov eax, 4
	mov ebx, 1
	mov ecx, displayArea
	mov edx, displayAreaLen
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, area
	mov edx, 9
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newLineMsg
	mov edx, newLineLen
	int 80h

; -------- Calculate perimeter of triangle
	mov eax, [side1]
	sub eax, '0'
	mov ebx, [side2]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'
	mov [inter], eax

	mov eax, [side3]
	sub eax, '0'
	mov ebx, [inter]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'
	mov [perimeter], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, displayPeri
	mov edx, displayPeriLen
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, perimeter
	mov edx, 9
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newLineMsg
	mov edx, newLineLen
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
