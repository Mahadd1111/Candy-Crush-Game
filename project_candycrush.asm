;COAL PROJECT MAHAD AHMED // ALISHBA ASIF --- CANDY CRUSH
.MODEL large
.STACK 100h
.DATA
str1 db "WELCOME TO CANDY CRUSH$"
str2 db "ENTER YOUR NAME:$"
name1 db ?,?,?,?,?,?
count db 0
temp1 dw 0
temp2 dw 0
temp4 dw 0
temp5 dw 0
temp6 dw 0
temp7 dw 0
temp8 dw 0
temp9 dw 0
temp10 dw 0
temp11 dw 0
temp3 db 0
temp12 db 0
count1 db 0
count2 db 0
count3 db 0
count4 dw 0
count5 dw 0
count6 dw 0
count7 dw 0
count8 dw 0
turns dw 0
co dw 0 
co1 dw 0 
co2 dw 0 
row db 0
col dw 0
num db 0
swap1x dw 0
swap1y dw 0
swap1val dw 0
swap2x dw 0
swap2y dw 0
swap2val dw 0
grid db 1,2,3,4,2,1,5
     db	4,3,1,5,2,3,1
     db	2,5,1,4,5,3,1
     db	4,1,2,3,2,4,3
     db	1,5,4,2,3,1,4
     db	2,4,2,4,5,3,1
     db	3,1,5,1,2,4,3
str3 db "IN CURRENT TURN$"
str4 db "IN PLAYING GAME$"
str5 db "UPDATING ARRAY$"
str6 db "BUTTON CLICKED$"
str7 db "IN FIND SWAP 2$"
str8 db "  INSTRUCTIONS  ",'$'
str9 db "SCORE",'$'
str10 db "++",'$'
str11 db "COLOR",'$'
str12 db "BOMB",'$'
str13 db "Press ENTER to play",'$'
str14 db "TARGET: ",'$'
str15 db "MOVES:  ",'$'
str16 db "SCORE:  ",'$'
str17 db "30",'$'
str18 db "User's Name: ",'$'
str19 db "LEVEL FAILED",'$'
str20 db "TRY AGAIN",'$'
str21 db "Out of moves!",'$'
str22 db "ENTER to play again",'$'
str23 db "LEVEL PASSED",'$'
str24 db "PLAY AGAIN!",'$'
randomnumber db 0
killAllShapes db 0
indexToCheck dw 100
index2 dw 100
color db ?
score dw 0
score2 dw 0
turns1 dw 10  
turns2 dw 0 
target dw 30 
moves dw 10 
msg db 3 DUP("$")
msg2 db 3 DUP("$")
f1 db "myfile.txt",0
f2 db "file2.txt",0
.CODE
mov ax,@data
mov ds,ax 

;---------------MAIN FUNCTION------------------------
main proc
call Page1
call instructPage
call page2

mov ah,4ch 
int 21h
main endp
;----------------PAGE 2 FUNCTION----------------------
page2 proc

call setpage2
call fillGrid
mov cx,0
mov dx,60

mov ax,1 ; show mouse
int 33h

.while turns<=10
.if turns1==0 
jmp endgame
.endif
call playGame
call delay
call fillgrid
call delay
.endw

endgame:

call checkScore
ret
page2 endp
;-----------------------------------------------------
;----------------CALL CHECK SCORE---------------------
checkScore proc 

mov bx,target
.if score<=bx
call FailedScreen
.elseif score>=bx 
call PassedScreen
.endif

ret
checkScore endp
;------------------end game display screen------------
PassedScreen proc 
mov dx,0 
mov cx,70
mov temp1,cx
mov count1,0
mov count2,0

.while count1<=200
.while count2<=170
mov ah,0ch
mov al,0ah
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

mov ah,02h 
mov bx,0 
mov dl,13
mov dh,2 
int 10h 
 
mov dx,offset str23 
mov ah,09h 
int 21h 

mov co,0 

mov cx,100
mov al,0eh
again:
mov dx,40
call Makestar
inc co 
cmp co,2
je callagain
add cx,40
mov al,0dh 
jmp again

callagain:
add cx,40 
mov dx,40 
mov al,01h
call MakeStar
jmp exit
;try again candy
exit:
mov cx,100
mov dx,170
call tryAgain

mov ah,02h 
mov bx,0 
mov dl,14
mov dh,22
int 10h

mov dx,offset str24 
mov ah,09h 
int 21h


mov ah,02h 
mov bx,0 
mov dl,10
mov dh,13
int 10h

mov dx,offset str22
mov ah,09h 
int 21h

;-------check enter key is pressed 

L1:
mov ah,0ch
mov al,0
int 21h

mov ah,01h
int 16h

cmp al,13
je exit2
jmp L1

exit2:
mov ah,02h 
mov bx,0 
mov dl,0
mov dh,20
int 10h
 

ret
PassedScreen endp
;------------------end game display screen------------
FailedScreen proc 

mov dx,0 
mov cx,70
mov temp1,cx
mov count1,0
mov count2,0

.while count1<=200
.while count2<=170
mov ah,0ch
mov al,0eh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

mov ah,02h 
mov bx,0 
mov dl,13
mov dh,2 
int 10h 
 
mov dx,offset str19 
mov ah,09h 
int 21h 

mov co,0 

mov cx,100
again:
mov dx,40
mov al,07h
call Makestar
inc co 
cmp co,3 
je exit
add cx,40 
jmp again

;try again candy
exit:
mov cx,100
mov dx,170
call tryAgain

mov ah,02h 
mov bx,0 
mov dl,15
mov dh,22
int 10h

mov dx,offset str20 
mov ah,09h 
int 21h

mov ah,02h 
mov bx,0 
mov dl,13
mov dh,13
int 10h

