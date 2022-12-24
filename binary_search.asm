;/**
;@Author: InariInDream
;@Date: 2022-12-13 16:29
;@Description: Binary Search in Assembly
;**/
STACK SEGMENT
    DW 100 DUP(?)
STACK ENDS

DATA SEGMENT
ARR DB 127 DUP(?) ;define array with maximmum size 127 
number DB 0
SOLVE DB 0
numberplace DB 10
KEY DB 0;the input key             
FOUND DB "Number is found at position $"
NOTFOUND DB "Number NOT FOUND! $"
SIZEINFO DB "Size of array: $"   
INPUTINFO DB "ENTER ELEMENT NUMBER  $"
KEYINPUT DB "Enter the number you want to find $"      
COUNTINFO DB "COUNT IS $"
INDEX DB 0
SIZE1 DB 0
OCC DB 0  
DATA ENDS 

CODE SEGMENT
ASSUME CS:CODE,DS:DATA,SS:STACK
START:   
MOV AX,DATA ;intialize the data segment
MOV DS,AX

STR:
MOV number,0    
JMP BEGIN

BEGIN:
LEA DX,SIZEINFO
MOV AH,09H
INT 21H                            
CALL CIN ; call function to inter the size
MOV SIZE1,AL
MOV CL,0 
ARR_LOOP: 
    CMP CL,SIZE1
    JE ARR_END  ;if CL = SIZE1 then jump to ARR_END, the loop ends
    LEA DX,INPUTINFO
    MOV AH,09H
    INT 21H
    MOV AL,CL   ;mov cl to al
    INC AL      ;increment AL by 1
    MOV AH,0    ;set AH = 0
    CALL CIN      ;call it to enter the elements of the arr
    MOV INDEX,AL    ;after entering the new element it keeps its vvalue INDEX
    MOV CH,0
    MOV SI,CX
    MOV ARR[SI],AL
    INC CL      
    MOV AH,0    
    JMP ARR_LOOP

ARR_END:         
LEA DX,KEYINPUT      ;load effective address to the dx
MOV AH,09H
INT 21H          ;fetch the instruction in 21h
CALL CIN       ;call it to enter the elements of the arr
MOV KEY,AL       ;put the key that enters in al to key
;array elements end    
MOV BL,SIZE1     ;mov the size of the array to BL, right index
DEC BL           ; decrement the BL by 1, set r = n - 1
MOV BH,00       ;left index
MOV CL,KEY      ;put the key at CL
MOV CH,0
MOV SI,CX

AGAIN:CMP BH,BL ;binary search
JA FAIL         ;if l > r then key not found
MOV AL, 1
ADD OCC, AL
MOV AL, 0
MOV AL,BH       ;mov BH to AL
ADD AL,BL       ;add BL to AL
SHR AL,1        ;shift AL to right by 1, AL = (l + r) >> 1
MOV AH,00       ;set AH to 00, AL = mid
MOV SI,AX       ;mov AX to SI, SI = mid
CMP CL,ARR[SI]  ;compare the SIth element with CL

JAE BIG         ;if CL >= SIth element then jump to BIG
DEC AL          ;else decrement AL by 1
MOV BL,AL       ;mov AL to BL
JMP AGAIN       ;continue the loop
BIG:JE SUCCESS  ;if CL = SIth element then jump to SUCCESS
INC AL          ;else AL = AL + 1
MOV BH,AL       ;mov AL to BH
JMP AGAIN       ;continue the loop
    
SUCCESS:
MOV SOLVE,AL    ;res = mid
LEA DX,FOUND
MOV AH,09H
INT 21H          
MOV AL,SOLVE 
INC AL           ;increment the AL by 1
MOV AH,0 
CALL COUT
MOV DL, 0AH
MOV AH, 02H
INT 21H
LEA DX,COUNTINFO
MOV AH,09H
INT 21H 
MOV AL,OCC  
MOV AH,0 
CALL COUT
JMP P_END        ;jump to the end of the program

FAIL:LEA DX,NOTFOUND     ;key not found
MOV AH,09H
INT 21H 
MOV AL, OCC
MOV AH,0
CALL COUT
JMP P_END
; ------CIN AND COUT PROCEDURES------
CIN PROC NEAR        ;read a number from keyboard and store it in AL
    PUSH AX          ;push the registers to the stack
    PUSH BX
    PUSH DX
    PUSH CX 
    MOV CX,0
loop_number_main:  
    MOV number,0     ;initialize number to zero
loop_read_number:
    MOV AH,01H       ;read a character from keyboard    
    INT 21H             
    CMP AL,0DH       ;compare AL with ASCII code of ENTER
    JE numbercomplete;if equal then jump to numbercomplete
    INC CX           
    SUB AL,30h       ;subtract ASCII code of zero from AL,so that the number is stored in AL                 
    MOV BL,AL        
    MOV AL,number    ;move number to AL
    MUL numberplace  ;multiply AL with 10   
    MOV BH,0         
    MOV AH,0
    ADD AX,BX        
    MOV number,AL     
    JMP loop_read_number                          
numbercomplete:      ;if enter is pressed then jump to numbercomplete
    CMP CX,0
    JE loop_number_main ;if the number of digits is zero then jump to loop_number_main
    POP CX
    POP DX
    POP BX
    POP AX
    MOV AL,number ;move number to AL
    RET
CIN ENDP 

COUT PROC     ;procedure to print a number from AL      
    ;initialize count
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV CX,0
    MOV DX,0
    label1:
        CMP AX,0    ; if ax is zero
        JE print1     
        MOV BX,10   ;initialize bx to 10
        ; extract the last digit
        DIV BX       ;put the result at AX and the remendier to DX,so that DX will be the last digit                 
        PUSH DX      ;push it in the stack       
        INC CX       ;increment the count     
        XOR DX,DX    ;set dx to 0
        JMP label1
    print1:      
        CMP CX,0     ;check if count is greater than zero
        JE exit      ;if not then jump to exit
        POP DX       ;pop the top of stack
        ADD DX,30h   ;add 30h to DX so that it will be the ASCII code of the digit
        MOV AH,02h   ;interrupt to print a character
        INT 21h
        DEC CX       ;decrease the count, so that the next digit will be printed
        JMP print1
exit:
    POP DX
    POP CX
    POP BX
    POP AX
RET
COUT ENDP
P_END: ; end of the program
MOV AH,4CH
INT 21H
CODE ENDS
    END START