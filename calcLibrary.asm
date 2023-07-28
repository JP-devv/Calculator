; toInt(factor (eax), string * (ecx), string * (edx))
; returns int of string
_toInt:
    push    ebx
    push    ecx
    push    edx

    call _getFactor         ; gets factor for num of digits dynamically
    nextChar1:
    mov     ebx, eax        ; assign factor to ebx 

    movzx   eax, byte [ecx] ; move first byte to eax
    inc     ecx             ; move on to next byte

    push    edx
    sub     eax, 48         ; convert to number
    mul     ebx             ; factor num

    pop     edx
    push    ebx             ; save factor stored in ebx
    mov     ebx, [edx]
    add     ebx, eax

    mov     [edx], ebx
    pop     eax             ; pop factor saved in stack
    call    _updateFactor   ; update factor 
    jz      exitToInt 
    jmp     nextChar1

    exitToInt:
    pop     edx
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

; getStringLength(string* num (eax))
; returns length of string in eax
_getStringLength:
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

_getNumLength:
    push    ebx
    call    _getStringLength
    mov     ebx, 2
    mul     ebx
    pop     ebx
    ret

; printNum(int num)
; prints what is in eax
_printNum:
    push    ebx
    push    eax
    push    ecx

    

    pop     ecx
    pop     eax
    pop     ebx
    ret

; getDigit(int num) modifies ecx, edx
; returns least significant decimal of num in edx
; eax: 123 -> 12
; edx: 3
_getChar:
    push    ebx
    push    ecx
    
    push    eax         ; save reference
    mov     edx, 0      ; edx must be zero for our div
    mov     ebx, 10
    div     ebx         ; divide by 10 to diff with itself
    mov     ecx, eax
    mul     ebx

    pop     ebx
    sub     ebx, eax    ; diff the multiple of ten with original,
    mov     edx, ebx    ; thus isolating the single digit
    add     edx, 0x30   ; convert to ascii

    mov     eax, ecx
    pop     ecx
    pop     ebx
    ret

; toString(int num (eax), string* str (ecx))
; returns eax pointer to string of num
_toString:
    push    ebx
    push    ecx

    mov     ebx, ecx    ; create a copy for str placeholder
    mov     ecx, 10     ; our memory index

    stringLoop:
    cmp     al, 0x0     ; if al is 0, we are done
    je      stringFinish
    call    _getChar    ; get first number to edx
    mov     byte [ebx + ecx], dl
    dec     ecx
    jmp     stringLoop
    stringFinish:

    inc     ecx
    add     ebx, ecx
    mov     eax, ebx

    pop     ecx
    pop     ebx
    ret