mov dx,offset str21
mov ah,09h 
int 21h

mov ah,02h 
mov bx,0 
mov dl,10
mov dh,14
int 10h

mov dx,offset str22
mov ah,09h 
int 21h

;-------check enter key is pressed 

L1:
mov ah,0ch
mov al,0
int 21h

mov ah,01h
int 16h

cmp al,13
je exit2
jmp L1

exit2:
mov ah,02h 
mov bx,0 
mov dl,0
mov dh,20
int 10h 


ret
FailedScreen endp 

;-------------------make try again block---------------
tryAgain proc 
mov temp1,cx
mov count1,0
mov count2,0
;count2 250
.while count1<=20
.while count2<=110
mov ah,0ch
mov al,0dh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

;-----------------triangles-------
mov temp2,168
mov count,0
again2:
add temp1,1
mov bx,temp1
mov co,bx
mov bx,temp2 
mov co2,bx
add temp2,18
mov bx,temp2
mov co1,bx

add co2,2
mov dx,co2 

sub co,2
mov cx,co
mov count4,0 
mov count5,0
mov bx,count4
mov temp1,bx

.while count5<=18
.while count4<=10
mov ah,0ch 
mov al,0dh 
int 10h 
inc dx
inc count4
.endw
add temp1,2
mov bx,temp1
mov count4,bx
add co2,1
mov dx,co2
dec cx 
inc count5
.endw

sub co2,8
mov dx,co2
sub co,24
mov cx,co
mov co,0 

inc count 
cmp count,2
je exit2
mov temp2,178
add temp1,62
jmp again2

;-----------------right side triangles--------
exit2:
mov dx,170
mov cx,210
mov count,0 
again3:
mov temp1,cx
mov temp2,dx
mov count4,0 
mov count5,0
mov co,0


.while count5<=10
.while count4<=10
mov ah,0ch 
mov al,0dh
int 10h 
inc dx 
inc count4
.endw
inc cx 
inc count5
add co,2
mov bx,co
mov count4,bx
inc temp2
mov dx,temp2
.endw

inc count
cmp count,2
je exithere
dec temp2
mov dx,temp2 
sub cx,11
jmp again3

exithere:
ret
tryAgain endp
;------------------make star-----------------------
Makestar proc
mov color,al
mov temp1,cx
mov count1,0
mov bl,26
mov count2,0

.while count1<=13
.while count2<=bl
mov ah,0ch
mov al,color
int 10h
inc cx
inc count2
.endw
inc count1
mov count2,0
mov cx,temp1
inc cx
sub bl,2
inc dx
mov temp1,cx
.endw

dec cx
sub dx,18 
mov temp1,cx
mov count1,0 ; 9 times down each time
mov count2,0 ; print uptill bl times
mov bl, 0 ; number of times to print

.while count1<=13
.while count2<=bl
mov ah,0ch
mov al,color
int 10h
inc cx
inc count2
.endw
add bl,2
inc count1
mov count2,0
mov cx,temp1
dec cx
mov temp1,cx
inc dx
.endw



ret
MakeStar endp 
;-----------------------------------------------------
;----------------play game---------------------------
playGame proc

;check button click then go to turn function
start:
mov ax,5
int 33h

cmp ax,1
jne start
call currentTurn
exit:

ret
playGame endp
;----------------------------------------------------
currentTurn proc
;first click and get coordinates of which to swap
mov ax,3
int 33h

mov temp4,dx
mov ax,cx
mov dx,0
mov bx,2
div bx ; QUOTIENT IN AX
mov cx,ax
mov dx,temp4

call findswap1
;when click released get coordinates of swap with

start2:
mov ax,3
int 33h
cmp bl,0
je nextstage
jmp start2
nextstage:

mov ax,6
int 33h

mov temp4,dx
mov ax,cx
mov dx,0
mov bx,2
div bx ; QUOTIENT IN AX
mov cx,ax
mov dx,temp4

call findswap2
call updateArray
call delay
call removeshape
call delay
call fillgrid

call checkCombos
call fillGrid
call delay

call delay
call delay
call delay
call delay
call delay
call delay
call delay 
call delay

call reFillGrid

mov indexToCheck,100
mov index2,100
inc turns

call writeScore
call writeTurns
ret
currentTurn endp
;-----------------------------------------------------------
;--------------------write turns----------------------------
writeTurns proc 
mov si,offset msg2
mov ah,02h ; setting cursor position
mov bx,0
mov dl,25 ;-----row
mov dh,4;-----col
int 10h

call openandprintfile2
call saveturns
call outputtofile2
call closetextfile2
ret
writeTurns endp
;--------------------save turns----------------------------
saveturns proc 
mov count1,0
dec turns1 
mov ax,turns1
mov turns2,ax 
PUSHTURNSTOSTACK:
mov ax,turns2
cmp ax,0
je POPTURNSTACK
mov bl,10 
div bl 
mov dl,ah 
mov dh,0 
push dx 
mov ah,0 
mov turns2,ax 
inc count1 
jmp PUSHTURNSTOSTACK
;---------------------------------------------------------
POPTURNSTACK:
cmp count1,0 
je exit
POP dx 
add dx,48 
mov [si],dl 
inc si
dec count1
jmp POPTURNSTACK
;---------------------------------------------------------
EXIT:
mov dx,offset msg2 
mov ah,09h 
int 21h
 
ret
saveturns endp
;------------------output turns to file2------------------
;---------------------------------------------------------
outputtofile2 proc 

mov dx,offset f2 
mov al,2
mov ah,3dh 
int 21h

mov cx,lengthof msg2
dec cx 

