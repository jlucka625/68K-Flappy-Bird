*-----------------------------------------------------------
* Title      : Flappy Bird
* Written by : Jonathan Lucka
* Date       : 10/4/2015
* Description: 
*-----------------------------------------------------------
        INCLUDE 'equates.x68'
        
START   ORG     $1000

        *setting window resolution
        move.b  #SET_OUTPUT_RESOLUTION_TRAP_CODE,d0
        move.l  #OUTPUT_WIDTH,d1
        swap.w  d1
        move.w  #OUTPUT_HEIGHT,d1
        TRAP    #15
    
        *set double buffered mode
      	move.b	#DRAWING_MODE_TRAP_CODE,d0
      	move.b	#DOUBLE_BUFFERED_MODE,d1
      	trap	#15    

beginGame:      	    
        *a5 will be designated specifically for storing image addresses when we call drawBitmap
        lea     Background,a5
        move.l  #0, -(sp)   
        move.l  #0, -(sp)     
        move.l  #OUTPUT_WIDTH, -(sp)   
        move.l  #OUTPUT_HEIGHT, -(sp) 
        jsr     drawBitmap              
        add     #16,sp   

        lea     ScorePanel,a5
        move.l  #OUTPUT_WIDTH, -(sp)   
        move.l  #0, -(sp)     
        move.l  #SCORE_PANEL_WIDTH, -(sp)
        move.l  #SCORE_PANEL_HEIGHT, -(sp) 
        jsr     drawBitmapWithTransparency              
        add     #16,sp 

        lea     AnimationFrameTable,a6   
        lea     BirdSpriteWingHigh,a5
        jsr     drawBird
        jsr     drawPipes
        jsr     swapBuffers
        
*don't want to start the game until after the player
*presses the space bar
waitForSpace:
        move.l  #SPACEBAR_INPUT,d1
        move.b  #READ_INPUT_COMMAND,d0
        TRAP    #15
        andi.l  #$FF,d1
        beq     waitForSpace
        move.b  #0,HAVE_HAD_NO_INPUT
      	
gameLoop:
        jsr     getTimeInD7
        jsr     checkInput
        jsr     updateBird
        jsr     updatePipes
        jsr     checkCollisions
       	jsr     clearObjects
        jsr     drawBird
        jsr     drawPipes
        jsr     getDeltaTime
        addi.l  #1,animFrameCount
        jsr     swapBuffers
        bra     gameLoop
        
getTimeInD7:
        move.b  #GET_TIME_COMMAND,d0
        TRAP    #15
        move.l  d1,d7 
        rts  
        
*gets difference in time from D7 and then stores it in global variable
getDeltaTime:
        move.b  #GET_TIME_COMMAND,d0
        TRAP    #15
        sub.l   d7,d1
        move.l  d1, DELTA_TIME
        rts
        
*clears invalid rectangles for the bird and pipes
clearObjects:
        *inval rect for the bird sprite
        lea     Background,a5
        move.l  #PLAYER_X, -(sp)         
        *using fixed point math on the y value
        move.l  PREVIOUS_Y,d0
        asr.l   #8,d0
        move.l  d0, -(sp)                
        move.l  #PLAYER_WIDTH, -(sp)      
        move.l  #PLAYER_HEIGHT, -(sp)   
        jsr     drawBitmap            
        add     #16,sp  
 
        *since the background behind the upper pipes is all the same color,
        *we will just draw a rectangle of that color to refresh the top part
        *of the screen, rather than wasting the time to draw the inval rects.
        move.l  #SKYBLUE,d1
        move.l  #PEN_COLOR_TRAP_CODE,d0
        TRAP    #15
        move.l  #SET_FILL_COLOR_COMMAND,d0
        TRAP    #15
        
        move.l  #0,d1
        move.l  #0,d2
        move.l  #(OUTPUT_WIDTH-1),d3
        move.l  #LONG_PIPE_HEIGHT,d4
        
        move.b  #DRAW_RECT_COMMAND,d0
        TRAP    #15

        move.l  INVAL_RECT_WIDTH,d1
        cmpi.l  #MINIMUM_INVAL_RECT_WIDTH,d1
        bgt     erasePipes
        move.l  #MINIMUM_INVAL_RECT_WIDTH,d1

