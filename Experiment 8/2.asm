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
    display db 'Array: [ 10, -21, 45, 12, -25, 43, 78, 96, -89]', 10
    displen equ $-display

    showp db 'Positive numbers: '
    showplen equ $-showp

    shown db 'Negative numbers: '
    shownlen equ $-shown

    array dw 10, -21, 45, 12, -25, 43, 78, 96, -89
    len equ 9

    npos dw 0
    nneg dw 0

    nl db '', 10
    nllen equ $-nl

section .bss
    buff resb 2

section .text
    global _start
_start:
    write display, displen

    mov esi, array      ; sets esi to point tot he start of the array
    mov ecx, len        ; sets ecx to the length of the array            

check:                  ; iterates thru each element in the array
    BT word[esi], 15    ; BT: Bitwise Test, checks the sign bit which is the 15th bit
    JC N                
    JMP P

P:
    inc byte[npos]
    JMP end

N:
    inc byte[nneg]
    JMP end

end:
    inc esi
    inc esi
    loop check

output:
    write showp, showplen
    mov bl, [npos]
    CALL hex_ascii
    write nl, nllen

    write shown, shownlen
    mov bl, [nneg]
    CALL hex_ascii
    write nl, nllen

mov eax, 1
int 80h

; Procedures

hex_ascii:
    mov ecx, 2
    mov edi, buff

    DUP:
        rol bl, 04
        mov al, bl
        and al, 0fh
        cmp al, 09h
        jbe NEXT
        add al, 07h
    
    NEXT:
        add al, 30h
        mov [edi], al
        inc edi
        loop DUP
    
    write buff, 2
ret