mov bx,ax 
mov dx,offset msg2
mov ah,40h 
int 21h
ret
outputtofile2 endp
;----------------------------------------------------------
;-------------------read from file-------------------------
openandprintfile2 proc 

mov dx,offset f2  ; open file in read mode 
mov al,0 
mov ah,3dh 
int 21h 


mov bx,ax 
mov dx,offset msg2 ;file saved into memory 
mov ah,3fh 
int 21h 

ret
openandprintfile2 endp
;-----------------------------------------------------------
;--------------------closing file--------------------------
closetextfile2 proc 

mov dx,offset f2
mov ah,3eh 
int 21h 
ret
closetextfile2 endp
;--------------------check score----------------------------
writeScore proc 
mov si,offset msg
mov ah,02h ; setting cursor position
mov bx,0
mov dl,25;-----row
mov dh,6;-----col
int 10h


call openandprintfile
mov temp1,215
mov temp2,44
mov cx,temp1
mov dx,temp2
mov count1,0 
mov count2,0
.while count1<=12
.while count2<=17
mov ah,0ch
mov al,0eh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw
call saveScore
call outputtofile
call closetextfile1

ret 
writeScore endp
;--------------------saving SCORE--------------------------
saveScore proc 
mov count1,0
mov ax,score
add score2,ax
PUSHSCORETOSTACK:
mov ax,score2
cmp ax,0
je POPSCORESTACK
mov bl,10 
div bl 
mov dl,ah 
mov dh,0 
push dx 
mov ah,0 
mov score2,ax 
inc count1 
jmp PUSHSCORETOSTACK
;---------------------------------------------------------
POPSCORESTACK:
cmp count1,0 
je exit
POP dx 
add dx,48 
mov [si],dl 
inc si
dec count1
jmp POPSCORESTACK
;---------------------------------------------------------
EXIT:
mov dx,offset msg 
mov ah,09h 
int 21h
 
ret
saveScore endp 
;----------------------------------------------------------
outputtofile proc 

mov dx,offset f1 
mov al,2
mov ah,3dh 
int 21h

mov cx,lengthof msg
dec cx 

mov bx,ax 
mov dx,offset msg
mov ah,40h 
int 21h
ret
outputtofile endp
;-------------------read from file-------------------------
openandprintfile proc 

mov dx,offset f1  ; open file in read mode 
mov al,0 
mov ah,3dh 
int 21h 


mov bx,ax 
mov dx,offset msg ;file saved into memory 
mov ah,3fh 
int 21h 

ret 
openandprintfile endp
;--------------------closing file--------------------------
closetextfile1 proc 

mov dx,offset f1
mov ah,3eh 
int 21h 
ret
closetextfile1 endp

;------------------refill grid-----------------------------
reFillGrid proc
push ax
push bx
push cx
push dx
push si

mov si,0
mov count8,0

.while count8<49

.if grid[si]==20
call randomNumberGenerator
mov bl,randomnumber
mov grid[si],bl

call delay
call delay
call delay
.endif

inc si
inc count8
.endw

call fillGrid

pop si
pop dx
pop cx
pop bx
pop ax
ret
reFillGrid endp
;----------------------------------------------------------
checkBombCombo proc
; INDEXTOCHECK HAS PREVIOUSLY SWAPPED INDEX, WE MUST CHECK IF ITS ADJACENT TO A BOMB (6)
push ax
push bx
push cx
push dx
push si
mov temp3,0

mov si,indextoCheck ; BOMB
mov di,index2  ; SHAPE
mov cl,grid[si]

mov dl,0

.if cl==6
mov grid[si],20
mov dl,grid[di]
mov al,dl
add score,10
call removeAllOccurances

.endif

mov temp3,0
pop si
pop dx
pop cx
pop bx
pop ax
ret
checkBombCombo endp
;----------------------------------------------------------
removeAllOccurances proc
push bx

mov count1,0

;we must traverse grid and wherever there  is al value we make it 20
mov si,0

.while count1<49
mov bl,grid[si]

.if al==bl
mov grid[si],20
.endif

inc si
inc count1
.endw

pop bx
ret
removeAllOccurances endp
;-----------------------------------------------------------
checkCombos proc

mov count6,0

;traverse array horizontally row wise for 7 rows
mov bx,0
.while count6<7
call findRowCombos
add bx,7
inc count6
.endw

call checkBombCombo

;traverse array vertically column wise for 7 cols
mov bx,0
mov count6,0
.while count6<7
call findColCombos
inc count6
inc bx
.endw

call checkBombCombo 
;call fillGrid

ret
checkCombos endp
;------------------------------------------------------------
findColCombos proc
push ax
push cx
push dx
mov count7,0
mov si,0

.while count7<5
mov al,grid[bx+si]
mov cl,grid[bx+si+7]
mov dl,grid[bx+si+14]

.if al==cl && cl==dl && al==dl
mov dl,grid[bx+si]
mov dh,0
add score,dx
mov grid[bx+si],20
mov grid[bx+si+7],20
mov grid[bx+si+14],20
.endif

inc count7
add si,7
.endw

mov count7,0
pop dx
pop cx
pop ax
ret
findColCombos endp
;------------------------------------------------------------
findRowCombos proc
push ax
push cx
push dx
mov count7,0
mov si,0

.while count7<5
mov al,grid[bx+si]
mov cl,grid[bx+si+1]
mov dl,grid[bx+si+2]

.if al==cl && cl==dl && al==dl
mov dl,grid[bx+si]
mov dh,0
add score,dx
mov grid[bx+si],20
mov grid[bx+si+1],20
mov grid[bx+si+2],20
.endif

inc count7
inc si
.endw

mov count7,0
pop dx
pop cx
pop ax
ret
findRowCombos endp
;------------------------------------------------------------
findswap1 proc
; CX CONTAINS X COORDINATES OF CLICK AND DX CONTAINS Y

