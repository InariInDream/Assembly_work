;/**
;@Author: InariInDream
;@Date: 2022-11-15 10:27
;@Description: 8086 program to convert a decimal number to hexadecimal number
;**/
DATA SEGMENT            
    CTR DB 0DH,0AH,'$'  
DATA ENDS
 
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA  
START:
    MOV AX,DATA
    MOV DS,AX               
 
MAIN:
    CALL READ          ;read a decimal number
    CALL CONVERT       
    JMP  EX            
    
READ PROC FAR    
    MOV BX,0
NEWCHAR:
    MOV AH,1          
    INT 21H
    XOR AH,AH
    CMP AL,'0'        
    JS  EXIT
    CMP AL,'9'
    JA  EXIT
    SUB AL,'0'         
    XCHG BX,AX     
    MOV CX,0AH
    MUL CX            ;multiply by 10 and add to BX
    XCHG BX,AX        ;BX = BX*10 + AL
    ADD BX,AX
    JMP NEWCHAR       ;result in BX
   
    EXIT:
    RET
READ ENDP
  
CONVERT PROC FAR   
    MOV CH,04H
ROTATE:
    MOV CL,04H
    ROL BX,CL        ;rotate left 4 bits
    MOV AL,BL
    AND AL,0FH       ;mask off high 4 bits
    ADD AL,30H       ;convert to ASCII
    CMP AL,'9'
    JB  PRINT        ;if AL < '9' then print
    ADD AL,07H       ;if AL > '9' then add 7 to convert to A-F
    
PRINT:
    MOV DL,AL   
    MOV AH,2
    INT 21H
    DEC CH
    JNE ROTATE   
    RET

CONVERT ENDP
   
    EX: 
    MOV AH,4CH
    INT 21H          ;exit to DOS
CODE ENDS
    END START