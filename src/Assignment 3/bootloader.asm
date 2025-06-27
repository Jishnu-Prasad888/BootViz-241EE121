[org 0x7C00]

mov si, message        

print_loop:
    lodsb              
    or al, al          
    jz wait_key
    mov ah, 0x0E       
    int 0x10           
    jmp print_loop

wait_key:
    mov ah, 0x00       
    int 0x16           

    mov ah, 0x0E       
    int 0x10

    cli               
    hlt                

message db "Press a key", 0

times 510 - ($ - $$) db 0
dw 0xAA55              ; Boot signature
