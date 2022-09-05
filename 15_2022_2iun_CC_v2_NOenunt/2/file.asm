extern printf
extern scanf

section .data
    printf_error: db "Ai introdus prost indicii", 10, 0
    printf_fmt_int_newline: db "%d", 10, 0
    arr:                    dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700
    N:                      dd 17
    pos1 dd 0
    pos2 dd 0
    format_int db "%d", 0

section .text
global main
;functie ce verifica daca un nr dat e o putere a lui 2
is_pow2:
    push ebp
    mov ebp, esp

    ; TODO a
    mov ebx, [ebp + 8]
    xor eax, eax
    xor ecx, ecx
count:
    bt ebx, ecx
    jc set_bit
continue:
    inc ecx
    cmp ecx, 31
    jle count
    jmp is_power
set_bit:
    cmp eax, 0
    jne not_power
    inc eax
    jmp continue


not_power:
    mov eax, -1
    jmp ending
is_power:
    mov eax, 0
ending:
    leave
    ret

;functie ce realizeaza suma elementelor dintr un vector cuprinse intre 2 indici dati
sum_interval:
    push ebp
    mov ebp, esp

    ; TODO b
    xor eax, eax
    mov ebx, [ebp + 8]
    mov ecx, [ebp + 16]
    mov esi, [ebp + 20]

    cmp ecx, 0
    jl error

    cmp esi, [ebp + 12]
    jg error

get_sum:
    add eax, [ebx + 4 * ecx]
    inc ecx
    cmp ecx, esi
    jl get_sum
    jmp finish

    

error:
    push printf_error
    call printf
    add esp, 4

finish:
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a(functie ce verifica daca un nr e putere a lui 2)
    push 8
    call is_pow2
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push 10
    call is_pow2
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT:
    ; 0
    ; -1

    ; TODO b(functie sum_interval)

    push dword[N]
    push 0
    push 17
    push arr
    call sum_interval
    add esp, 16

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8


    push 3
    push 1
    push 17
    push arr
    call sum_interval
    add esp, 16

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT:
    ; 15300
    ; 500

    ; TODO c(citire indici pt sum_interval cu scanf si paelare functie doar daca 
    ;acesti indici dunt o putere a lui 2)
    push pos1
    push format_int
    call scanf
    add esp, 8

    push pos2
    push format_int
    call scanf
    add esp, 8

    push dword [pos1]
    call is_pow2
    add esp, 4

    cmp eax, 0
    jne eroare

    push dword [pos2]
    call is_pow2
    add esp, 4

    cmp eax, 0
    jne eroare

    push dword [pos2]
    push dword [pos1]
    push dword [N]
    push arr
    call sum_interval
    add esp, 16

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8
    jmp end_main

eroare:
    push printf_error
    call printf
    add esp, 4

end_main:
    xor eax, eax
    leave
    ret
