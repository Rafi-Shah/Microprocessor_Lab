.MODEL SMALL
.STACK 100H
.DATA
A DB 2,2,4,2,6
B DB 5 DUP(?)
RESULT DB ?
STR DW "Enter your values: $"    
STR1 DW "Sum of given values: $"  
STR2 DW "Display array: $"  

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
   
    ;string output
    MOV DX,OFFSET STR
    MOV AH,9
    INT 21H  
     
    ;NEWLINE  
    MOV AH,2
    MOV DX,13  
    INT 21H
    MOV DX,10
    INT 21H
     
    MOV CX,0
    MOV CL,5
    MOV SI,0
    MOV AX,0
     
    ;int input  1
    INPUT:
     MOV AH,1
    INT 21H
    SUB AX,30H  
    MOV B[SI],AL
    INC SI  
    LOOP INPUT
   
     ;NEWLINE  
    MOV AH,2
    MOV DX,13  
    INT 21H
    MOV DX,10
    INT 21H
   
   
    ;string output
    MOV DX,OFFSET STR2
    MOV AH,9
    INT 21H
     
    ;PRINT ARRAY
   
    MOV CX,0
    MOV CL,5
    MOV SI,0
    MOV AX,0
   
    DISPLAY:
    MOV DX,0
    MOV DL,B[SI]
    ADD DX,30H
    MOV AH,2
    INT 21H
    INC SI
    LOOP DISPLAY
   
   
   
 
   
   
     ;NEWLINE  
    MOV AH,2
    MOV DX,13  
    INT 21H
    MOV DX,10
    INT 21H
   
    ;SUMMATION
    MOV AX,0
    MOV CX,0
    MOV CL,5
    MOV SI,0
   
    SUM:
    ADD AL,B[SI]
    INC SI
    LOOP SUM
   
    ;BX INITI  
    MOV BX,0
    MOV BX,AX
     
   
     
    ;NEWLINE  
    MOV AH,2
    MOV DX,13  
    INT 21H
    MOV DX,10
    INT 21H
   
     
    ;string output
    MOV DX,OFFSET STR1
    MOV AH,9
    INT 21H  
   
    ;DIV BY 10
    MOV AX,0
    MOV AX,BX
    MOV BX,10
    DIV BL
   
    MOV BX,AX
   
    ;RESULT PRINT
   
    MOV DX,0
    MOV DL,BL
    ADD DX,48
    MOV AH,2
    INT 21H
   
    MOV DX,0
    MOV DL,BH
    ADD DX,48
    MOV AH,2
    INT 21H
   
   
    MAIN ENDP
END MAIN
