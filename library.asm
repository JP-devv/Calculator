; printf(ecx: string*)
; prints string and also adds new line
_printf:
  push  ebx
  push  ecx
  push  edx

  mov   eax, 4
  mov   ebx, 1
  call  _getStringLength
  int   0x80

  mov   ecx, 0xa
  push  ecx
  mov   ecx, esp
  mov   edx, 1
  int   0x80

  pop   ecx

  pop   edx
  pop   ecx
  pop   ebx
  ret

_exit:
  mov   eax, 1
  mov   ebx, 0
  int   0x80

; getStringLength(ecx: string*)
; returns string length in edx
_getStringLength:
  push  ebx
  push  eax
  push  ecx

  ; Create a reference point
  mov   ebx, ecx

  nextChar:
  cmp   byte [ecx], 0x0
  je    nextCharEnd
  inc   ecx
  jmp   nextChar
  nextCharEnd:
  sub   ecx, ebx
  mov   edx, ecx

  pop   ecx
  pop   eax
  pop   ebx
  ret
