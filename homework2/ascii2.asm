assume cs:code, ds:data

data segment
    char db 'a'
    space db ' ',0dh,0ah,'$'
data ends

code segment
start:
    mov ax, data
    mov ds, ax

    mov bl, 'a'
    mov cx, 2          ;两行

outer_jmp:
    push cx            ;保存外层计数

    mov cx, 13         ;每行13个字符

inner_jmp:
    mov dl, bl
    mov ah, 02h
    int 21h

    mov dl, ' '
    int 21h

    inc bl
    dec cx
    jnz inner_jmp

    mov dx, offset space
    mov ah, 09h
    int 21h

    pop cx
    dec cx
    jnz outer_jmp

    mov ah, 4ch
    int 21h
code ends
end start
