;/**
;@Author: InariInDream
;@Date: 2022-11-16 10:31
;@Description: 8086 program to count the number of 1's in a binary number
;**/
DATA SEGMENT
DXNum Dw 1011001111000101B
AXNum Dw 1100001110100110B
Bit1Num DB ?
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX, DATA  
    MOV DS, AX
    MOV BX, DXNum
    MOV AL, 0
    MOV CX, 16
LOW8:
    MOV DX, BX
    AND DX, 01H
    CMP DX, 01H
    JE LOP1       ;if equal, jump to LOP1
LOP2:
    SHR BX, 1
    LOOP LOW8

    MOV BX, AXNum
    MOV CX, 16
HIGH8:
    MOV DX, BX
    AND DX, 01H
    CMP DX, 01H
    JE LOP3       ;if equal, jump to LOP3   
LOP4:
    SHR BX, 1
    LOOP HIGH8

    
    MOV AH, 0H
    MOV BL, 10
    DIV BL      ;at most 32 1's, move the quotient to AL, remainder to AH
    MOV DX, AX
    ADD DX, 3030H ;convert to ASCII
    MOV Bit1Num, DH ;store the high byte of DX to Bit1Num
    MOV AH, 02H
    INT 21H
    MOV DL, DH
    MOV Bit1Num, DL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H

LOP1: 
    INC AL     ;if equal, add 1 to AL
    JMP LOP2
LOP3: 
    INC AL    ;if equal, add 1 to AL
    JMP LOP4
CODE ENDS
	 END START
