%include "utils/printf32.asm"
extern printf

section .data
    arr1 dd -100, 200, 300, -400, -950, 230, 900, -230, -180, 100
    arr2 dd 300, 900, -200, -300, -50, -70, -800, -30, -280, 120
    N dd 10

    ;TODO c: definiti vectorul 'res' cu dimensiunea `N` elemente de tip double word (4 octeti)
section .bss
    res resd 10

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: afisati vectorul arr1
ex1:
    mov ecx, [N]
    xor eax, eax

.loop_arr1:
    cmp eax, ecx
    jge ex1.end_loop_arr1

    PRINTF32 `%d \x0`, [arr1 + 4 * eax]

    inc eax
    jmp ex1.loop_arr1

.end_loop_arr1:
    PRINTF32 `\n\x0`

    ; TODO b: afisati modulul fiecarui element din vectorul `arr2`
    ; modulul unui numar x, este definit astfel:
    ;   |x| =
    ;       * x, daca x >= 0
    ;       * -x, daca x < 0
ex2:
    xor eax, eax

.loop_arr1:
    cmp eax, ecx
    jge ex2.end_loop_arr1

    mov ebx, [arr2 + 4 * eax]
    cmp ebx, 0
    jge ex2.end_if_neg

.if_neg:
    neg ebx

.end_if_neg:

    PRINTF32 `%d \x0`, ebx

    inc eax
    jmp ex2.loop_arr1

.end_loop_arr1:
    PRINTF32 `\n\x0`

    ; TODO c: Determinati suma modulelor numerelor din vectorul arr1
    ; s = |arr1[0]| + |arr1[1]| + ... + |arr1[N-1]|
ex3:
    xor eax, eax
    xor edx, edx

.loop_arr1:
    cmp eax, ecx
    jge ex3.end_loop_arr1

    mov ebx, [arr1 + 4 * eax]
    cmp ebx, 0
    jge ex3.end_if_neg

.if_neg:
    neg ebx

.end_if_neg:

    add edx, ebx

    inc eax
    jmp ex3.loop_arr1

.end_loop_arr1:
    PRINTF32 `%d\n\x0`, edx

    ; TODO d: Completati vectorul `res` astfel incat fiecare element res sa fie modulul diferentei
    ; elementelor din vectorii `arr1` si `arr2`
    ; res[i] = |arr1[i] - arr2[i]|, 0 <= i < N
ex41:
    xor eax, eax
    xor edx, edx

.loop_arr1:
    cmp eax, ecx
    jge ex41.end_loop_arr1

    mov ebx, [arr1 + 4 * eax]
    sub ebx, [arr2 + 4 * eax]
    cmp ebx, 0
    jge ex41.end_if_neg

.if_neg:
    neg ebx

.end_if_neg:

    mov [res + 4 * eax], ebx

    inc eax
    jmp ex41.loop_arr1

.end_loop_arr1:
    ; TODO d: Afisati vectorul `res`
ex42:
    xor eax, eax
    xor edx, edx

.loop_arr1:
    cmp eax, ecx
    jge ex42.end_loop_arr1

    PRINTF32 `%d \x0`, [res + 4 * eax]

    inc eax
    jmp ex42.loop_arr1

.end_loop_arr1:
    PRINTF32 `\n\x0`
    ; Return 0.
    xor eax, eax
    leave
    ret
