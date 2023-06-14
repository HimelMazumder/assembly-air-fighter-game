
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.stack 100h

.data 
   doubleLB db 0ah, 0dh, 0ah, 0dh, '$' 
   lineBreakHS db 0ah, 0dh, 0ah, 0dh, 0ah, 0dh, 0ah, 0dh, 0ah, 0dh, 0ah, 0dh, 0ah, 0dh, 0ah, 0dh,'$'
   lineBreakSC db 0ah, 0dh, 0ah, 0dh, 0ah, 0dh, '$'
   
   hs0 db '                                 AIR FIGHTER                 $'
   hs1 db '                   ========================================= $'    
   hs2 db '                              Press SPACE to start           $'
   hs3 db '                             press C to see controls         $' 
   
   
   sc0 db '                                 Controls                 $'
   sc1 db '                   ========================================= $' 
   sc2 db '                                 A --- Move Left             $'   
   sc3 db '                                 D --- Move Right            $'
   sc4 db '                                 W --- Move Forward          $' 
   sc5 db '                                 S --- Move Backward         $'
   sc6 db '                             Left Mouse Button --- Fire      $'
   sc7 db '                             Right Mouse Button --- Bomb     $'
   sc8 db '                         Press SPACE to go to Home Screen    $'    
   
   
   xc dw ?
   yc dw ? 
   
   jetIniPosX dw 145h
   jetIniPosY dw 1a4h
   
   mainJetBodyWidthFactor dw 0h 
 

.code 


proc main
    mov dx, @data
    mov ds, dx
    
              
    call homeScreen  
    
ret    
    
endp main



proc homeScreen
    
    mov ah, 00h
    mov al, 03h
    int 10h    
    
    lea dx, lineBreakHS
    mov ah, 9     
    int 21h
        
    
    lea dx, hs0
    mov ah, 9     
    int 21h 
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h
    
    lea dx, hs1
    mov ah, 9     
    int 21h
    
    lea dx, doubleLB 
    mov ah, 9     
    int 21h
    
    lea dx, hs2
    mov ah, 9     
    int 21h
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h
    
    lea dx, hs3
    mov ah, 9     
    int 21h 
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h
    
    lea dx, hs1
    mov ah, 9     
    int 21h
    
    homeScreenLoop:
        mov ah, 0
        int 16h
        
        cmp al, 20h            
        
            je call setGameScreen 
            
        cmp al, 43h            
            
            je call showControls
            
        cmp al, 63h            
            
            je call showControls
            
        
        jmp homeScreenLoop          
        
    
    ret
    
endp homeScreen 
    
    
    

proc showControls    
        
    mov ah, 00h
    mov al, 03h
    int 10h    
    
    lea dx, lineBreakSC
    mov ah, 9     
    int 21h
    
    lea dx, sc0
    mov ah, 9     
    int 21h 
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h    
    
    lea dx, sc1
    mov ah, 9     
    int 21h 
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h
    
    lea dx, sc2
    mov ah, 9     
    int 21h
    
    lea dx, doubleLB 
    mov ah, 9     
    int 21h
    
    lea dx, sc3
    mov ah, 9     
    int 21h
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h
    
    lea dx, sc4
    mov ah, 9     
    int 21h 
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h  
    
    lea dx, sc5
    mov ah, 9     
    int 21h
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h
    
    lea dx, sc6
    mov ah, 9     
    int 21h 
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h 
    
    lea dx, sc7
    mov ah, 9     
    int 21h 
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h  
    
    lea dx, sc8
    mov ah, 9     
    int 21h 
    
    lea dx, doubleLB
    mov ah, 9     
    int 21h
    
    
    lea dx, sc1
    mov ah, 9     
    int 21h
    
    showControlsLoop:
        
        mov ah, 0
        int 16h 
        
        cmp al, 20h             
            je call homeScreen
            
        jmp showControlsLoop
        
    ret
endp showControls

proc setGameScreen
   
    
    mov ah, 00h
    mov al, 12h
    int 10h
    
        
    call startGame
    
    ret
    
endp setGameScreen



proc startGame 
    
    call drawMainJet
    
       
    ret
endp startGame





proc drawMainJet
    
    mov cx, jetIniPosX
    mov dx, jetIniPosY
    
    mov bx, jetIniPosy
    add bx, 5
     
    
    mainJetLoop1:
        cmp dx, bx
            jne mainJetLoop1Inner
            je exit
            
        
    mainJetLoop1Inner:
        mov cx, jetIniPosX
        sub cx, mainJetBodyWidthFactor
        
        mov bx, jetIniPosX
        add bx, mainJetBodyWidthFactor 
        
        jmp mainJetLoop2
        
        
    mainJetLoop2:
    
        cmp cx, bx
            je incMainJetLoop1
            jne mainJetLoop2Inner
        
        
    mainJetLoop2Inner:    
        mov ah, 0ch
        mov al, 11 
        int 10h
    
    mainJetLoop2Inc:    
        inc cx
        jmp mainJetLoop2

                  
        
    incMainJetLoop1:
        inc mainJetBodyWidthFactor    
        inc dx
        
        mov bx, jetIniPosy
        add bx, 5 
        
        jmp mainJetLoop1         
        
        
    exit:
    
    mov cx, jetIniPosX
    mov dx, jetIniPosY
    
    mov bx, dx
    add dx, 13
    sub cx, 12
    
    
    leftGun:
        mov ah, 0ch
        mov al, 11 
        int 10h
        
        dec dx
        cmp dx, bx
            jne leftGun
            
            
            
    mov cx, jetIniPosX
    mov dx, jetIniPosY
    
    mov bx, dx
    add dx, 13
    add cx, 12
    
    
    rightGun:
        mov ah, 0ch
        mov al, 11 
        int 10h
        
        dec dx
        cmp dx, bx
            jne rightGun
            
        
    mov cx, jetIniPosX
    mov dx, jetIniPosY
    
    
    mov ax, 0
    int 33h ;mouse set up 
    
    
                
    doFire:
        
    
        mov ax, 3 ;to get coordinates of  
        int 33h
            
        cmp bx, 1
            je call fire
            
            
            
            
    fire:

    add cx, 12
    mov dx, jetIniPosY
    
    add dx, 3
    
    rightGunFire:
        mov ah, 0ch
        mov al, 12 
        int 10h
        
        dec dx
        cmp dx, -1
            jne rightGunFire 
        
    
    
    
    sub cx, 12
    mov dx, jetIniPosY
    
    add dx, 3 
    
    leftGunFire:
        mov ah, 0ch
        mov al, 12 
        int 10h
        
        dec dx
        cmp dx, 0
            jne rightGunFire
    
         
    jmp doFire     
     

    
    ret
endp drawMainJet




    
    




