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
    mov eax,[ebp+8]
    mov edx,[ebp+12]
    xor ecx,ecx

loop_afisare1:
    mov ebx,[eax]
    push eax
    push edx
    push ecx
    push ebx
    push printf_fmt_int
    call printf
    add esp,8
    pop ecx
    pop edx
    pop eax
    inc ecx
    cmp ecx,edx
    je exita
    add eax,4
    jmp loop_afisare1

exita:
    push printf_fmt_newline
    call printf
    add esp,4
    leave
    ret

compute:
    push ebp
    mov ebp, esp

    ; TODO b

    mov ebx,[ebp+8]
    mov ecx,ebx
    add ecx,ebx
    add ecx,ebx
    add ecx,ebx
    add ecx,ebx
    add ecx,ebx
    add ecx,ebx
    add ecx,ebx
    add ecx,ebx
    add ecx,10
    mov eax,ecx

    leave
    ret

new_array:
    push ebp
    mov ebp, esp

    ; TODO c
    mov edi,[ebp+8]
    push edi
    call malloc
    add esp,4
    mov edx,eax
    mov edi,[ebp+8]
    xor ecx,ecx

loop_creatie:
    push edi
    push edx
    push ecx
    push ecx
    call compute
    add esp,4
    pop ecx
    pop edx
    pop edi
    mov [edx],eax
    inc ecx
    cmp ecx,edi
    je exitd
    add edx,4
    jmp loop_creatie

exitd:
    neg ecx
    inc ecx
    lea eax,[edx+4*ecx]

    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a
    ; call print_arr
    push DWORD [n]
    push arr
    call print_arr
    add esp,8

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
    push 11
    call new_array
    add esp,4

    push eax
    push printf_fmt_newline
    call printf
    add esp, 4
    pop eax
    ; OUTPUT:
    ; 10 19 28 37 46 55 64 73 82 91 100
    xor ecx,ecx
    xor edx,edx
    mov edx,11

loop_afisare2:
    mov ebx,[eax]
    push eax
    push ecx
    push edx
    push ebx
    push printf_fmt_int
    call printf
    add esp,8
    pop edx
    pop ecx
    pop eax
    inc ecx
    cmp ecx,edx
    je final
    add eax,4
    jmp loop_afisare2

final:
    push printf_fmt_newline
    call printf
    add esp, 4
    xor eax, eax
    leave
    ret
