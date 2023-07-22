; Gets user input, converts to an actual number
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
    call _toInt

    quit:
    ; Quit
    mov     eax, 1
    mov     ebx, 0
    int     0x80

; toInt(factor (eax), string * (ecx))
; returns int of string
_toInt:
    push    ebx
    push    ecx

    call _getFactor         ; gets factor for num of digits dynamically
    nextChar1:
    mov     ebx, eax        ; assign factor to ebx 

    movzx   eax, byte [ecx] ; move first byte to eax
    inc     ecx             ; move on to next byte

    sub     eax, 48         ; convert to number
    mul     ebx             ; factor num

    push    ebx             ; save factor stored in ebx
    mov     ebx, [val]
    add     ebx, eax

    mov     [val], ebx
    pop     eax             ; pop factor saved in stack
    call    _updateFactor   ; update factor 
    jz      exitToInt 
    jmp     nextChar1

    exitToInt:
    pop     ecx
    pop     ebx
    ret

; updateFactor(factor (eax))
; gets current factor and divides by 10
; sets zero flag if zero
_updateFactor:
    push    ebx
    push    edx

    xor     edx, edx
    mov     ebx, 10
    div     ebx

    cmp     eax, 0x0
    pop     edx
    pop     ebx
    ret

; getFactor(string* num (eax))
; returns an inital factor by getting length
_getFactor:
    push    ebx
    push    ecx
    mov     ebx, eax        ; Create a reference point

    nextChar2:
    cmp     byte [eax], 0xa
    je      done 
    inc     eax
    jmp     nextChar2
    done:
    sub     eax, ebx
    mov     ecx, eax
    mov     eax, 1
    mov     ebx, 10
    loop    factor
    factor: 
    mul     ebx
    loop    factor

    pop     ecx
    pop     ebx
    ret