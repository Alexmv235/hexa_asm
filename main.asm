[bits 16]

section .data
    msg_inp db 'Ingrese un numero en base 10:', 0x0D, 0x0A, '$'

section .bss
    input resb 3    ; Buffer de 3 bytes para almacenar el valor hexadecimal

section .text
    org 100h

    global _start

_start:
    ; Imprimir mensaje de entrada
    mov ah, 09h
    lea dx, [msg_inp]
    int 21h

    ; Leer el número decimal ingresado
    call read_number

    ; Almacenar en el buffer en formato hexadecimal
    call store_in_buffer

    ; Cargar el buffer en un registro (ejemplo: AX)
    mov ax, [input]        ; Cargar los primeros 2 bytes del buffer en AX
    mov dx, [input + 2]    ; Cargar el byte más significativo del buffer en DL

    ; Insertar INT 3 para detener el programa
    int 3                  ; Punto de interrupción para depuración

    ; Terminar el programa
    mov ah, 4Ch
    int 21h

; Leer el número en base 10 y almacenarlo en DX:AX (hasta 24 bits)
read_number:
    xor ax, ax
    xor dx, dx       ; Inicializar DX:AX a 0 (para almacenar hasta 32 bits)

read_loop:
    ; Leer un carácter desde el teclado
    mov ah, 01h
    int 21h
    cmp al, 0x0D     ; Verificar si es Enter
    je end_read

    sub al, '0'      ; Convertir de ASCII a número
    cmp al, 9
    ja invalid_input ; Verificar que es un número válido

    ; Multiplicar DX:AX por 0x0A (base 10)
    mov bx, 0x0A     ; Multiplicamos por base decimal 10
    mul bx           ; AX = AX * 0x0A (resultado en DX:AX)

    ; Sumar el dígito leído a AX
    add ax, dx       ; Añadir el dígito a AX
    adc dx, 0        ; Propagar el acarreo a DX si es necesario

    ; Continuar leyendo caracteres
    jmp read_loop

invalid_input:
    ; Manejo de entrada inválida (ignorar)
    jmp read_loop

end_read:
    ret

; Almacenar el número en base hexadecimal en el buffer de 3 bytes
store_in_buffer:
    ; Guardar los primeros 16 bits en el buffer (los menos significativos)
    mov [input], ax
    ; Guardar el byte más significativo en el buffer
    mov [input + 2], dl
    ret
