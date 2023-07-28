; Gets user input, converts to an actual number
%include 'calcLibrary.asm'
section .data
    msg     db      'Please enter a number: ', 0x0
    buffer  dw      0x0


section .bss
    input:  resb    10      ; reserve 10 bytes (Max signed int is 10 digits long)

section .text
global _start

_start:
    ; Print message
    mov     eax, 4          ; opcode 4 sys_print
    mov     ebx, 1          ; stdout
    mov     ecx, msg        ; string
    mov     edx, 24         ; length
    int     0x80            ; kernel

    ; Get input
    mov     ebx, 0          ; stdin
    mov     ecx, input      ; address
    mov     eax, 3          ; opcode 3 sys_read
    mov     edx, 10         ; read 10
    int     0x80            ; kernel

    mov     eax, ecx        ; parameter is string address
    mov     edx, buffer 
    call    _toInt          ; converts string to int in eax

    quit:
    mov     eax, 1
    mov     ebx, 0
    int     0x80