mov ax,cx
mov bl,45 
div bl ; AL holds col number
mov ah,0
mov swap1y,ax

sub dx,60
mov ax,dx
mov bl,20
div bl ; AL Holds row number
mov ah,0
mov swap1x,ax


ret
findswap1 endp
;----------------------------------------------------
findswap2 proc
; CX CONTAINS X COORDINATES OF CLICK AND DX CONTAINS Y

mov ax,cx
mov bl,45 
div bl ; AL holds col number
mov ah,0
mov swap2y,ax

sub dx,60
mov ax,dx
mov bl,20
div bl ; AL Holds row number
mov ah,0
mov swap2x,ax


ret
findswap2 endp
;----------------------------------------------------
updatearray proc
; WE WANT TO SWAP SWAP1 WITH SWAP2 , WE HAVE ROWS AND COLS FOR BOTH

mov ax,swap1x
mov bl,7
mul bl ; DX AX HOLDS row*7
mov dx,0
mov bx,ax
mov temp1,bx

mov ax,swap1y
mov si,ax
mov temp2,ax

mov ah,0
mov al,grid[bx+si]
mov temp3,al ; TEMP3 HOLDS VAL1
add bx,si
mov indexToCheck,bx
mov bx,0

;NOW FIND SWAP TWO

mov ax,swap2x
mov bl,7
mul bl
mov dx,0
mov bx,ax

mov ax,swap2y
mov si,ax

mov ah,0
mov al,grid[bx+si]
mov temp12,al ;TEMP5 HOLDS VAL2
mov al,temp3
mov grid[bx+si],al
add bx,si
mov index2, bx

mov bx,temp1
mov si,temp2

mov ah,0
mov al,temp12
mov grid[bx+si],al

ret
updatearray endp
;-----------------------------------------------------
randomNumberGenerator proc
push ax
push bx
push cx
push dx

call delay
call delay

mov ah,0h  ; gets system time and clock ticks saved in dx
int 1ah

mov ax,dx
mov dx,0
mov bx,6
div bx

mov randomnumber,dl
inc randomnumber

pop dx
pop cx
pop bx
pop ax
ret
randomNumberGenerator endp
;-----------------------------------------------------
removeshape proc

mov dx,40
mov cx,135
mov ax,4
int 33h


mov count1,0
mov count2,0

mov ax,swap1y
mov bl,45
mul bl 
mov cx,ax ; CX has x coordinate
inc cx
mov temp1,cx

mov ax,swap1x
mov bl,20
mul bl
add ax,61
mov dx,ax ; DX has Y coordinate

.while count1<=18
.while count2<=43
mov ah,0ch
mov al,00h
int 10h
inc count2
inc cx
.endw
mov count2,0
inc dx
mov cx,temp1
inc count1
.endw

mov count1,0
mov count2,0

mov ax,swap2y
mov bl,45
mul bl 
mov cx,ax ; CX has x coordinate
inc cx
mov temp1,cx

mov ax,swap2x
mov bl,20
mul bl
add ax,61
mov dx,ax ; DX has Y coordinate

.while count1<=18
.while count2<=43
mov ah,0ch
mov al,00h
int 10h
inc count2
inc cx
.endw
mov count2,0
inc dx
mov cx,temp1
inc count1
.endw


ret
removeshape endp
;----------------------------------------------------
delay proc
push cx
push dx

mov cx,100
L1:
mov dx,100
L2:
dec dx
cmp dx,0
jne L2
loop L1

pop dx
pop cx

ret
delay endp
;-------------------FILLING THE GRID------------------
fillGrid proc
;WE WILL FILL BY TRAVERSING GRID ARRAY AND CHOOSING

mov ax,0
mov cx,0
mov dx,60
mov temp8,cx
mov temp9,dx
mov temp10,cx
mov temp11,dx

mov si,0
mov bx,0

mov row,0
mov col,0

.while row<7

.while col<7
mov si,col
mov al,row
mov bl,7
mul bl ; we multiply row number * row size and save in bx
mov bx,ax
mov ax,0
mov al,grid[bx + si]

cmp al,1
jne NotOne
add cx,15
add dx,2
call gameCandy1
mov cx,temp8
mov dx,temp9
jmp Next

NotOne:
cmp al,2
jne NotTwo
add cx,5
add dx,3
call gameCandy2
mov cx,temp8
mov dx,temp9
jmp Next

NotTwo:
cmp al,3
jne NotThree
add cx,5
add dx,2
call gameCandy3
mov cx,temp8
mov dx,temp9
jmp Next

NotThree:
cmp al,4
jne NotFour
add cx,22
add dx,1
call gameCandy4
mov cx,temp8
mov dx,temp9
jmp Next

NotFour:
cmp al,5
jne NotFive
add cx,15
add dx,2
call gameCandy5
mov cx,temp8
mov dx,temp9
jmp Next

NotFive:
cmp al,6
jne NotSix
call gameCandyBomb
mov cx,temp8
mov dx,temp9

NotSix:
cmp al,20
jne Next
call emptyBox
mov cx,temp8
mov dx,temp9

Next:
mov cx,temp8
mov dx,temp9
inc col
add cx,45
mov temp8,cx
.endw

mov cx,temp10
mov dx,temp11
inc row
add dx,20
mov temp10,cx
mov temp11,dx
mov temp8,cx
mov temp9,dx
mov col,0
.endw

ret
fillGrid endp
;----------------FUNCTION FOR INSTRUCTIONS PAGE-----------
instructPage proc 

mov ah,06h 
mov al,0 
mov cx,0 
mov dh,80  ;X COORDINATE
mov dl,80  ;Y COORDINATE
mov bh,03h 
int 10h 

