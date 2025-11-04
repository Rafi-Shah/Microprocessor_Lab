.MODEL SMALL
.STACK 100H
.DATA
N DB ?
MSG1 DB "Enter N: $"
MSG2 DB "Summation of squares is: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display "Enter N"
    MOV DX, OFFSET MSG1
    MOV AH, 9
    INT 21H
    ; Input N 
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV N, AL
    ; New line
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    ; Display output message
    MOV DX, OFFSET MSG2
    MOV AH, 9
    INT 21H
    ;Calculate sum of squares
    XOR BX, BX     
    MOV CL, N

LOOP_SQ:
    MOV AL, CL
    MUL AL        
    ADD BX, AX
    DEC CL
    JNZ LOOP_SQ

    ;Convert to 3 digits
    MOV AX, BX

    MOV CX, 100
    XOR DX, DX
    DIV CX
    MOV BL, AL     ; BL = hundreds
    MOV AX, DX     ; AX = remainder

    MOV CX, 10
    XOR DX, DX
    DIV CX
    MOV BH, AL   
    MOV CH, DL   

    ;Print 3 digits
    MOV DL, BL
    ADD DL, 30H
    MOV AH, 2
    INT 21H

    MOV DL, BH
    ADD DL, 30H
    MOV AH, 2
    INT 21H

    MOV DL, CH
    ADD DL, 30H
    MOV AH, 2
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
