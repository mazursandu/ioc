%include "utils/printf32.asm"
extern printf

section .data


M dd 0x12121212
mask db 0x12

arr dd 0x12345678, 0x12121212, 0x42424242, 0x12771277, 0xCAFEBABE, 0x12001200, 0x20222022, 0x03020302, 0x12FF12FF, 0xFF12FF12
len equ 10

;TODO c: Declarati vectorul de intregi (double word) `res` cu dimensiunea egala cu `len`
;res dd 0,0,0,0,0,0,0,0,0,0

res dd 0,0,0,0,0,0,0,0,0,0

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Calculați și afișati numărul de biți `1` din numărul întreg `M`.
    ; Numărul `M` este definit în secțiunea `.data`.
    ;mov eax,[M]
    mov ebx,1
    mov ecx,1
    shl ecx,31
    xor edx,edx

loop1:
    mov eax,[M]
    and eax,ebx
    cmp eax,ebx
    je add_1_bit
back:
    cmp ebx,ecx
    je exit
    shl ebx,1
    jmp loop1

add_1_bit:
    inc edx
    jmp back

exit:
    PRINTF32 `%d\n\x0`, edx
    ; TODO b: Calculați și afișati numărul de octeți egali cu `mask` din numărul întreg `M`.
    ; Numerele `M` și `mask` sunt definite în secțiunea `data`
    mov ebx,0b11111111
    mov ecx,0b11111111
    shl ecx,24
    xor edx,edx
    xor esi,esi
    mov dl,BYTE[mask]
loop2:
    mov eax,[M]
    and eax,ebx
    cmp eax,edx
    je add_1_octet
back2:
    cmp ebx,ecx
    je exit2
    shl ebx,8
    shl edx,8
    jmp loop2

add_1_octet:
    inc esi
    jmp back2

exit2:
    PRINTF32 `%d\n\x0`, esi
    ; TODO c: Completați vectorul `res` de dimensiune `len` astfel:
    ;   - fiecare element res[i] este egal cu numărul de octeți din arr[i] ce au valoarea `mask`
    xor edi,edi
loop_ext:
    lea eax, [arr+4*edi]
    mov eax,[eax]
    mov ebx,0b11111111
    mov ecx,0b11111111
    shl ecx,24
    xor edx,edx
    xor esi,esi
    mov dl,BYTE[mask]
loop_int:
    lea eax, [arr+4*edi]
    mov eax,[eax]
    and eax,ebx
    cmp eax,edx
    je add_1_octetc
back3:
    cmp ebx,ecx
    je exit3
    shl ebx,8
    shl edx,8
    jmp loop_int

add_1_octetc:
    inc esi
    jmp back3

exit3:
    mov eax,len
    cmp edi,eax
    je exitt
    lea eax,[res+4*edi]
    mov [eax],esi
    inc edi
    jmp loop_ext

exitt:
    ; TODO d: Afișați vectorul `res` de dimensiunea `len` completat cu elementele definite la punctul c)
    mov ecx,len
    xor edi,edi
loop_afisare:
    lea eax,[res+4*edi]
    mov eax,[eax]
    PRINTF32 `%d \x0`, eax
    inc edi
    cmp edi,ecx
    je exittt
    jmp loop_afisare
exittt:
    ; Return 0.
    xor eax, eax
    leave
    ret
