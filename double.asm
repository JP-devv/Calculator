%include 'library.asm'

section   .data
msg       db    "Double it and give it to the next person!", 0x0

section   .bss
input:    resb  16
output:   resb  16

section   .text
global    _start

; Program that Prompts the user for input, multiplies it by two
; and prints the result
_start:
  mov   ecx, msg
  call  _printString

  mov   ecx, input 
  mov   edx, 16
  call  _readString

  call  _toInt
  imul  eax, 2

  mov   ecx, output   
  call  _toString

  call  _printString

  call _exit
