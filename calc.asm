; Gets user input, converts to an actual number
%include 'calcLibrary.asm'
section .data
    msg     db      'Please enter a number: ', 0x0
    val     dw      0x0


section .bss
    input:  resb    4   ; reserve 2 bytes 

section .text
global _start

_start:
    ; Print message
    mov     eax, 4          ; opcode 4 sys_print
    mov     ebx, 1          ; stdout
    mov     ecx, msg        ; string
    mov     edx, 24         ; length
    int     0x80            ; sys call

    ; Get input
    mov     eax, 3          ; opcode 3 sys_read
    mov     ebx, 0          ; stdin
    mov     ecx, input      ; address
    mov     edx, 4          ; read 4 bytes
    int     0x80

    mov     eax, ecx        ; parameter is string address
    call    _toInt          ; converts string to int in eax

    quit:
    mov     eax, 1
    mov     ebx, 0
    int     0x80