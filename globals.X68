*global vars needed for my game
Boundary                ds.l    0

Background              INCBIN  'bg2.bmp'
ScorePanel              INCBIN  'scorePanel.bmp'
                        ds.l    0
BirdSpriteWingHigh      INCBIN  'bird.bmp'
BirdSpriteWingLow       INCBIN  'bird2.bmp'
BirdSpriteWingMid       INCBIN  'bird3.bmp'
animFrameCount          dc.l    0

ScoreSound              dc.b    'Score.wav',0
JumpSound               dc.b    'Jump.wav',0
HitSound                dc.b    'Whip.wav',0

RANDOMVAL               ds.l    1
TEMPRANDOMLONG          ds.l    1

PREVIOUS_Y              dc.l    (200<<8)

PLAYER_Y                dc.l    (200<<8)
VELOCITY_Y              dc.l    0
DELTA_TIME              dc.l    1

PIPE_SET_1_X            dc.l    0
UPPER_PIPE_1_HEIGHT     dc.l    120
LOWER_PIPE_1_Y          dc.l    240
LOWER_PIPE_1_HEIGHT     dc.l    120

PIPE_SET_2_X            dc.l    160
UPPER_PIPE_2_HEIGHT     dc.l    180
LOWER_PIPE_2_Y          dc.l    300
LOWER_PIPE_2_HEIGHT     dc.l    60

PIPE_SET_3_X            dc.l    320
UPPER_PIPE_3_HEIGHT     dc.l    180
LOWER_PIPE_3_Y          dc.l    300
LOWER_PIPE_3_HEIGHT     dc.l    60

INVAL_RECT_WIDTH        dc.l    1

HAVE_HAD_NO_INPUT       ds.b    1
SCORE                   dc.l    0
                        ds.l    0
SCORE_DIGITS            dc.w    $3F3F, $3F30, $3F5B, $3F4F, $3F66, $3F6D, $3F7D, $3F07, $3F7F, $3F6F
                        dc.w    $303F, $3030, $305B, $304F, $3066, $306D, $307D, $3007, $307F, $306F
                        dc.w    $5B3F, $5B30, $5B5B, $5B4F, $5B66, $5B6D, $5B7D, $5B07, $5B7F, $5B6F                                
                        dc.w    $4F3F, $4F30, $4F5B, $4F4F, $4F66, $4F6D, $4F7D, $4F07, $4F7F, $4F6F 
                        dc.w    $663F, $6630, $665B, $664F, $6666, $666D, $667D, $6607, $667F, $666F
                        dc.w    $6D3F, $6D30, $6D5B, $6D4F, $6D66, $6D6D, $6D7D, $6D07, $6D7F, $6D6F
                        dc.w    $7D3F, $7D30, $7D5B, $7D4F, $7D66, $7D6D, $7D7D, $7D07, $7D7F, $7D6F
                        dc.w    $073F, $0730, $075B, $074F, $0766, $076D, $077D, $0707, $077F, $076F
                        dc.w    $7F3F, $7F30, $7F5B, $7F4F, $7F66, $7F6D, $7F7D, $7F07, $7F7F, $7F6F                            
                        dc.w    $6F3F, $6F30, $6F5B, $6F4F, $6F66, $6F6D, $6F7D, $6F07, $6F7F, $6F6F

FunctionTable           dc.l    drawA2, drawB2, drawC2, drawD2, drawE2, drawF2, drawG2
                        dc.l    drawA1, drawB1, drawC1, drawD1, drawE1, drawF1, drawG1
                      
                        ds.l    0  
AnimationFrameTable     dc.l    BirdSpriteWingHigh,BirdSpriteWingHigh,BirdSpriteWingHigh,BirdSpriteWingHigh,BirdSpriteWingHigh,BirdSpriteWingHigh,BirdSpriteWingHigh,BirdSpriteWingHigh
                        dc.l    BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid
                        dc.l    BirdSpriteWingLow,BirdSpriteWingLow,BirdSpriteWingLow,BirdSpriteWingLow,BirdSpriteWingLow,BirdSpriteWingLow,BirdSpriteWingLow,BirdSpriteWingLow
                        dc.l    BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid,BirdSpriteWingMid
















*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
