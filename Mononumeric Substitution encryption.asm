include 'emu8086.inc'
org 100h

jmp start

Buffer db 81 dup(0)
Buffer2 db 81 dup(0)

msg1 db 0dh,0ah, 'Choose: 1-Encrypt or 2-Decrypt: $'
msg2 db 0dh,0ah, 'Enter your text: $'
msg3 db 0dh,0ah, 'Encrypted: $'
msg4 db 0dh,0ah, 'Decrypted: $'
msg5 db 0dh,0ah, 'Enter numbers (2 digits each): $'

start:
    ; Print menu
    lea dx, msg1
    mov ah, 09h
    int 21h
    
    ; Get choice
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je encrypt
    cmp al, '2'
    je decrypt
    jmp start

encrypt:
    ; Ask for text
    lea dx, msg2
    mov ah, 09h
    int 21h
    
    ; Setup buffer
    lea bx, Buffer
    mov byte ptr [bx], 80
    
    ; Read string
    lea dx, Buffer
    mov ah, 0ah
    int 21h
    
    ; Print result header
    lea dx, msg3
    mov ah, 09h
    int 21h
    
    ; Get string length
    lea bx, Buffer
    mov cl, [bx+1]
    xor ch, ch
    mov si, 2
    
encrypt_loop:
    cmp cl, 0
    je encrypt_done
    
    mov al, [bx+si]
    
    ; Check if lowercase letter
    cmp al, 'a'
    jb skip_char
    cmp al, 'z'
    ja skip_char
    
    ; Convert a=1, b=2, ..., z=26
    sub al, 'a'
    add al, 1
    
    ; Print as 2-digit number
    push bx
    push cx
    push si
    xor ah, ah
    call print_two_digit
    
    ; Print space
    mov dl, ' '
    mov ah, 02h
    int 21h
    
    pop si
    pop cx
    pop bx
    
skip_char:
    inc si
    dec cl
    jmp encrypt_loop
    
encrypt_done:
    jmp start

decrypt:
    ; Ask for numbers
    lea dx, msg5
    mov ah, 09h
    int 21h
    
    ; Setup buffer
    lea bx, Buffer
    mov byte ptr [bx], 80
    
    ; Read string
    lea dx, Buffer
    mov ah, 0ah
    int 21h
    
    ; Print result header
    lea dx, msg4
    mov ah, 09h
    int 21h
    
    ; Convert pairs of digits
    lea bx, Buffer
    mov si, 2
    mov cl, [bx+1]
    xor ch, ch
    
decrypt_loop:
    cmp cl, 1
    jle decrypt_done
    
    ; Get first digit
    mov al, [bx+si]
    cmp al, '0'
    jb next_char
    cmp al, '9'
    ja next_char
    
    sub al, '0'
    mov dl, 10
    mul dl
    mov dh, al
    
    ; Get second digit
    inc si
    dec cl
    mov al, [bx+si]
    cmp al, '0'
    jb next_char
    cmp al, '9'
    ja next_char
    
    sub al, '0'
    add al, dh
    
    ; Check valid range (1-26)
    cmp al, 1
    jb next_char
    cmp al, 26
    ja next_char
    
    ; Convert to letter (1=a, 2=b, etc.)
    add al, 'a'
    sub al, 1
    
    ; Print character
    push bx
    push cx
    push si
    mov dl, al
    mov ah, 02h
    int 21h
    pop si
    pop cx
    pop bx
    
next_char:
    inc si
    dec cl
    cmp cl, 0
    jg decrypt_loop
    
decrypt_done:
    jmp start

; Print number in AX as two digits
print_two_digit proc near
    push ax
    push dx
    push bx
    
    ; Divide by 10
    mov bl, 10
    div bl
    
    ; Print tens digit
    push ax
    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h
    
    ; Print ones digit
    pop ax
    mov dl, ah
    add dl, '0'
    mov ah, 02h
    int 21h
    
    pop bx
    pop dx
    pop ax
    ret
print_two_digit endp

end
