[bits 16]

section .data
    msg_inp db 'Ingrese un numero en base 10:', 0x0D, 0x0A, '$'

section .bss
    input resb 1    ; Buffer de 3 bytes para almacenar el valor hexadecimal

section .text
    org 100h

    global _start

_start:
 xor ax,ax
 xor bx,bx
 xor dx,dx
 xor cx,cx
 int 3
 mov bh,1
 mov [input],bh
 mov al,[input]
 mov bl,5
 mov cl,10 
 mul cx
 add al,bl
 int 3

 