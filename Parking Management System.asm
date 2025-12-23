.MODEL SMALL
.STACK 100H

.DATA
    ; Main Menu
    MENU_TITLE DB 13,10,'======================================',13,10
               DB '   PARKING MANAGEMENT SYSTEM',13,10
               DB '======================================',13,10,'$'
    MENU_OPT DB '1. Add Vehicle',13,10
             DB '2. Remove Vehicle',13,10
             DB '3. Show Records',13,10
             DB '4. Check Status',13,10
             DB '5. Reset System',13,10
             DB '6. Exit',13,10
             DB 'Enter Choice: $'
    
    ; Vehicle Type Menu
    VEH_MENU DB 13,10,'Select Vehicle Type:',13,10
             DB '1. Scooter (Fee: 200 Tk)',13,10
             DB '2. Car (Fee: 300 Tk)',13,10
             DB '3. Bus (Fee: 400 Tk)',13,10
             DB 'Enter Choice: $'
    
    ; Messages
    SUCCESS_ADD DB 13,10,'Vehicle Added Successfully!',13,10,'$'
    SUCCESS_REMOVE DB 13,10,'Vehicle Removed Successfully!',13,10,'$'
    PARKING_FULL DB 13,10,'ERROR: Parking is Full! (Max 8 slots)',13,10,'$'
    NO_VEHICLE DB 13,10,'ERROR: No vehicle of this type!',13,10,'$'
    INVALID_MSG DB 13,10,'ERROR: Invalid Choice!',13,10,'$'
    
    ; Records Display
    RECORDS_TITLE DB 13,10,'===== PARKING RECORDS =====',13,10,'$'
    TOTAL_INCOME_MSG DB 'Total Income: $'
    TOTAL_VEH_MSG DB 13,10,'Total Vehicles: $'
    SCOOTER_MSG DB 13,10,'Scooters: $'
    CAR_MSG DB 13,10,'Cars: $'
    BUS_MSG DB 13,10,'Buses: $'
    
    ; Status Display
    STATUS_TITLE DB 13,10,'===== PARKING STATUS =====',13,10,'$'
    OCCUPIED_MSG DB 'Occupied: $'
    AVAILABLE_MSG DB 13,10,'Available: $'
    
    ; Reset Confirmation
    RESET_MSG DB 13,10,'Reset? (Y/N): $'
    RESET_SUCCESS DB 13,10,'System Reset!',13,10,'$'
    
    NEWLINE DB 13,10,'$'
    PRESS_KEY DB 13,10,'Press any key...$'
    TK_SYMBOL DB ' Tk$'
    
    ; Parking Data
    MAX_CAPACITY DB 8
    TOTAL_VEHICLES DB 0
    SCOOTER_COUNT DB 0
    CAR_COUNT DB 0
    BUS_COUNT DB 0
    
    ; Fees
    SCOOTER_FEE DW 200
    CAR_FEE DW 300
    BUS_FEE DW 400
    TOTAL_INCOME DW 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
MENU_LOOP:
    CALL CLEAR_SCREEN
    
    LEA DX, MENU_TITLE
    MOV AH, 09H
    INT 21H
    
    LEA DX, MENU_OPT
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    
    CMP AL, 1
    JE ADD_VEH
    CMP AL, 2
    JE REMOVE_VEH
    CMP AL, 3
    JE SHOW_REC
    CMP AL, 4
    JE CHECK_STAT
    CMP AL, 5
    JE RESET_SYS
    CMP AL, 6
    JE EXIT_PROG
    
    LEA DX, INVALID_MSG
    MOV AH, 09H
    INT 21H
    CALL WAIT_KEY
    JMP MENU_LOOP

ADD_VEH:
    MOV AL, TOTAL_VEHICLES
    CMP AL, MAX_CAPACITY
    JGE PARK_FULL
    
    LEA DX, VEH_MENU
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    
    CMP AL, 1
    JE ADD_SC
    CMP AL, 2
    JE ADD_CA
    CMP AL, 3
    JE ADD_BU
    JMP INV_CH

ADD_SC:
    INC SCOOTER_COUNT
    MOV AX, SCOOTER_FEE
    ADD TOTAL_INCOME, AX
    JMP ADD_OK

ADD_CA:
    INC CAR_COUNT
    MOV AX, CAR_FEE
    ADD TOTAL_INCOME, AX
    JMP ADD_OK

ADD_BU:
    INC BUS_COUNT
    MOV AX, BUS_FEE
    ADD TOTAL_INCOME, AX
    JMP ADD_OK

ADD_OK:
    INC TOTAL_VEHICLES
    LEA DX, SUCCESS_ADD
    MOV AH, 09H
    INT 21H
    CALL WAIT_KEY
    JMP MENU_LOOP

PARK_FULL:
    LEA DX, PARKING_FULL
    MOV AH, 09H
    INT 21H
    CALL WAIT_KEY
    JMP MENU_LOOP

