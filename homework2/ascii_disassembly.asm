.LC0:
        .string "%c "       ; 定义一个常量字符串，作为 printf 的格式化字符串 ("%c ")
main:
        push    rbp         ; 栈帧设置：保存旧的基址指针 RBP
        mov     rbp, rsp    ; 设置新的基址指针 RBP 为当前栈顶 RSP
        sub     rsp, 16     ; 为局部变量在栈上分配 16 字节空间 (1, 2, 4, 8 字节变量)

        ; 局部变量内存分配 (推测):
        ; [rbp-1]  : char ch
        ; [rbp-8]  : int i (外层循环计数器)
        ; [rbp-12] : int j (内层循环计数器)

        mov     BYTE PTR [rbp-1], 97    ; char ch = 'a'; (97 是 'a' 的 ASCII 值，存放在 [rbp-1])
        mov     DWORD PTR [rbp-8], 0    ; int i = 0; (外层循环变量 i，存放在 [rbp-8])
        jmp     .L2                     ; 无条件跳转到外层循环的条件检查 .L2

.L5:                                    ; 外层循环体开始 (for(i=0; ... ))
        mov     DWORD PTR [rbp-12], 0   ; int j = 0; (内层循环变量 j，存放在 [rbp-12])
        jmp     .L3                     ; 跳转到内层循环的条件检查 .L3

.L4:                                    ; 内层循环体开始 (for(j=0; ... ))
        ; printf("%c ", ch);
        movsx   eax, BYTE PTR [rbp-1]   ; 将 ch 的值（一个字节）带符号扩展到 EAX 寄存器
        mov     esi, eax                ; 将 ch 的值作为第二个参数 (参数 2：要打印的字符) 传给 ESI 
        mov     edi, OFFSET FLAT:.LC0   ; 将格式字符串 "%c " 的地址作为第一个参数 (参数 1) 传给 EDI
        mov     eax, 0                  ; 设置 EAX=0，表示 printf 没有浮点参数
        call    printf                  ; 调用 printf 函数

        ; ch++;
        movzx   eax, BYTE PTR [rbp-1]   ; 将 ch 的当前值加载到 EAX
        add     eax, 1                  ; EAX 加 1 (ch + 1)
        mov     BYTE PTR [rbp-1], al    ; 将结果（低 8 位 AL）存回 ch (实现 ch++)

        ; j++
        add     DWORD PTR [rbp-12], 1   ; 内层循环计数器 j 加 1

.L3:                                    ; 内层循环条件检查 (j < 13)
        cmp     DWORD PTR [rbp-12], 12  ; 比较 j 和 12
        jle     .L4                     ; 如果 j <= 12 (即 j 从 0 到 12，共 13 次)，则跳转回内层循环体 .L4

        ; printf("\n");
        mov     edi, 10                 ; 将换行符的 ASCII 值 10 (LF) 作为参数传给 EDI
        call    putchar                 ; 调用 putchar(10) (比 printf("\n") 更高效)

        ; i++
        add     DWORD PTR [rbp-8], 1    ; 外层循环计数器 i 加 1

.L2:                                    ; 外层循环条件检查 (i < 2)
        cmp     DWORD PTR [rbp-8], 1    ; 比较 i 和 1
        jle     .L5                     ; 如果 i <= 1 (即 i 从 0 到 1，共 2 次)，则跳转回外层循环体 .L5

        ; return 0;
        mov     eax, 0                  ; 设置返回值为 0 (EAX 存放函数返回值)
        leave                           ; 栈帧恢复：相当于 mov rsp, rbp; pop rbp
        ret                             ; 函数返回