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
    mov eax, 3
    mov ebx, 2
    mov ecx, trash
    mov edx, 1
    int 80h
%endmacro

%macro endl 0
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

%macro return 0
    mov eax, 1
    int 80h
%endmacro

section .data
    asknum db 'Enter the number of elements: ';
    asknumlen equ $-asknum

    ask db 'Enter the elements'
    asklen equ $-ask

    cont db 'Array: '
    contlen equ $-cont

    srtd db 'The Sorted Array is'
    srtedlen equ $-srtd

    pass db 'Pass '
    passlen equ $-pass

    arrow db ': '
    arlen equ $-arrow

    space db ' '
    splen equ $-space

    nl db '', 10
    nllen equ $-nl

    array times 10 dw 0
    len equ 10

section .bss
    n resb 4
    arr resb 10
    i resb 4
    j resb 9
    trash resb 1

section .text
    global _start
_start:
    write asknum, asknumlen
    read n, 1
    ; sub [n], byte '0'

    ; input
    ; mov eax, arr
    ; mov edx, [n]
    call input
    
    endl

    mov eax, '0'
    mov [j], eax

    call bubblesort

    write nl, nllen
    write srtd, srtedlen
    endl
    ; display
    ; mov eax, arr
    ; mov edx, [n]
    call display

    return

input:
    write ask, asklen   ; Write the "Enter the number of elements: " message
    write nl, nllen     ; Write a new line character

    mov [i], dword '0'  ; Initialize the value stored in the memory location referenced by 'i' to ASCII '0'

loop1:
    mov esi, [i]        ; Move the value stored in the memory location referenced by 'i' into 'esi'
    cmp esi, [n]        ; Compare the values in 'esi' and 'n'
    jge after1          ; Jump to 'after1' if the value in 'esi' is greater than or equal to 'n'

    sub esi, '0'        ; Convert the ASCII value in 'esi' to its corresponding numeric value
    add esi, arr        ; Add the value of 'arr' to 'esi' to calculate the memory address
    read esi, 1         ; Read one character of input and store it in the memory location referenced by 'esi'

    inc dword[i]        ; Increment the value stored in the memory location referenced by 'i'
    jmp loop1           ; Jump back to 'loop1' to read the next input

after1:
    ret                 ; Return from the current subroutine

display:
    write pass, passlen ; Write the "Pass: " message
    write j, 9          ; Write the value of 'j' (assumed to be a single digit) followed by a space
    write arrow, arlen  ; Write the arrow symbol
    mov [i], dword '0'  ; Initialize the value stored in the memory location referenced by 'i' to ASCII '0'

loop2:
    mov esi, [i]        ; Move the value stored in the memory location referenced by 'i' into 'esi'
    cmp esi, [n]        ; Compare the values in 'esi' and 'n'
    jge after2          ; Jump to 'after2' if the value in 'esi' is greater than or equal to 'n'

    sub esi, '0'        ; Convert the ASCII value in 'esi' to its corresponding numeric value
    add esi, arr        ; Add the value of 'arr' to 'esi' to calculate the memory address
    write esi, 1        ; Write the value at the memory location referenced by 'esi'
    write space, splen  ; Write a space character

    inc dword[i]        ; Increment the value stored in the memory location referenced by 'i'
    jmp loop2           ; Jump back to 'loop2' to process the next element

after2:
    write nl, nllen     ; Write a new line character
    ret                 ; Return from the current subroutine

bubblesort:
    mov al, 0           ; Initialize the counter for the outer loop to 0

    mov bl, [n]         ; Move the value stored in the memory location referenced by 'n' into 'bl'
    sub bl, '0'         ; Convert the ASCII value in 'bl' to its corresponding numeric value
    sub bl, 1           ; Subtract 1 from the numeric value in 'bl' (bl is n-1)

loop3:
    cmp al, bl          ; Compare the values in 'al' and 'bl'
    jge after3          ; Jump to 'after3' if the value in 'al' is greater than or equal to 'bl'

    pushad              ; Save all general-purpose registers on the stack
    mov eax, arr        ; Move the address of 'arr' into 'eax'
    mov edx, [n]        ; Move the value stored in the memory location referenced by 'n' into 'edx'
    call display        ; Call the 'display' subroutine to print the array
    popad               ; Restore all general-purpose registers from the stack

    mov ecx, 0          ; Initialize the counter for the inner loop to 0

    mov dl, bl          ; Move the value stored in 'bl' into 'dl'
    sub dl, al          ; Subtract the value in 'al' from the value in 'dl' (dl is n-1-al)

loop4:
    cmp cl, dl          ; Compare the values in 'cl' and 'dl'
    jge after4          ; Jump to 'after4' if the value in 'cl' is greater than or equal to 'dl'

    mov esi, arr        ; Move the address of 'arr' into 'esi'
    add esi, ecx        ; Add the value of 'ecx' to 'esi' to calculate the memory address of arr[ecx]

    mov ah, [esi]       ; Move the byte value at the memory location referenced by 'esi' into 'ah'
    mov bh, [esi + 1]   ; Move the byte value at the memory location referenced by 'esi+1' into 'bh'
    cmp ah, bh          ; Compare the values in 'ah' and 'bh'

    jle after5          ; Jump to 'after5' if the value in 'ah' is less than or equal to the value in 'bh'

    ; Swap arr[ecx] and arr[ecx+1]
    mov [esi + 1], ah   ; Move the value in 'ah' to the memory location referenced by 'esi+1'
    mov [esi], bh       ; Move the value in 'bh' to the memory location referenced by 'esi'

after5:
    inc cl              ; Increment the value stored in the memory location referenced by 'cl'
    jmp loop4           ; Jump back to 'loop4' to process the next pair of elements

after4:
    inc al              ; Increment the value stored in the memory location referenced by 'al'
    inc byte[j]         ; Increment the value stored in the memory location referenced by 'j'
    jmp loop3           ; Jump back to 'loop3' for the next iteration of the outer loop

after3:
    ret                 ; Return from the current subroutine