erasePipes:        
        *inval rects for the lower pipes
        move.l  PIPE_SET_1_X,d0
        addi.l  #PIPE_WIDTH,d0
        addi.l  #PIPE_STROKE_WIDTH,d0
        move.l  d0, -(sp)
        move.l  LOWER_PIPE_1_Y, -(sp)
        move.l  d1,-(sp)
        move.l  LOWER_PIPE_1_HEIGHT, -(sp) 
        jsr     drawBitmap              
        add     #16,sp 
       
        move.l  PIPE_SET_2_X,d0
        addi.l  #PIPE_WIDTH,d0
        addi.l  #PIPE_STROKE_WIDTH,d0
        move.l  d0, -(sp)
        move.l  LOWER_PIPE_2_Y, -(sp)
        move.l  d1,-(sp)
        move.l  LOWER_PIPE_2_HEIGHT, -(sp)       
        jsr     drawBitmap              
        add     #16,sp   

        move.l  PIPE_SET_3_X,d0
        addi.l  #PIPE_WIDTH,d0
        addi.l  #PIPE_STROKE_WIDTH,d0
        move.l  d0, -(sp)
        move.l  LOWER_PIPE_3_Y, -(sp)
        move.l  d1,-(sp)
        move.l  LOWER_PIPE_3_HEIGHT, -(sp)       
        jsr     drawBitmap              
        add     #16,sp         
        
        jsr     scoreInvalRect  
     
        rts
        
*adjusts bird's velocity if up arrow key was pressed and also de-bounces
*input on the up key
checkInput:
        move.l  #SPACEBAR_INPUT,d1
        move.b  #READ_INPUT_COMMAND,d0
        TRAP    #15
        andi.l  #$FF,d1
        beq     noInput
        
        move.b  HAVE_HAD_NO_INPUT,d0
        beq     aroundNoInput
        move.b  #0,HAVE_HAD_NO_INPUT
        
        lea     JumpSound,a1
        move.l  #PLAY_SOUND_COMMAND,d0
        TRAP    #15
        move.l  #JUMP_VELOCITY,VELOCITY_Y
        
        bra     aroundNoInput
noInput:
        move.b  #1,HAVE_HAD_NO_INPUT
aroundNoInput: 
        rts
        
        
swapBuffers:
	    move.b  #REPAINT_SCREEN_TRAP_CODE,d0
      	TRAP    #15   
        rts       

*calculates new x position for each pipe based on velocity * deltaTime
updatePipes:     
        move.l  DELTA_TIME,d0
        move.l  #PIPE_SPEED,d1
        mulu    d1,d0
        
        *how far the pipes moves is based on delta time, so we will store that
        *for when we calculate the inval rect
        move.l  d0, INVAL_RECT_WIDTH
        
        sub.l  d0, PIPE_SET_3_X
        sub.l  d0, PIPE_SET_2_X
        sub.l  d0, PIPE_SET_1_X
        
        cmpi.l  #(LEFT_EDGE_OF_SCREEN),PIPE_SET_3_X
        blt     resetPipe3  

        cmpi.l  #(LEFT_EDGE_OF_SCREEN),PIPE_SET_2_X
        blt     resetPipe2
        
        cmpi.l  #(LEFT_EDGE_OF_SCREEN),PIPE_SET_1_X
        blt     resetPipe1
        
        rts
        
*gets a random number (0-255). If the number is above 170, then there is a high gap between
*the pipes. If the number is between 85 and 170, then there is a gap directly in the center,
*and below 85 is a low gap. This process is done for each of the three pipes
resetPipe1:
        jsr     seedRandomNumber
        jsr     getRandomByteIntoD6
        cmpi.b  #HIGH_RANDOM_BOUND,d6
        bgt     highGap1
        cmpi.b  #MED_RANDOM_BOUND,d6
        bgt     medGap1
        
