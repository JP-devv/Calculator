%include 'library.asm'

section .data
msg db  "Enter a single character:", 0x0

section .bss

input:  resb  1

section .text
global _start

_start:
  mov   ecx, msg
  call  _printString

  mov   ecx, input 
  call  _readString
  call  _printString

  call  _exit
