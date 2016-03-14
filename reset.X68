resetGameEntities:
        move.l  #(200<<8),PLAYER_Y
        move.l  #(200<<8),PREVIOUS_Y
        move.l  #0,VELOCITY_Y
        move.l  #1,DELTA_TIME
        move.l  #0,PIPE_SET_1_X
        move.l  #120,UPPER_PIPE_1_HEIGHT
        move.l  #240,LOWER_PIPE_1_Y
        move.l  #120,LOWER_PIPE_1_HEIGHT
        move.l  #160,PIPE_SET_2_X
        move.l  #180,UPPER_PIPE_2_HEIGHT
        move.l  #300,LOWER_PIPE_2_Y
        move.l  #60,LOWER_PIPE_2_HEIGHT   
        move.l  #320,PIPE_SET_3_X
        move.l  #180,UPPER_PIPE_3_HEIGHT
        move.l  #300,LOWER_PIPE_3_Y
        move.l  #60,LOWER_PIPE_3_HEIGHT   
        move.l  #1,INVAL_RECT_WIDTH
        move.l  #0,SCORE   
        rts
*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
