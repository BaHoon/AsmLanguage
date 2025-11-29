.MODEL SMALL
.STACK 100h

.DATA
    MsgOF   DB 0DH,0AH,'*** ERROR: Overflow Occurred! ***',0DH,0AH,'$'
    MsgNor  DB 0DH,0AH,'No Overflow, Normal Result: $'

    Old4Ofs DW ?
    Old4Seg DW ?

.CODE

OF_Handler PROC FAR
    PUSH AX
    PUSH DX

    LEA DX, MsgOF
    MOV AH, 09H
    INT 21H

    POP DX
    POP AX

    MOV AH, 4CH    
    INT 21H
OF_Handler ENDP


START:
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 35H       ; 35H = Get interrupt vector
    MOV AL, 04H       ; INT 4
    INT 21H           ; ES:BX = old handler
    MOV Old4Seg, ES
    MOV Old4Ofs, BX

    LEA DX, OF_Handler
    MOV AX, SEG OF_Handler
    MOV DS, AX
    MOV DX, OFFSET OF_Handler
    MOV AX, 2504H     ; AH=25H, AL=04H -> Set INT4
    INT 21H

    MOV AX, @DATA
    MOV DS, AX

    MOV AL, 7FH       ; +127
    ADD AL, 02H       ; +2 → OF=1
    INTO              ; 若OF=1，触发中断4

    ; 若无溢出，则继续执行：
    LEA DX, MsgNor
    MOV AH, 09H
    INT 21H

    MOV AH, 4CH
    INT 21H
END START
