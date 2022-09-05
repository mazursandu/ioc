extern scanf
extern strchr
extern strlen
extern printf
extern puts

section .data
    printf_fmt_int: db "%d", 10, 0
    alice:          db "Alce", 0
    bob:            db "Bob", 0
    scanf_fmt:      db "%10s", 0
    string:         times 11 db 0
    printf_fmt_str: db "%s", 10, 0

section .bss
    buffer resb 100

section .text
global main

mystrchr:
    push ebp
    mov ebp, esp

    push edi
    push esi
    push ebx

    ; TODO a
    push dword [ebp + 12]
    push dword [ebp + 8]
    call strchr
    sub eax, [ebp + 8]
    add esp, 8

    cmp eax, 0
    jge mystrchr.exit
.cmp_zero:
    mov eax, -1
.exit:
    pop ebx
    pop esi
    pop edi
    leave
    ret

is_lower:
    push ebp
    mov ebp, esp

    ; TODO b
    mov eax, [ebp + 8]

.loop_string:
    cmp byte [eax], 0
    je is_lower.end_loop_string

    cmp byte [eax], 'a'
    jl is_lower.if_not_low
    cmp byte [eax], 'z'
    jg is_lower.if_not_low
    jmp .end_if_not_low

.if_not_low:
    mov eax, -1
    jmp .exit

.end_if_not_low:
    inc eax
    jmp is_lower.loop_string

.end_loop_string:
    xor eax, eax

.exit:
    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a
    xor eax, eax
    mov al, 'i'
    push eax
    push alice
    call mystrchr
    add esp, 8
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    xor eax, eax
    mov al, 'x'
    push eax
    push bob
    call mystrchr
    add esp, 8
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    ; OUTPUT:
    ; 2
    ; -1

    ; TODO b
    push alice
    call is_lower
    add esp, 4
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    push bob
    call is_lower
    add esp, 4
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    ; OUTPUT:
    ; -1
    ; 0

    ; TODO c
    push buffer
    push scanf_fmt
    call scanf
    add esp, 8
    
    push buffer
    call is_lower

    cmp eax, 0
    je all_low
    jmp not_all_low

all_low:

.loop_string:
    push buffer
    push printf_fmt_str
    call printf

not_all_low:

    xor eax, eax
    leave
    ret
