;/**
;@Author: InariInDream
;@Date: 2022-11-02 22:18
;@Description: 
;**/

ASSUME CS:CODE

MY_DATA SEGMENT
    SUM DB ?
MY_DATA ENDS

CODE SEGMENT
    MOV AX, 0FFFFH
    MOV DS, AX
    MOV BX, 6  ; 设置DS:BX指向FFFF:0006处

    MOV AL, [BX]
    MOV AH, 0

    MOV DX, 0
    MOV CX, 3

    S: ADD DX, AX
    LOOP S

    MOV AX, 4C00H
    INT 21H
CODE ENDS
END

