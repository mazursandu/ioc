extern strlen
extern printf


section .rodata
    test_str db "hell, it's about time", 0
    format db "length = %d", 10, 0

section .text
global main

my_strlen:
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 8]
    cmp byte [ebx], 0
    jnz recursive_call
    xor eax, eax
    jmp end_my_strlen

recursive_call:
    inc ebx
    push ebx
    call my_strlen
    add esp, 4
    inc eax
end_my_strlen:
    leave
    ret

main:
    push ebp
    mov ebp, esp



    push test_str
    call strlen
    add esp, 4


    push eax
    push format
    call printf
    add esp, 8


    ; TODO a: Implement strlen-like functionality using a RECURSIVE implementation.
    push test_str
    call my_strlen
    add esp, 4

    push eax
    push format
    call printf
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
