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
    ; clearing the input buffer
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

    space db ''

section .bss
    n resb 4
    num resb 4
    arr resb 10
    index resb 4
    lb resb 1
    ub resb 1
    mid resb 1
    trash resb 1

section .text
    global _start
_start:
    write asknum, asknumlen
    endl
    read n, 1
    sub [n], byte '0' ; convert from ASCII to numerical

    write ask, asklen
    endl
    mov eax, arr ; passing address of array
    mov edx, [n] ; passing size of the array
    call input   ; calling the input procedure

    write cont, contlen
    endl
    mov eax, arr 
    mov edx, [n]
    call display

    write search, slen
    read num, 1

    mov eax, arr
    mov edx, [n]
    mov edi, [num]
    call binsearch

    endl
    return

; procedures start here

input:
    ; eax -> address of array
    ; edx -> size

    mov ecx, 0  ; Initialize counter ecx to 0

    repin: 
        cmp ecx, edx  ; Compare ecx with the size of the array
        jge after_in  ; If ecx >= edx, exit the loop and jump to after_in

        mov esi, eax  ; Move the address of the array to esi
        add esi, ecx  ; Add the value of ecx to esi to get the address of the current element

        pushad  ; Save the registers since the read macro may change general eax, ebx, registers

        read esi, 1  ; Read a single character from the user and store it at the address in esi

        popad  ; Restore the registers

        inc ecx  ; Increment the counter ecx
        jmp repin  ; Jump back to the beginning of the loop

    after_in:
        ret  ; Return from the procedure

display:
    mov ecx, 0  ; Initialize counter ecx to 0

    repdis: 
        cmp ecx, edx  ; Compare ecx with the size of the array
        jge after_dis  ; If ecx >= edx, exit the loop and jump to after_dis

        mov esi, eax  ; Move the address of the array to esi
        add esi, ecx  ; Add the value of ecx to esi to get the address of the current element

        pushad  ; Save the registers

        write esi, 1  ; Write the value at the address in esi to the output

        endl  ; Print a new line

        popad  ; Restore the registers

        inc ecx  ; Increment the counter ecx
        jmp repdis  ; Jump back to the beginning of the loop

    after_dis:
        endl  ; Print a new line
        ret  ; Return from the procedure

binsearch:
    ; eax = address of arr
    ; edx = size
    ; edi = number to be searched

    ; array elements are 4 bti values
    and edi, 000fh  ; Perform a bitwise AND operation with the number to be searched (edi) and 000fh to keep only the lower 4 bits
    mov [lb], byte 0  ; Initialize the lower bound (lb) to 0
    mov [ub], dl  ; Initialize the upper bound (ub) to the size of the array, we use dl because ub is resb 1 (1 byte, so lowe 8 bits of edx)

    repsearch:
        pushad  ; Save the registers

        mov al, [lb]  ; Move the value of the lower bound (lb) to the al register

        add al, [ub]  ; Add the value of the upper bound (ub) to al
        cbw  ; Convert byte to word (sign-extend al into ax)
        mov bl, 2  ; Set the divisor (bl) to 2 for division

        div bl  ; Divide ax by bl
        mov [mid], al  ; Store the quotient (mid) in the mid variable

        popad  ; Restore the registers
        
        mov cl, [lb]  ; Move the value of the lower bound (lb) to the cl register
        mov dl, [ub]  ; Move the value of the upper bound (ub) to the dl register

        cmp cl, dl  ; Compare the lower bound (lb) with the upper bound (ub)
        jg after_search  ; If lb > ub, exit the loop and jump to after_search

        mov edx, [mid]  ; Move the value of mid to edx
        and edx, 000fh  ; Perform a bitwise AND operation with edx and 000fh to keep only the lower 4 bits
        mov esi, dword[eax + edx]  ; Move the value at the address [eax + edx] to esi
        and esi, 000fh  ; Perform a bitwise AND operation with esi and 000fh to keep only the lower 4 bits

        cmp edi, esi  ; Compare the number to be searched (edi) with the value in esi

        je matched  ; If they are equal, jump to matched
        jl lower  ; If edi < esi, jump to lower

    upper:
        mov bl, [mid]  ; Move the value of mid to bl
        add bl, 1  ; Increment bl by 1 to update the lower bound (lb)
        mov [lb], bl  ; Store the updated lower bound (lb) in memory
        jmp repsearch  ; Jump back to the beginning of the loop

    lower:
        mov bl, [mid]  ; Move the value of mid to bl
        sub bl, 1  ; Decrement bl by 1 to update the upper bound (ub)
        mov [ub], bl  ; Store the updated upper bound (ub) in memory
        jmp repsearch  ; Jump back to the beginning of the loop

    matched:
        add edx, '0'  ; Add '0' to edx to convert the index value to ASCII
        mov [index], edx  ; Store the converted index value in memory

        pushad  ; Save the registers

        write found, foundlen  ; Write the "Element found at index: " string
        write index, 1  ; Write the index value

        popad  ; Restore the registers
        ret  ; Return from the procedure

    after_search:
        write nfound, nfoundlen  ; Write the "Element not found" string
        endl  ; Print a new line
        ret  ; Return from the procedure

    

    
