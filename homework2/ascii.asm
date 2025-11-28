;---------------------------------------
; 打印ASCII表中的小写字母，每行13个
; 用 loop 实现
;---------------------------------------
data segment
    msg db 0Ah,0Dh,'$'      ; 换行符+回车符（DOS格式）
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov al, 'a'          ; 从ASCII 97开始
    mov bl, 2             ; 外层循环两行

outer_loop:
    push bx               ; 保存外层计数
    mov cx, 13            ; 内层循环计数

inner_loop:
    mov dl, al            ; 当前字符
    mov ah, 02h           ; DOS功能：显示字符
    int 21h

    inc al                ; 下一个字母
    loop inner_loop       ; CX--

    ; 输出换行
    lea dx, msg
    mov ah, 09h
    int 21h

    pop bx
    dec bl
    jnz outer_loop        ; 外层循环

    mov ah, 4Ch
    int 21h
code ends
end start
