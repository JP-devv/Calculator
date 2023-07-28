%include 'library.asm'

section .data
msg db  "Enter a single character:", 0x0

section .bss

input:  resb  5

section .text
global _start

_start:
  mov   ecx, msg
  call  _printString

  mov   ecx, input 
  mov   edx, 5
  call  _readString
  call  _printString

  call  _exit
