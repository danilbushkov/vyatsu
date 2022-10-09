.model small

.stack 256h

.data 
    strCount dw 3h
    message0 db 'Enter 3 string.',0Ah,'$'
    message1 db 'Enter string (max length 20):',0Ah,'$'

    char db 'b'
    teststr db '00000a0000a000df00adsf$'


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

inputStr proc near 
    mov ax, 01h
    
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

    mov cx, 0
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
    jmp m1

  m2:
    mov [si], ah
  m1:
    inc si
    cmp byte ptr [si],'0'
    je m2
    cmp [si],'$'
    jne m1

    pop dx
    ret
replace endp


main:
    call init
    call input
    
    lea dx, teststr
    mov ah, char
    call replace
    
    lea dx, teststr
    call printMessage

    mov ah, 4ch
    int 21h

end main
