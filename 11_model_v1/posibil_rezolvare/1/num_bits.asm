section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012
    has_sign_bit db "sign bit", 13, 10, 0
    has_not_sign_bit db "no sign bit", 13, 10, 0
    print_format db "%s", 0
    print_format_b db "%d", 13, 10, 0

section .text
extern printf
global main

count_bits_function:
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 8]
    mov esi, [ebp + 12]
    xor ecx, ecx
    xor edx, edx
count_bits:
    mov eax, 1
    shl eax, cl
    test eax, ebx
    jnz add_bit
    jmp check_condition
add_bit:
    inc edx
check_condition:
    inc ecx
    cmp ecx, esi
    jl count_bits
    mov eax, edx
    leave
    ret
main:
    push ebp
    mov ebp, esp


    ; TODO a: Print if sign bit is present or not.
    mov eax, 1
    shl eax, 31
    mov ebx, [val1]
    test eax, ebx
    jnz print_sign_bit
    push has_not_sign_bit
    push print_format
    call printf
    add esp, 8
    jmp end_first_task

print_sign_bit:
    push has_sign_bit
    push print_format
    call printf
    add esp, 8
end_first_task:
    ; TODO b: Prin number of bits for integer value.
    push DWORD 32
    push ebx
    call count_bits_function
    add esp, 8
    push eax
    push print_format_b
    call printf
    add esp, 8
    ; TODO c: Prin number of bits for array.
    xor ecx, ecx
    xor edx, edx
iterate_array:
    movzx eax, BYTE [arr1 + ecx]
    push ecx
    push edx
    push DWORD 8
    push eax
    call count_bits_function
    add esp, 8
    pop edx
    pop ecx
    add edx, eax
    inc ecx
    cmp ecx, len1
    jl iterate_array
    push edx
    push print_format_b
    call printf
    add esp, 8
    ; Return 0.
    xor eax, eax
    leave
    ret