REMOVE_VEH:
    MOV AL, TOTAL_VEHICLES
    CMP AL, 0
    JE NO_VEH
    
    LEA DX, VEH_MENU
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    
    CMP AL, 1
    JE REM_SC
    CMP AL, 2
    JE REM_CA
    CMP AL, 3
    JE REM_BU
    JMP INV_CH

REM_SC:
    MOV AL, SCOOTER_COUNT
    CMP AL, 0
    JE NO_VEH
    DEC SCOOTER_COUNT
    MOV AX, SCOOTER_FEE
    SUB TOTAL_INCOME, AX
    JMP REM_OK

REM_CA:
    MOV AL, CAR_COUNT
    CMP AL, 0
    JE NO_VEH
    DEC CAR_COUNT
    MOV AX, CAR_FEE
    SUB TOTAL_INCOME, AX
    JMP REM_OK

REM_BU:
    MOV AL, BUS_COUNT
    CMP AL, 0
    JE NO_VEH
    DEC BUS_COUNT
    MOV AX, BUS_FEE
    SUB TOTAL_INCOME, AX
    JMP REM_OK

REM_OK:
    DEC TOTAL_VEHICLES
    LEA DX, SUCCESS_REMOVE
    MOV AH, 09H
    INT 21H
    CALL WAIT_KEY
    JMP MENU_LOOP

NO_VEH:
    LEA DX, NO_VEHICLE
    MOV AH, 09H
    INT 21H
    CALL WAIT_KEY
    JMP MENU_LOOP

SHOW_REC:
    CALL CLEAR_SCREEN
    LEA DX, RECORDS_TITLE
    MOV AH, 09H
    INT 21H
    
    LEA DX, TOTAL_INCOME_MSG
    MOV AH, 09H
    INT 21H
    MOV AX, TOTAL_INCOME
    CALL PRINT_NUM
    LEA DX, TK_SYMBOL
    MOV AH, 09H
    INT 21H
    
    LEA DX, TOTAL_VEH_MSG
    MOV AH, 09H
    INT 21H
    MOV AL, TOTAL_VEHICLES
    MOV AH, 0
    CALL PRINT_NUM
    
    LEA DX, SCOOTER_MSG
    MOV AH, 09H
    INT 21H
    MOV AL, SCOOTER_COUNT
    MOV AH, 0
    CALL PRINT_NUM
    
    LEA DX, CAR_MSG
    MOV AH, 09H
    INT 21H
    MOV AL, CAR_COUNT
    MOV AH, 0
    CALL PRINT_NUM
    
    LEA DX, BUS_MSG
    MOV AH, 09H
    INT 21H
    MOV AL, BUS_COUNT
    MOV AH, 0
    CALL PRINT_NUM
    
    CALL WAIT_KEY
    JMP MENU_LOOP

CHECK_STAT:
    CALL CLEAR_SCREEN
    LEA DX, STATUS_TITLE
    MOV AH, 09H
    INT 21H
    
    LEA DX, OCCUPIED_MSG
    MOV AH, 09H
    INT 21H
    MOV AL, TOTAL_VEHICLES
    MOV AH, 0
    CALL PRINT_NUM
    
    LEA DX, AVAILABLE_MSG
    MOV AH, 09H
    INT 21H
    MOV AL, MAX_CAPACITY
    SUB AL, TOTAL_VEHICLES
    MOV AH, 0
    CALL PRINT_NUM
    
    CALL WAIT_KEY
    JMP MENU_LOOP

RESET_SYS:
    LEA DX, RESET_MSG
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    CMP AL, 'Y'
    JE DO_RES
    CMP AL, 'y'
    JE DO_RES
    JMP MENU_LOOP

DO_RES:
    MOV TOTAL_VEHICLES, 0
    MOV SCOOTER_COUNT, 0
    MOV CAR_COUNT, 0
    MOV BUS_COUNT, 0
    MOV TOTAL_INCOME, 0
    
    LEA DX, RESET_SUCCESS
    MOV AH, 09H
    INT 21H
    CALL WAIT_KEY
    JMP MENU_LOOP

INV_CH:
    LEA DX, INVALID_MSG
    MOV AH, 09H
    INT 21H
    CALL WAIT_KEY
    JMP MENU_LOOP

EXIT_PROG:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV CX, 0
    MOV BX, 10
    
DIV_LP:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE DIV_LP
    
PRT_LP:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRT_LP
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

CLEAR_SCREEN PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AH, 06H
    MOV AL, 0
    MOV BH, 07H
    MOV CX, 0
    MOV DH, 24
    MOV DL, 79
    INT 10H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DX, 0
    INT 10H
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CLEAR_SCREEN ENDP

WAIT_KEY PROC
    PUSH AX
    PUSH DX
    
    LEA DX, PRESS_KEY
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    POP DX
    POP AX
    RET
WAIT_KEY ENDP

END MAIN
