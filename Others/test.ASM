CODES SEGMENT
MOV   CX,M             
MOV   AX,0             
MOV   SI,AX           
START:
    ADD   AX,ARRAY[SI]
    CMP   AX, FFFFH
    JAE Lop1 
    ADD   SI,2              
    LOOP  START             
    MOV   TOTAL,AX
    MOV  CL, N
    SHL  TOTAL, 8*N
    MOV TOTAL, TOTAL-N

Lop1: MOV AX, 0
N=N+1
LOOP START
CODES ENDS
    END START