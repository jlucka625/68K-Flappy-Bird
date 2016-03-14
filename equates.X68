*all of the equates for my program
ALL_REG                         REG     D0-D7/A0-A5
DATA_REGS                       REG     D0-D4

CLIP_RECT_HEIGHT                EQU     60
CLIP_RECT_WIDTH                 EQU     64
CLIP_RECT_TOP_Y                 EQU     68
CLIP_RECT_LEFT_X                EQU     72

IMAGE_DATA_OFFSET               EQU     $36

TOTAL_ANIMATION_FRAMES          EQU     32

PLAYER_X                        EQU     60
PLAYER_WIDTH                    EQU     36
PLAYER_HEIGHT                   EQU     24
BOTTOM_OF_SCREEN                EQU     360
LEFT_EDGE_OF_SCREEN             EQU     -30
RIGHT_EDGE_OF_SCREEN            EQU     450
TOP_EDGE_OF_SCREEN              EQU     0
JUMP_VELOCITY                   EQU     $fffffaff
GRAVITY                         EQU     $30
PIPE_WIDTH                      EQU     24
PIPE_SPEED                      EQU     $2
UPPER_PIPE_Y                    EQU     0
LONG_PIPE_HEIGHT                EQU     180    
MED_PIPE_HEIGHT                 EQU     120
SHORT_PIPE_HEIGHT               EQU     60
HIGH_RANDOM_BOUND               EQU     42
MED_RANDOM_BOUND                EQU     -43

MINIMUM_INVAL_RECT_WIDTH        EQU     5
PIPE_STROKE_WIDTH               EQU     1
SCORE_STROKE_WIDTH              EQU     5
PIPE_OUTLINE_FIXED_POINT        EQU     10

MAX_SCORE                       EQU     100
SCORE_DIGIT_LEFT_X1             EQU     510
SCORE_DIGIT_RIGHT_X1            EQU     555
SCORE_DIGIT_LEFT_X2             EQU     565
SCORE_DIGIT_RIGHT_X2            EQU     610
SCORE_DIGIT_TOP_Y               EQU     30
SCORE_DIGIT_MID_Y               EQU     75
SCORE_DIGIT_BOTTOM_Y            EQU     120
SCORE_PANEL_WIDTH               EQU     160
SCORE_PANEL_HEIGHT              EQU     480
SCORE_INVAL_RECT_LX             EQU     505
SCORE_INVAL_RECT_UY             EQU     25
SCORE_INVAL_RECT_RX             EQU     620
SCORE_INVAL_RECT_LY             EQU     125
SCORE_INDEX_OFFSET              EQU     4
SECOND_SCORE_DIGIT_OFFSET       EQU     28
END_OF_SCORE_OFFSET             EQU     56

YELLOW                          EQU     $0000FFFF
TRANSPARENCY_COLOR              EQU     $0000FF00
SKYBLUE                         EQU     $00D0C571
PIPE_OUTLINE_COLOR              EQU     $00473854
PIPE_FILL_COLOR                 EQU     $002EBF74
BLACK                           EQU     $00000000
WHITE                           EQU     $00FFFFFF
BEIGE                           EQU     $0095D8DE  
  
PLAY_SOUND_COMMAND              EQU     73                                      
PEN_COLOR_TRAP_CODE             EQU     80
PEN_WIDTH_TRAP_CODE             EQU     93
DRAW_PIXEL_TRAP_CODE            EQU     82
SET_OUTPUT_RESOLUTION_TRAP_CODE EQU     33
SET_FILL_COLOR_COMMAND          EQU     81
DRAW_LINE_COMMAND               EQU     84
READ_INPUT_COMMAND              EQU     19
DRAW_RECT_COMMAND               EQU     87
DRAW_CIRCLE_COMMAND             EQU     88
GET_TIME_COMMAND                EQU     8
CLEAR_SCREEN_COMMAND            EQU     11
DRAWING_MODE_TRAP_CODE	        EQU 	92
DOUBLE_BUFFERED_MODE	        EQU 	17
REPAINT_SCREEN_TRAP_CODE	    EQU 	94
CLEAR_SCREEN_MAGIC_VAL          EQU     $FF00
KEY_UP_INPUT                    EQU     $26
SPACEBAR_INPUT                  EQU     $20

LARGE_NUMBER                    EQU     127
LARGE_NUMBER1                   EQU     69

OUTPUT_WIDTH                    EQU     480
OUTPUT_HEIGHT                   EQU     480



























*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
