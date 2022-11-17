ASSUME CS:CODE, DS:DATA, SS:STACK
DATA SEGMENT
    DW 0123H, 4567H, 89ABH, CDEFH
DATA ENDS

STACK SEGMENT
    DW 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
STACK ENDS

CODE SEGMENT
    START:
    MOV AX, STACK
    MOV SS, AX
    MOV SP, 20H ; 设置栈顶ss：sp指向stack：20
    
    MOV AX, DATA
    MOV DS, AX ; 设置数据段寄存器ds指向data

    MOV BX, 0 ; 设置BX指向data：0

    MOV CX, 8
S:  
    PUSH DS:[BX] ; 将data：0的值压入栈中
    ADD BX, 2 ; BX指向data：2
    LOOP S ; 循环8次

    MOV BX, 0

    MOV CX, 8
S0:
    POP [BX]
    ADD BX, 2
    LOOP S0

    MOV AX, 4C00H
    INT 21H
CODE ENDS
END START