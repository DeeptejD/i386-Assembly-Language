SECTION .bss
a resb 1
b resb 1
sum resb 2 ; one extra byte for carry

SECTIOn .data
ask db "Enter: ", 8
asklen equ $-ask
res db "Sum: ", 6
reslen equ $-res

SECTION .text
global _start

_start:
mov eax, 4
mov, ebx, 1
mov, ecx, ask
mov edx, asklen
int 80h

mov eax, 3
mov, ebx, 2
mov, ecx, a
mov edx, 1
int 80h

mov eax, 4
mov, ebx, 1
mov, ecx, ask
mov edx, asklen
int 80h

mov eax, 3
mov, ebx, 2
mov, ecx, b
mov edx, 1
int 80h

; addition
mov eax, [a]
sub eax, '0'
mov ebx, [b]
sub ebx, '0'
add eax, ebx

cmp eax, 9
jle ans

add eax, '1'
sub eax, 10

ans:
add eax, '0'

mov eax, 4
mov ebx, 1
mov ecx, eax
mov edx, 2
int 80h
