define KEY_LEFT     #04
define KEY_RIGHT    #06

; Speeds greater than 2 break my shitty collision checks.
define MOVE_SPEED #02

define UpRight #00
define DownRight #01
define DownLeft #02
define UpLeft #03

start:
    CLS
    CALL initBall
    mainLoop:
        LD VC, MOVE_SPEED
        drawLoop:
            CALL drawBall
            CALL moveBall
            ADD VC, #FF
            SE VC, #00
                JP drawLoop
        LD V0, #01
        CALL waitForTimer
        JP mainLoop

end:
    JP end

initBall:
    LD I, ballData
    LD V2, [I]
    RND V2, %11
    LD [I], V2
    RET

waitForTimer:
    LD DT, V0
    
    waitLoop:
        LD V0, DT
        SE V0, #00
            JP waitLoop
    RET

moveBall:
    ;CALL drawBall
    LD I, ballData
    LD V2, [I]
    SNE V2, #00
        JP moveBallUpRight
    SNE V2, #01
        JP moveBallDownRight
    SNE V2, #02
        JP moveBallDownLeft
    SNE V2, #03
        JP moveBallUpLeft

    moveBallEnd:
        LD [I], V2
        RET

moveBallUpRight:
    ADD V0, #01
    ADD V1, #FF
    SNE V0, 61
        LD V2, UpLeft
    SNE V1, #00
        LD V2, DownRight
    JP moveBallEnd

moveBallDownRight:
    ADD V0, #01
    ADD V1, #01
    SNE V0, 61
        LD V2, DownLeft
    SNE V1, 30
        LD V2, UpRight
    JP moveBallEnd

moveBallDownLeft:
    ADD V0, #FF
    ADD V1, #01
    SNE V0, #00
        LD V2, DownRight
    SNE V1, 30
        LD V2, UpLeft
    JP moveBallEnd

moveBallUpLeft:
    ADD V0, #FF
    ADD V1, #FF
    SNE V0, #00
        LD V2, UpRight
    SNE V1, #00
        LD V2, DownLeft
    JP moveBallEnd

drawBall:
    LD I, ballData
    LD V2, [I]
    LD I, ballSpriteUpRight
    SHL V2
    ADD I, V2
    DRW V0, V1, 2
    RET

ballData:
    db 28, 1, #00

gameData:
    db #00

; Direction #00
ballSpriteUpRight:
    db %11000000
    db %01000000

; Direction #01
ballSpriteDownRight:
    db %01000000
    db %11000000

; Direction #02
ballSpriteDownLeft:
    db %10000000
    db %11000000

; Direction #03
ballSpriteUpLeft:
    db %11000000
    db %10000000