mov ah,02h ; setting new cursor position
mov bx,0 
mov dh,1   ;row
mov dl,53  ;col
int 10h

mov ah,09
mov dx,offset str8 ; instructions message
int 21h

call setInstructpage
ret
instructPage endp
;-----------------SETTING INSTRUCTIONS PAGE----------
setInstructpage proc 
mov cx,50
mov dx,30
mov co,0
again:
call gameCandy2 
inc co 
cmp co,3
je jumphere
mov dx,30
add cx,50
jmp again 

jumphere: 
mov co,0 
add cx,60
mov dx,35
again2:
call drawEqual

inc co 
cmp co,2 
je jumphere2
sub cx,23
add dx,5 
jmp again2


jumphere2:
mov temp3,32 
mov temp12,4
call setCursor

mov cx,50
mov dx,60
mov co,0
again3: 
call gameCandy2
inc co 
cmp co,3 
je jumphere3
add dx,5 
mov cx,50 
jmp again3

jumphere3:
mov co,0 
add cx,8
add dx,178
again4:
call drawEqual 
inc co
cmp co,2  
je jumphere4
sub cx,23
sub dx,5
jmp again4 

jumphere4:
mov temp3,21
mov temp12,10
call setCursor


mov cx,50
mov dx,135
call makecolorbomb

mov cx,120
mov dx,150
call drawEqual

mov cx,120
mov dx,155 
call drawEqual

mov ah,02h ; setting cursor position
mov bx,0
mov dl,21 ;-----row
mov dh,18 ;-----col
int 10h

mov ah,09
mov dx,offset str11 ; color message
int 21h

mov ah,02h ; setting cursor position
mov bx,0
mov dl,21 ;-----row
mov dh,19 ;-----col
int 10h

mov ah,09
mov dx,offset str12 ; bomb message
int 21h

mov cx,300
mov dx,165
call nextCandy1

mov ah,02h ; setting cursor position
mov bx,0
mov dl,18 ;-----row
mov dh,22;-----col
int 10h

mov ah,09
mov dx,offset str13 ; enter to play message
int 21h

;-------check enter key is pressed 

L1:
mov ah,0ch
mov al,0
int 21h

mov ah,01h
int 16h

cmp al,13
je exit
jmp L1

exit:
mov ah,02h ; setting cursor position
mov bx,0
mov dl,9 ;-----row
mov dh,23;-----col
int 10h


ret
setInstructpage endp
;-----------draw equals sign--------------
drawEqual proc 

mov temp1,cx
mov count1,0

.while count1<=22
mov ah,0ch
mov al,01h
int 10h
inc cx
inc count1
.endw

ret
drawEqual endp 
;-------------------set cursor-------------------
setCursor proc  
mov ah,02h ; setting cursor position
mov bx,0
mov dl,temp3 ;-----row
mov dh,temp12 ;-----col
int 10h

mov ah,09
mov dx,offset str9 ; score message
int 21h

mov ah,02h ; setting cursor position
mov bx,0
mov dl,temp3 ;-----row
inc temp12
mov dh,temp12 ;-----col
int 10h

mov ah,09h
mov dx,offset str10 ;++ message 
int 21h

mov ah,02h ; setting cursor position
mov bx,0
mov dl,15 ;-----row
mov dh,15 ;-----col
int 10h

ret
setCursor endp 
;-----------------SETTING PAGE 2----------------------
setpage2 proc

mov ah,06h ;
mov al,0
mov cx,0
mov dh,200
mov dl,200
mov bh,00h ;change page 2 color 
int 10h

mov cx,0
mov dx,60

mov count1,0
mov count4,0
.while count1<=7
.while count4<=315
mov ah,0ch
mov al,0fh
int 10h
inc cx
inc count4
.endw
mov cx,0
add dx,20
mov count4,0
inc count1
.endw

mov cx,0 
mov dx,60

mov count1,0
mov count4,0
.while count1<=7
.while count4<=140
mov ah,0ch
mov al,0fh
int 10h
inc dx
inc count4
.endw
inc count1
mov dx,60
add cx,45
mov count4,0
.endw

;-------------make rectangle on top 
mov dx,0 
;mov cx,35
mov cx,70
call scoreBoard 
 
mov ah,02h ; setting new cursor position
mov bx,0 
mov dh,1
mov dl,1
int 10h


ret
setpage2 endp
;-----------------make scoreboard---------------------
scoreBoard proc 
mov temp1,cx
mov count1,0
mov count2,0
;count2 250
.while count1<=58
.while count2<=170
mov ah,0ch
mov al,0eh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw
 
mov ah,02h ; setting cursor position
mov bx,0
mov dl,12 ;-----row
mov dh,0;-----col
int 10h

mov ah,09
mov dx,offset str18 ; user's name message
int 21h

;--------displaying users name
mov ah,09h 
mov dx,offset name1
int 21h

mov ah,02h ; setting cursor position
mov bx,0
mov dl,12 ;-----row
mov dh,2;-----col
int 10h

mov ah,09
mov dx,offset str14 ; target message
int 21h
 
mov ah,02h ; setting cursor position
mov bx,0
mov dl,12 ;-----row
mov dh,4;-----col
int 10h

mov ah,09
mov dx,offset str15 ; moves message
int 21h

mov ah,02h ; setting cursor position
mov bx,0
mov dl,12 ;-----row
mov dh,6;-----col
int 10h

mov ah,09
mov dx,offset str16 ; score message
int 21h


mov ah,02h ; setting cursor position
mov bx,0
mov dl,25 ;-----row
mov dh,2;-----col
int 10h

