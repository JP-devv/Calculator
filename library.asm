; printString(ecx: string*)
; prints string and also adds new line
_printString:
  push  ebx
  push  ecx
  push  edx

  mov   eax, 4
  mov   ebx, 1
  call  _getStringLength
  int   0x80

  mov   eax, 4
  mov   ebx, 1
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

; readString(ecx: string*, edx: bytes to read)
; reads user input and places it in ecx memory
_readString:
  push  ebx
  push  eax

  mov   eax, 3
  mov   ebx, 0
  int   0x80

  ; Get rid of '\n'
  push  ecx
  readScan:
  cmp   byte [ecx], 0xa
  je    removelf
  inc   ecx
  jmp   readScan
  removelf:
  mov   ebx, 0x0
  mov   byte [ecx], bl
  pop   ecx

  pop   eax
  pop   ebx
  ret

; toInt(ecx: String*)
; returns numeric value to eax
_toInt:
  push  ebx

  xor   ebx, ebx
  nextNum:
  xor   eax, eax
  mov   al, byte [ecx]
  cmp   al, 0x0
  je    nextNumEnd
  inc   ecx
  sub   al, 0x30
  imul  ebx, 10
  add   ebx, eax
  jmp   nextNum

  nextNumEnd:
  mov   eax, ebx

  pop   ebx
  ret

; getNumLength(eax: integer)
; returns length in ecx
_getNumLength:
  push  ebx
  push  eax
  push  edx

  xor   ecx, ecx
  mov   ebx, 10
  nextNum2:
  xor   edx, edx
  cmp   eax, 0x0
  je    nextNumEnd2
  div   ebx
  inc   ecx
  jmp nextNum2
  nextNumEnd2:

  pop   edx
  pop   eax
  pop   ebx
  ret

; toString(eax: integer, ecx: string *)
; returns string * in ecx
_toString:
  push  ebx
  push  eax
  push  edx
                      ; eax has int
  mov   ebx, ecx      ; ebx has str*
  call  _getNumLength ; ecx has length
  add   ebx, ecx      ; strings are in little endian, we add length to addr

  nextDigit:
  xor   edx, edx
  cmp   eax, 0x0
  je    nextDigitEnd
  mov   ecx, 10
  div   ecx
  add   edx, 0x30
  mov   byte [ebx], dl
  dec   ebx
  jmp nextDigit
  nextDigitEnd:
  inc   ebx
  mov   ecx, ebx

  pop   edx
  pop   eax
  pop   ebx
  ret
