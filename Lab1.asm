.MODEL SMALL
.STACK 100H
.DATA
C DB ?                 
F DB ?                
STR DB        "Enter Celsius value: $"
STR1 DB 13,10,"Fahrenheit is: $"

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ;input message
    MOV DX,OFFSET STR
    MOV AH,9
    INT 21H

    MOV AH,1
    INT 21H
    SUB AL,30H       
    MOV C,AL

    ;Celsius to Fahrenheit
    MOV AL,C
    MOV BL,9
    MUL BL            
    MOV BL,5
    DIV BL            
    ADD AL,32
    DEC AL           
    MOV F,AL

    ;Newline
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H

    ;output message
    MOV DX,OFFSET STR1
    MOV AH,9
    INT 21H

    ;Fahrenheit value
    MOV AL,F
    MOV AH,0
    MOV BL,10
    DIV BL            

    ADD AL,30H        
    MOV DL,AL
    MOV AH,2
    INT 21H

    ADD AH,30H       
    MOV DL,AH
    MOV AH,2
    INT 21H

    ;Newline
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H

    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
