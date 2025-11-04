.MODEL SMALL
.STACK 100H
.DATA
A DB ?
B DB ?
RESULT DB ?

STR  DW "Enter FIRST value: $"
STR1 DW "Enter SECOND value: $"
STR2 DW "The LARGEST number is: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;Input First Number
    MOV DX, OFFSET STR
    MOV AH, 9
    INT 21H  

    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV A, AL  

    ;New Line
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H

    ;Input Second Number
    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H  

    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV B, AL  

    ;Compare the Two Numbers
    MOV AL, A
    MOV BL, B
    CMP AL, BL
    JGE FIRST_LARGE
    
    ;If second is larger
    MOV RESULT, BL    
    JMP DISPLAY
    ; If first is larger
    FIRST_LARGE:
    MOV RESULT, AL    

    DISPLAY:
    ;New Line
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H

    ;Display Result Message
    MOV DX, OFFSET STR2
    MOV AH, 9
    INT 21H  

    ;Display Result Value
    MOV DL, RESULT
    ADD DL, 30H
    MOV AH, 2
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
