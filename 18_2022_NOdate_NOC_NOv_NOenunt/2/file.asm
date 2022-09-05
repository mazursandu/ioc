extern malloc
extern printf

section .data
    printf_fmt_int:         db "%d ", 0
    printf_fmt_newline:     db 10, 0
    printf_fmt_int_newline: db "%d", 10, 0
    n:                      dd 5
    arr:                    dd 11, 22, 33, 44, 55

section .text
global main

print_arr:
    push ebp
    mov ebp, esp

    ; TODO a
    mov eax, [ebp + 8]
    mov edx, [ebp + 12]
    xor ecx, ecx
print_loop:
    push eax
    push ecx
    push edx
    push dword [eax + 4 * ecx]
    push printf_fmt_int
    call printf
    add esp, 8
    pop edx
    pop ecx
    pop eax
    inc ecx
    cmp ecx, edx
    jl print_loop
    leave
    ret

compute:
    push ebp
    mov ebp, esp

    ; TODO b
    mov eax, [ebp + 8]
    push ebx
    mov ebx, 9
    mul ebx
    pop ebx
    add eax, 10
    leave
    ret

new_array:
    push ebp
    mov ebp, esp

    ; TODO c
    push ebx
    mov edx, [ebp + 8]
    lea ebx, [edx * 4]
    push ebx
    call malloc
    add esp, 4
    mov edi, eax
    pop ebx
    xor ecx, ecx
    mov edx, [ebp + 8]
make_array:
    push ecx
    call compute
    add esp, 4
    mov edx, [ebp + 8]
    mov [edi + 4 * ecx], eax
    inc ecx
    cmp ecx, edx
    jl make_array
    mov eax, edi
    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a
    ; call print_arr
    push dword [n]
    push arr
    call print_arr
    add esp, 8

    push printf_fmt_newline
    call printf
    add esp, 4

    ; OUTPUT:
    ; 11 22 33 44 55

    ; TODO b
    push dword[n]
    call compute
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push 100
    call compute
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT:
    ; 55
    ; 910

    ; TODO c
    ; call new_array(11)
    ; call print_arr

    push dword 11
    call new_array
    add esp, 4

    push dword 11
    push eax
    call print_arr
    add esp, 8

    push printf_fmt_newline
    call printf
    add esp, 4

    ; OUTPUT:
    ; 10 19 28 37 46 55 64 73 82 91 100


    xor eax, eax
    leave
    ret
