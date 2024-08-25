[bits 16]

section .data
    msg_inp db 'Ingrese un numero en base 10:', 0x0D, 0x0A, '$'

section .bss
    input resb 3    ; Buffer de 3 bytes para almacenar el valor hexadecimal

section .text
    org 100h

    global _start

_start:
 xor ax,ax
 xor bx,bx
 xor dx,dx
 int 3
 mov bl,13
 mov ax,10
 int 3
 mul bx
 int 3
