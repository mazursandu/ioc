extern printf

section .data
    arr                 dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    arr_len             dd 10
    msg1                db "This is ten percent luck, twenty percent skill", 0
    msg1_len            equ $ - msg1
    msg2                db "Fifteen percent concentrated power of will", 0
    msg2_len            equ $ - msg2
    printf_fmt_int      db "%d", 10, 0
    printf_fmt_hex      db "%02x ", 0
    printf_fmt_newline  db 10, 0
    key1_random         db "BO1F6HyuQP6KdyqdzJGpfw4uGUIL2S44qaNTBdD7YPXi2u", 0
    key2_random         db "VO76ljjQI1ytGENbbyIhdxBLsd4SZ502zVNW66f1DV", 0

section .bss
    msg1_xor    resb 47
    key1_zero   resb 47
    msg2_xor    resb 43
    key2_zero   resb 43

section .text
global main

sum:
    push ebp
    mov ebp, esp

    ; TODO a
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

    mov eax, [ebp + 8]
    mov ecx, [ebp + 12]

my_label:
    mov edx, [arr + ecx*4 - 4]
    dec ecx
    cmp ecx, -1
    je exit
    add ebx, edx
    jmp my_label

exit:
    mov eax, ebx
    leave
    ret

print_hex:
    push ebp
    mov ebp, esp

    ; TODO b

    leave
    ret

xor_encrypt:
    push ebp
    mov ebp, esp

    ; TODO c
     mov ebx, [ebp + 8] ;in
    mov eax, [ebp + 12] ;lungime
    mov edx, [ebp + 16] ;out

    xor esi, esi
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; Test a
    push dword[arr_len]
    push arr
    call sum
    add esp, 8
    
    push eax
    push printf_fmt_int
    call printf
    add esp, 8


    ;push msg1_len
    ;push msg1
    ;call sum
    ;add esp, 8

    ; OUTPUT Test a
    ; 55
    ; -505698929

    ; Test b
    push msg1_len
    push msg1
    call print_hex
    add esp, 4

    push msg2_len
    push msg2
    call print_hex
    add esp, 4

    ; OUTPUT Test b
    ; 54 68 69 73 20 69 73 20 74 65 6e 20 70 65 72 63 65 6e 74 20 6c 75 63 6b 2c \
    ; 20 74 77 65 6e 74 79 20 70 65 72 63 65 6e 74 20 73 6b 69 6c 6c 00
    ; 46 69 66 74 65 65 6e 20 70 65 72 63 65 6e 74 20 63 6f 6e 63 65 6e 74 72 61 \
    ; 74 65 64 20 70 6f 77 65 72 20 6f 66 20 77 69 6c 6c 00

    ; Test c
    push msg1_len
    push key1_zero
    push msg1_xor
    push msg1
    call xor_encrypt
    add esp, 16
    push msg1_len
    push msg1_xor
    call print_hex
    add esp, 4

    push msg2_len
    push key2_zero
    push msg2_xor
    push msg2
    call xor_encrypt
    add esp, 16
    push msg2_len
    push msg2_xor
    call print_hex
    add esp, 4

    push msg1_len
    push key1_random
    push msg1_xor
    push msg1
    call xor_encrypt
    add esp, 16
    push msg1_len
    push msg1_xor
    call print_hex
    add esp, 4

    push msg2_len
    push key2_random
    push msg2_xor
    push msg2
    call xor_encrypt
    add esp, 16
    push msg2_len
    push msg2_xor
    call print_hex
    add esp, 4

    ; OUTPUT Test c
    ; 54 68 69 73 20 69 73 20 74 65 6e 20 70 65 72 63 65 6e 74 20 6c 75 63 6b 2c \
    ; 20 74 77 65 6e 74 79 20 70 65 72 63 65 6e 74 20 73 6b 69 6c 6c 00 
    ; 46 69 66 74 65 65 6e 20 70 65 72 63 65 6e 74 20 63 6f 6e 63 65 6e 74 72 61 \
    ; 74 65 64 20 70 6f 77 65 72 20 6f 66 20 77 69 6c 6c 00 
    ; 16 27 58 35 16 21 0a 55 25 35 58 6b 14 1c 03 07 1f 24 33 50 0a 02 57 1e 6b \
    ; 75 3d 3b 57 3d 40 4d 51 11 2b 26 21 01 2a 43 79 23 33 00 5e 19 00 
    ; 10 26 51 42 09 0f 04 71 39 54 0b 17 22 2b 3a 42 01 16 27 0b 01 16 36 3e 12 \
    ; 10 51 37 7a 45 5f 45 1f 24 6e 38 50 16 11 58 28 3a 00

    xor eax, eax
    leave
    ret
