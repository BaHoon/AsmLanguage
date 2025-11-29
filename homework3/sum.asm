.MODEL SMALL
.STACK 100h

.DATA
    msg     db 'Result = ', '$'
    buffer  db 5 dup('0'), '$'    ; 用来保存转换后的数字（最多5位）

.CODE
START:
    mov ax, @DATA
    mov ds, ax

    ;--------- 求 1+2+...+100 ---------
    xor ax, ax        ; AX=0
    mov cx, 100
SumLoop:
    add ax, cx        ; AX += CX
    loop SumLoop      ; dec cx, while cx!=0 jump

    ; AX = 5050

    ;--------- 转换 AX 为十进制字符串 ---------
    mov bx, 10        ; 除数 10
    lea si, buffer+4  ; 从末尾开始填充
convert:
    xor dx, dx        ; 清除高位
    div bx            ; AX / 10，商在AX，余数在DX
    add dl, '0'       ; 余数变字符
    mov [si], dl      ; 写入缓冲区
    dec si            ; 指针前移
    cmp ax, 0
    jne convert
    inc si            ; SI 指向数字首字符

    mov ah, 09h
    mov dx, OFFSET msg
    int 21h

    mov ah, 09h
    mov dx, si
    int 21h

    mov ax, 4C00h
    int 21h
END START
