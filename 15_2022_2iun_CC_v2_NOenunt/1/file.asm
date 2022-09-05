%include "utils/printf32.asm"
extern printf

section .data

M dd 0xF0F1F071

arr dd 0x11223344, 0xFF11FF11, 0x12AA12AA, 0xAABBCCDD, 0x10C010C0, 0x17272727, 0x97979797, 0xA1A1A1A1, 0xB2B2B2B2, 0xC4C4C4
len equ 10
res times 10 dd 0

section .bss

;TODO c: Declarati vectorul `res` cu elemente de tip intreg si dimensiunea egala cu `len`

section .text
global main

get_even:
    enter 0,0

    mov ebx, [ebp + 8]
    xor eax, eax
    xor ecx, ecx

while:
    bt ebx, ecx
    jnc increase
resume:
    add ecx, 8
    cmp ecx, 32
    jl while
    jmp ending
increase:
    inc eax
    jmp resume
ending:
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Afișați în binar numărul întreg definit de variabila M.
    ; Cel mai semnificativ bit va fi afișat primul (e.g 0x0000000F -> 0b00000000000000000000000000001111)
    ; Pentru simplificare, se vor afișa 32 de cifre binare chiar dacă biții cei mai semnificativi sunt zero
    mov ecx, 31
    mov eax, [M]
for:
    bt eax, ecx
    jc set_bit
    PRINTF32 `0\x0`
continue:
    dec ecx
    cmp ecx, 0
    jge for
    jmp end
set_bit:
    PRINTF32 `1\x0`
    jmp continue
end:
    PRINTF32 `\n\x0`
    ; TODO b: Afișați numărul octetilor pari din reprezentarea numărului întreg M (e.g 0x12131415 -> are 2 octeți pari 0x12, 0x14)
    push dword[M]
    call get_even
    add esp, 4

    PRINTF32 `%d\n\x0`, eax
    ; TODO c: Completati fiecare element al vectorului `res` cu numărul octetilor pari corespunzator fiecarui element din vectorul `arr`
    ; e.g: elementul `j` al vectorului `res` va contine numarul octetilor pari al intregului de pe pozitia `j` din vectorul `arr`
    ; res [2] = octeti_pari(arr[2]) = octeti_pari(0x12AA12AA) = 4
    xor ecx, ecx
fill_res:
    xor eax, eax
    push ecx
    push dword [arr + ecx * 4]
    call get_even
    add esp, 4
    pop ecx
    mov [res + ecx * 4], eax
    inc ecx
    cmp ecx, len
    jl fill_res
    ; TODO d: Afisati elementele vectorului `res` pe aceeasi linie separate de spatii.
    xor ecx, ecx
print_res:
    push ecx
    PRINTF32 `%d \x0`, [res + ecx * 4]
    pop ecx
    inc ecx
    cmp ecx, len
    jl print_res

    PRINTF32 `\n\x0`
    ; Return 0.
    xor eax, eax
    leave
    ret
