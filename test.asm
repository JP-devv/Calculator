%include 'library.asm'

section .data
msg db  "Enter a single character:", 0x0

section .r

section .text
global _start

_start:
  mov   ecx, msg
  call  _printf
  
  call  _exit

; readString(ecx: string*)
; reads user input and places it in ecx memory
_readString:
  
