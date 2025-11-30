.MODEL SMALL
.STACK 100H
.DATA
A DB 5 DUP(?)           
EVEN DB 0                
ODD  DB 0                

STR  DB "Enter values: $"
STR2 DB "Even Count: $"
STR3 DB "Odd Count: $"

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV DX,OFFSET STR
    MOV AH,9
    INT 21H

    ; NEW LINE
    MOV AH,2
    MOV DX,13
    INT 21H
    MOV DX,10
    INT 21H

    ; INPUT ARRAY 
    MOV CX,5
    MOV SI,0

INPUT_LOOP:
    MOV AH,1
    INT 21H
    SUB AL,30H        
    MOV A[SI],AL      
    INC SI
    LOOP INPUT_LOOP

    ; NEW LINE
    MOV AH,2
    MOV DX,13
    INT 21H
    MOV DX,10
    INT 21H

    ; CHECK EVEN / ODD
    MOV CX,5
    MOV SI,0
    MOV EVEN,0
    MOV ODD,0

CHECK_LOOP:
    MOV AL,A[SI]
    AND AL,01H
    JZ EVEN_NUM     

ODD_NUM:
    INC ODD
    JMP NEXT

EVEN_NUM:
    INC EVEN

NEXT:
    INC SI
    LOOP CHECK_LOOP
    
    ; newline
    MOV AH,2
    MOV DX,13
    INT 21H
    MOV DX,10
    INT 21H

    MOV DX,OFFSET STR2
    MOV AH,9
    INT 21H

    MOV DL,EVEN
    ADD DL,30H
    MOV AH,2
    INT 21H

    ; newline
    MOV AH,2
    MOV DX,13
    INT 21H
    MOV DX,10
    INT 21H

    MOV DX,OFFSET STR3
    MOV AH,9
    INT 21H

    MOV DL,ODD
    ADD DL,30H
    MOV AH,2
    INT 21H

    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN
