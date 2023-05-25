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
    sub byte[n], '0'

    mov eax, '0'
    mov [j], eax

    call input

    call selectionsort

    endl
    write srtd, srtedlen
    endl

    call display

    return

; procedures

input:
    write ask, asklen   ; Write the string "Enter the size of the array: "
write nl, nllen     ; Write a newline character

mov [i], dword 0    ; Initialize the counter variable 'i' to zero

loop1:
    mov esi, [i]        ; Move the value of 'i' into the register esi
    cmp esi, [n]        ; Compare 'i' with the value in 'n'
    jge after1          ; If 'i' is greater or equal to 'n', jump to 'after1'

    add esi, arr        ; Calculate the address of arr[i]
    read esi, 1         ; Read a single character and store it at the calculated address

    inc dword[i]        ; Increment the value of 'i' by 1
    jmp loop1           ; Jump back to the beginning of the loop

after1:
    ret                 ; Return from the procedure

display:
    write pass, passlen ; Write the string "pass"
    write j, 9          ; Write the variable 'j' with a width of 9 characters
    write arrow, arlen  ; Write the string "->"
    mov [i], dword 0    ; Initialize the counter variable 'i' to zero

loop2:
    mov esi, [i]        ; Move the value of 'i' into the register esi
    cmp esi, [n]        ; Compare 'i' with the value in 'n'
    jge after2          ; If 'i' is greater or equal to 'n', jump to 'after2'

    add esi, arr        ; Calculate the address of arr[i]
    write esi, 1        ; Write the value at the calculated address (arr[i])
    write space, splen  ; Write a space character
    inc dword[i]        ; Increment the value of 'i' by 1
    jmp loop2           ; Jump back to the beginning of the loop

after2:
    write nl, nllen     ; Write a newline character
    ret                 ; Return from the procedure

selectionsort:
    mov eax, 0          ; Initialize the counter variable 'al' to zero

    mov bl, [n]         ; Move the value of 'n' into the register bl
    sub bl, 1           ; Subtract 1 from bl (bl is n-1)

loop3:
    cmp al, bl          ; Compare the value in 'al' with 'bl'
    jge after3          ; If 'al' is greater or equal to 'bl', jump to 'after3'

    pushad              ; Save the values of all registers on the stack

    call display        ; Call the 'display' procedure to show the current state of 'arr'

    popad               ; Restore the values of registers from the stack

    mov ecx, 0          ; Clear the register ecx
    mov cl, al          ; Move the value of 'al' into the lower byte of 'ecx'
    add cl, 1           ; Increment 'cl' by 1 (ecx is the counter for the inner loop)

    mov edi, arr        ; edi points to arr[eax]
    add edi, eax

loop4:
    cmp cl, [n]         ; Compare 'cl' with the value in 'n'
    jge after4          ; If 'cl' is greater or equal to 'n', jump to 'after4'

    mov esi, arr        ; esi points to arr[ecx]
    add esi, ecx

    mov bh, [esi]       ; Move the value at 'arr[ecx]' into the register 'bh'
    mov dh, [edi]       ; Move the value at 'arr[eax]' into the register 'dh'
    cmp bh, dh          ; Compare 'bh' with 'dh'
    jge after5          ; If 'bh' is greater or equal, jump to 'after5'

    mov edi, arr        ; edi points to arr[ecx]
    add edi, ecx

after5:
    inc cl              ; Increment the counter 'cl' by 1
    jmp loop4           ; Jump back to the beginning of the inner loop

after4:
    ; Swap arr[eax] and [edi]
    mov bh, [arr + eax] ; Move the value at 'arr[eax]' into the register 'bh'

    mov dh, [edi]       ; Move the value at 'arr[ecx]' into the register 'dh'
    mov [arr + eax], dh ; Move the value of 'dh' into 'arr[eax]'
    mov [edi], bh       ; Move the value of 'bh' into 'arr[ecx]'

    inc al              ; Increment the value of 'al' by 1

    inc byte[j]         ; Increment the value of 'j' by 1
    jmp loop3           ; Jump back to the beginning of the outer loop

after3:
    ret                 ; Return from the procedure