lowGap1:
        move.l  #LONG_PIPE_HEIGHT, UPPER_PIPE_1_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+LONG_PIPE_HEIGHT),LOWER_PIPE_1_Y
        move.l  #SHORT_PIPE_HEIGHT, LOWER_PIPE_1_HEIGHT
        jmp     resetX1
        
highGap1:
        move.l  #SHORT_PIPE_HEIGHT, UPPER_PIPE_1_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+SHORT_PIPE_HEIGHT),LOWER_PIPE_1_Y
        move.l  #LONG_PIPE_HEIGHT, LOWER_PIPE_1_HEIGHT
        jmp     resetX1
        
medGap1:
        move.l  #MED_PIPE_HEIGHT, UPPER_PIPE_1_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+MED_PIPE_HEIGHT),LOWER_PIPE_1_Y
        move.l  #MED_PIPE_HEIGHT, LOWER_PIPE_1_HEIGHT
        
resetX1:
        lea     ScoreSound,a1
        move.l  #PLAY_SOUND_COMMAND,d0
        TRAP    #15
        addi.l  #1,SCORE
        move.l  #(RIGHT_EDGE_OF_SCREEN),PIPE_SET_1_X
        rts
        
resetPipe2:
        jsr     getRandomByteIntoD6
        cmpi.b  #HIGH_RANDOM_BOUND,d6
        bgt     highGap2
        cmpi.b  #MED_RANDOM_BOUND,d6
        bgt     medGap2
        
lowGap2:
        move.l  #LONG_PIPE_HEIGHT, UPPER_PIPE_2_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+LONG_PIPE_HEIGHT),LOWER_PIPE_2_Y
        move.l  #SHORT_PIPE_HEIGHT, LOWER_PIPE_2_HEIGHT
        jmp     resetX2
        
highGap2:
        move.l  #SHORT_PIPE_HEIGHT, UPPER_PIPE_2_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+SHORT_PIPE_HEIGHT),LOWER_PIPE_2_Y
        move.l  #LONG_PIPE_HEIGHT, LOWER_PIPE_2_HEIGHT
        jmp     resetX2
        
medGap2:
        move.l  #MED_PIPE_HEIGHT, UPPER_PIPE_2_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+MED_PIPE_HEIGHT),LOWER_PIPE_2_Y
        move.l  #MED_PIPE_HEIGHT, LOWER_PIPE_2_HEIGHT 
        
resetX2:
        lea     ScoreSound,a1
        move.l  #PLAY_SOUND_COMMAND,d0
        TRAP    #15
        addi.l  #1,SCORE
        move.l  #(RIGHT_EDGE_OF_SCREEN),PIPE_SET_2_X
        rts
        
resetPipe3:
        jsr     getRandomByteIntoD6
        cmpi.b  #HIGH_RANDOM_BOUND,d6
        bgt     highGap3
        cmpi.b  #MED_RANDOM_BOUND,d6
        bgt     medGap3
        
lowGap3:
        move.l  #LONG_PIPE_HEIGHT, UPPER_PIPE_3_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+LONG_PIPE_HEIGHT),LOWER_PIPE_3_Y
        move.l  #SHORT_PIPE_HEIGHT, LOWER_PIPE_3_HEIGHT
        jmp     resetX3
        
highGap3:
        move.l  #SHORT_PIPE_HEIGHT, UPPER_PIPE_3_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+SHORT_PIPE_HEIGHT),LOWER_PIPE_3_Y
        move.l  #LONG_PIPE_HEIGHT, LOWER_PIPE_3_HEIGHT
        jmp     resetX3
        
medGap3:
        move.l  #MED_PIPE_HEIGHT, UPPER_PIPE_3_HEIGHT
        move.l  #(MED_PIPE_HEIGHT+MED_PIPE_HEIGHT),LOWER_PIPE_3_Y
        move.l  #MED_PIPE_HEIGHT, LOWER_PIPE_3_HEIGHT
 
resetX3:
        lea     ScoreSound,a1
        move.l  #PLAY_SOUND_COMMAND,d0
        TRAP    #15
        addi.l  #1,SCORE
        move.l  #(RIGHT_EDGE_OF_SCREEN),PIPE_SET_3_X
        rts
       
*checks if the sprite's x position is in between the width of each pipe.
*if it is, then the subroutine checks if the player is outside of the gap
*between the two pipes.
checkCollisions:
        move.l  PIPE_SET_1_X,d3
        cmpi.l  #(PLAYER_X+PLAYER_WIDTH),d3
        bgt     collisionWithPipe2
        addi.l  #(PIPE_WIDTH+PIPE_STROKE_WIDTH+PIPE_STROKE_WIDTH),d3
        cmpi.l  #(PLAYER_X),d3
        blt     collisionWithPipe2
        move.l  UPPER_PIPE_1_HEIGHT,d0
        move.l  PLAYER_Y,d1
        asr.l   #8,d1
        cmp.l   d0, d1
        blt     endGame
        addi.l  #PLAYER_HEIGHT,d1
        move.l  LOWER_PIPE_1_Y,d2
        cmp.l   d2,d1
        bgt     endGame
        
collisionWithPipe2:
        move.l  PIPE_SET_2_X,d3
        cmpi.l  #(PLAYER_X+PLAYER_WIDTH),d3
        bgt     collisionWithPipe3
        addi.l  #(PIPE_WIDTH+PIPE_STROKE_WIDTH+PIPE_STROKE_WIDTH),d3
        cmpi.l  #(PLAYER_X),d3
        blt     collisionWithPipe3
        move.l  UPPER_PIPE_2_HEIGHT,d0
        move.l  PLAYER_Y,d1
        asr.l   #8,d1
        cmp.l   d0, d1
        blt     endGame
        addi.l  #PLAYER_HEIGHT,d1
        move.l  LOWER_PIPE_2_Y,d2
        cmp.l   d2,d1
        bgt     endGame
        
collisionWithPipe3:
        move.l  PIPE_SET_3_X,d3
        cmpi.l  #(PLAYER_X+PLAYER_WIDTH),d3
        bgt     endCollisionCheck
        addi.l  #(PIPE_WIDTH+PIPE_STROKE_WIDTH+PIPE_STROKE_WIDTH),d3
        cmpi.l  #(PLAYER_X),d3
        blt     endCollisionCheck
        move.l  UPPER_PIPE_3_HEIGHT,d0
        move.l  PLAYER_Y,d1
        asr.l   #8,d1
        cmp.l   d0, d1
        blt     endGame
        addi.l  #PLAYER_HEIGHT,d1
        move.l  LOWER_PIPE_3_Y,d2
        cmp.l   d2,d1
        bgt     endGame
        
endCollisionCheck:
        rts
     

*updates the bird's y position, adding gravity * time + velocity
*also stores bird's previous y position for the inval rect
updateBird:
        cmpi.l  #(TOP_EDGE_OF_SCREEN-PLAYER_WIDTH/2),PLAYER_Y
        blt     endGame
        move.l  PLAYER_Y,PREVIOUS_Y
        
        move.l  DELTA_TIME,d0
        mulu    #GRAVITY,d0
        add.l   d0, VELOCITY_Y
        move.l  VELOCITY_Y,d0
        add.l   d0,PLAYER_Y
        
        cmpi.l  #(BOTTOM_OF_SCREEN)<<8,PLAYER_Y
        bgt     endGame
        rts
        
drawBird:
        jsr     determineBirdSpriteFrame
        move.l  #PLAYER_X, -(sp)    
        move.l  PLAYER_Y,d0
        asr.l   #8,d0
        move.l  d0, -(sp)    
        move.l  #PLAYER_WIDTH, -(sp)   
        move.l  #PLAYER_HEIGHT, -(sp) 
        jsr     drawBitmapWithTransparency              
        add     #16,sp  
        rts

determineBirdSpriteFrame:
        cmpi.l  #32,animFrameCount
        bne     setFrame
        move.l  #0,animFrameCount
        lea     AnimationFrameTable,a6
