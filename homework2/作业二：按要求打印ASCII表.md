# 作业二：按要求打印ASCII表

1. 用loop指令实现

sacii.asm：

```assembly
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
```

2. 条件跳转指令实现

```
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
```

3. C语言实现后，查看反汇编代码，并加注释

   ```
   #include <stdio.h>
   
   int main() {
       char ch = 'a';
       for(int i = 0; i < 2; i++) {       // 两行
           for(int j = 0; j < 13; j++) {  // 每行13字符
               printf("%c ", ch);
               ch++;
           }
           printf("\n");
       }
       return 0;
   }
   
   ```

   

