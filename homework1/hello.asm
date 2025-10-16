; helloworld.asm
data segment
    msg db 'Hello, World!$'  ; 定义字符串，以'$'结尾是DOS中断的要求
data ends

code segment
    assume cs:code, ds:data
start:
    mov ax, data    ; 将数据段地址加载到AX寄存器
    mov ds, ax      ; 将AX的值设置到DS（数据段寄存器）

    mov dx, offset msg ; DX指向字符串的地址
    mov ah, 09h     ; AH=09h，代表DOS的“显示字符串”功能
    int 21h         ; 调用DOS中断

    mov ah, 4ch     ; AH=4ch，代表DOS的“程序退出”功能
    int 21h         ; 调用DOS中断，退出程序
code ends
end start