setFrame:
        move.l  (a6)+,a5
        rts
        
drawPipes:
        move.l  #PIPE_OUTLINE_COLOR,d1
        move.l  #PEN_COLOR_TRAP_CODE,d0
        TRAP    #15
        move.l  #PIPE_FILL_COLOR,d1
        move.l  #SET_FILL_COLOR_COMMAND,d0
        TRAP    #15
        
        *x pos and width is the same for both upper and lower pipes
        *drawing both upper and lower pipes for each pipe set
firstPipe:
        move.l  PIPE_SET_1_X,d1
        move.l  d1,d3
        add.l   #PIPE_WIDTH,d3
        
        move.l  UPPER_PIPE_Y,d2
        move.l  d2,d4
        add.l   UPPER_PIPE_1_HEIGHT,d4
        
        move.b  #DRAW_RECT_COMMAND,d0
        TRAP    #15
        
        move.l  LOWER_PIPE_1_Y, d2
        move.l  d2,d4
        add.l   LOWER_PIPE_1_HEIGHT,d4
        
        move.b  #DRAW_RECT_COMMAND,d0
        TRAP    #15
        
secondPipe:
        move.l  PIPE_SET_2_X,d1
        move.l  d1,d3
        add.l   #PIPE_WIDTH,d3
        
        move.l  UPPER_PIPE_Y,d2
        move.l  d2,d4
        add.l   UPPER_PIPE_2_HEIGHT,d4
        
        move.b  #DRAW_RECT_COMMAND,d0
        TRAP    #15
        
        move.l  LOWER_PIPE_2_Y, d2
        move.l  d2,d4
        add.l   LOWER_PIPE_2_HEIGHT,d4
        
        move.b  #DRAW_RECT_COMMAND,d0
        TRAP    #15
        
thirdPipe:       
        move.l  PIPE_SET_3_X,d1
        move.l  d1,d3
        add.l   #PIPE_WIDTH,d3
        
        move.l  UPPER_PIPE_Y,d2
        move.l  d2,d4
        add.l   UPPER_PIPE_3_HEIGHT,d4
        
        move.b  #DRAW_RECT_COMMAND,d0
        TRAP    #15
        
        move.l  LOWER_PIPE_3_Y, d2
        move.l  d2,d4
        add.l   LOWER_PIPE_3_HEIGHT,d4
        
        move.b  #DRAW_RECT_COMMAND,d0
        TRAP    #15
        
        rts 

*repaints the screen under the score LED, also checks
*if player has reached max score
scoreInvalRect:
        cmpi.l  #MAX_SCORE,SCORE
        beq     endGame

        move.l  #BEIGE,d1
        move.l  #PEN_COLOR_TRAP_CODE,d0
        TRAP    #15
        move.l  #SET_FILL_COLOR_COMMAND,d0
        TRAP    #15

        move.l  #SCORE_INVAL_RECT_LX,d1
        move.l  #SCORE_INVAL_RECT_UY,d2
        move.l  #SCORE_INVAL_RECT_RX,d3
        move.l  #SCORE_INVAL_RECT_LY,d4
        
        move.l  #DRAW_RECT_COMMAND,d0
        TRAP    #15
        
        jsr drawScore
        
        rts
             
endGame:
        lea     HitSound,a1
        move.l  #PLAY_SOUND_COMMAND,d0
        TRAP    #15
        
*restart game once player presses space bar
waitForSpaceForRestart:
        move.l  #SPACEBAR_INPUT,d1
        move.b  #READ_INPUT_COMMAND,d0
        TRAP    #15
        andi.l  #$FF,d1
        beq     waitForSpaceForRestart
        
        jsr     resetGameEntities
        jmp     beginGame

        
        move.b  #9,d0
        TRAP    #15
        STOP   #$2000
        
        INCLUDE  'globals.x68'          
        INCLUDE  'drawBitmap.x68'
        INCLUDE  'random.x68'
        INCLUDE  'scoreLED.x68'
        INCLUDE  'reset.x68'
          
        END    START        























*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
