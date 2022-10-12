.model small

.stack 256h

.data 
    strCount dw 3h
    messageStringCount db 'Enter 3 string. Strings must start with 0',0Ah,'$'
    messageString db 'Enter string  (max length 20):',0Ah,'$'
    messageChar db 'Enter char:',0Ah,'$'
    messageAgain db 'Enter again:',0Ah,'$'
    
    errorLong db 'Error: String is too long!',0Ah,'$'
    errorZeroLength db 'Error: String does not start at 0!',0Ah,'$'
    errorNoZeroChar db 'Error: First character is not Zero!',0Ah,'$'

    errorCharCountZero db 'Error: Character not entered!',0Ah,'$'
    errorManyChar db 'Error: More than 1 character entered!',0Ah,'$'

    messageResult db 'Result:',0Ah,'$'
    char db ' '
    
    maxStrLen dw 14h


String struc
    chars db 14h dup (' ')
    len dw 0h
String ends

    strings String 3h dup(<>)
    ;teststr String < '000000a00', 9h >
    ;teststr db '00000a0000a000df00adsf$'

.code

init proc near 
    mov ax,@data
    mov ds,ax
    mov es,ax

    ret
init endp


printMessage proc near
    push ax 
    push cx

    mov ah, 09h
    int 21h

    pop cx
    pop ax 
    ret
printMessage endp


;al - number sting
printEnterString proc near 
    
    lea si, messageString
    add si, 0Ch
    add al, 30h
    mov [si], al
    lea dx, messageString
    call printMessage

    ret
printEnterString endp


;dx - address begin string
;ax - len
;0 - no error
;1 - error: length > max
;2 - error: length == 0
;3 - error: first char != 0
input proc near 
    
    push dx
    
    
    mov bx, dx
    mov si, dx
    mov dx, ax
    mov cx, 0h
  im1:
    mov ah, 0h
    int 16h    
    cmp al, 0h 
    jne im2
    jmp im1

  im2:
    cmp al, 0Dh
    je im3

    cmp al, 24h
    jle im1

    cmp al, 7Fh
    je im1
  
    
    cmp cx, dx 
    jge im1 
    inc cx
    mov [si], al 
    inc si
    
  im4:
    push dx 
    mov ah, 02h
    mov dl, al
    int 21h
    pop dx

    jmp im1;
  im3:


    push dx 
    mov ah, 02h
    mov dl, 0Ah
    int 21h
    pop dx


    mov ah, 1h
    cmp cx, dx
    jg iquit

    mov ah, 2h
    cmp cx, 0h
    je iquit

    mov ah, 3h
    cmp [bx], byte ptr '0'
    jne iquit

    mov ah, 0h
    mov [bx].len, cx
    
  iquit:

    
    pop dx
    ret
input endp


inputChar proc near

    
  ich:
    lea dx, char
    mov ax, 1h 
    call input
    cmp ah, 0h
    je cexit

    cmp ah, 3h
    je cexit

    cmp ah, 1h 
    je printErrManyChar

    cmp ah, 2h 
    je printErrCharCountZero

  printErrCharCountZero:
    lea dx, errorCharCountZero
    call printMessage
    lea dx, messageAgain
    call printMessage
    jmp ich

  printErrManyChar:
    lea dx, errorManyChar
    call printMessage
    lea dx, messageAgain
    call printMessage
    jmp ich

  cexit:
    ret 
inputChar endp

;dx - address begin string
inputStr proc near
    push cx
  ish:
    ;lea dx, char
    mov ax, maxStrLen
    call input
    cmp ah, 0h
    je inexit

    cmp ah, 1h 
    je printErrLong

    cmp ah, 2h 
    je printErrZeroLength

    cmp ah, 3h
    je printErrNoZeroChar

  printErrLong:
    push dx
    lea dx, errorLong
    call printMessage
    lea dx, messageAgain
    call printMessage
    pop dx
    jmp ish

  printErrZeroLength:
    push dx
    lea dx, errorZeroLength
    call printMessage
    lea dx, messageAgain
    call printMessage
    pop dx
    jmp ish

  printErrNoZeroChar:
    push dx
    lea dx, errorNoZeroChar
    call printMessage
    lea dx, messageAgain
    call printMessage
    pop dx
    jmp ish

  inexit:
    pop cx
    ret
inputStr endp
    
inputThreeStringAndChar proc near

    lea dx, messageStringCount
    call printMessage

    mov cx, 0h
    ;call input
  printAndInput:


    mov al, cl
    inc al
    call printEnterString
    
    mov ax, type String
    mul cx
    lea dx, strings
    add dx, ax
    call inputStr
    
    inc cx
    cmp cx, strCount
    jne printAndInput

    lea dx, messageChar
    call printMessage
    call inputChar

    
    ret
inputThreeStringAndChar endp 

;dx - begin string
;ah - char
replace proc near
    push dx     

    mov si, dx
    mov cx, [si].len
    dec cx
    jmp rm1
  rm2:
    mov [si], ah
  rm1:
    cmp cx, 0h 
    je rm3
    dec cx
    inc si
    cmp [si], byte ptr '0'
    je rm2
    
    jmp rm1 
  
  rm3:
    pop dx
    ret
replace endp


replaceStrings proc near 
    mov cx, 0h
  rst:

    push cx

    mov ax, type String
    mul cx
    lea dx, strings 
    add dx, ax
    mov ah, char
    call replace

    pop cx

    inc cx 
    cmp cx, strCount 
    jne rst
    
    ret

replaceStrings endp


;dx - address begin string
printString proc near
    push dx 
    
    mov si, dx
    mov cx, [si].len
  pm1:
    mov ah, 02h
    mov dl, [si]
    int 21h
    inc si
    loop pm1

    pop dx
    ret
printString endp

printStrings proc near 
    lea dx, messageResult
    call printMessage

    mov cx, 0h
  prst:

    push cx

    mov ax, type String
    mul cx
    lea dx, strings
    add dx, ax
    call printString

    mov ah, 02h
    mov dl, 0Ah
    int 21h

    pop cx
    inc cx 
    cmp cx, strCount 
    jne prst
    
    ret
printStrings endp


main:
    call init
    
    call inputThreeStringAndChar
    call replaceStrings
    call printStrings
    
    

    mov ah, 4ch
    int 21h

end main