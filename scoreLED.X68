prepareToDrawDigit:
    move.l  #SCORE_STROKE_WIDTH,d1
    move.b  #PEN_WIDTH_TRAP_CODE,d0
    TRAP    #15
    
    move.l  #WHITE,d1
    move.b  #PEN_COLOR_TRAP_CODE,d0
    TRAP    #15
    
    rts
    
resetPenWidth:
    move.l  #PIPE_STROKE_WIDTH,d1
    move.b  #PEN_WIDTH_TRAP_CODE,d0
    TRAP    #15 

    rts   
    
drawA1:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X1,d1
    move.l  #SCORE_DIGIT_TOP_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X1,d3
    move.l  #SCORE_DIGIT_TOP_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawA2:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X2,d1
    move.l  #SCORE_DIGIT_TOP_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X2,d3
    move.l  #SCORE_DIGIT_TOP_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawB1:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_RIGHT_X1,d1
    move.l  #SCORE_DIGIT_TOP_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X1,d3
    move.l  #SCORE_DIGIT_MID_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawB2:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_RIGHT_X2,d1
    move.l  #SCORE_DIGIT_TOP_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X2,d3
    move.l  #SCORE_DIGIT_MID_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawC1:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_RIGHT_X1,d1
    move.l  #SCORE_DIGIT_MID_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X1,d3
    move.l  #SCORE_DIGIT_BOTTOM_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawC2:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_RIGHT_X2,d1
    move.l  #SCORE_DIGIT_MID_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X2,d3
    move.l  #SCORE_DIGIT_BOTTOM_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawD1:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X1,d1
    move.l  #SCORE_DIGIT_BOTTOM_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X1,d3
    move.l  #SCORE_DIGIT_BOTTOM_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawD2:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X2,d1
    move.l  #SCORE_DIGIT_BOTTOM_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X2,d3
    move.l  #SCORE_DIGIT_BOTTOM_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawE1:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X1,d1
    move.l  #SCORE_DIGIT_MID_Y,d2
    move.l  #SCORE_DIGIT_LEFT_X1,d3
    move.l  #SCORE_DIGIT_BOTTOM_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawE2:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X2,d1
    move.l  #SCORE_DIGIT_MID_Y,d2
    move.l  #SCORE_DIGIT_LEFT_X2,d3
    move.l  #SCORE_DIGIT_BOTTOM_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawF1:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X1,d1
    move.l  #SCORE_DIGIT_TOP_Y,d2
    move.l  #SCORE_DIGIT_LEFT_X1,d3
    move.l  #SCORE_DIGIT_MID_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawF2:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X2,d1
    move.l  #SCORE_DIGIT_TOP_Y,d2
    move.l  #SCORE_DIGIT_LEFT_X2,d3
    move.l  #SCORE_DIGIT_MID_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawG1:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X1,d1
    move.l  #SCORE_DIGIT_MID_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X1,d3
    move.l  #SCORE_DIGIT_MID_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    movem.l (sp)+,DATA_REGS    
    rts
    
drawG2:
    movem.l DATA_REGS,-(sp)
    move.l  #SCORE_DIGIT_LEFT_X2,d1
    move.l  #SCORE_DIGIT_MID_Y,d2
    move.l  #SCORE_DIGIT_RIGHT_X2,d3
    move.l  #SCORE_DIGIT_MID_Y,d4
    
    move.b  #DRAW_LINE_COMMAND,d0
    TRAP    #15
    
    movem.l (sp)+,DATA_REGS
    rts
    
drawScore:
        jsr     prepareToDrawDigit
        clr.l   d2
        clr.l   d0
        clr.l   d3
        move.l  #$01,d3
        lea     SCORE_DIGITS,a0
        lea     FunctionTable,a1
        move.l  SCORE,d1
        add.l   d1,d1
loop:
        move.w  (a0,d1),d2
        and.l   d3,d2
        beq     skipDraw
        move.l  (a1,d0),a2
        jsr     (a2)
skipDraw:
        addi.l  #SCORE_INDEX_OFFSET,d0
        lsl.l   #1,d3
        cmpi.l  #SECOND_SCORE_DIGIT_OFFSET,d0
        bne     loopCheck
        lsl.l   #1,d3
loopCheck:
        cmpi.l  #END_OF_SCORE_OFFSET,d0
        bne     loop
        
        jsr     resetPenWidth
        rts
        
        
        
        
 



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
