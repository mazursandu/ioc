extern stdin

extern printf
extern scanf
extern calloc
extern strlen

section .data
str_fmt db '%s', 0
str_fmt_newline db '%s', 10, 0
int_fmt_newline db '%d', 10, 0
N dd 64

section .text
global main

;TODO a: Implementati functia `char* read_string(void)` cu urmatorul comportament:
;   - functia aloca memorie pentru a stoca cel mult `N` octeti initializati cu 0.
;   - functia citeste de la intrarea standard un sir de caractere de dimensiune cel mult `N-1` si il stocheaza in memoria alocata.
;   - functia intoarce adresa de memorie alocata mai sus.
;   - pentru alocarea de memorie se recomanda folosirea functiei `void *calloc(size_t nmemb, size_t size);` din biblioteca standard.
;   - pentru citirea de la intrarea standard se recomanda folosirea functiei `int scanf(const char *format, ...);`

read_string:
    push ebp
    mov ebp, esp


    leave
    ret


; TODO b: Implementati functia `int is_vowel(char c)` care ne spune daca un caracter este vocala sau nu.
;   - functia intoarce 1 daca caracterul primit ca parametru este vocala si 0 in rest.
;   - vocalele sunt `aeiou`.
;   - puteti folosi functia de biblioteca `strlen` pentru a determina dimensiunea unui sir de caractere.
;   - este garantat ca parametrul de intrare va fi o litera mica a alfabetului englezesc.
is_vowel:
    push ebp
    mov ebp, esp
    
    push str_fmt_newline
    call printf
    add esp,4



    leave
    ret

push str_fmt_newline
call is_vowel
add esp,4

mov eax,[str_fmt_newline]
push eax
push str_fmt_newline
call printf

; TODO c: Implementati functia `void replace_vowels(char *s)` care inlocuieste toate vocalele din sirul primit
;   la intrare cu caracterul 'X'
;   - functia va modifica sirul de intrare
;   - sirul de intrare este compus doar din litere mici ale alfabetului englezesc

replace_vowels:
    push ebp
    mov ebp, esp


    leave
    ret

;TODO d: Implementati functia `int is_palindrome(char *s)` care ne spune daca un sir este palindrom sau nu.
;   - un sir este palindrom daca citit de la dreapta la stanga sau de la standa la dreapta ramane neschimbat.
;   - functia va intoarce 1 daca sirul este palindrom si 0 in rest
is_palindrome:
    push ebp
    mov ebp, esp

    leave
    ret


main:
    push ebp
    mov ebp, esp

    ; Rulati ./file < input.txt pentru o testare completa

    ; TODO a: Apelati functia `read_string` pentru a citi un sir de caractere de la intrarea standard si afisati-l!
    ; pentru afisare puteti folosi functia `printf`.
    ; ATENTIE: functia `printf` poate sa modifice anumite registre. puteti salva / restaura toate registrele folosind instructiunile `pusha`/`popa`



    ; TODO b: Decomentati apelurile functiei `is_vowel` si afisati rezultatul intors. Acesta ne spune daca argumentul este vocala sau nu.

    ;push 'a'
    ;call is_vowel
    ;add esp, 4

    ;push eax
    ;push int_fmt_newline
    ;call printf
    ;add esp, 8

    ;push 'b'
    ;call is_vowel
    ;add esp, 4

    ;push eax
    ;push int_fmt_newline
    ;call printf
    ;add esp, 8


    ; TODO c: Citi de la intrarea standard un sir de caractere si apelati functia `replace_vowels` pentru a marca
    ; cu caracterul `X` toate vocalele. Afisati apoi sirul rezultat.



    ; TODO d: Testati implementarea functiei `is_palindrome` folosind ca intrare doua siruri de caractere citite de la intrarea standard.
    ; Exemplu:
    ; test #1
    ; call read_string
    ; call is_palindrome
    ; call printf ; to print result
    ; test #2
    ; call read_string
    ; call is_palindrome
    ; call printf; to print result


    ; Return 0.
    xor eax, eax
    leave
    ret
