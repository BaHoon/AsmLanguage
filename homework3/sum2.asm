.MODEL SMALL
.STACK 100h

.DATA
    prompt_msg  DB 'Input (1-100): $'
    sum_msg     DB 'Output: $'
    number      DW ?
    sum         DW 0

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; -------- 显示输入提示 --------
    LEA DX, prompt_msg
    MOV AH, 09h
    INT 21h

    XOR CX, CX       ; CX 用来保存输入的数字（逐位累积）

READ_INPUT:
    MOV AH, 01h      ; 读取一个字符
    INT 21h
    CMP AL, 0Dh      ; 回车结束输入
    JE  CALCULATE_SUM
    SUB AL, '0'      ; 转数字
    MOV BL, AL
    MOV AX, CX
    MOV CX, 10
    MUL CX           ; AX = AX * 10
    ADD AX, BX       ; AX = AX + 新数字
    MOV CX, AX
    JMP READ_INPUT

CALCULATE_SUM:
    MOV AX, CX       ; AX = 输入的 N
    MOV number, AX
    MOV CX, AX       ; CX = N（循环次数）
    MOV BX, 1
    XOR AX, AX       ; AX = 累加和

SUM_LOOP:
    ADD AX, BX
    INC BX
    LOOP SUM_LOOP
    MOV sum, AX

    ; -------- 输出结果文字 --------
    LEA DX, sum_msg
    MOV AH, 09h
    INT 21h

    ; -------- 调用打印十进制过程 --------
    MOV AX, sum
    CALL PRINT_DECIMAL

    MOV AH, 4Ch
    INT 21h

; -------------- 十进制转换并打印（核心模块） --------------
PRINT_DECIMAL PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX       ; 位数计数
    MOV BX, 10       ; 除数基数

CONVERT_LOOP:
    XOR DX, DX
    DIV BX           ; AX / 10，商在 AX，余数在 DX
    PUSH DX          ; 保存一位数字（倒序）
    INC CX
    CMP AX, 0
    JNE CONVERT_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 02h
    INT 21h
    LOOP PRINT_LOOP

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_DECIMAL ENDP

END START