mov ah,09
mov dx,offset str17 ; target number message
int 21h
ret
scoreBoard  endp
;----------------PAGE 1 FUNCTION----------------------
page1 proc

call setpage1
call yellowcandy1
call magentacandy1
call graycandy1
mov cx,55
mov dx,93
call nextcandy1
call greencandy1
call bluecandy1
mov cx,149
mov dx,164
call makecolorbomb
mov cx,50
mov dx,50
;call gamecandy4
call inputName
ret
page1 endp
;-----------------SETTING PAGE 1----------------------
setPage1 proc

mov ah,00h ; setting video mode and grid size
mov al,13h 
int 10h

mov ah,06h ; setting cyan background colour
mov al,0
mov cx,0
mov dh,200
mov dl,200
mov bh,08h ;change page 1 color 
int 10h

mov ah,02h ; setting new cursor position
mov bx,0 
mov dh,8
mov dl,10
int 10h

print:
mov ah,09
mov dx,offset str1 ; welcome message
int 21h

ret
setPage1 endp
;----------------INPUT NAME FUNCTION------------------
inputName proc

mov ah,02h ; setting cursor position
mov bx,0
mov dh,13
mov dl,10
int 10h

mov dx,offset str2
mov ah,09
int 21h

mov ah,02h ; setting cursor position
mov bx,0
mov dh,15
mov dl,10
int 10h

mov si,offset name1
startInput:

mov ah,01
int 21h

cmp al,13
je endInput
mov [si],al
inc si
jmp startInput

endInput:
mov byte ptr [si],'$'
ret
inputName endp
;----------------DISPLAY NAME-------------------------
displayName proc
mov ah,02h ; setting cursor position
mov bx,0
mov dh,17
mov dl,10
int 10h

mov dx,offset name1
mov ah,09
int 21h

ret
displayName endp
;--------------------------------------------------
emptyBox proc
; CX DX CONTAIN COORDINATES
inc cx
inc dx
mov temp1,cx
mov count1,0
mov count2,0

.while count1<=18
.while count2<=43
mov ah,0ch
mov al,00h
int 10h
inc count2
inc cx
.endw
mov count2,0
inc dx
mov cx,temp1
inc count1
.endw

ret
emptyBox endp
;---------------------YELLOW CANDY 1----------------------
yellowcandy1 proc

mov cx,250 ; x coordinate  
mov co1,150 
mov co2,200 ;y coordinate
mov dx,co1

startfunction:
cmp count,32
je stopfunction

mov ah,0
mov al,count
mov bl,5
div bl ; ah=rem
cmp ah,0
je PRINTWHITE

.while dx<=co2
mov ah,0ch
mov al,0eh
int 10h
inc dx
.endw
inc cx
mov dx,co1 
inc count
jmp startfunction

PRINTWHITE:
.while dx<=co2
mov ah,0ch
mov al,0fh
int 10h
inc dx
.endw
inc cx
mov dx,co1
inc count
jmp startfunction

stopfunction:
inc co 
mov count,0
cmp co,2
je exit
jmp startfunction2

startfunction2:
mov cx,50
mov co1,150
mov co2,200
mov dx,co1
jmp startfunction 

exit:
ret
yellowcandy1 endp
;--------------DRAWS THE Magenta CANDY------------------
magentacandy1 proc

mov co,0 
mov cx,82
here:
mov dx,170
mov temp1,cx
mov count1,0
mov count2,0

.while count1<=30
.while count2<=30
mov ah,0ch
mov al,05h
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

inc co
cmp co,2
je exit
mov cx,219
jmp here

exit:
ret
magentacandy1 endp
;------------------DRAWS THE GRAY CANDY--------------
graycandy1 proc 

mov co,0
mov cx,128
here:
mov dx,170
mov temp1,cx
mov count1,0 ; 9 times down each time
mov count2,0 ; print uptill bl times
mov bl, 0 ; number of times to print

.while count1<=14
.while count2<=bl
mov ah,0ch
mov al,07h
int 10h
inc cx
inc count2
.endw
add bl,2
inc count1
mov count2,0
mov cx,temp1
dec cx
mov temp1,cx
inc dx
.endw

mov temp1,cx
mov count1,0
mov bl,30
mov count2,0
.while count1<=14
.while count2<=bl
mov ah,0ch
mov al,07h
int 10h
inc cx
inc count2
.endw
inc count1
mov count2,0
mov cx,temp1
inc cx
sub bl,2
inc dx
mov temp1,cx
.endw


SeconndDiamond:
inc co
mov cx,203
cmp co,2
je exit
jmp here

exit:
ret
graycandy1 endp
;-----------------DRAWS THE GREEN CANDY---------------
greencandy1 proc
mov cx,18
mov co,0
tostart:
mov dx,183
mov temp1,cx
mov count1,0 ; 15 times down
mov count2,0 ; print uptill bl in x direction
mov bl,30 ; initially 30 decreases by 2 each time

.while count1<=15
.while count2<=bl
mov ah,0ch
mov al,0ah
int 10h
inc cx
inc count2
.endw
inc dx
mov count2,0
sub bl,2
mov cx,temp1
inc cx
mov temp1,cx
inc count1
.endw
jmp SecondTriangle 

SecondTriangle: 
inc co 
mov cx,282
cmp co,2
je exit
jmp tostart
exit:
ret
greencandy1 endp
;------------------------------------------------------------
;-----------------------DRAW THE blue CANDY------------------
bluecandy1 proc 
mov cx,108
mov dx,144
mov co,0 

here:
mov temp1,cx
mov temp2,dx
mov count1,0
mov count2,0

.while count1<=20
.while count2<=20
mov ah,0ch
mov al,01h
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

