%include 'calcLibrary.asm'

section .bss

str:    resd    10

section .text
global _start

_start:
    ; convert to string
    mov     eax, 125
    push    eax

    mov     ecx, str
    call    _toString
    
    ; print string
    mov     ecx, eax
    mov     eax, esp 
    call    _getNumLength
    mov     edx, eax

    pop     eax

    mov     eax, 4
    mov     ebx, 1
    int     0x80

    ; quit
    mov     eax, 1
    mov     ebx, 0
    int     0x80