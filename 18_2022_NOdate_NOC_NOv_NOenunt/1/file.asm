%include "utils/printf32.asm"
extern printf

section .data

M dd 0x12121212
mask db 0x12

arr dd 0x12345678, 0x12121212, 0x42424242, 0x12771277, 0xCAFEBABE, 0x12001200, 0x20222022, 0x03020302, 0x12FF12FF, 0xFF12FF12
len equ 10
res: times len dd 0

;TODO c: Declarati vectorul de intregi (double word) `res` cu dimensiunea egala cu `len`

section .text
global main

count_bytes_func:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    xor ecx, ecx
    xor edx, edx
count_bytes:
    cmp al, [mask]
    jne check_loop_byte_count
    inc edx
check_loop_byte_count:
    inc ecx
    shr eax, 8
    cmp ecx, 4
    jl count_bytes
    mov eax, edx
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Calculați și afișati numărul de biți `1` din numărul întreg `M`.
    ; Numărul `M` este definit în secțiunea `.data`.
    xor ecx, ecx
    xor edx, edx
count_bits:
    mov eax, 1
    shl eax, cl
    test eax, dword [M]
    jz check_loop_count
    inc edx
check_loop_count:
    inc ecx
    cmp ecx, 32
    jl count_bits

    PRINTF32 `%d\n\x0`, edx
    ; TODO b: Calculați și afișati numărul de octeți egali cu `mask` din numărul întreg `M`.
    ; Numerele `M` și `mask` sunt definite în secțiunea `data`
    push dword [M]
    call count_bytes_func
    add esp, 4

    PRINTF32 `%d\n\x0`, eax
    ; TODO c: Completați vectorul `res` de dimensiune `len` astfel:
    ;   - fiecare element res[i] este egal cu numărul de octeți din arr[i] ce au valoarea `mask`
    xor ecx, ecx
fill_vect:
    push ecx
    push dword [arr + 4 * ecx]
    call count_bytes_func
    add esp, 4
    pop ecx
    mov dword [res + 4 * ecx], eax
    inc ecx
    cmp ecx, len
    jl fill_vect
    ; TODO d: Afișați vectorul `res` de dimensiunea `len` completat cu elementele definite la punctul c)
    xor ecx, ecx
print_loop:
    PRINTF32 `%d \x0`, dword [res + 4 * ecx]
    inc ecx
    cmp ecx, len
    jl print_loop

    PRINTF32 `\n\x0`
    ; Return 0.
    xor eax, eax
    leave
    ret