;-----------small squares
mov cx,temp1
mov dx,temp2
mov count1,0 
mov count2,0
.while count1<=8
.while count2<=8
mov ah,0ch
mov al,0fh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

add temp1,6
mov cx,temp1
add temp2,6
mov dx,temp2
mov count1,0 
mov count2,0
.while count1<=8
.while count2<=8
mov ah,0ch
mov al,0fh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

add temp1,6
mov cx,temp1
add temp2,6
mov dx,temp2
mov count1,0 
mov count2,0
.while count1<=8
.while count2<=8
mov ah,0ch
mov al,0fh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

inc co 
cmp co,2 
je exit
mov cx,209
mov dx,144
jmp here
exit:
ret
bluecandy1 endp
;-------------------MAKE COLOR BOMB FUNCTION ---------
makecolorbomb proc 
mov co,0 
mov temp2,dx
;mov cx,149

;mov dx,164
mov temp1,cx
mov count1,0
mov count2,0

.while count1<=35
.while count2<=33
mov ah,0ch
mov al,0fh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw


;-----------green 
inc temp1
mov cx,temp1
;mov cx,150
mov co,0
tostart:
mov dx,temp2
mov temp1,cx
mov count1,0 ; 15 times down
mov count2,0 ; print uptill bl in x direction
mov bl,32 ; initially 30 decreases by 2 each time

.while count1<=16
.while count2<=bl
mov ah,0ch
mov al,0ah
int 10h
inc cx
inc count2
.endw
inc dx
mov count2,0
sub bl,2
mov cx,temp1
inc cx
mov temp1,cx
inc count1
.endw

;----------gray
dec temp1
mov cx,temp1
add temp2,18
mov dx,temp2
;mov cx,166
;mov dx,182
mov temp1,cx
mov count1,0 ; 9 times down each time
mov count2,0 ; print uptill bl times

mov bl, 0 ; number of times to print

.while count1<=17
.while count2<=bl
mov ah,0ch
mov al,07h
int 10h
inc cx
inc count2
.endw
add bl,2
inc count1
mov count2,0
mov cx,temp1
dec cx
mov temp1,cx
inc dx
.endw

;---------------magenta
inc temp1
mov cx,temp1
mov co,cx

add temp2,20
mov bx,temp2
mov co2,bx

sub temp2,39
mov bx,temp2
mov co1,bx
;mov co1,163
;mov co2,201
mov dx,co1

L4:
.while dx<=co2
mov ah,0ch
mov al,05h
int 10h
inc dx
.endw
inc co
inc co1
dec co2
mov cx,co
mov dx,co1
cmp co2,91
je toyellow
Loop L4

;---------------------yellow
toyellow:
add temp1,36
mov bx,temp1
mov co,bx

dec temp2
mov bx,temp2 
mov co2,bx
add temp2,18
mov bx,temp2
mov co1,bx

add co2,2
mov dx,co2 

sub co,2
mov cx,co
mov count4,0 
mov count5,0
mov bx,count4
mov temp1,bx

.while count5<=18
.while count4<=34
mov ah,0ch 
mov al,0eh 
int 10h 
inc dx
inc count4
.endw

add temp1,2
mov bx,temp1
mov count4,bx
add co2,1
mov dx,co2
dec cx 
inc count5
.endw

sub co2,8
mov dx,co2
sub co,24
mov cx,co
mov co,0 

here:
mov temp1,cx
mov temp2,dx
mov count1,0
mov count2,0

.while count1<=15
.while count2<=15
mov ah,0ch
mov al,01h
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

exit:
ret
makecolorbomb endp
;------------------DRAWS THE next CANDY---------------
nextcandy1 proc
mov temp1,cx
mov temp2,dx
mov bl,count
mov temp3,bl

startmaking:
cmp count2,15
je endmaking2
.while count<=bl
mov ah,0ch
mov al,0fh
int 10h
inc dx
dec cx
inc count
.endw
mov count,0
inc temp1
inc temp2
mov cx,temp1
mov dx,temp2
inc bl
inc count2
jmp startmaking

endmaking:
mov count,0
mov count2,0
startmaking2:
cmp count2,15
je endmaking2
.while count<=bl
mov ah,0ch
mov al,09h
int 10h
inc dx
dec cx
inc count
.endw
mov count,0
dec temp1
dec temp2
mov cx,temp1
mov dx,temp2
dec bl
inc count2
jmp startmaking2

endmaking2:

ret
nextcandy1 endp
;--------------------DRAWINGMagentaSQUARE---------------------------
gameCandy1 proc
;BEFORE CALLING CX AND DX CONTAIN X-Y COORDINATES

mov temp1,cx
mov count1,0
mov count2,0

.while count1<=15
.while count2<=15
mov ah,0ch
mov al,05h
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

ret
gameCandy1 endp
;---------------------DRAWINGYELLOWRECTANGLE-----------------------------
gameCandy2 proc
;BEFORE CALLING CX AND DX CONTAIN X-Y COORDINATES

mov temp1,cx
mov count1,0
mov count2,0

.while count1<=15

mov ah,0
mov al,count1
mov bl,5
div bl ; ah=rem
cmp ah,0
je SETWHITE
mov al,0eh
jmp SKIP

SETWHITE:
mov al,0fh

SKIP:

.while count2<=35
mov ah,0ch
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
inc count1
mov count2,0
.endw

ret
gamecandy2 endp
;-------------------------------DRAWING Green TRIANGLE ------------------------------
gameCandy3 proc
;BEFORE CALLING CX AND DX CONTAIN X AND Y COORDINATES

mov temp1,cx
mov count1,0 ; 15 times down
mov count2,0 ; print uptill bl in x direction
mov bl,30 ; initially 30 decreases by 2 each time

