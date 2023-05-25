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
    asknum db 'Enter the number of elements: ';
    asknumlen equ $-asknum

    ask db 'Enter'
    asklen equ $-ask

    cont db 'Array: '
    contlen equ $-cont

    search db 'Enter element to be searched: '
    slen equ $-search

    found db 'Element found at index: '
    foundlen equ $-found

    nfound db 'Element not found'
    nfoundlen equ $-nfound

    array times 10 dw 0
    len equ 10

    nl db '', 10
    nllen equ $-nl

section .bss
    num resb 5
    i resb 5
    el resb 5
    temp resb 5
    pos resb 5

section .text
    global _start
_start:
    ; enter length of array
    write asknum, asknumlen
    read num, 5

    write ask, asklen
    write nl, nllen

    mov byte[i], 0
    mov esi, array

    input:
    read temp, 2         ; Read two characters of input and store them in 'temp'
    mov ebx, [temp]     ; Move the value of 'temp' into 'ebx'
    mov [esi], ebx      ; Store the value of 'ebx' into the memory location pointed to by 'esi'

    inc esi             ; Increment 'esi' to point to the next element in the array
    inc byte[i]         ; Increment the value stored in the memory location referenced by 'i'

    mov al, [i]         ; Move the value stored in the memory location referenced by 'i' into 'al'
    mov bl, [num]       ; Move the value stored in the memory location referenced by 'num' into 'bl'
    sub bl, '0'         ; Convert the character in 'bl' to its corresponding numeric value
    cmp al, bl          ; Compare the values in 'al' and 'bl' for equality
    JE e_in             ; Jump to 'e_in' if the values in 'al' and 'bl' are equal
    jmp input           ; Jump back to 'input' to read the next input

e_in:
    write search, slen  ; Write the "Enter element to be searched: " message
    read el, 5          ; Read up to five characters of input and store them in 'el'

display:
    write cont, contlen ; Write the "Array: " message
    mov byte[i], 0      ; Reset the value stored in the memory location referenced by 'i' to zero
    mov esi, array      ; Set 'esi' to point to the start of the array
    mov ecx, len        ; Set 'ecx' to the length of the array

display_loop:
    mov ebx, [esi]      ; Move the value at the memory location pointed to by 'esi' into 'ebx'
    mov [temp], ebx     ; Store the value of 'ebx' in 'temp'
    write temp, 1       ; Write the value of 'temp' to output
    write nl, nllen     ; Write a new line character

    inc esi             ; Increment 'esi' to point to the next element in the array
    inc byte[i]         ; Increment the value stored in the memory location referenced by 'i'

    mov al, [i]         ; Move the value stored in the memory location referenced by 'i' into 'al'
    mov bl, [num]       ; Move the value stored in the memory location referenced by 'num' into 'bl'
    sub bl, '0'         ; Convert the character in 'bl' to its corresponding numeric value
    cmp al, bl          ; Compare the values in 'al' and 'bl'
    jl display_loop     ; Jump to 'display_loop' if the value in 'al' is less than 'bl'

check:
    mov ebx, [esi]      ; Move the value at the memory location pointed to by 'esi' into 'ebx'
    mov [temp], ebx     ; Store the value of 'ebx' in 'temp'
    mov bl, [temp]      ; Move the value of 'temp' into 'bl'
    mov al, [el]        ; Move the value at the memory location referenced by 'el' into 'al'

    cmp al, bl          ; Compare the values in 'al' and 'bl'
    je f                ; Jump to 'f' if the values are equal
    jmp nf              ; Jump to 'nf' otherwise

f:
    inc byte[i]         ; Increment the value stored in the memory location referenced by 'i'
    mov al, [i]         ; Move the value stored in the memory location referenced by 'i' into 'al'
    add al, '0'         ; Convert the numeric value in 'al' to its corresponding ASCII character
    mov [pos], al       ; Store the ASCII character in the memory location referenced by 'pos'
    dec byte[pos]       ; Decrement the value stored in the memory location referenced by 'pos'
    write found, foundlen ; Write the "Element found at index: " message
    write pos, 5        ; Write the value stored in the memory location referenced by 'pos'
    write nl, nllen     ; Write a new line character
    jmp return          ; Jump to 'return'

nf:
    inc esi             ; Increment 'esi' to point to the next element in the array
    inc byte[i]         ; Increment the value stored in the memory location referenced by 'i'

    mov al, [i]         ; Move the value stored in the memory location referenced by 'i' into 'al'
    mov bl, [num]       ; Move the value stored in the memory location referenced by 'num' into 'bl'
    sub bl, '0'         ; Convert the character in 'bl' to its corresponding numeric value
    cmp al, bl          ; Compare the values in 'al' and 'bl'
    jl check            ; Jump to 'check' if the value in 'al' is less than 'bl'
    je fail             ; Jump to 'fail' if the values in 'al' and 'bl' are equal

fail:
    write nfound, nfoundlen ; Write the "Element not found" message
    write nl, nllen     ; Write a new line character
    jmp return          ; Jump to 'return'

return:
    mov eax, 1          ; Set the system call number for exit (1)
    int 80h             ; Perform the system call
