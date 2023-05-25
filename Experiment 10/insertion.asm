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

    mov eax, '0'
    mov [j], eax

    call input

    call insertionsort

    endl
    write srtd, srtedlen
    endl

    call display

    return

; procedures

input:
    write ask, asklen    ; Write the prompt asking for input
    write nl, nllen      ; Write a newline character

    mov [i], dword '0'   ; Initialize the counter variable 'i' to zero

    loop1:
        mov esi, [i]        ; Move the value of 'i' into the register esi
        cmp esi, [n]        ; Compare 'i' with the value in 'n'
        jge after1          ; If 'i' is greater or equal to 'n', jump to 'after1'

        sub esi, '0'        ; Convert the character value of 'i' to its corresponding integer value
        add esi, arr        ; Calculate the address of arr[i]
        read esi, 1         ; Read a single character and store it at arr[i]

        inc dword[i]        ; Increment the value of 'i' by 1
        jmp loop1           ; Jump back to the beginning of the loop

    after1:
        ret                 ; Return from the procedure

display:
    write pass, passlen        ; Write the string "pass"
    write j, 9                 ; Write the variable 'j' with a width of 9 characters
    write arrow, arlen         ; Write the string "->"
    mov [i], dword '0'         ; Initialize the counter variable 'i' to zero

    loop2:
        mov esi, [i]               ; Move the value of 'i' into the register esi
        cmp esi, [n]               ; Compare 'i' with the value in 'n'
        jge after2                 ; If 'i' is greater or equal to 'n', jump to 'after2'

        sub esi, '0'               ; Convert the character value of 'i' to its corresponding integer value
        add esi, arr               ; Calculate the address of arr[i]
        write esi, 1               ; Write the value at the calculated address (arr[i])
        write space, splen        ; Write a space character
        inc dword[i]               ; Increment the value of 'i' by 1
        jmp loop2                  ; Jump back to the beginning of the loop

    after2:
        write nl, nllen            ; Write a newline character
        ret                        ; Return from the procedure

insertionsort:
    mov eax, 1                  ; Initialize the counter variable 'al' to 1
    mov bl, [n]                 ; Move the value of 'n' into the register bl
    sub bl, '0'                 ; Convert the character value of 'n' to its corresponding integer value

    loop3:
        cmp al, bl                 ; Compare the value in 'al' with 'bl'
        jge after3                  ; If 'al' is greater or equal to 'bl', jump to 'after3'

        pushad                      ; Save the values of all registers on the stack

        call display                ; Call the 'display' procedure to show the current state of 'arr'

        popad                       ; Restore the values of registers from the stack

        mov ecx, 0                  ; Initialize the counter variable 'ecx' to zero
        mov cl, al                  ; Move the value of 'al' into the lower byte of 'ecx'
        sub cl, 1                   ; Decrement 'cl' by 1 to start the inner loop

        mov dl, [arr + eax]         ; Move the value at 'arr[eax]' into the register 'dl'

        loop4:
            cmp cl, 0                ; Repeat until 'cl' is less than 0
            jl after4                 ; If 'cl' is less than 0, jump to 'after4'

            cmp dl, [arr + ecx]      ; Compare 'dl' with the value at 'arr[ecx]'
            jge after4                ; If 'dl' is greater or equal, jump to 'after4'

            mov dh, [arr + ecx]      ; Move the value at 'arr[ecx]' into the register 'dh'
            mov [arr + ecx + 1], dh  ; Move the value of 'dh' into 'arr[ecx + 1]'

            dec ecx                   ; Decrement the counter 'ecx' by 1
            jmp loop4                 ; Jump back to the beginning of the inner loop

        after4:
            mov [arr + ecx + 1], dl  ; Move the value of 'dl' into 'arr[ecx + 1]'

            inc al                     ; Increment the value of 'al' by 1

            inc byte[j]                ; Increment the value of 'j' by 1
            jmp loop3                  ; Jump back to the beginning of the outer loop

    after3:
        ret                           ; Return from the procedure