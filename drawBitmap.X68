*Takes in bounds of a clipping rectangle and draws a bitmap 
*pixel by pixel within the bounds.
drawBitmap:
        movem.l ALL_REG,-(sp)
        *a5 is our designated register for storing bitmap addresses
        add.l   #IMAGE_DATA_OFFSET,a5  
        clr.l   d6
    
        *calculate how many bytes to skip to get to the pixel that actually gets drawn first
        *((OUTPUT_HEIGHT-TOP_Y-HEIGHT)*OUTPUT_WIDTH+LEFT_X)*4
        move.l  #OUTPUT_HEIGHT,d4
        sub.l   CLIP_RECT_HEIGHT(sp),d4    
        sub.l   CLIP_RECT_TOP_Y(sp),d4   
        muls.w  #OUTPUT_WIDTH,d4
        add.l   CLIP_RECT_LEFT_X(sp),d4    
        add.l   d4,d6
        add.l   d4,d6
        add.l   d4,d6      
        add.l   d4,d6                  
        add.l   d6,a5  
        clr.l   d6
    
        *this is used to skip the remaining pixels on the current line of the image
        *AND the pixels on the next line before LEFT_X. The formula used for this is
        *(OUTPUT_WIDTH - WIDTH)*4
        move.l  #OUTPUT_WIDTH,d4
        sub.l   CLIP_RECT_WIDTH(sp),d4
        clr.l   d7
        add.l   d4,d7
        add.l   d4,d7
        add.l   d4,d7 
        add.l   d4,d7    
    
        *storing initial positions, using TOP_Y+HEIGHT-1 because the color
        *data is stored from the bottom -> up
        move.l  CLIP_RECT_LEFT_X(sp),d1        
        move.l  CLIP_RECT_TOP_Y(sp),d2    
        add.l   CLIP_RECT_HEIGHT(sp),d2    
        subi.l  #1,d2

        *double loop that draws pixel by pixel within the clipping rect
continueRow:    
        *gets pixel data (32 bits) and shifts out alpha channel.
        move.l  (a5)+,d3
        lsr.l   #8,d3
        move.l  d1,d5
        move.l  d3,d1
        move.l  #PEN_COLOR_TRAP_CODE,d0 
        TRAP    #15
        move.l  d5,d1
        move.l  #DRAW_PIXEL_TRAP_CODE,d0 
    
        TRAP    #15
        addi.l  #1,d1
        move.l  CLIP_RECT_LEFT_X(sp),d4    
        add.l   CLIP_RECT_WIDTH(sp),d4     
        cmp.l   d4,d1 
        bne     continueRow
        move.l  CLIP_RECT_LEFT_X(sp),d1    
        subi.l  #1,d2
        add.l   d7, a5                      ;skips the pixels that won't be in clipping rect
        move.l  CLIP_RECT_TOP_Y(sp),d4    
        subi.l  #1,d4
        cmp.l   d4,d2
        bne     continueRow
        bra     done

done:   
        movem.l (sp)+,ALL_REG    
        rts
        
*has the ability to draw images with transparency based on a designated
*transparency color. Does not use a clipping rect
drawBitmapWithTransparency:
        movem.l ALL_REG,-(sp)
    
        add.l   #IMAGE_DATA_OFFSET,a5 
        clr.l   d6
    
        *storing initial positions, using TOP_Y+HEIGHT-1 because the color
        *data is stored from the bottom -> up
        move.l  CLIP_RECT_LEFT_X(sp),d1        
        move.l  CLIP_RECT_TOP_Y(sp),d2    
        add.l   CLIP_RECT_HEIGHT(sp),d2    
        subi.l  #1,d2

        *double loop that draws pixel by pixel within the clipping rect
continueRow2:    
        *gets pixel data (32 bits) and shifts out alpha channel.
        move.l  (a5)+,d3
        lsr.l   #8,d3
        cmpi.l  #TRANSPARENCY_COLOR,d3
        beq     updatePos
        move.l  d1,d5
        move.l  d3,d1
        move.l  #PEN_COLOR_TRAP_CODE,d0 
        TRAP    #15
        move.l  d5,d1
        move.l  #DRAW_PIXEL_TRAP_CODE,d0 
    
        TRAP    #15
        
updatePos:        
        addi.l  #1,d1
        move.l  CLIP_RECT_LEFT_X(sp),d4    
        add.l   CLIP_RECT_WIDTH(sp),d4     
        cmp.l   d4,d1 
        bne     continueRow2
        move.l  CLIP_RECT_LEFT_X(sp),d1    
        subi.l  #1,d2
        move.l  CLIP_RECT_TOP_Y(sp),d4    
        subi.l  #1,d4
        cmp.l   d4,d2
        bne     continueRow2
        bra     done








*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
