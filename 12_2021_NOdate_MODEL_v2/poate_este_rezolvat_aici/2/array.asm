%include "utils/printf32.asm"

extern printf

section .data
    num dd 55555123
    char_format db "%s", 13, 10, 0
    word_format db "%hd", 13, 10, 0
    arr db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    arr_result dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
;;  TODO d: declare byte_array so that PRINT_HEX shows babadac 
    byte_array db 172, 173, 171, 11
	
section .text
global main

; TODO b: implement array_reverse
array_reverse:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov esi, [ebp + 12]
    mov edi, esi
    shr edi, 1
    xor ecx, ecx
    dec esi
reverse_loop:
    mov bl, [eax + ecx]
    push eax
    add eax, esi
    sub eax, ecx
    mov dl, [eax]
    pop eax
    mov [eax + ecx], dl
    push eax
    add eax, esi,
    sub eax, ecx
    mov [eax], bl
    pop eax
    inc ecx
    cmp ecx, edi
    jl reverse_loop
    leave
    ret
; TODO c: implement pow_arraypowArray
pow_array:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 16]
    mov edx, [ebp + 12]
    xor ecx, ecx
compute_array:
    movzx edi, byte [eax + ecx]
    push eax
    push edx
    mov eax, edi
    mul edi
    mov [ebx + 2 * ecx], ax
    pop edx
    pop eax
    inc ecx
    cmp ecx, edx
    jl compute_array
    leave
    ret
main:
    push ebp
    mov ebp, esp

    ;TODO a: allocate on array of 20 byte elements and initializate it incrementally starting from 'A'
    sub esp, 20
    mov eax, 65
    xor ecx, ecx
initialize_array:
    mov BYTE [esp + ecx], al
    inc ecx
    inc eax
    cmp ecx, 20
    jl initialize_array
    ;TODO b: call array_reverse and print reversed array
    lea eax, [ebp - 20]
    push dword 20
    push eax
    call array_reverse
    add esp, 8
    push esp
    push char_format
    call printf
    add esp, 8
    ;TODO c: call pow_array and print the result array
    push arr_result
    push dword 10
    push arr
    call pow_array
    add esp, 12
    
    push dword [arr_result + 4]
    push word_format
    call printf
    add esp, 8
	;;  TODO d: this print of an uint32_t should print babadac 
	PRINTF32 `%x\n\x0`, [byte_array]

    xor eax, eax
    leave
    ret
