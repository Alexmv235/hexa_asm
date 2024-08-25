[BITS 16]

section .data
    msg_inp db 'Ingrese un numero en base 10:', 0x0D, 0x0A, '$'
    stra dw '    $'    ; Espacio para almacenar el número convertido a cadena
    number db 0x01,0x1D,0x94,0xAD,0x07,0x1C,0x3A
    hex_digits db '0123456789ABCDEF'

section .bss
    input resb 3    ; Buffer de 3 bytes para almacenar la entrada del usuario

section .text
    org 100h

_start:
    ; Inicializar el segmento de datos
    mov ax, cs
    mov ds, ax

    ; Mostrar mensaje de entrada
    mov ah, 9
    mov dx, msg_inp
    int 21h

    ; Mostrar todos los números en el array "number"
    mov si, number  ; Apunta a la primera posición del array
    mov cx, 7       ; Cantidad de bytes a mostrar en el array "number"

display_loop:
    lodsb           ; Cargar el siguiente byte desde [si] en al
    call byte_to_hex
    mov ah, 9       ; Mostrar la cadena convertida
    mov dx, stra
    int 21h
    loop display_loop

    ; Esperar a que el usuario presione una tecla
    mov ah, 7
    int 21h

    ; Terminar el programa
    mov ax, 4c00h
    int 21h

;------------------------------------------
; PROCEDIMIENTO PARA CONVERTIR BYTE A HEXADECIMAL
; Entrada: AL contiene el byte a convertir
; Salida: [str] contiene los dos caracteres hexadecimales

byte_to_hex:
    mov ah, al      ; Copia el valor de al en ah
    shr ah, 4       ; Aísla el nibble alto
    and al, 0Fh     ; Aísla el nibble bajo

    ; Convertir el nibble alto
    mov bl, ah
    mov bh, 0
    mov bx, hex_digits[bx]
    mov [stra], bl

    ; Convertir el nibble bajo
    mov bl, al
    mov bh, 0
    mov bx, hex_digits[bx]
    mov [stra+1], bl

    ; Añadir el terminador '$'
    mov byte [stra+2], '$'

    ret