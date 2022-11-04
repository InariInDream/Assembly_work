;/**
;@Author: InariInDream
;@Date: 2022-11-01 22:22
;@Description: 
;**/
 
ASSUME CS:CODESEG

CODESEG SEGMENT
    MOV AX, 2
    MOV CX, 11 ; 11次循环
S:  ADD AX, AX
    LOOP S
    MOV AX, 4C00H
    INT 21H

CODESEG ENDS

END
