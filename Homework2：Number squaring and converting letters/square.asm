;/**
;@Author: InariInDream
;@Date: 2022-11-14 20:01
;@Description: 8086 program for squaring numbers and converting letters to upper and lower case
;**/

DATA SEGMENT USE16
    TAB DB " 0$ 1$ 4$ 9$16$25$36$49$64$81$"
    RETURN DB 13,10,"$"
DATA ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE,DS:DATA
    START:
        MOV AX,DATA
        MOV DS,AX
        
        MOV AH, 1 ; read character from keyboard
        INT 21H  
        MOV BL, AL ; save character in BL
        MOV AH, 9
        MOV DX, OFFSET RETURN ; print return
        INT 21H  

        CMP BX, '9' ; check if character is not a digit
        JA UPLOW ; if not, jump to uplow
        CMP BX, '0' ; check if character is not a digit
        JB UPLOW ; if not, jump to uplow

        AND BX , 0FH
        MOV DX, OFFSET TAB 
        ADD DX, BX 
        ADD DX, BX 
        ADD DX, BX 

        MOV AH, 9 ; print result
        INT 21H 
        JMP EXIT

    UPLOW:
        CMP BX, 'z' ; check if character is not a letter
        JA UPLOW2 ; if not, jump to exit
        CMP BX, 'a' ; check if character is not a letter
        JB UPLOW2 ; if not, jump to exit
        XOR AL, 20H
        MOV DX, OFFSET RETURN
        MOV AH, 9 ; print result
        MOV DL, AL
        MOV AH, 2
        INT 21H
        JMP EXIT

    UPLOW2:
        CMP BX, 'Z' ; check if character is not a letter
        JA EXIT ; if not, jump to exit
        CMP BX, 'A' ; check if character is not a letter
        JB EXIT ; if not, jump to exit
        XOR AL, 20h
        MOV DX, OFFSET RETURN
        MOV AH, 9 ; print result
        MOV DL, AL
        MOV AH, 2
        INT 21H
        JMP EXIT

    EXIT:
        MOV AH, 4Ch
        INT 21H

CODE ENDS
END START
