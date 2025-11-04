.MODEL SMALL
.STACK 100H
.DATA
A DB ?
B DB ?
STR  DW "Enter FIRST character: $"
STR1 DW "Enter SECOND character: $"
STR2 DW "Characters in REVERSE order: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV DX, OFFSET STR
    MOV AH, 9
    INT 21H  

    MOV AH, 1
    INT 21H
    MOV A, AL

    ;New Line
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H

    MOV DX, OFFSET STR1
    MOV AH, 9
    INT 21H  

    MOV AH, 1
    INT 21H
    MOV B, AL

    ;New Line
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H

    MOV DX, OFFSET STR2
    MOV AH, 9
    INT 21H  

    ;Compare & Print in Reverse Order
    MOV AL, A
    MOV BL, B
    CMP AL, BL
    JG PRINT_AB     ; If A > B, print A then B

    ; Otherwise, print B first then A
    MOV DL, B
    MOV AH, 2
    INT 21H

    MOV DL, ' '
    MOV AH, 2
    INT 21H

    MOV DL, A
    MOV AH, 2
    INT 21H
    JMP EXIT

PRINT_AB:
    MOV DL, A
    MOV AH, 2
    INT 21H

    MOV DL, ' '
    MOV AH, 2
    INT 21H

    MOV DL, B
    MOV AH, 2
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
