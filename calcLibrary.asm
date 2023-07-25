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

; getLength(string* num (eax))
; returns length of string
_getLength:
    push    ebx
    mov     ebx, eax        ; Create reference point

    lengthLoop:
    cmp     byte [eax], 0x0
    jz      lengthLoopEnd
    inc     eax
    jmp     lengthLoop

    lengthLoopEnd:
    sub     eax, ebx

    pop     ebx
    ret