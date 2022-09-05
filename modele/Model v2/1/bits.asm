%include "utils/printf32.asm"

section .data
    num dd 55555123

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num
    mov eax, [num]
    shr eax, 16
    mov ebx, 1
    mov edx, 2
    and ebx, eax
    and edx, eax
    shr edx, 1
    PRINTF32 `%d%d\n\x0`, edx, ebx
    ;TODO b: print number of bits set on odd positions
    xor ecx, ecx
    xor edx, edx
count_bits:
    mov eax, 1
    shl eax, cl
    test dword [num], eax
    jz check_counter
    inc edx
check_counter:
    add ecx, 2
    cmp ecx, 32
    jl count_bits
    PRINTF32 `%d\n\x0`, edx
    ;TODO c: print number of groups of 3 consecutive bits set
    xor ecx, ecx
    xor edx, edx
count_bits_c:
    mov eax, 7
    shl eax, cl
    mov ebx, eax
    and eax, dword [num]
    cmp eax, ebx
    jne check_counter_c
    inc edx
check_counter_c:
    inc ecx
    cmp ecx, 30
    jl count_bits_c
    PRINTF32 `%d\n\x0`, edx
    xor eax, eax
    leave
    ret