.while count1<=15
.while count2<=bl
mov ah,0ch
mov al,0ah
int 10h
inc cx
inc count2
.endw
inc dx
mov count2,0
sub bl,2
mov cx,temp1
inc cx
mov temp1,cx
inc count1
.endw

ret
gameCandy3 endp
;---------------------------------DRAWING Gray DIAMOND---------------------------------
gameCandy4 proc
;BEFORE CALLING CX AND DX CONTAIN X AND Y COORDINATES

mov temp1,cx
mov count1,0 ; 9 times down each time
mov count2,0 ; print uptill bl times
mov bl, 0 ; number of times to print

.while count1<=9
.while count2<=bl
mov ah,0ch
mov al,07h
int 10h
inc cx
inc count2
.endw
add bl,2
inc count1
mov count2,0
mov cx,temp1
dec cx
mov temp1,cx
inc dx
.endw

mov temp1,cx
mov count1,0
mov bl,20
mov count2,0

.while count1<=9
.while count2<=bl
mov ah,0ch
mov al,07h
int 10h
inc cx
inc count2
.endw
inc count1
mov count2,0
mov cx,temp1
inc cx
sub bl,2
inc dx
mov temp1,cx
.endw

ret
gameCandy4 endp
;-------------------------------------DRAWING COLOUR BOMB IN GRID------------------------------------------
gameCandyBomb proc
;CX DX COORDINATES OF TOPCORNER ARE SET

mov temp6,cx
mov temp7,dx
call cleangridsquare
mov cx,temp6
mov dx,temp7
add cx,22
add dx,10
mov temp2,dx
mov temp1,cx
mov temp4,cx
mov temp5,dx
mov count1,0
mov count2,0

;printing bottom triangle
mov cx,temp1
mov dx,temp2
mov count1,0
mov count2,0
mov bl,0

.while count1<=10
.while count2<=bl
mov ah,0ch
mov al,07h
int 10h
inc count2
inc cx
.endw
mov count2,0
add bl,4
mov cx,temp4
sub cx,2
mov temp4,cx
inc dx
inc count1
.endw

;printing top triangle
mov cx,temp1
mov dx,temp2
mov temp4,cx
mov temp5,dx

mov count1,0
mov count2,0
mov bl,0

.while count1<=10
.while count2<=bl
mov ah,0ch
mov al,0Ah
int 10h
inc count2
inc cx
.endw
mov count2,0
mov cx,temp4
sub cx,2
add bl,4
mov temp4,cx
dec dx
inc count1
.endw

;printing left triangle
mov cx,temp6
add cx,2
mov temp6,cx
mov dx,temp7
mov temp4,cx

mov count1,0
mov count2,0
mov bl,0

.while count1<=10
.while count2<=bl
mov ah,0ch
mov al,05h
int 10h
inc count2
inc cx
.endw
mov count2,0
mov cx,temp4
inc dx
mov temp4,cx
add bl,2
inc count1
.endw

mov count1,0
mov count2,0
mov bl,20

.while count1<=10
.while count2<=bl
mov ah,0ch
mov al,05h
int 10h
inc count2
inc cx
.endw
mov count2,0
mov cx,temp4
inc dx
mov temp4,cx
sub bl,2
inc count1
.endw

;print right triangle
mov cx,temp6
add cx,41
mov dx,temp7
mov temp4,cx
mov count1,0
mov count2,0
mov bl,0

.while count1<=10
.while count2<=bl
mov ah,0ch
mov al,0eh
int 10h
inc count2
dec cx
.endw
mov count2,0
mov cx,temp4
inc dx
add bl,2
inc count1
.endw

mov count1,0
mov count2,0
mov bl,20

.while count1<=10
.while count2<=bl
mov ah,0ch
mov al,0eh
int 10h
inc count2
dec cx
.endw
mov count2,0
mov cx,temp4
inc dx
sub bl,2
inc count1
.endw

sub dx,16
sub cx,26
mov temp1,cx
mov temp2,dx
mov count1,0
mov count2,0

.while count1<=10
.while count2<=11
mov ah,0ch
mov al,01h
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

ret
gameCandyBomb endp
;---------------------------------------------------Cleans the grid Square--------------------------------------------
cleangridsquare proc
;CX AND DX COORDINATES SENT AND CALLED
add cx,1
add dx,1
mov count1,0
mov count2,0
mov temp1,cx
mov temp2,dx

.while count1<=18
.while count2<=43
mov ah,0ch
mov al,00h
int 10h
inc count2
inc cx
.endw
mov count2,0
mov cx,temp1
inc dx
inc count1
.endw

ret
cleangridsquare endp
;---------------------------------------------DRAWING FANCY CANDY---------------------------------------------------------
gameCandy5 proc
;CX DX CONTAIN X Y COORDINATES

mov temp1,cx
mov temp2,dx
mov count1,0
mov count2,0

.while count1<=15
.while count2<=15
mov ah,0ch
mov al,01h
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw
;-----------small squares
mov cx,temp1
mov dx,temp2
mov count1,0 
mov count2,0
.while count1<=5
.while count2<=5
mov ah,0ch
mov al,0fh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

add temp1,5
mov cx,temp1
add temp2,5
mov dx,temp2
mov count1,0 
mov count2,0
.while count1<=5
.while count2<=5
mov ah,0ch
mov al,0fh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw

add temp1,5
mov cx,temp1
add temp2,5
mov dx,temp2
mov count1,0 
mov count2,0
.while count1<=5
.while count2<=5
mov ah,0ch
mov al,0fh
int 10h
inc cx
inc count2
.endw
mov cx,temp1
inc dx
mov count2,0
inc count1
.endw


ret
gameCandy5 endp
;-------------------------------------------------------------------------------------------------------------------------
end