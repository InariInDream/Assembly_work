;/**
;@Author: InariInDream
;@Date: 2022-11-17 10:22
;@Description: 
;**/
ASSUME CS:CODE

CODE SEGMENT
S:  MOV AX, BX
    MOV SI, OFFSET S
    MOV DI, OFFSET S0
    MOV AX, CS:[SI]
    MOV CS:[DI], AX
S0:
    NOP
    NOP
CODE ENDS
END S