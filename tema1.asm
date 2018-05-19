%include "io.inc"

section .data
   %include "input.inc"
    message db "Baza incorecta", 0
   
section .text
global CMAIN

CMAIN:
   mov ebp, esp
   mov ecx, 1                         ;initializeaza contorul ecx cu 1

base:
   
    cmp ecx, [nums]                     ;compara daca ecx a depasit valoarea lui nums
    jg exit                             ; daca ecx e mai mare decat nums iese din program
    mov eax, [nums_array + 4*(ecx-1)]   
    mov ebx, [base_array + 4*(ecx-1)]
    cmp ebx, 2                          ;verifica daca baza este valida
    jl baza_incorecta
    cmp ebx, 16
    jg baza_incorecta
     
    
impartire:
    xor edx, edx
    div ebx             ;imparte numarul din eax la baza corespunzatoare stocata in ebx
    cmp edx, 9          ; daca restul e mai mare decat 9 sare la eticheta bigger_10
    jg bigger_10
    add edx, '0'
    push edx            ;pune restul pe stiva
    cmp eax, 0
    jg impartire
    inc ecx
    jmp print
    
bigger_10:

    add edx, 87         ;codul ASCII corespunzator literei
    push edx
    cmp eax, 0
    jg impartire
    inc ecx
    
print:
    cmp ebp, esp        ;verifica daca stiva s-a terminat
    je linie_noua
    pop eax
    PRINT_CHAR eax
    jmp print

linie_noua:
    NEWLINE
    jmp base
    
baza_incorecta:
    PRINT_STRING message
    NEWLINE
    inc ecx
    cmp ecx, [nums]
    jl base
    
exit:
    xor eax, eax
    ret