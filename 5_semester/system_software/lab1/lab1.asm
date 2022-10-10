.model small

.stack 256h

.data 
    strCount dw 3h
    message0 db 'Enter 3 string.',0Ah,'$'
    message1 db 'Enter string (max length 20):',0Ah,'$'

    error0 db 'Error: String is too long!$'
    error1 db 'Error: String does not start at 0!$'

    char db 'd'
    ;teststr db '00000a0000a000df00adsf$'
    maxStrLen dw 14h


String struc
    chars db 14h dup (' ')
    len dw 0h
String ends

    teststr String < '000000a00', 9h >
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

;dx - begin string
;ax - len
;0 - no error
;1 - error: length > max
;2 - error: length == 0
;3 - error: first char != 0
inputStr proc near 
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
    cmp al, 2Fh
    jle im1
  
    inc cx
    cmp cx, dx 
    jg im4 
    mov [si], al 
    inc si
    
  im4:
    mov ah, 02h
    mov dl, al
    int 21h

    jne im1;
  im3:

    mov ah, 02h
    mov dl, 0Ah
    int 21h



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
inputStr endp


inputChar proc near

    ret
inputChar endp


    ret
input proc near
    push cx

    lea dx, message0
    call printMessage

    mov cx, 0h
    call inputStr
  printAndInput:
    lea dx, message1
    call printMessage
    
    
    inc cx
    cmp cx, strCount
    jne printAndInput


    pop cx
    ret
input endp 

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
    inc si
    cmp [si], byte ptr '0'
    je rm2
    
    loop rm1

    pop dx
    ret
replace endp

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


main:
    call init
    call input
    
    lea dx, teststr
    mov ah, char
    call replace
    call printString
    ;lea dx, teststr
    

    mov ah, 4ch
    int 21h

end main
