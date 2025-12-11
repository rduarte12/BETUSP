; Normal Commands:
;
; ['w']       - Chips[CurChips] += 1
; ['a']       - CurChips -= 1
; ['s']       - CurChips += 1
; ['d']       - Chips[CurChips] -= 1
; [<Enter>]   - Confirm | Wager
; [<Space>]   - Stop
; ['?']       - Help
;
; Admin Commands:
;
; ['>']       - Money  = Limit
; ['<']       - Money  = 0
; ['+']       - Money *= 2
; ['-']       - Money /= 2

jmp main

; |==================| Section: Cat |==================|

; This is Sir Gato.   (en)
; Este é o Sr. Gato.  (ptbr)
; █████░▀██████████████▀░████
; ████▌▒▒░████████████░▒▒▐███
; ████░▒▒▒░██████████░▒▒▒░███
; ███▌░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▐██
; ███░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░██
; █████▀▀▀██▄▒▒▒▒▒▒▒▄██▀▀▀███
; ████░░░▐█░▀█▒▒▒▒▒█▀░█▌░░░██
; ███▌░░░▐▄▌░▐▌▒▒▒▐▌░▐▄▌░░▐██
; ████░░░▐█▌░░▌▒▒▒▐░░▐█▌░░███
; ███▒▀▄▄▄█▄▄▄▌░▄░▐▄▄▄█▄▄▀▒██
; ████░░░░░░░░░░└┴┘░░░░░░░░██
; █████▄▄░░░░░░░░░░░░░░▄▄████
; ███████████▒▒▒▒▒▒██████████
; ████▀░░███▒▒░░▒░░▒▀████████
; ████▒░███▒▒╖░░╥░░╓▒▐███████
; ████▒░▀▀▀░░║░░║░░║░░███████
; █████▄▄▄▄▀▀┴┴╚╧╧╝╧╧╝┴┴█████
; ███████████████████████████

; |==================| Section: Memory Variables |==================|

Money : var #1
  static Money, #64
;

Limit : var #1
  static Limit, #65535
;

ChipsInitialPosition : var #1
  static ChipsInitialPosition, #293
;

CurChip : var #1
  static CurChip, #3
;

Chips : var #5
  static Chips + #0, #0       ; 10000
  static Chips + #1, #0       ; 1000
  static Chips + #2, #0       ; 100
  static Chips + #3, #1       ; 10
  static Chips + #4, #0       ; 1
;

ChipsColors : var #5
  static ChipsColors + #0, #1290       ; Roxo         (#1280)
  static ChipsColors + #1, #1034       ; Azul marinho (#1024)
  static ChipsColors + #2, #522        ; Verde        (#512)
  static ChipsColors + #3, #2314       ; Vermelho     (#2304)
  static ChipsColors + #4, #10         ; Branco       (#0)
;

; |==================| Section: Main Code |==================|

main:

  GameReStart:
  
  call _setInitialMoney
  call _setInitialChips

  call _showInitialScreen
  ceq _showTutorialScreen

	GameStart:
		
    call _showGameScreen
    call _showMoney
    call _showChips

		GameLoop:

      call _takeCommand
      
      jnc Game_Stop
      
      call _checkMoney
      jle Game_Lose
      jgr Game_Win

      call _checkChips

      call _showMoney
			call _showChips

			jmp GameLoop
		;
  ;

  Game_Lose:
    call _showLoseScreen
    jmp GameReStart
  ;

  Game_Win:
    call _showWinScreen
    jmp GameReStart
  ;

  Game_Stop:
    call _showStopScreen
    jmp GameStart
  ;
  
;

; |==================| Section: Routines  |==================|

; |------------------| Screens Routines |------------------|

_showInitialScreen:
  push r0
  push r1
  push r2

  loadn r1, #13   ; [r1] = <Enter>
  loadn r2, #63   ; [r2] = '?'

  _showInitialScreen_Loop:

    loadn r0, #InitialScreen1
    call printScreen

    call IncharDelay                  ; [r0] = Inchar Value
    cmp r0, r1                        ; [r0] == [r1] | Inchar Value == <Enter>
    jeq _showInitialScreen_Game
    cmp r0, r2                        ; [r0] == [r2] | Inchar Value == '?'
    jeq _showInitialScreen_Tutorial

    loadn r0, #InitialScreen2
    call printScreen

    call IncharDelay                  ; [r0] = Inchar Value
    cmp r0, r1                        ; [r0] == [r1] | Inchar Value == <Enter>
    jeq _showInitialScreen_Game
    cmp r0, r2                        ; [r0] == [r2] | Inchar Value == '?'
    jeq _showInitialScreen_Tutorial
    
    loadn r0, #InitialScreen3
    call printScreen

    call IncharDelay                  ; [r0] = Inchar Value
    cmp r0, r1                        ; [r0] == [r1] | Inchar Value == <Enter>
    jeq _showInitialScreen_Game
    cmp r0, r2                        ; [r0] == [r2] | Inchar Value == '?'
    jeq _showInitialScreen_Tutorial
    
    jmp _showInitialScreen_Loop 

  _showInitialScreen_Game:
    cmp r1, r2
    jmp _showInitialScreen_Exit
  ;
  
  _showInitialScreen_Tutorial:
    cmp r1, r1
    jmp _showInitialScreen_Exit
  ;
  
  _showInitialScreen_Exit:
  
  pop r2
  pop r1
  pop r0
  rts
; END _showInitialScreen

_showTutorialScreen:
  push r0

  loadn r0, #Tutorial_Screen
  call printScreen

  call waitEnter

  pop r0
  rts
; END _showTutorialScreen

_showGameScreen:
  push r0

  loadn r0, #GameScreen
  call printScreen

  pop r0
  rts
; END _showGameScreen

_showMoney:
  push r0
  push r1
  push r5

  loadn r0, #Money
  loadi r1, r0
  loadn r5, #560     ; '0' + greenColor ( 48 + 512 )
  
  call printMoney

  pop r5
  pop r1
  pop r0
  rts
; END _showMoney

_showChips:
  push r0
  push r1
  push r2
  push r3
  push r4
  push r5
  push r6
  push r7

  loadn r0, #0
  load  r1, ChipsInitialPosition
  loadn r2, #Chips
  loadn r3, #ChipsColors
  loadn r4, #5

  loadn r5, #48
  load  r6, CurChip

  _showChips_Loop:
    
    add r7, r2, r0
    loadi r7, r7

    cmp r0, r6
    jne _showChips_Loop_White
      loadn r5, #2864
    _showChips_Loop_White:

    add r7, r7, r5
    loadn r5, #48

    outchar r7, r1
    inc r1

    add r7, r3, r0
    loadi r7, r7

    outchar r7, r1

    inc r0
    inc r1
    inc r1
    dec r4
    jnz _showChips_Loop

  pop r7
  pop r6
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  rts
; END _showChips

_showLoseScreen:
  push r0

  loadn r0, #LoseScreen1
  call printScreen
  call delay

  loadn r0, #LoseScreen2
  call printScreen
  call delay
  
  loadn r0, #LoseScreen3
  call printScreen
  call delay

  call waitEnter    
  
  pop r0
  rts
; END _showLoseScreen

_showStopScreen:
  push r0

  loadn r0, #StopScreen
  call printScreen

  call waitSpace

  pop r0
  rts
; END _showStopScreen

_showWinScreen:
  push r0

  loadn r0, #WinScreen1
  call printScreen
  call delay

  loadn r0, #WinScreen2
  call printScreen
  call delay
  
  call waitEnter    
  
  pop r0
  rts
; END _showWinScreen

; |------------------| Commands Routines |------------------|

_takeCommand:
  push r0
  push r1
  push r2
  push r3
  push r4

  loadn r1, #255  ; Non-Inchar
  loadn r3, #0
  loadn r4, #1000
  
  _takeCommand_Loop:
    inchar r0
    cmp r0, r1
    jne _takeCommand_LoopExit
    inc r3
    mod r3, r3, r4
    jmp _takeCommand_Loop
  ;

  _takeCommand_LoopExit:

  loadn r1, #119	; 'w'
  cmp r0, r1
  ceq updateChips
  jeq _takeCommand_SetC

  loadn r1, #97	; 'a'
  cmp r0, r1
  ceq updateChips
  jeq _takeCommand_SetC

  loadn r1, #115	; 's'
  cmp r0, r1
  ceq updateChips
  jeq _takeCommand_SetC

  loadn r1, #100	; 'd'
  cmp r0, r1
  ceq updateChips
  jeq _takeCommand_SetC

  loadn r1, #13	; <Enter>
  cmp r0, r1
  jeq _takeCommand_Enter

  loadn r1, #32	; <Space>
  cmp r0, r1
  jeq _takeCommand_Space

  loadn r1, #63	; '?'
  cmp r0, r1
  jeq _takeCommand_Help

  loadn r1, #60 ; '<'
  cmp r0, r1
  jeq _takeCommand_ADMIN0
  
  loadn r1, #62 ; '>'
  cmp r0, r1
  jeq _takeCommand_ADMIN1
  
  loadn r1, #43 ; '+'
  cmp r0, r1
  jeq _takeCommand_ADMIN2

  loadn r1, #45 ; '-'
  cmp r0, r1
  jeq _takeCommand_ADMIN3
  
  jmp _takeCommand_Loop

  _takeCommand_Enter:
    ; Wager
    mov r0, r3
    call wager
    jmp _takeCommand_SetC
  ;

  _takeCommand_Space:
    ; Stop
    jmp _takeCommand_ClearC
  ;

  _takeCommand_ADMIN0:
    loadn r0, #0
    store Money, r0
    jmp _takeCommand_SetC
  ;
  _takeCommand_ADMIN1:
    load  r0, Limit
    store Money, r0
    jmp _takeCommand_SetC
  ;

  _takeCommand_ADMIN2:
    load  r0, Money
    loadn r1, #2
    mul r0, r0, r1
    store Money, r0
    jmp _takeCommand_SetC
  ;
  
  _takeCommand_ADMIN3:
    load  r0, Money
    loadn r1, #2
    div r0, r0, r1
    store Money, r0
    jmp _takeCommand_SetC
  ;

  _takeCommand_Help:
    ; Help
    call _showTutorialScreen
    call _showGameScreen
    jmp _takeCommand_SetC
  ;

  _takeCommand_SetC:
    setc
    jmp _takeCommand_Exit
  ;
  _takeCommand_ClearC:
    clearc
    jmp _takeCommand_Exit
  ;
  
  _takeCommand_Exit:

  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  rts
; END _takeCommand

; |------------------| Checks Routines |------------------|

_checkMoney:

  push r0
  push r1

  load  r0, Money

  loadn r1, #0
  cmp r0, r1
  jel _checkMoney_Underflow

  load r1, Limit
  cmp r0, r1
  jeg _checkMoney_Overflow

  loadn r0, #0
  loadn r1, #0
  jmp _checkMoney_Exit

  _checkMoney_Underflow:
    loadn r0, #0
    loadn r1, #1
    jmp _checkMoney_Exit
  ;
  _checkMoney_Overflow:
    loadn r0, #1
    loadn r1, #0
    jmp _checkMoney_Exit
  ;

  _checkMoney_Exit:
  cmp r0, r1

  pop r1
  pop r0
  rts
; END _checkMoney

_checkChips:

  push r0
  push r1

  call getChips   ; [r0] = Chips
  load r1, Money  ; [r1] = Money

  cmp r0, r1
  jel _checkChips_Exit

  mov r0, r1
  call setChips   ; if (Money < Chips) Chips = Money

  _checkChips_Exit:

  pop r1
  pop r0
  rts
; END _checkChips

; |------------------| Initial Sets Routines |------------------|

_setInitialMoney:

  push r0
  push r1

  load  r0, Money
  loadn r1, #0

  cmp r0, r1
  jel _setInitialMoney_SetMoney
  
  load  r1, Limit
  cmp r0, r1
  jeg _setInitialMoney_SetMoney
  
  jmp _setInitialMoney_Exit
  
  _setInitialMoney_SetMoney:
  loadn r1, #64
  store Money, r1
  
  _setInitialMoney_Exit:

  pop r1
  pop r0
  rts
; END _setInitialMoney

_setInitialChips:

  push r0
  
  loadn r0, #10
  call setChips

  loadn r0, #3
  store CurChip, r0
  
  pop r0
  rts
; END _setInitialChips

; |==================| Section: Functions |==================|

; |------------------| I/O Functions |------------------|

printScreen: ; Use [r0] as Memory Adress of Screen
		
	; [r0] = Memory Adress
	; [r1] = Position to Outchar  | Index of Screen
	; [r2] = Limit (Constant #1200) 
  ; [r3] = Character to Outchar

  push r1
  push r2
  push r3

  loadn r1, #0
  loadn r2, #1200

  printScreen_Loop:

    add r3, r0, r1
    loadi r3, r3
    outchar r3, r1
    
    inc r1
    cmp r1, r2

    jne printScreen_Loop

  pop r3
  pop r2
  pop r1
	rts
; END printScreen	

IncharDelay: ; User [r0] as Inchar value
  
  ; [r0] = Inchar Value
  ; [r1] = Non-Inchar Value
  ; [r2] = Delay

  push r1
  push r2

  loadn r1, #255
  loadn r2, #16384
  
  readKeyDelay_Loop:
    inchar r0
    cmp r0, r1
    jne readKeyDelay_Exit 
    dec r2
    jnz readKeyDelay_Loop    
  ;

  readKeyDelay_Exit:

  pop r2
  pop r1
  rts
; END IncharDelay

printMoney: ; Use [r1] as Number to Outchar & [r5] as Constant color + '0'

	; [r0] = Constant #10
	; [r1] = Number to Outchar
	; [r2] = Digits to Outchar
	; [r3] = Qty of digits + 1
	; [r4] = Position to print
	; [r5] = Constant greenColor + '0' (512 + 48)
	; [r6] = Qty of digits to clean

	push r0
	push r1
	push r2
	push r3
	push r4
  push r5
  push r6

	loadn r0, #10
	loadn r3, #0
	loadn r4, #113
  loadn r6, #5

	printMoney_PUSH:
		
		mod r2, r1, r0
		
		push r2
		inc r3
    dec r6
		
		div r1, r1, r0
		
		jnz printMoney_PUSH
	;
	
	printMoney_POP:
		
		pop r2
	
		add r2, r2, r5
		
		outchar r2, r4

		inc r4
		dec r3
		jnz printMoney_POP		
	;

  cmp r3, r6
  jeq printMoney_EXIT

  loadn r2, #' '

  printMoney_Clean:

    outchar r2, r4
    inc r4
    dec r6
    jnz printMoney_Clean
	
	printMoney_EXIT:
	
  pop r6
  pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; END printMoney

waitEnter:
	
	; [r0] = Inchar Value
	; [r1] = <Enter> Value
	
	push r0
	push r1
	
	loadn r1, #13
	
	waitEnter_Loop:
		inchar r0				
		cmp r0, r1
		jne waitEnter_Loop
	;

	pop r1
	pop r0
	rts
; END waitEnter

delay:

  push r0
  push r1

  loadn r1, #65535
  delay_Loop1:

  loadn r0, #30
  delay_Loop0:

  dec r0
  jnz delay_Loop0
  
  dec r1
  jnz delay_Loop1
  
  pop r1
  pop r0
  rts
; END delay

waitSpace:
	
	; [r0] = Inchar Value
	; [r1] = <Space> Value
	
	push r0
	push r1
	
	loadn r1, #32
	
	waitSpace_Loop:
		inchar r0				
		cmp r0, r1
		jne waitSpace_Loop
	;

	pop r1
	pop r0
	rts
; END waitEnter

; |------------------| Chips Functions |------------------|

updateChips: ; User [r0] as WTD

  ; [r0] = Command
  ; [r1] = Aux
  ; [r2] = Limit

  push fr
  push r0
  push r1
  push r2

  loadn r1, #119	; 'w'
  cmp r0, r1
  jeq updateChips_w

  loadn r1, #97	; 'a'
  cmp r0, r1
  jeq updateChips_a

  loadn r1, #115	; 's'
  cmp r0, r1
  jeq updateChips_s

  loadn r1, #100	; 'd'
  cmp r0, r1
  jeq updateChips_d

  updateChips_w:
    call getChips         ; [r0] = Chips
    call getCurChip       ; [r1] = CurChip
    
    add r0, r0, r1        ; [r0] = Chips + CurChips
    
    load  r2, Money
    cmp r0, r2
    cel setChips          ; [r0] <= Money -> Store [r0]

    jmp updateChips_Exit
  ;

  updateChips_a:
    loadn r2, #0
    load r0, CurChip
    dec r0
    cmp r0, r2
    jle updateChips_Exit
    store CurChip, r0
    jmp updateChips_Exit
  ;

  updateChips_s:
    call getChips         ; [r0] = Chips
    call getCurChip       ; [r1] = CurChip
    
    sub r0, r0, r1        ; [r0] = [r1] - [r0] === [r0] = CurChip - Chips

    loadn r2, #1
    cmp r0, r2
    ceg setChips          ; [r0] >= 1 -> Store [r0]

    jmp updateChips_Exit
  ;

  updateChips_d:
    loadn r2, #4
    load r0, CurChip
    inc r0
    cmp r0, r2
    jgr updateChips_Exit
    store CurChip, r0
    jmp updateChips_Exit
  ;

  updateChips_Exit:

  pop r2
  pop r1
  pop r0
  pop fr
  rts
; END updateChips

getCurChip: ; Use [r1] as CurChip

  push r0
  push r2
  push r3

  load  r0, CurChip
  loadn r1, #1
  loadn r2, #4
  loadn r3, #10

  getCurChip_Loop:
    cmp r0, r2
    jeq getCurChip_Exit
    mul r1, r1, r3
    inc r0
    jmp getCurChip_Loop
  ;
  getCurChip_Exit:

  pop r3
  pop r2
  pop r0
  rts
; END getCurChip

getChips: ; Use [r0] as Chips

  push r1
  push r2
  push r3
  push r4

  loadn r0, #0
  loadn r1, #Chips
  loadn r3, #10
  loadn r4, #5

  getChips_Loop:
    loadi r2, r1

    mul r0, r0, r3
    add r0, r0, r2

    inc r1
    dec r4
    jnz getChips_Loop
  ;

  pop r4
  pop r3
  pop r2
  pop r1
  rts
; END getChips

setChips: ; Use [r0] as Chips

  push r0
  push r1
  push r2
  push r3
  push r4

  loadn r1, #Chips
  loadn r2, #4
  add r1, r1, r2

  loadn r2, #5
  loadn r3, #10
  
  setChips_Loop:
    mod r4, r0, r3
    div r0, r0, r3

    storei r1, r4

    dec r1
    dec r2
    jnz setChips_Loop
  ;

  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  rts
; END setChips

; |------------------| Wager Functions |------------------|

wager: ; Use [r0] as Number
	
	; [r0] = Number | Chips
	; [r1] = Aux    | Money
	; [r2] = Aux    | Aux

	push r0
  push r1
	push r2
	push r3

  call writeWager

	; r0 % 111 == 0:		  ; xxx
	loadn r1, #111
	mod r2, r0, r1
	jz wager_Triple
	
	; r0 // 10 % 11 == 0:	; xxy
	loadn r1, #10
	div r2, r0, r1
	
	loadn r1, #11
	mod r2, r2, r1
	jz wager_Twice
	
	; r0 % 101 % 10 == 0:	; xyx
	loadn r1, #101
	mod r2, r0, r1
	
	loadn r1, #10
	mod r2, r2, r1
	jz wager_Twice
	
	; r0 % 100 % 11 == 0:	; yxx
	loadn r1, #100
	mod r2, r0, r1
	
	loadn r1, #11
	mod r2, r2, r1
	jz wager_Twice
	
	jmp waget_Once			  ; xyz

	wager_Triple:
		loadn r2, #3        ; [r2] = #3
    jmp waget_CalMoney
	;
	
	wager_Twice:
		loadn r2, #2        ; [r2] = #2
    jmp waget_CalMoney
	;

  waget_Once:
		loadn r2, #0        ; [r2] = #0
    jmp waget_CalMoney
	;

	waget_CalMoney:
	
  call getChips       ; [r0] = Chips
  load r1, Money      ; [r1] = Money
  load r3, Limit      ; [r3] = Limit

  ; Money -= Chips
  sub r1, r1, r0      ; [r1] = [r1] - [r0] | [r1] = Money - Chips

  ; Chips *= [r2]
  mul r0, r0, r2      ; [r1] = [r0] * [r2] | [r1] = Chips * [r2]

  ; Check if Overflow
  sub r3, r3, r1      ; [r3] = [r3] - [r1] | [r3] = Limit - Money
  cmp r0, r3
  jgr waget_Overflow  ; [r1] > [r3]        | Chips > ( Limit - Money ) -> Overflow

  ; Money += Chips
  add r1, r0, r1      ; [r1] = [r0] + [r1] | [r1] = Money + Chips
  jmp waget_Store

  waget_Overflow:
    load r1, Limit
  ;

  waget_Store:

  store Money, r1
	
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; END wager

writeWager: ; Use [r0] as Number to Outchar
	
	; [r0] = prgn to Outchar
	; [r1] = Constant #10
	; [r2] = Digit to Outchar
	; [r3] = Contant yellowColor + '0' (2816 + 48)
	; [r4] = Positions of the Digits
	
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r1, #10
	loadn r3, #2864
	
	mod r2, r0, r1
	div r0, r0, r1
	
	add r2, r2, r3
	
	loadn r4, #583
	outchar r2, r4

	mod r2, r0, r1
	div r0, r0, r1
	
	add r2, r2, r3
	
	loadn r4, #579
	outchar r2, r4
	
	mod r2, r0, r1
	div r0, r0, r1
	
	add r2, r2, r3
	
	loadn r4, #575
	outchar r2, r4
		
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; END writeprgn

; |==================| Section: Screens |==================|

GameScreen : var #1200
  ;Linha 0
  static GameScreen + #0, #2825
  static GameScreen + #1, #2825
  static GameScreen + #2, #2825
  static GameScreen + #3, #2825
  static GameScreen + #4, #2825
  static GameScreen + #5, #2825
  static GameScreen + #6, #2825
  static GameScreen + #7, #2825
  static GameScreen + #8, #2825
  static GameScreen + #9, #2825
  static GameScreen + #10, #2825
  static GameScreen + #11, #2825
  static GameScreen + #12, #2825
  static GameScreen + #13, #2825
  static GameScreen + #14, #2825
  static GameScreen + #15, #2825
  static GameScreen + #16, #2825
  static GameScreen + #17, #2825
  static GameScreen + #18, #2825
  static GameScreen + #19, #2825
  static GameScreen + #20, #2825
  static GameScreen + #21, #2825
  static GameScreen + #22, #2825
  static GameScreen + #23, #2825
  static GameScreen + #24, #2825
  static GameScreen + #25, #2825
  static GameScreen + #26, #2825
  static GameScreen + #27, #2825
  static GameScreen + #28, #2825
  static GameScreen + #29, #2825
  static GameScreen + #30, #2825
  static GameScreen + #31, #2825
  static GameScreen + #32, #2825
  static GameScreen + #33, #2825
  static GameScreen + #34, #2825
  static GameScreen + #35, #2825
  static GameScreen + #36, #2825
  static GameScreen + #37, #2825
  static GameScreen + #38, #2825
  static GameScreen + #39, #2825

  ;Linha 1
  static GameScreen + #40, #2825
  static GameScreen + #41, #3967
  static GameScreen + #42, #3967
  static GameScreen + #43, #3967
  static GameScreen + #44, #3967
  static GameScreen + #45, #3967
  static GameScreen + #46, #3967
  static GameScreen + #47, #3967
  static GameScreen + #48, #3967
  static GameScreen + #49, #3967
  static GameScreen + #50, #3967
  static GameScreen + #51, #3967
  static GameScreen + #52, #3967
  static GameScreen + #53, #3967
  static GameScreen + #54, #3967
  static GameScreen + #55, #3967
  static GameScreen + #56, #3967
  static GameScreen + #57, #3967
  static GameScreen + #58, #3967
  static GameScreen + #59, #3967
  static GameScreen + #60, #3967
  static GameScreen + #61, #3967
  static GameScreen + #62, #3967
  static GameScreen + #63, #3967
  static GameScreen + #64, #3967
  static GameScreen + #65, #3967
  static GameScreen + #66, #3967
  static GameScreen + #67, #3967
  static GameScreen + #68, #3967
  static GameScreen + #69, #3967
  static GameScreen + #70, #3967
  static GameScreen + #71, #3967
  static GameScreen + #72, #3967
  static GameScreen + #73, #3967
  static GameScreen + #74, #3967
  static GameScreen + #75, #3967
  static GameScreen + #76, #3967
  static GameScreen + #77, #3967
  static GameScreen + #78, #3967
  static GameScreen + #79, #2825

  ;Linha 2
  static GameScreen + #80, #2825
  static GameScreen + #81, #3967
  static GameScreen + #82, #3967
  static GameScreen + #83, #3967
  static GameScreen + #84, #3967
  static GameScreen + #85, #3967
  static GameScreen + #86, #3967
  static GameScreen + #87, #3967
  static GameScreen + #88, #3967
  static GameScreen + #89, #3967
  static GameScreen + #90, #3967
  static GameScreen + #91, #3967
  static GameScreen + #92, #3967
  static GameScreen + #93, #3967
  static GameScreen + #94, #3967
  static GameScreen + #95, #3967
  static GameScreen + #96, #3967
  static GameScreen + #97, #3967
  static GameScreen + #98, #3967
  static GameScreen + #99, #3967
  static GameScreen + #100, #3967
  static GameScreen + #101, #3967
  static GameScreen + #102, #3967
  static GameScreen + #103, #3967
  static GameScreen + #104, #3967
  static GameScreen + #105, #3967
  static GameScreen + #106, #3967
  static GameScreen + #107, #3967
  static GameScreen + #108, #3967
  static GameScreen + #109, #3967
  static GameScreen + #110, #3967
  static GameScreen + #111, #82
  static GameScreen + #112, #36
  static GameScreen + #113, #3967
  static GameScreen + #114, #3967
  static GameScreen + #115, #3967
  static GameScreen + #116, #3967
  static GameScreen + #117, #3967
  static GameScreen + #118, #3967
  static GameScreen + #119, #2825

  ;Linha 3
  static GameScreen + #120, #2825
  static GameScreen + #121, #3967
  static GameScreen + #122, #3967
  static GameScreen + #123, #3967
  static GameScreen + #124, #3967
  static GameScreen + #125, #3967
  static GameScreen + #126, #3967
  static GameScreen + #127, #3967
  static GameScreen + #128, #3967
  static GameScreen + #129, #3967
  static GameScreen + #130, #3967
  static GameScreen + #131, #3967
  static GameScreen + #132, #3967
  static GameScreen + #133, #3967
  static GameScreen + #134, #3967
  static GameScreen + #135, #3967
  static GameScreen + #136, #3967
  static GameScreen + #137, #3967
  static GameScreen + #138, #3967
  static GameScreen + #139, #3967
  static GameScreen + #140, #3967
  static GameScreen + #141, #3967
  static GameScreen + #142, #3967
  static GameScreen + #143, #3967
  static GameScreen + #144, #3967
  static GameScreen + #145, #3967
  static GameScreen + #146, #3967
  static GameScreen + #147, #3967
  static GameScreen + #148, #3967
  static GameScreen + #149, #3967
  static GameScreen + #150, #3967
  static GameScreen + #151, #3967
  static GameScreen + #152, #3967
  static GameScreen + #153, #3967
  static GameScreen + #154, #3967
  static GameScreen + #155, #3967
  static GameScreen + #156, #3967
  static GameScreen + #157, #3967
  static GameScreen + #158, #3967
  static GameScreen + #159, #2825

  ;Linha 4
  static GameScreen + #160, #2825
  static GameScreen + #161, #3967
  static GameScreen + #162, #3967
  static GameScreen + #163, #3967
  static GameScreen + #164, #3967
  static GameScreen + #165, #3967
  static GameScreen + #166, #3967
  static GameScreen + #167, #3967
  static GameScreen + #168, #3967
  static GameScreen + #169, #3967
  static GameScreen + #170, #3967
  static GameScreen + #171, #3967
  static GameScreen + #172, #3967
  static GameScreen + #173, #3967
  static GameScreen + #174, #3967
  static GameScreen + #175, #3967
  static GameScreen + #176, #3967
  static GameScreen + #177, #3967
  static GameScreen + #178, #3967
  static GameScreen + #179, #3967
  static GameScreen + #180, #3967
  static GameScreen + #181, #3967
  static GameScreen + #182, #3967
  static GameScreen + #183, #3967
  static GameScreen + #184, #3967
  static GameScreen + #185, #3967
  static GameScreen + #186, #3967
  static GameScreen + #187, #3967
  static GameScreen + #188, #3967
  static GameScreen + #189, #3967
  static GameScreen + #190, #3967
  static GameScreen + #191, #3967
  static GameScreen + #192, #3967
  static GameScreen + #193, #3967
  static GameScreen + #194, #3967
  static GameScreen + #195, #3967
  static GameScreen + #196, #3967
  static GameScreen + #197, #3967
  static GameScreen + #198, #3967
  static GameScreen + #199, #2825

  ;Linha 5
  static GameScreen + #200, #2825
  static GameScreen + #201, #3967
  static GameScreen + #202, #3967
  static GameScreen + #203, #3967
  static GameScreen + #204, #3967
  static GameScreen + #205, #3967
  static GameScreen + #206, #3967
  static GameScreen + #207, #3967
  static GameScreen + #208, #3967
  static GameScreen + #209, #3967
  static GameScreen + #210, #3967
  static GameScreen + #211, #3967
  static GameScreen + #212, #3967
  static GameScreen + #213, #3967
  static GameScreen + #214, #3967
  static GameScreen + #215, #3967
  static GameScreen + #216, #3967
  static GameScreen + #217, #3967
  static GameScreen + #218, #3967
  static GameScreen + #219, #3967
  static GameScreen + #220, #3967
  static GameScreen + #221, #3967
  static GameScreen + #222, #3967
  static GameScreen + #223, #3967
  static GameScreen + #224, #3967
  static GameScreen + #225, #3967
  static GameScreen + #226, #3967
  static GameScreen + #227, #3967
  static GameScreen + #228, #3967
  static GameScreen + #229, #3967
  static GameScreen + #230, #3967
  static GameScreen + #231, #3967
  static GameScreen + #232, #3967
  static GameScreen + #233, #3967
  static GameScreen + #234, #3967
  static GameScreen + #235, #3967
  static GameScreen + #236, #3967
  static GameScreen + #237, #3967
  static GameScreen + #238, #3967
  static GameScreen + #239, #2825

  ;Linha 6
  static GameScreen + #240, #2825
  static GameScreen + #241, #3967
  static GameScreen + #242, #3967
  static GameScreen + #243, #3967
  static GameScreen + #244, #3967
  static GameScreen + #245, #3967
  static GameScreen + #246, #3967
  static GameScreen + #247, #3967
  static GameScreen + #248, #3967
  static GameScreen + #249, #3967
  static GameScreen + #250, #3967
  static GameScreen + #251, #3967
  static GameScreen + #252, #3967
  static GameScreen + #253, #3967
  static GameScreen + #254, #3967
  static GameScreen + #255, #3967
  static GameScreen + #256, #3967
  static GameScreen + #257, #3967
  static GameScreen + #258, #3967
  static GameScreen + #259, #3967
  static GameScreen + #260, #3967
  static GameScreen + #261, #3967
  static GameScreen + #262, #3967
  static GameScreen + #263, #3967
  static GameScreen + #264, #3967
  static GameScreen + #265, #3967
  static GameScreen + #266, #3967
  static GameScreen + #267, #3967
  static GameScreen + #268, #3967
  static GameScreen + #269, #3967
  static GameScreen + #270, #3081
  static GameScreen + #271, #3081
  static GameScreen + #272, #3081
  static GameScreen + #273, #3967
  static GameScreen + #274, #3967
  static GameScreen + #275, #3967
  static GameScreen + #276, #3967
  static GameScreen + #277, #3967
  static GameScreen + #278, #3967
  static GameScreen + #279, #2825

  ;Linha 7
  static GameScreen + #280, #2825
  static GameScreen + #281, #3967
  static GameScreen + #282, #3967
  static GameScreen + #283, #3967
  static GameScreen + #284, #3967
  static GameScreen + #285, #3967
  static GameScreen + #286, #3967
  static GameScreen + #287, #3967
  static GameScreen + #288, #3967
  static GameScreen + #289, #3967
  static GameScreen + #290, #3967
  static GameScreen + #291, #3967
  static GameScreen + #292, #3967
  static GameScreen + #293, #3967
  static GameScreen + #294, #3967
  static GameScreen + #295, #3967
  static GameScreen + #296, #3967
  static GameScreen + #297, #3967
  static GameScreen + #298, #3967
  static GameScreen + #299, #3967
  static GameScreen + #300, #3967
  static GameScreen + #301, #3967
  static GameScreen + #302, #3967
  static GameScreen + #303, #3967
  static GameScreen + #304, #3967
  static GameScreen + #305, #3967
  static GameScreen + #306, #3967
  static GameScreen + #307, #3967
  static GameScreen + #308, #3967
  static GameScreen + #309, #3967
  static GameScreen + #310, #3081
  static GameScreen + #311, #3081
  static GameScreen + #312, #3081
  static GameScreen + #313, #3967
  static GameScreen + #314, #3967
  static GameScreen + #315, #3967
  static GameScreen + #316, #3967
  static GameScreen + #317, #3967
  static GameScreen + #318, #3967
  static GameScreen + #319, #2825

  ;Linha 8
  static GameScreen + #320, #2825
  static GameScreen + #321, #3967
  static GameScreen + #322, #3967
  static GameScreen + #323, #3967
  static GameScreen + #324, #3967
  static GameScreen + #325, #3967
  static GameScreen + #326, #3967
  static GameScreen + #327, #3967
  static GameScreen + #328, #3967
  static GameScreen + #329, #265
  static GameScreen + #330, #265
  static GameScreen + #331, #265
  static GameScreen + #332, #2313
  static GameScreen + #333, #2313
  static GameScreen + #334, #2313
  static GameScreen + #335, #2313
  static GameScreen + #336, #2313
  static GameScreen + #337, #2313
  static GameScreen + #338, #2313
  static GameScreen + #339, #2313
  static GameScreen + #340, #2313
  static GameScreen + #341, #2313
  static GameScreen + #342, #2313
  static GameScreen + #343, #2313
  static GameScreen + #344, #2313
  static GameScreen + #345, #2313
  static GameScreen + #346, #2313
  static GameScreen + #347, #265
  static GameScreen + #348, #265
  static GameScreen + #349, #265
  static GameScreen + #350, #3081
  static GameScreen + #351, #3081
  static GameScreen + #352, #3081
  static GameScreen + #353, #3967
  static GameScreen + #354, #3967
  static GameScreen + #355, #3967
  static GameScreen + #356, #3967
  static GameScreen + #357, #3967
  static GameScreen + #358, #3967
  static GameScreen + #359, #2825

  ;Linha 9
  static GameScreen + #360, #2825
  static GameScreen + #361, #3967
  static GameScreen + #362, #3967
  static GameScreen + #363, #3967
  static GameScreen + #364, #3967
  static GameScreen + #365, #3967
  static GameScreen + #366, #3967
  static GameScreen + #367, #3967
  static GameScreen + #368, #3967
  static GameScreen + #369, #265
  static GameScreen + #370, #265
  static GameScreen + #371, #2313
  static GameScreen + #372, #2313
  static GameScreen + #373, #2313
  static GameScreen + #374, #2313
  static GameScreen + #375, #2313
  static GameScreen + #376, #2313
  static GameScreen + #377, #2313
  static GameScreen + #378, #2313
  static GameScreen + #379, #2313
  static GameScreen + #380, #2313
  static GameScreen + #381, #2313
  static GameScreen + #382, #2313
  static GameScreen + #383, #2313
  static GameScreen + #384, #2313
  static GameScreen + #385, #2313
  static GameScreen + #386, #2313
  static GameScreen + #387, #2313
  static GameScreen + #388, #265
  static GameScreen + #389, #265
  static GameScreen + #390, #3967
  static GameScreen + #391, #1545
  static GameScreen + #392, #3967
  static GameScreen + #393, #3967
  static GameScreen + #394, #3967
  static GameScreen + #395, #3967
  static GameScreen + #396, #3967
  static GameScreen + #397, #3967
  static GameScreen + #398, #3967
  static GameScreen + #399, #2825

  ;Linha 10
  static GameScreen + #400, #2825
  static GameScreen + #401, #3967
  static GameScreen + #402, #3967
  static GameScreen + #403, #2825
  static GameScreen + #404, #2825
  static GameScreen + #405, #2825
  static GameScreen + #406, #2825
  static GameScreen + #407, #2825
  static GameScreen + #408, #3967
  static GameScreen + #409, #265
  static GameScreen + #410, #2313
  static GameScreen + #411, #9
  static GameScreen + #412, #9
  static GameScreen + #413, #9
  static GameScreen + #414, #9
  static GameScreen + #415, #9
  static GameScreen + #416, #9
  static GameScreen + #417, #9
  static GameScreen + #418, #9
  static GameScreen + #419, #9
  static GameScreen + #420, #9
  static GameScreen + #421, #9
  static GameScreen + #422, #9
  static GameScreen + #423, #9
  static GameScreen + #424, #9
  static GameScreen + #425, #9
  static GameScreen + #426, #9
  static GameScreen + #427, #9
  static GameScreen + #428, #2313
  static GameScreen + #429, #265
  static GameScreen + #430, #3967
  static GameScreen + #431, #1545
  static GameScreen + #432, #3967
  static GameScreen + #433, #3967
  static GameScreen + #434, #3967
  static GameScreen + #435, #3967
  static GameScreen + #436, #3967
  static GameScreen + #437, #3967
  static GameScreen + #438, #3967
  static GameScreen + #439, #2825

  ;Linha 11
  static GameScreen + #440, #2825
  static GameScreen + #441, #3967
  static GameScreen + #442, #3967
  static GameScreen + #443, #2825
  static GameScreen + #444, #3967
  static GameScreen + #445, #3967
  static GameScreen + #446, #3967
  static GameScreen + #447, #2825
  static GameScreen + #448, #2825
  static GameScreen + #449, #265
  static GameScreen + #450, #2313
  static GameScreen + #451, #2825
  static GameScreen + #452, #9
  static GameScreen + #453, #9
  static GameScreen + #454, #9
  static GameScreen + #455, #9
  static GameScreen + #456, #9
  static GameScreen + #457, #9
  static GameScreen + #458, #9
  static GameScreen + #459, #9
  static GameScreen + #460, #9
  static GameScreen + #461, #9
  static GameScreen + #462, #9
  static GameScreen + #463, #9
  static GameScreen + #464, #9
  static GameScreen + #465, #9
  static GameScreen + #466, #9
  static GameScreen + #467, #2825
  static GameScreen + #468, #2313
  static GameScreen + #469, #265
  static GameScreen + #470, #3967
  static GameScreen + #471, #1545
  static GameScreen + #472, #3967
  static GameScreen + #473, #3967
  static GameScreen + #474, #3967
  static GameScreen + #475, #3967
  static GameScreen + #476, #3967
  static GameScreen + #477, #3967
  static GameScreen + #478, #3967
  static GameScreen + #479, #2825

  ;Linha 12
  static GameScreen + #480, #2825
  static GameScreen + #481, #3967
  static GameScreen + #482, #3967
  static GameScreen + #483, #2825
  static GameScreen + #484, #3967
  static GameScreen + #485, #69
  static GameScreen + #486, #3967
  static GameScreen + #487, #2825
  static GameScreen + #488, #3967
  static GameScreen + #489, #265
  static GameScreen + #490, #2313
  static GameScreen + #491, #9
  static GameScreen + #492, #2825
  static GameScreen + #493, #3081
  static GameScreen + #494, #3081
  static GameScreen + #495, #3081
  static GameScreen + #496, #3081
  static GameScreen + #497, #3081
  static GameScreen + #498, #3081
  static GameScreen + #499, #3081
  static GameScreen + #500, #3081
  static GameScreen + #501, #3081
  static GameScreen + #502, #3081
  static GameScreen + #503, #3081
  static GameScreen + #504, #3081
  static GameScreen + #505, #3081
  static GameScreen + #506, #2825
  static GameScreen + #507, #9
  static GameScreen + #508, #2313
  static GameScreen + #509, #265
  static GameScreen + #510, #3967
  static GameScreen + #511, #1545
  static GameScreen + #512, #3967
  static GameScreen + #513, #3967
  static GameScreen + #514, #3967
  static GameScreen + #515, #3967
  static GameScreen + #516, #3967
  static GameScreen + #517, #3967
  static GameScreen + #518, #3967
  static GameScreen + #519, #2825

  ;Linha 13
  static GameScreen + #520, #2825
  static GameScreen + #521, #3967
  static GameScreen + #522, #3967
  static GameScreen + #523, #2825
  static GameScreen + #524, #3967
  static GameScreen + #525, #78
  static GameScreen + #526, #3967
  static GameScreen + #527, #2825
  static GameScreen + #528, #3967
  static GameScreen + #529, #265
  static GameScreen + #530, #2313
  static GameScreen + #531, #2825
  static GameScreen + #532, #9
  static GameScreen + #533, #3081
  static GameScreen + #534, #3967
  static GameScreen + #535, #3967
  static GameScreen + #536, #3967
  static GameScreen + #537, #3081
  static GameScreen + #538, #3967
  static GameScreen + #539, #3967
  static GameScreen + #540, #3967
  static GameScreen + #541, #3081
  static GameScreen + #542, #3967
  static GameScreen + #543, #3967
  static GameScreen + #544, #3967
  static GameScreen + #545, #3081
  static GameScreen + #546, #9
  static GameScreen + #547, #2825
  static GameScreen + #548, #2313
  static GameScreen + #549, #265
  static GameScreen + #550, #1545
  static GameScreen + #551, #3967
  static GameScreen + #552, #3967
  static GameScreen + #553, #3967
  static GameScreen + #554, #3967
  static GameScreen + #555, #3967
  static GameScreen + #556, #3967
  static GameScreen + #557, #3967
  static GameScreen + #558, #3967
  static GameScreen + #559, #2825

  ;Linha 14
  static GameScreen + #560, #2825
  static GameScreen + #561, #3967
  static GameScreen + #562, #3967
  static GameScreen + #563, #2825
  static GameScreen + #564, #3967
  static GameScreen + #565, #84
  static GameScreen + #566, #3967
  static GameScreen + #567, #2825
  static GameScreen + #568, #3967
  static GameScreen + #569, #265
  static GameScreen + #570, #2313
  static GameScreen + #571, #9
  static GameScreen + #572, #2825
  static GameScreen + #573, #3081
  static GameScreen + #574, #3967
  static GameScreen + #575, #3967
  static GameScreen + #576, #3967
  static GameScreen + #577, #3081
  static GameScreen + #578, #3967
  static GameScreen + #579, #3967
  static GameScreen + #580, #3967
  static GameScreen + #581, #3081
  static GameScreen + #582, #3967
  static GameScreen + #583, #3967
  static GameScreen + #584, #3967
  static GameScreen + #585, #3081
  static GameScreen + #586, #2825
  static GameScreen + #587, #9
  static GameScreen + #588, #2313
  static GameScreen + #589, #1289
  static GameScreen + #590, #1545
  static GameScreen + #591, #1289
  static GameScreen + #592, #3967
  static GameScreen + #593, #3967
  static GameScreen + #594, #3967
  static GameScreen + #595, #3967
  static GameScreen + #596, #3967
  static GameScreen + #597, #3967
  static GameScreen + #598, #3967
  static GameScreen + #599, #2825

  ;Linha 15
  static GameScreen + #600, #2825
  static GameScreen + #601, #3967
  static GameScreen + #602, #3967
  static GameScreen + #603, #2825
  static GameScreen + #604, #3967
  static GameScreen + #605, #69
  static GameScreen + #606, #3967
  static GameScreen + #607, #2825
  static GameScreen + #608, #3967
  static GameScreen + #609, #265
  static GameScreen + #610, #2313
  static GameScreen + #611, #2825
  static GameScreen + #612, #9
  static GameScreen + #613, #3081
  static GameScreen + #614, #3967
  static GameScreen + #615, #3967
  static GameScreen + #616, #3967
  static GameScreen + #617, #3081
  static GameScreen + #618, #3967
  static GameScreen + #619, #3967
  static GameScreen + #620, #3967
  static GameScreen + #621, #3081
  static GameScreen + #622, #3967
  static GameScreen + #623, #3967
  static GameScreen + #624, #3967
  static GameScreen + #625, #3081
  static GameScreen + #626, #9
  static GameScreen + #627, #2825
  static GameScreen + #628, #2313
  static GameScreen + #629, #1289
  static GameScreen + #630, #1545
  static GameScreen + #631, #1289
  static GameScreen + #632, #3967
  static GameScreen + #633, #3967
  static GameScreen + #634, #3967
  static GameScreen + #635, #3967
  static GameScreen + #636, #3967
  static GameScreen + #637, #3967
  static GameScreen + #638, #3967
  static GameScreen + #639, #2825

  ;Linha 16
  static GameScreen + #640, #2825
  static GameScreen + #641, #3967
  static GameScreen + #642, #3967
  static GameScreen + #643, #2825
  static GameScreen + #644, #3967
  static GameScreen + #645, #82
  static GameScreen + #646, #3967
  static GameScreen + #647, #2825
  static GameScreen + #648, #3967
  static GameScreen + #649, #265
  static GameScreen + #650, #2313
  static GameScreen + #651, #9
  static GameScreen + #652, #2825
  static GameScreen + #653, #3081
  static GameScreen + #654, #3081
  static GameScreen + #655, #3081
  static GameScreen + #656, #3081
  static GameScreen + #657, #3081
  static GameScreen + #658, #3081
  static GameScreen + #659, #3081
  static GameScreen + #660, #3081
  static GameScreen + #661, #3081
  static GameScreen + #662, #3081
  static GameScreen + #663, #3081
  static GameScreen + #664, #3081
  static GameScreen + #665, #3081
  static GameScreen + #666, #2825
  static GameScreen + #667, #9
  static GameScreen + #668, #2313
  static GameScreen + #669, #1289
  static GameScreen + #670, #1545
  static GameScreen + #671, #1289
  static GameScreen + #672, #3967
  static GameScreen + #673, #3967
  static GameScreen + #674, #3967
  static GameScreen + #675, #3967
  static GameScreen + #676, #3967
  static GameScreen + #677, #3967
  static GameScreen + #678, #3967
  static GameScreen + #679, #2825

  ;Linha 17
  static GameScreen + #680, #2825
  static GameScreen + #681, #3967
  static GameScreen + #682, #3967
  static GameScreen + #683, #2825
  static GameScreen + #684, #3967
  static GameScreen + #685, #3967
  static GameScreen + #686, #3967
  static GameScreen + #687, #2825
  static GameScreen + #688, #2825
  static GameScreen + #689, #2313
  static GameScreen + #690, #2313
  static GameScreen + #691, #2825
  static GameScreen + #692, #9
  static GameScreen + #693, #9
  static GameScreen + #694, #9
  static GameScreen + #695, #9
  static GameScreen + #696, #9
  static GameScreen + #697, #9
  static GameScreen + #698, #9
  static GameScreen + #699, #9
  static GameScreen + #700, #9
  static GameScreen + #701, #9
  static GameScreen + #702, #9
  static GameScreen + #703, #9
  static GameScreen + #704, #9
  static GameScreen + #705, #9
  static GameScreen + #706, #9
  static GameScreen + #707, #2825
  static GameScreen + #708, #2313
  static GameScreen + #709, #2313
  static GameScreen + #710, #1545
  static GameScreen + #711, #1289
  static GameScreen + #712, #3967
  static GameScreen + #713, #3967
  static GameScreen + #714, #3967
  static GameScreen + #715, #3967
  static GameScreen + #716, #3967
  static GameScreen + #717, #3967
  static GameScreen + #718, #3967
  static GameScreen + #719, #2825

  ;Linha 18
  static GameScreen + #720, #2825
  static GameScreen + #721, #3967
  static GameScreen + #722, #3967
  static GameScreen + #723, #2825
  static GameScreen + #724, #2825
  static GameScreen + #725, #2825
  static GameScreen + #726, #2825
  static GameScreen + #727, #2825
  static GameScreen + #728, #3967
  static GameScreen + #729, #2313
  static GameScreen + #730, #2313
  static GameScreen + #731, #9
  static GameScreen + #732, #2825
  static GameScreen + #733, #9
  static GameScreen + #734, #9
  static GameScreen + #735, #9
  static GameScreen + #736, #9
  static GameScreen + #737, #9
  static GameScreen + #738, #9
  static GameScreen + #739, #9
  static GameScreen + #740, #9
  static GameScreen + #741, #9
  static GameScreen + #742, #9
  static GameScreen + #743, #9
  static GameScreen + #744, #9
  static GameScreen + #745, #9
  static GameScreen + #746, #2825
  static GameScreen + #747, #9
  static GameScreen + #748, #2313
  static GameScreen + #749, #2313
  static GameScreen + #750, #1289
  static GameScreen + #751, #1289
  static GameScreen + #752, #3967
  static GameScreen + #753, #3967
  static GameScreen + #754, #3967
  static GameScreen + #755, #3967
  static GameScreen + #756, #3967
  static GameScreen + #757, #3967
  static GameScreen + #758, #3967
  static GameScreen + #759, #2825

  ;Linha 19
  static GameScreen + #760, #2825
  static GameScreen + #761, #3967
  static GameScreen + #762, #3967
  static GameScreen + #763, #3967
  static GameScreen + #764, #3967
  static GameScreen + #765, #3967
  static GameScreen + #766, #3967
  static GameScreen + #767, #3967
  static GameScreen + #768, #3967
  static GameScreen + #769, #2313
  static GameScreen + #770, #2313
  static GameScreen + #771, #2825
  static GameScreen + #772, #9
  static GameScreen + #773, #9
  static GameScreen + #774, #9
  static GameScreen + #775, #9
  static GameScreen + #776, #9
  static GameScreen + #777, #9
  static GameScreen + #778, #9
  static GameScreen + #779, #9
  static GameScreen + #780, #9
  static GameScreen + #781, #9
  static GameScreen + #782, #9
  static GameScreen + #783, #9
  static GameScreen + #784, #9
  static GameScreen + #785, #9
  static GameScreen + #786, #9
  static GameScreen + #787, #2825
  static GameScreen + #788, #2313
  static GameScreen + #789, #2313
  static GameScreen + #790, #1289
  static GameScreen + #791, #1289
  static GameScreen + #792, #3967
  static GameScreen + #793, #3967
  static GameScreen + #794, #3967
  static GameScreen + #795, #3967
  static GameScreen + #796, #3967
  static GameScreen + #797, #3967
  static GameScreen + #798, #3967
  static GameScreen + #799, #2825

  ;Linha 20
  static GameScreen + #800, #2825
  static GameScreen + #801, #3967
  static GameScreen + #802, #3967
  static GameScreen + #803, #3967
  static GameScreen + #804, #3967
  static GameScreen + #805, #3967
  static GameScreen + #806, #3967
  static GameScreen + #807, #3967
  static GameScreen + #808, #3967
  static GameScreen + #809, #265
  static GameScreen + #810, #265
  static GameScreen + #811, #265
  static GameScreen + #812, #265
  static GameScreen + #813, #265
  static GameScreen + #814, #265
  static GameScreen + #815, #265
  static GameScreen + #816, #265
  static GameScreen + #817, #265
  static GameScreen + #818, #265
  static GameScreen + #819, #265
  static GameScreen + #820, #265
  static GameScreen + #821, #265
  static GameScreen + #822, #265
  static GameScreen + #823, #265
  static GameScreen + #824, #265
  static GameScreen + #825, #265
  static GameScreen + #826, #265
  static GameScreen + #827, #265
  static GameScreen + #828, #265
  static GameScreen + #829, #265
  static GameScreen + #830, #1289
  static GameScreen + #831, #1289
  static GameScreen + #832, #3967
  static GameScreen + #833, #3967
  static GameScreen + #834, #3967
  static GameScreen + #835, #3967
  static GameScreen + #836, #3967
  static GameScreen + #837, #3967
  static GameScreen + #838, #3967
  static GameScreen + #839, #2825

  ;Linha 21
  static GameScreen + #840, #2825
  static GameScreen + #841, #3967
  static GameScreen + #842, #3967
  static GameScreen + #843, #3967
  static GameScreen + #844, #3967
  static GameScreen + #845, #3967
  static GameScreen + #846, #3967
  static GameScreen + #847, #3967
  static GameScreen + #848, #3967
  static GameScreen + #849, #1033
  static GameScreen + #850, #3081
  static GameScreen + #851, #1033
  static GameScreen + #852, #265
  static GameScreen + #853, #265
  static GameScreen + #854, #265
  static GameScreen + #855, #265
  static GameScreen + #856, #265
  static GameScreen + #857, #265
  static GameScreen + #858, #265
  static GameScreen + #859, #265
  static GameScreen + #860, #265
  static GameScreen + #861, #265
  static GameScreen + #862, #265
  static GameScreen + #863, #265
  static GameScreen + #864, #265
  static GameScreen + #865, #265
  static GameScreen + #866, #265
  static GameScreen + #867, #1033
  static GameScreen + #868, #3081
  static GameScreen + #869, #1033
  static GameScreen + #870, #3967
  static GameScreen + #871, #3967
  static GameScreen + #872, #3967
  static GameScreen + #873, #3967
  static GameScreen + #874, #3967
  static GameScreen + #875, #3967
  static GameScreen + #876, #3967
  static GameScreen + #877, #3967
  static GameScreen + #878, #3967
  static GameScreen + #879, #2825

  ;Linha 22
  static GameScreen + #880, #2825
  static GameScreen + #881, #3967
  static GameScreen + #882, #3967
  static GameScreen + #883, #3967
  static GameScreen + #884, #3967
  static GameScreen + #885, #3967
  static GameScreen + #886, #3967
  static GameScreen + #887, #3967
  static GameScreen + #888, #1033
  static GameScreen + #889, #3081
  static GameScreen + #890, #1033
  static GameScreen + #891, #2313
  static GameScreen + #892, #2825
  static GameScreen + #893, #2313
  static GameScreen + #894, #2313
  static GameScreen + #895, #2313
  static GameScreen + #896, #2313
  static GameScreen + #897, #2313
  static GameScreen + #898, #2313
  static GameScreen + #899, #2313
  static GameScreen + #900, #2313
  static GameScreen + #901, #2313
  static GameScreen + #902, #2313
  static GameScreen + #903, #2313
  static GameScreen + #904, #2313
  static GameScreen + #905, #2313
  static GameScreen + #906, #2825
  static GameScreen + #907, #2313
  static GameScreen + #908, #1033
  static GameScreen + #909, #3081
  static GameScreen + #910, #1033
  static GameScreen + #911, #3967
  static GameScreen + #912, #3967
  static GameScreen + #913, #3967
  static GameScreen + #914, #3967
  static GameScreen + #915, #3967
  static GameScreen + #916, #3967
  static GameScreen + #917, #3967
  static GameScreen + #918, #3967
  static GameScreen + #919, #2825

  ;Linha 23
  static GameScreen + #920, #2825
  static GameScreen + #921, #3967
  static GameScreen + #922, #3967
  static GameScreen + #923, #3967
  static GameScreen + #924, #3967
  static GameScreen + #925, #3967
  static GameScreen + #926, #3967
  static GameScreen + #927, #1033
  static GameScreen + #928, #3081
  static GameScreen + #929, #1033
  static GameScreen + #930, #2313
  static GameScreen + #931, #2313
  static GameScreen + #932, #2313
  static GameScreen + #933, #2313
  static GameScreen + #934, #2313
  static GameScreen + #935, #2313
  static GameScreen + #936, #2313
  static GameScreen + #937, #2313
  static GameScreen + #938, #2313
  static GameScreen + #939, #2313
  static GameScreen + #940, #2313
  static GameScreen + #941, #2313
  static GameScreen + #942, #2313
  static GameScreen + #943, #2313
  static GameScreen + #944, #2313
  static GameScreen + #945, #2825
  static GameScreen + #946, #2825
  static GameScreen + #947, #2313
  static GameScreen + #948, #2313
  static GameScreen + #949, #1033
  static GameScreen + #950, #3081
  static GameScreen + #951, #1033
  static GameScreen + #952, #3967
  static GameScreen + #953, #3967
  static GameScreen + #954, #3967
  static GameScreen + #955, #3967
  static GameScreen + #956, #3967
  static GameScreen + #957, #3967
  static GameScreen + #958, #3967
  static GameScreen + #959, #2825

  ;Linha 24
  static GameScreen + #960, #2825
  static GameScreen + #961, #3967
  static GameScreen + #962, #3967
  static GameScreen + #963, #3967
  static GameScreen + #964, #3967
  static GameScreen + #965, #3967
  static GameScreen + #966, #1033
  static GameScreen + #967, #3081
  static GameScreen + #968, #1033
  static GameScreen + #969, #2313
  static GameScreen + #970, #2313
  static GameScreen + #971, #2313
  static GameScreen + #972, #2313
  static GameScreen + #973, #2313
  static GameScreen + #974, #2313
  static GameScreen + #975, #2313
  static GameScreen + #976, #2313
  static GameScreen + #977, #2313
  static GameScreen + #978, #2313
  static GameScreen + #979, #2313
  static GameScreen + #980, #2313
  static GameScreen + #981, #2313
  static GameScreen + #982, #2313
  static GameScreen + #983, #2313
  static GameScreen + #984, #2313
  static GameScreen + #985, #2313
  static GameScreen + #986, #2313
  static GameScreen + #987, #2313
  static GameScreen + #988, #2313
  static GameScreen + #989, #2313
  static GameScreen + #990, #1033
  static GameScreen + #991, #3081
  static GameScreen + #992, #1033
  static GameScreen + #993, #3967
  static GameScreen + #994, #3967
  static GameScreen + #995, #3967
  static GameScreen + #996, #3967
  static GameScreen + #997, #3967
  static GameScreen + #998, #3967
  static GameScreen + #999, #2825

  ;Linha 25
  static GameScreen + #1000, #2825
  static GameScreen + #1001, #3967
  static GameScreen + #1002, #3967
  static GameScreen + #1003, #3967
  static GameScreen + #1004, #3967
  static GameScreen + #1005, #3967
  static GameScreen + #1006, #265
  static GameScreen + #1007, #265
  static GameScreen + #1008, #265
  static GameScreen + #1009, #265
  static GameScreen + #1010, #265
  static GameScreen + #1011, #265
  static GameScreen + #1012, #265
  static GameScreen + #1013, #265
  static GameScreen + #1014, #265
  static GameScreen + #1015, #265
  static GameScreen + #1016, #265
  static GameScreen + #1017, #265
  static GameScreen + #1018, #265
  static GameScreen + #1019, #265
  static GameScreen + #1020, #265
  static GameScreen + #1021, #265
  static GameScreen + #1022, #265
  static GameScreen + #1023, #265
  static GameScreen + #1024, #265
  static GameScreen + #1025, #265
  static GameScreen + #1026, #265
  static GameScreen + #1027, #265
  static GameScreen + #1028, #265
  static GameScreen + #1029, #265
  static GameScreen + #1030, #265
  static GameScreen + #1031, #265
  static GameScreen + #1032, #265
  static GameScreen + #1033, #3967
  static GameScreen + #1034, #3967
  static GameScreen + #1035, #3967
  static GameScreen + #1036, #3967
  static GameScreen + #1037, #3967
  static GameScreen + #1038, #3967
  static GameScreen + #1039, #2825

  ;Linha 26
  static GameScreen + #1040, #2825
  static GameScreen + #1041, #3967
  static GameScreen + #1042, #3967
  static GameScreen + #1043, #3967
  static GameScreen + #1044, #3967
  static GameScreen + #1045, #3967
  static GameScreen + #1046, #265
  static GameScreen + #1047, #265
  static GameScreen + #1048, #265
  static GameScreen + #1049, #2825
  static GameScreen + #1050, #3081
  static GameScreen + #1051, #3081
  static GameScreen + #1052, #2313
  static GameScreen + #1053, #2313
  static GameScreen + #1054, #2313
  static GameScreen + #1055, #2313
  static GameScreen + #1056, #2313
  static GameScreen + #1057, #2313
  static GameScreen + #1058, #2313
  static GameScreen + #1059, #2313
  static GameScreen + #1060, #2313
  static GameScreen + #1061, #2313
  static GameScreen + #1062, #2313
  static GameScreen + #1063, #2313
  static GameScreen + #1064, #2313
  static GameScreen + #1065, #2313
  static GameScreen + #1066, #2313
  static GameScreen + #1067, #3081
  static GameScreen + #1068, #3081
  static GameScreen + #1069, #2825
  static GameScreen + #1070, #265
  static GameScreen + #1071, #265
  static GameScreen + #1072, #265
  static GameScreen + #1073, #3967
  static GameScreen + #1074, #3967
  static GameScreen + #1075, #3967
  static GameScreen + #1076, #3967
  static GameScreen + #1077, #3967
  static GameScreen + #1078, #3967
  static GameScreen + #1079, #2825

  ;Linha 27
  static GameScreen + #1080, #2825
  static GameScreen + #1081, #3967
  static GameScreen + #1082, #3967
  static GameScreen + #1083, #3967
  static GameScreen + #1084, #3967
  static GameScreen + #1085, #3967
  static GameScreen + #1086, #265
  static GameScreen + #1087, #265
  static GameScreen + #1088, #265
  static GameScreen + #1089, #3081
  static GameScreen + #1090, #2825
  static GameScreen + #1091, #3081
  static GameScreen + #1092, #2313
  static GameScreen + #1093, #265
  static GameScreen + #1094, #2313
  static GameScreen + #1095, #2313
  static GameScreen + #1096, #2313
  static GameScreen + #1097, #2313
  static GameScreen + #1098, #2313
  static GameScreen + #1099, #2313
  static GameScreen + #1100, #2313
  static GameScreen + #1101, #2313
  static GameScreen + #1102, #2313
  static GameScreen + #1103, #2313
  static GameScreen + #1104, #2313
  static GameScreen + #1105, #265
  static GameScreen + #1106, #2313
  static GameScreen + #1107, #3081
  static GameScreen + #1108, #2825
  static GameScreen + #1109, #3081
  static GameScreen + #1110, #265
  static GameScreen + #1111, #265
  static GameScreen + #1112, #265
  static GameScreen + #1113, #3967
  static GameScreen + #1114, #3967
  static GameScreen + #1115, #3967
  static GameScreen + #1116, #3967
  static GameScreen + #1117, #3967
  static GameScreen + #1118, #3967
  static GameScreen + #1119, #2825

  ;Linha 28
  static GameScreen + #1120, #2825
  static GameScreen + #1121, #3967
  static GameScreen + #1122, #3967
  static GameScreen + #1123, #3967
  static GameScreen + #1124, #3967
  static GameScreen + #1125, #3967
  static GameScreen + #1126, #265
  static GameScreen + #1127, #265
  static GameScreen + #1128, #265
  static GameScreen + #1129, #2825
  static GameScreen + #1130, #3081
  static GameScreen + #1131, #3081
  static GameScreen + #1132, #2313
  static GameScreen + #1133, #2313
  static GameScreen + #1134, #2313
  static GameScreen + #1135, #2313
  static GameScreen + #1136, #2313
  static GameScreen + #1137, #2313
  static GameScreen + #1138, #2313
  static GameScreen + #1139, #2313
  static GameScreen + #1140, #2313
  static GameScreen + #1141, #2313
  static GameScreen + #1142, #2313
  static GameScreen + #1143, #2313
  static GameScreen + #1144, #2313
  static GameScreen + #1145, #265
  static GameScreen + #1146, #2313
  static GameScreen + #1147, #3081
  static GameScreen + #1148, #3081
  static GameScreen + #1149, #2825
  static GameScreen + #1150, #265
  static GameScreen + #1151, #265
  static GameScreen + #1152, #265
  static GameScreen + #1153, #3967
  static GameScreen + #1154, #3967
  static GameScreen + #1155, #3967
  static GameScreen + #1156, #3967
  static GameScreen + #1157, #3967
  static GameScreen + #1158, #3967
  static GameScreen + #1159, #2825

  ;Linha 29
  static GameScreen + #1160, #2825
  static GameScreen + #1161, #2825
  static GameScreen + #1162, #2825
  static GameScreen + #1163, #2825
  static GameScreen + #1164, #2825
  static GameScreen + #1165, #2825
  static GameScreen + #1166, #265
  static GameScreen + #1167, #265
  static GameScreen + #1168, #265
  static GameScreen + #1169, #3081
  static GameScreen + #1170, #2825
  static GameScreen + #1171, #3081
  static GameScreen + #1172, #2313
  static GameScreen + #1173, #2313
  static GameScreen + #1174, #2313
  static GameScreen + #1175, #2313
  static GameScreen + #1176, #2313
  static GameScreen + #1177, #2313
  static GameScreen + #1178, #2313
  static GameScreen + #1179, #2313
  static GameScreen + #1180, #2313
  static GameScreen + #1181, #2313
  static GameScreen + #1182, #2313
  static GameScreen + #1183, #2313
  static GameScreen + #1184, #2313
  static GameScreen + #1185, #2313
  static GameScreen + #1186, #2313
  static GameScreen + #1187, #3081
  static GameScreen + #1188, #2825
  static GameScreen + #1189, #3081
  static GameScreen + #1190, #265
  static GameScreen + #1191, #265
  static GameScreen + #1192, #265
  static GameScreen + #1193, #2825
  static GameScreen + #1194, #2825
  static GameScreen + #1195, #2825
  static GameScreen + #1196, #2825
  static GameScreen + #1197, #2825
  static GameScreen + #1198, #2825
  static GameScreen + #1199, #2825
;

InitialScreen1 : var #1200
  ;Linha 0
  static InitialScreen1 + #0, #2825
  static InitialScreen1 + #1, #2825
  static InitialScreen1 + #2, #2825
  static InitialScreen1 + #3, #2825
  static InitialScreen1 + #4, #2825
  static InitialScreen1 + #5, #2825
  static InitialScreen1 + #6, #2825
  static InitialScreen1 + #7, #2825
  static InitialScreen1 + #8, #2825
  static InitialScreen1 + #9, #2825
  static InitialScreen1 + #10, #2825
  static InitialScreen1 + #11, #2825
  static InitialScreen1 + #12, #2825
  static InitialScreen1 + #13, #2825
  static InitialScreen1 + #14, #2825
  static InitialScreen1 + #15, #2825
  static InitialScreen1 + #16, #2825
  static InitialScreen1 + #17, #2825
  static InitialScreen1 + #18, #2825
  static InitialScreen1 + #19, #2825
  static InitialScreen1 + #20, #2825
  static InitialScreen1 + #21, #2825
  static InitialScreen1 + #22, #2825
  static InitialScreen1 + #23, #2825
  static InitialScreen1 + #24, #2825
  static InitialScreen1 + #25, #2825
  static InitialScreen1 + #26, #2825
  static InitialScreen1 + #27, #2825
  static InitialScreen1 + #28, #2825
  static InitialScreen1 + #29, #2825
  static InitialScreen1 + #30, #2825
  static InitialScreen1 + #31, #2825
  static InitialScreen1 + #32, #2825
  static InitialScreen1 + #33, #2825
  static InitialScreen1 + #34, #2825
  static InitialScreen1 + #35, #2825
  static InitialScreen1 + #36, #2825
  static InitialScreen1 + #37, #2825
  static InitialScreen1 + #38, #2825
  static InitialScreen1 + #39, #2825

  ;Linha 1
  static InitialScreen1 + #40, #2825
  static InitialScreen1 + #41, #3967
  static InitialScreen1 + #42, #3967
  static InitialScreen1 + #43, #3967
  static InitialScreen1 + #44, #3967
  static InitialScreen1 + #45, #3967
  static InitialScreen1 + #46, #3967
  static InitialScreen1 + #47, #3967
  static InitialScreen1 + #48, #3967
  static InitialScreen1 + #49, #3967
  static InitialScreen1 + #50, #3967
  static InitialScreen1 + #51, #3967
  static InitialScreen1 + #52, #3967
  static InitialScreen1 + #53, #3967
  static InitialScreen1 + #54, #3967
  static InitialScreen1 + #55, #3967
  static InitialScreen1 + #56, #3967
  static InitialScreen1 + #57, #3967
  static InitialScreen1 + #58, #3967
  static InitialScreen1 + #59, #3967
  static InitialScreen1 + #60, #3967
  static InitialScreen1 + #61, #3967
  static InitialScreen1 + #62, #3967
  static InitialScreen1 + #63, #3967
  static InitialScreen1 + #64, #3967
  static InitialScreen1 + #65, #3967
  static InitialScreen1 + #66, #3967
  static InitialScreen1 + #67, #3967
  static InitialScreen1 + #68, #3967
  static InitialScreen1 + #69, #3967
  static InitialScreen1 + #70, #3967
  static InitialScreen1 + #71, #3967
  static InitialScreen1 + #72, #3967
  static InitialScreen1 + #73, #3967
  static InitialScreen1 + #74, #3967
  static InitialScreen1 + #75, #3967
  static InitialScreen1 + #76, #3967
  static InitialScreen1 + #77, #3967
  static InitialScreen1 + #78, #3967
  static InitialScreen1 + #79, #2825

  ;Linha 2
  static InitialScreen1 + #80, #2825
  static InitialScreen1 + #81, #3967
  static InitialScreen1 + #82, #3967
  static InitialScreen1 + #83, #3967
  static InitialScreen1 + #84, #3967
  static InitialScreen1 + #85, #3967
  static InitialScreen1 + #86, #3967
  static InitialScreen1 + #87, #3967
  static InitialScreen1 + #88, #3967
  static InitialScreen1 + #89, #3967
  static InitialScreen1 + #90, #3967
  static InitialScreen1 + #91, #3967
  static InitialScreen1 + #92, #3967
  static InitialScreen1 + #93, #3967
  static InitialScreen1 + #94, #3967
  static InitialScreen1 + #95, #3967
  static InitialScreen1 + #96, #3967
  static InitialScreen1 + #97, #3967
  static InitialScreen1 + #98, #3967
  static InitialScreen1 + #99, #2313
  static InitialScreen1 + #100, #3967
  static InitialScreen1 + #101, #3967
  static InitialScreen1 + #102, #3967
  static InitialScreen1 + #103, #3967
  static InitialScreen1 + #104, #3967
  static InitialScreen1 + #105, #3967
  static InitialScreen1 + #106, #3967
  static InitialScreen1 + #107, #3967
  static InitialScreen1 + #108, #3967
  static InitialScreen1 + #109, #3967
  static InitialScreen1 + #110, #3967
  static InitialScreen1 + #111, #3967
  static InitialScreen1 + #112, #3967
  static InitialScreen1 + #113, #3967
  static InitialScreen1 + #114, #3967
  static InitialScreen1 + #115, #3967
  static InitialScreen1 + #116, #3967
  static InitialScreen1 + #117, #3967
  static InitialScreen1 + #118, #3967
  static InitialScreen1 + #119, #2825

  ;Linha 3
  static InitialScreen1 + #120, #2825
  static InitialScreen1 + #121, #3967
  static InitialScreen1 + #122, #3967
  static InitialScreen1 + #123, #3967
  static InitialScreen1 + #124, #3967
  static InitialScreen1 + #125, #3967
  static InitialScreen1 + #126, #3967
  static InitialScreen1 + #127, #3967
  static InitialScreen1 + #128, #3967
  static InitialScreen1 + #129, #3967
  static InitialScreen1 + #130, #3967
  static InitialScreen1 + #131, #3967
  static InitialScreen1 + #132, #3967
  static InitialScreen1 + #133, #3967
  static InitialScreen1 + #134, #3967
  static InitialScreen1 + #135, #3967
  static InitialScreen1 + #136, #3967
  static InitialScreen1 + #137, #3967
  static InitialScreen1 + #138, #3967
  static InitialScreen1 + #139, #2313
  static InitialScreen1 + #140, #2313
  static InitialScreen1 + #141, #3967
  static InitialScreen1 + #142, #3967
  static InitialScreen1 + #143, #3967
  static InitialScreen1 + #144, #3967
  static InitialScreen1 + #145, #3967
  static InitialScreen1 + #146, #3967
  static InitialScreen1 + #147, #3967
  static InitialScreen1 + #148, #3967
  static InitialScreen1 + #149, #3967
  static InitialScreen1 + #150, #3967
  static InitialScreen1 + #151, #3967
  static InitialScreen1 + #152, #3967
  static InitialScreen1 + #153, #3967
  static InitialScreen1 + #154, #3967
  static InitialScreen1 + #155, #3967
  static InitialScreen1 + #156, #3967
  static InitialScreen1 + #157, #3967
  static InitialScreen1 + #158, #3967
  static InitialScreen1 + #159, #2825

  ;Linha 4
  static InitialScreen1 + #160, #2825
  static InitialScreen1 + #161, #3967
  static InitialScreen1 + #162, #3967
  static InitialScreen1 + #163, #3967
  static InitialScreen1 + #164, #3967
  static InitialScreen1 + #165, #3967
  static InitialScreen1 + #166, #3967
  static InitialScreen1 + #167, #3967
  static InitialScreen1 + #168, #3967
  static InitialScreen1 + #169, #3967
  static InitialScreen1 + #170, #3967
  static InitialScreen1 + #171, #3967
  static InitialScreen1 + #172, #3967
  static InitialScreen1 + #173, #3967
  static InitialScreen1 + #174, #3967
  static InitialScreen1 + #175, #3967
  static InitialScreen1 + #176, #3967
  static InitialScreen1 + #177, #3967
  static InitialScreen1 + #178, #3967
  static InitialScreen1 + #179, #3967
  static InitialScreen1 + #180, #2313
  static InitialScreen1 + #181, #2313
  static InitialScreen1 + #182, #3967
  static InitialScreen1 + #183, #3967
  static InitialScreen1 + #184, #3967
  static InitialScreen1 + #185, #3967
  static InitialScreen1 + #186, #3967
  static InitialScreen1 + #187, #3967
  static InitialScreen1 + #188, #3967
  static InitialScreen1 + #189, #3967
  static InitialScreen1 + #190, #3967
  static InitialScreen1 + #191, #3967
  static InitialScreen1 + #192, #3967
  static InitialScreen1 + #193, #3967
  static InitialScreen1 + #194, #3967
  static InitialScreen1 + #195, #3967
  static InitialScreen1 + #196, #3967
  static InitialScreen1 + #197, #3967
  static InitialScreen1 + #198, #3967
  static InitialScreen1 + #199, #2825

  ;Linha 5
  static InitialScreen1 + #200, #2825
  static InitialScreen1 + #201, #3967
  static InitialScreen1 + #202, #3967
  static InitialScreen1 + #203, #3967
  static InitialScreen1 + #204, #3967
  static InitialScreen1 + #205, #3967
  static InitialScreen1 + #206, #3967
  static InitialScreen1 + #207, #3967
  static InitialScreen1 + #208, #3967
  static InitialScreen1 + #209, #3967
  static InitialScreen1 + #210, #3967
  static InitialScreen1 + #211, #3967
  static InitialScreen1 + #212, #3967
  static InitialScreen1 + #213, #3967
  static InitialScreen1 + #214, #3967
  static InitialScreen1 + #215, #3967
  static InitialScreen1 + #216, #3967
  static InitialScreen1 + #217, #3967
  static InitialScreen1 + #218, #3967
  static InitialScreen1 + #219, #3967
  static InitialScreen1 + #220, #2313
  static InitialScreen1 + #221, #2313
  static InitialScreen1 + #222, #3967
  static InitialScreen1 + #223, #3967
  static InitialScreen1 + #224, #3967
  static InitialScreen1 + #225, #3967
  static InitialScreen1 + #226, #3967
  static InitialScreen1 + #227, #3967
  static InitialScreen1 + #228, #3967
  static InitialScreen1 + #229, #3967
  static InitialScreen1 + #230, #3967
  static InitialScreen1 + #231, #3967
  static InitialScreen1 + #232, #3967
  static InitialScreen1 + #233, #3967
  static InitialScreen1 + #234, #3967
  static InitialScreen1 + #235, #3967
  static InitialScreen1 + #236, #3967
  static InitialScreen1 + #237, #3967
  static InitialScreen1 + #238, #3967
  static InitialScreen1 + #239, #2825

  ;Linha 6
  static InitialScreen1 + #240, #2825
  static InitialScreen1 + #241, #3967
  static InitialScreen1 + #242, #3967
  static InitialScreen1 + #243, #3967
  static InitialScreen1 + #244, #3967
  static InitialScreen1 + #245, #3967
  static InitialScreen1 + #246, #3967
  static InitialScreen1 + #247, #3967
  static InitialScreen1 + #248, #3967
  static InitialScreen1 + #249, #3967
  static InitialScreen1 + #250, #3967
  static InitialScreen1 + #251, #3967
  static InitialScreen1 + #252, #3967
  static InitialScreen1 + #253, #3967
  static InitialScreen1 + #254, #3967
  static InitialScreen1 + #255, #2313
  static InitialScreen1 + #256, #3967
  static InitialScreen1 + #257, #3967
  static InitialScreen1 + #258, #3967
  static InitialScreen1 + #259, #3967
  static InitialScreen1 + #260, #2313
  static InitialScreen1 + #261, #2313
  static InitialScreen1 + #262, #2313
  static InitialScreen1 + #263, #3967
  static InitialScreen1 + #264, #3967
  static InitialScreen1 + #265, #3967
  static InitialScreen1 + #266, #3967
  static InitialScreen1 + #267, #3967
  static InitialScreen1 + #268, #3967
  static InitialScreen1 + #269, #3967
  static InitialScreen1 + #270, #3967
  static InitialScreen1 + #271, #3967
  static InitialScreen1 + #272, #3967
  static InitialScreen1 + #273, #3967
  static InitialScreen1 + #274, #3967
  static InitialScreen1 + #275, #3967
  static InitialScreen1 + #276, #3967
  static InitialScreen1 + #277, #3967
  static InitialScreen1 + #278, #3967
  static InitialScreen1 + #279, #2825

  ;Linha 7
  static InitialScreen1 + #280, #2825
  static InitialScreen1 + #281, #3967
  static InitialScreen1 + #282, #3967
  static InitialScreen1 + #283, #3967
  static InitialScreen1 + #284, #3967
  static InitialScreen1 + #285, #3967
  static InitialScreen1 + #286, #3967
  static InitialScreen1 + #287, #3967
  static InitialScreen1 + #288, #3967
  static InitialScreen1 + #289, #3967
  static InitialScreen1 + #290, #3967
  static InitialScreen1 + #291, #3967
  static InitialScreen1 + #292, #3967
  static InitialScreen1 + #293, #3967
  static InitialScreen1 + #294, #3967
  static InitialScreen1 + #295, #2313
  static InitialScreen1 + #296, #2313
  static InitialScreen1 + #297, #3967
  static InitialScreen1 + #298, #3967
  static InitialScreen1 + #299, #2313
  static InitialScreen1 + #300, #2313
  static InitialScreen1 + #301, #2313
  static InitialScreen1 + #302, #2313
  static InitialScreen1 + #303, #2313
  static InitialScreen1 + #304, #3967
  static InitialScreen1 + #305, #3967
  static InitialScreen1 + #306, #3967
  static InitialScreen1 + #307, #3967
  static InitialScreen1 + #308, #3967
  static InitialScreen1 + #309, #3967
  static InitialScreen1 + #310, #3967
  static InitialScreen1 + #311, #3967
  static InitialScreen1 + #312, #3967
  static InitialScreen1 + #313, #3967
  static InitialScreen1 + #314, #3967
  static InitialScreen1 + #315, #3967
  static InitialScreen1 + #316, #3967
  static InitialScreen1 + #317, #3967
  static InitialScreen1 + #318, #3967
  static InitialScreen1 + #319, #2825

  ;Linha 8
  static InitialScreen1 + #320, #2825
  static InitialScreen1 + #321, #3967
  static InitialScreen1 + #322, #3967
  static InitialScreen1 + #323, #3967
  static InitialScreen1 + #324, #3967
  static InitialScreen1 + #325, #3967
  static InitialScreen1 + #326, #3967
  static InitialScreen1 + #327, #3967
  static InitialScreen1 + #328, #3967
  static InitialScreen1 + #329, #3967
  static InitialScreen1 + #330, #3967
  static InitialScreen1 + #331, #3967
  static InitialScreen1 + #332, #3967
  static InitialScreen1 + #333, #3967
  static InitialScreen1 + #334, #3967
  static InitialScreen1 + #335, #2313
  static InitialScreen1 + #336, #2313
  static InitialScreen1 + #337, #2313
  static InitialScreen1 + #338, #2313
  static InitialScreen1 + #339, #2313
  static InitialScreen1 + #340, #2313
  static InitialScreen1 + #341, #2313
  static InitialScreen1 + #342, #2313
  static InitialScreen1 + #343, #2313
  static InitialScreen1 + #344, #3967
  static InitialScreen1 + #345, #3967
  static InitialScreen1 + #346, #3967
  static InitialScreen1 + #347, #3967
  static InitialScreen1 + #348, #3967
  static InitialScreen1 + #349, #3967
  static InitialScreen1 + #350, #3967
  static InitialScreen1 + #351, #3967
  static InitialScreen1 + #352, #3967
  static InitialScreen1 + #353, #3967
  static InitialScreen1 + #354, #3967
  static InitialScreen1 + #355, #3967
  static InitialScreen1 + #356, #3967
  static InitialScreen1 + #357, #3967
  static InitialScreen1 + #358, #3967
  static InitialScreen1 + #359, #2825

  ;Linha 9
  static InitialScreen1 + #360, #2825
  static InitialScreen1 + #361, #3967
  static InitialScreen1 + #362, #3967
  static InitialScreen1 + #363, #3967
  static InitialScreen1 + #364, #3967
  static InitialScreen1 + #365, #3967
  static InitialScreen1 + #366, #3967
  static InitialScreen1 + #367, #3967
  static InitialScreen1 + #368, #3967
  static InitialScreen1 + #369, #3967
  static InitialScreen1 + #370, #3967
  static InitialScreen1 + #371, #3967
  static InitialScreen1 + #372, #3967
  static InitialScreen1 + #373, #3967
  static InitialScreen1 + #374, #2313
  static InitialScreen1 + #375, #2313
  static InitialScreen1 + #376, #2313
  static InitialScreen1 + #377, #2313
  static InitialScreen1 + #378, #2313
  static InitialScreen1 + #379, #9
  static InitialScreen1 + #380, #2313
  static InitialScreen1 + #381, #2313
  static InitialScreen1 + #382, #2313
  static InitialScreen1 + #383, #2313
  static InitialScreen1 + #384, #2313
  static InitialScreen1 + #385, #3967
  static InitialScreen1 + #386, #3967
  static InitialScreen1 + #387, #3967
  static InitialScreen1 + #388, #3967
  static InitialScreen1 + #389, #3967
  static InitialScreen1 + #390, #3967
  static InitialScreen1 + #391, #3967
  static InitialScreen1 + #392, #3967
  static InitialScreen1 + #393, #3967
  static InitialScreen1 + #394, #3967
  static InitialScreen1 + #395, #3967
  static InitialScreen1 + #396, #3967
  static InitialScreen1 + #397, #3967
  static InitialScreen1 + #398, #3967
  static InitialScreen1 + #399, #2825

  ;Linha 10
  static InitialScreen1 + #400, #2825
  static InitialScreen1 + #401, #3967
  static InitialScreen1 + #402, #3967
  static InitialScreen1 + #403, #3967
  static InitialScreen1 + #404, #3967
  static InitialScreen1 + #405, #3967
  static InitialScreen1 + #406, #3967
  static InitialScreen1 + #407, #3967
  static InitialScreen1 + #408, #3967
  static InitialScreen1 + #409, #3967
  static InitialScreen1 + #410, #3967
  static InitialScreen1 + #411, #3967
  static InitialScreen1 + #412, #3967
  static InitialScreen1 + #413, #3967
  static InitialScreen1 + #414, #2313
  static InitialScreen1 + #415, #2313
  static InitialScreen1 + #416, #2313
  static InitialScreen1 + #417, #2313
  static InitialScreen1 + #418, #9
  static InitialScreen1 + #419, #9
  static InitialScreen1 + #420, #9
  static InitialScreen1 + #421, #2313
  static InitialScreen1 + #422, #2313
  static InitialScreen1 + #423, #2313
  static InitialScreen1 + #424, #2313
  static InitialScreen1 + #425, #3967
  static InitialScreen1 + #426, #3967
  static InitialScreen1 + #427, #3967
  static InitialScreen1 + #428, #3967
  static InitialScreen1 + #429, #3967
  static InitialScreen1 + #430, #3967
  static InitialScreen1 + #431, #3967
  static InitialScreen1 + #432, #3967
  static InitialScreen1 + #433, #3967
  static InitialScreen1 + #434, #3967
  static InitialScreen1 + #435, #3967
  static InitialScreen1 + #436, #3967
  static InitialScreen1 + #437, #3967
  static InitialScreen1 + #438, #3967
  static InitialScreen1 + #439, #2825

  ;Linha 11
  static InitialScreen1 + #440, #2825
  static InitialScreen1 + #441, #3967
  static InitialScreen1 + #442, #3967
  static InitialScreen1 + #443, #3967
  static InitialScreen1 + #444, #3967
  static InitialScreen1 + #445, #3967
  static InitialScreen1 + #446, #3967
  static InitialScreen1 + #447, #3967
  static InitialScreen1 + #448, #3967
  static InitialScreen1 + #449, #3967
  static InitialScreen1 + #450, #3967
  static InitialScreen1 + #451, #3967
  static InitialScreen1 + #452, #3967
  static InitialScreen1 + #453, #3967
  static InitialScreen1 + #454, #2313
  static InitialScreen1 + #455, #2313
  static InitialScreen1 + #456, #2313
  static InitialScreen1 + #457, #9
  static InitialScreen1 + #458, #9
  static InitialScreen1 + #459, #2313
  static InitialScreen1 + #460, #9
  static InitialScreen1 + #461, #9
  static InitialScreen1 + #462, #2313
  static InitialScreen1 + #463, #2313
  static InitialScreen1 + #464, #2313
  static InitialScreen1 + #465, #3967
  static InitialScreen1 + #466, #3967
  static InitialScreen1 + #467, #3967
  static InitialScreen1 + #468, #3967
  static InitialScreen1 + #469, #3967
  static InitialScreen1 + #470, #3967
  static InitialScreen1 + #471, #3967
  static InitialScreen1 + #472, #3967
  static InitialScreen1 + #473, #3967
  static InitialScreen1 + #474, #3967
  static InitialScreen1 + #475, #3967
  static InitialScreen1 + #476, #3967
  static InitialScreen1 + #477, #3967
  static InitialScreen1 + #478, #3967
  static InitialScreen1 + #479, #2825

  ;Linha 12
  static InitialScreen1 + #480, #2825
  static InitialScreen1 + #481, #3967
  static InitialScreen1 + #482, #3967
  static InitialScreen1 + #483, #3967
  static InitialScreen1 + #484, #3967
  static InitialScreen1 + #485, #3967
  static InitialScreen1 + #486, #3967
  static InitialScreen1 + #487, #3967
  static InitialScreen1 + #488, #3967
  static InitialScreen1 + #489, #3967
  static InitialScreen1 + #490, #3967
  static InitialScreen1 + #491, #3967
  static InitialScreen1 + #492, #3967
  static InitialScreen1 + #493, #2313
  static InitialScreen1 + #494, #2313
  static InitialScreen1 + #495, #2313
  static InitialScreen1 + #496, #9
  static InitialScreen1 + #497, #9
  static InitialScreen1 + #498, #9
  static InitialScreen1 + #499, #9
  static InitialScreen1 + #500, #9
  static InitialScreen1 + #501, #9
  static InitialScreen1 + #502, #9
  static InitialScreen1 + #503, #2313
  static InitialScreen1 + #504, #2313
  static InitialScreen1 + #505, #2313
  static InitialScreen1 + #506, #3967
  static InitialScreen1 + #507, #3967
  static InitialScreen1 + #508, #3967
  static InitialScreen1 + #509, #3967
  static InitialScreen1 + #510, #3967
  static InitialScreen1 + #511, #3967
  static InitialScreen1 + #512, #3967
  static InitialScreen1 + #513, #3967
  static InitialScreen1 + #514, #3967
  static InitialScreen1 + #515, #3967
  static InitialScreen1 + #516, #3967
  static InitialScreen1 + #517, #3967
  static InitialScreen1 + #518, #3967
  static InitialScreen1 + #519, #2825

  ;Linha 13
  static InitialScreen1 + #520, #2825
  static InitialScreen1 + #521, #3967
  static InitialScreen1 + #522, #3967
  static InitialScreen1 + #523, #3967
  static InitialScreen1 + #524, #3967
  static InitialScreen1 + #525, #3967
  static InitialScreen1 + #526, #3967
  static InitialScreen1 + #527, #3967
  static InitialScreen1 + #528, #3967
  static InitialScreen1 + #529, #3967
  static InitialScreen1 + #530, #3967
  static InitialScreen1 + #531, #3967
  static InitialScreen1 + #532, #3967
  static InitialScreen1 + #533, #2313
  static InitialScreen1 + #534, #2313
  static InitialScreen1 + #535, #9
  static InitialScreen1 + #536, #9
  static InitialScreen1 + #537, #9
  static InitialScreen1 + #538, #9
  static InitialScreen1 + #539, #9
  static InitialScreen1 + #540, #9
  static InitialScreen1 + #541, #9
  static InitialScreen1 + #542, #9
  static InitialScreen1 + #543, #9
  static InitialScreen1 + #544, #2313
  static InitialScreen1 + #545, #2313
  static InitialScreen1 + #546, #3967
  static InitialScreen1 + #547, #3967
  static InitialScreen1 + #548, #3967
  static InitialScreen1 + #549, #3967
  static InitialScreen1 + #550, #3967
  static InitialScreen1 + #551, #3967
  static InitialScreen1 + #552, #3967
  static InitialScreen1 + #553, #3967
  static InitialScreen1 + #554, #3967
  static InitialScreen1 + #555, #3967
  static InitialScreen1 + #556, #3967
  static InitialScreen1 + #557, #3967
  static InitialScreen1 + #558, #3967
  static InitialScreen1 + #559, #2825

  ;Linha 14
  static InitialScreen1 + #560, #2825
  static InitialScreen1 + #561, #3967
  static InitialScreen1 + #562, #3967
  static InitialScreen1 + #563, #3967
  static InitialScreen1 + #564, #3967
  static InitialScreen1 + #565, #3967
  static InitialScreen1 + #566, #3967
  static InitialScreen1 + #567, #3967
  static InitialScreen1 + #568, #3967
  static InitialScreen1 + #569, #3967
  static InitialScreen1 + #570, #3967
  static InitialScreen1 + #571, #3967
  static InitialScreen1 + #572, #3967
  static InitialScreen1 + #573, #2313
  static InitialScreen1 + #574, #9
  static InitialScreen1 + #575, #9
  static InitialScreen1 + #576, #2313
  static InitialScreen1 + #577, #9
  static InitialScreen1 + #578, #9
  static InitialScreen1 + #579, #2313
  static InitialScreen1 + #580, #9
  static InitialScreen1 + #581, #9
  static InitialScreen1 + #582, #2313
  static InitialScreen1 + #583, #9
  static InitialScreen1 + #584, #9
  static InitialScreen1 + #585, #2313
  static InitialScreen1 + #586, #3967
  static InitialScreen1 + #587, #3967
  static InitialScreen1 + #588, #3967
  static InitialScreen1 + #589, #3967
  static InitialScreen1 + #590, #3967
  static InitialScreen1 + #591, #3967
  static InitialScreen1 + #592, #3967
  static InitialScreen1 + #593, #3967
  static InitialScreen1 + #594, #3967
  static InitialScreen1 + #595, #3967
  static InitialScreen1 + #596, #3967
  static InitialScreen1 + #597, #3967
  static InitialScreen1 + #598, #3967
  static InitialScreen1 + #599, #2825

  ;Linha 15
  static InitialScreen1 + #600, #2825
  static InitialScreen1 + #601, #3967
  static InitialScreen1 + #602, #3967
  static InitialScreen1 + #603, #3967
  static InitialScreen1 + #604, #3967
  static InitialScreen1 + #605, #3967
  static InitialScreen1 + #606, #3967
  static InitialScreen1 + #607, #3967
  static InitialScreen1 + #608, #3967
  static InitialScreen1 + #609, #3967
  static InitialScreen1 + #610, #3967
  static InitialScreen1 + #611, #3967
  static InitialScreen1 + #612, #3967
  static InitialScreen1 + #613, #2313
  static InitialScreen1 + #614, #2313
  static InitialScreen1 + #615, #9
  static InitialScreen1 + #616, #9
  static InitialScreen1 + #617, #9
  static InitialScreen1 + #618, #9
  static InitialScreen1 + #619, #9
  static InitialScreen1 + #620, #9
  static InitialScreen1 + #621, #9
  static InitialScreen1 + #622, #9
  static InitialScreen1 + #623, #9
  static InitialScreen1 + #624, #2313
  static InitialScreen1 + #625, #2313
  static InitialScreen1 + #626, #3967
  static InitialScreen1 + #627, #3967
  static InitialScreen1 + #628, #3967
  static InitialScreen1 + #629, #3967
  static InitialScreen1 + #630, #3967
  static InitialScreen1 + #631, #3967
  static InitialScreen1 + #632, #3967
  static InitialScreen1 + #633, #3967
  static InitialScreen1 + #634, #3967
  static InitialScreen1 + #635, #3967
  static InitialScreen1 + #636, #3967
  static InitialScreen1 + #637, #3967
  static InitialScreen1 + #638, #3967
  static InitialScreen1 + #639, #2825

  ;Linha 16
  static InitialScreen1 + #640, #2825
  static InitialScreen1 + #641, #3967
  static InitialScreen1 + #642, #3967
  static InitialScreen1 + #643, #3967
  static InitialScreen1 + #644, #3967
  static InitialScreen1 + #645, #3967
  static InitialScreen1 + #646, #3967
  static InitialScreen1 + #647, #3967
  static InitialScreen1 + #648, #3967
  static InitialScreen1 + #649, #3967
  static InitialScreen1 + #650, #3967
  static InitialScreen1 + #651, #3967
  static InitialScreen1 + #652, #3967
  static InitialScreen1 + #653, #3967
  static InitialScreen1 + #654, #2313
  static InitialScreen1 + #655, #2313
  static InitialScreen1 + #656, #9
  static InitialScreen1 + #657, #9
  static InitialScreen1 + #658, #9
  static InitialScreen1 + #659, #9
  static InitialScreen1 + #660, #9
  static InitialScreen1 + #661, #9
  static InitialScreen1 + #662, #9
  static InitialScreen1 + #663, #2313
  static InitialScreen1 + #664, #2313
  static InitialScreen1 + #665, #3967
  static InitialScreen1 + #666, #3967
  static InitialScreen1 + #667, #3967
  static InitialScreen1 + #668, #3967
  static InitialScreen1 + #669, #3967
  static InitialScreen1 + #670, #3967
  static InitialScreen1 + #671, #3967
  static InitialScreen1 + #672, #3967
  static InitialScreen1 + #673, #3967
  static InitialScreen1 + #674, #3967
  static InitialScreen1 + #675, #3967
  static InitialScreen1 + #676, #3967
  static InitialScreen1 + #677, #3967
  static InitialScreen1 + #678, #3967
  static InitialScreen1 + #679, #2825

  ;Linha 17
  static InitialScreen1 + #680, #2825
  static InitialScreen1 + #681, #3967
  static InitialScreen1 + #682, #3967
  static InitialScreen1 + #683, #3967
  static InitialScreen1 + #684, #3967
  static InitialScreen1 + #685, #3967
  static InitialScreen1 + #686, #3967
  static InitialScreen1 + #687, #3967
  static InitialScreen1 + #688, #3967
  static InitialScreen1 + #689, #3967
  static InitialScreen1 + #690, #3967
  static InitialScreen1 + #691, #3967
  static InitialScreen1 + #692, #3967
  static InitialScreen1 + #693, #3967
  static InitialScreen1 + #694, #3967
  static InitialScreen1 + #695, #2313
  static InitialScreen1 + #696, #2313
  static InitialScreen1 + #697, #9
  static InitialScreen1 + #698, #9
  static InitialScreen1 + #699, #2313
  static InitialScreen1 + #700, #9
  static InitialScreen1 + #701, #9
  static InitialScreen1 + #702, #2313
  static InitialScreen1 + #703, #2313
  static InitialScreen1 + #704, #3967
  static InitialScreen1 + #705, #3967
  static InitialScreen1 + #706, #3967
  static InitialScreen1 + #707, #3967
  static InitialScreen1 + #708, #3967
  static InitialScreen1 + #709, #3967
  static InitialScreen1 + #710, #3967
  static InitialScreen1 + #711, #3967
  static InitialScreen1 + #712, #3967
  static InitialScreen1 + #713, #3967
  static InitialScreen1 + #714, #3967
  static InitialScreen1 + #715, #3967
  static InitialScreen1 + #716, #3967
  static InitialScreen1 + #717, #3967
  static InitialScreen1 + #718, #3967
  static InitialScreen1 + #719, #2825

  ;Linha 18
  static InitialScreen1 + #720, #2825
  static InitialScreen1 + #721, #3967
  static InitialScreen1 + #722, #3967
  static InitialScreen1 + #723, #3967
  static InitialScreen1 + #724, #3967
  static InitialScreen1 + #725, #3967
  static InitialScreen1 + #726, #3967
  static InitialScreen1 + #727, #3967
  static InitialScreen1 + #728, #3967
  static InitialScreen1 + #729, #3967
  static InitialScreen1 + #730, #3967
  static InitialScreen1 + #731, #3967
  static InitialScreen1 + #732, #3967
  static InitialScreen1 + #733, #3967
  static InitialScreen1 + #734, #3967
  static InitialScreen1 + #735, #3967
  static InitialScreen1 + #736, #2313
  static InitialScreen1 + #737, #2313
  static InitialScreen1 + #738, #9
  static InitialScreen1 + #739, #9
  static InitialScreen1 + #740, #9
  static InitialScreen1 + #741, #2313
  static InitialScreen1 + #742, #2313
  static InitialScreen1 + #743, #3967
  static InitialScreen1 + #744, #3967
  static InitialScreen1 + #745, #3967
  static InitialScreen1 + #746, #3967
  static InitialScreen1 + #747, #3967
  static InitialScreen1 + #748, #3967
  static InitialScreen1 + #749, #3967
  static InitialScreen1 + #750, #3967
  static InitialScreen1 + #751, #3967
  static InitialScreen1 + #752, #3967
  static InitialScreen1 + #753, #3967
  static InitialScreen1 + #754, #3967
  static InitialScreen1 + #755, #3967
  static InitialScreen1 + #756, #3967
  static InitialScreen1 + #757, #3967
  static InitialScreen1 + #758, #3967
  static InitialScreen1 + #759, #2825

  ;Linha 19
  static InitialScreen1 + #760, #2825
  static InitialScreen1 + #761, #3967
  static InitialScreen1 + #762, #3967
  static InitialScreen1 + #763, #3967
  static InitialScreen1 + #764, #3967
  static InitialScreen1 + #765, #3967
  static InitialScreen1 + #766, #3967
  static InitialScreen1 + #767, #3967
  static InitialScreen1 + #768, #3967
  static InitialScreen1 + #769, #3967
  static InitialScreen1 + #770, #3967
  static InitialScreen1 + #771, #3967
  static InitialScreen1 + #772, #3967
  static InitialScreen1 + #773, #3967
  static InitialScreen1 + #774, #3967
  static InitialScreen1 + #775, #3967
  static InitialScreen1 + #776, #3967
  static InitialScreen1 + #777, #2313
  static InitialScreen1 + #778, #2313
  static InitialScreen1 + #779, #9
  static InitialScreen1 + #780, #2313
  static InitialScreen1 + #781, #2313
  static InitialScreen1 + #782, #3967
  static InitialScreen1 + #783, #3967
  static InitialScreen1 + #784, #3967
  static InitialScreen1 + #785, #3967
  static InitialScreen1 + #786, #3967
  static InitialScreen1 + #787, #3967
  static InitialScreen1 + #788, #3967
  static InitialScreen1 + #789, #3967
  static InitialScreen1 + #790, #3967
  static InitialScreen1 + #791, #3967
  static InitialScreen1 + #792, #3967
  static InitialScreen1 + #793, #3967
  static InitialScreen1 + #794, #3967
  static InitialScreen1 + #795, #3967
  static InitialScreen1 + #796, #3967
  static InitialScreen1 + #797, #3967
  static InitialScreen1 + #798, #3967
  static InitialScreen1 + #799, #2825

  ;Linha 20
  static InitialScreen1 + #800, #2825
  static InitialScreen1 + #801, #3967
  static InitialScreen1 + #802, #3967
  static InitialScreen1 + #803, #3967
  static InitialScreen1 + #804, #3967
  static InitialScreen1 + #805, #3967
  static InitialScreen1 + #806, #3967
  static InitialScreen1 + #807, #3967
  static InitialScreen1 + #808, #3967
  static InitialScreen1 + #809, #3967
  static InitialScreen1 + #810, #3967
  static InitialScreen1 + #811, #3967
  static InitialScreen1 + #812, #3967
  static InitialScreen1 + #813, #3967
  static InitialScreen1 + #814, #3967
  static InitialScreen1 + #815, #3967
  static InitialScreen1 + #816, #3967
  static InitialScreen1 + #817, #3967
  static InitialScreen1 + #818, #2313
  static InitialScreen1 + #819, #2313
  static InitialScreen1 + #820, #2313
  static InitialScreen1 + #821, #3967
  static InitialScreen1 + #822, #3967
  static InitialScreen1 + #823, #3967
  static InitialScreen1 + #824, #3967
  static InitialScreen1 + #825, #3967
  static InitialScreen1 + #826, #3967
  static InitialScreen1 + #827, #3967
  static InitialScreen1 + #828, #3967
  static InitialScreen1 + #829, #3967
  static InitialScreen1 + #830, #3967
  static InitialScreen1 + #831, #3967
  static InitialScreen1 + #832, #3967
  static InitialScreen1 + #833, #3967
  static InitialScreen1 + #834, #3967
  static InitialScreen1 + #835, #3967
  static InitialScreen1 + #836, #3967
  static InitialScreen1 + #837, #3967
  static InitialScreen1 + #838, #3967
  static InitialScreen1 + #839, #2825

  ;Linha 21
  static InitialScreen1 + #840, #2825
  static InitialScreen1 + #841, #3967
  static InitialScreen1 + #842, #3967
  static InitialScreen1 + #843, #3967
  static InitialScreen1 + #844, #3967
  static InitialScreen1 + #845, #3967
  static InitialScreen1 + #846, #3967
  static InitialScreen1 + #847, #3967
  static InitialScreen1 + #848, #3967
  static InitialScreen1 + #849, #3967
  static InitialScreen1 + #850, #3967
  static InitialScreen1 + #851, #3967
  static InitialScreen1 + #852, #3967
  static InitialScreen1 + #853, #3967
  static InitialScreen1 + #854, #3967
  static InitialScreen1 + #855, #3967
  static InitialScreen1 + #856, #3967
  static InitialScreen1 + #857, #3967
  static InitialScreen1 + #858, #3967
  static InitialScreen1 + #859, #2313
  static InitialScreen1 + #860, #3967
  static InitialScreen1 + #861, #3967
  static InitialScreen1 + #862, #3967
  static InitialScreen1 + #863, #3967
  static InitialScreen1 + #864, #3967
  static InitialScreen1 + #865, #3967
  static InitialScreen1 + #866, #3967
  static InitialScreen1 + #867, #3967
  static InitialScreen1 + #868, #3967
  static InitialScreen1 + #869, #3967
  static InitialScreen1 + #870, #3967
  static InitialScreen1 + #871, #3967
  static InitialScreen1 + #872, #3967
  static InitialScreen1 + #873, #3967
  static InitialScreen1 + #874, #3967
  static InitialScreen1 + #875, #3967
  static InitialScreen1 + #876, #3967
  static InitialScreen1 + #877, #3967
  static InitialScreen1 + #878, #3967
  static InitialScreen1 + #879, #2825

  ;Linha 22
  static InitialScreen1 + #880, #2825
  static InitialScreen1 + #881, #3967
  static InitialScreen1 + #882, #3967
  static InitialScreen1 + #883, #3967
  static InitialScreen1 + #884, #3967
  static InitialScreen1 + #885, #3967
  static InitialScreen1 + #886, #3967
  static InitialScreen1 + #887, #3967
  static InitialScreen1 + #888, #3967
  static InitialScreen1 + #889, #3967
  static InitialScreen1 + #890, #3967
  static InitialScreen1 + #891, #3967
  static InitialScreen1 + #892, #3967
  static InitialScreen1 + #893, #3967
  static InitialScreen1 + #894, #3967
  static InitialScreen1 + #895, #3967
  static InitialScreen1 + #896, #3967
  static InitialScreen1 + #897, #3967
  static InitialScreen1 + #898, #3967
  static InitialScreen1 + #899, #3967
  static InitialScreen1 + #900, #3967
  static InitialScreen1 + #901, #3967
  static InitialScreen1 + #902, #3967
  static InitialScreen1 + #903, #3967
  static InitialScreen1 + #904, #3967
  static InitialScreen1 + #905, #3967
  static InitialScreen1 + #906, #3967
  static InitialScreen1 + #907, #3967
  static InitialScreen1 + #908, #3967
  static InitialScreen1 + #909, #3967
  static InitialScreen1 + #910, #3967
  static InitialScreen1 + #911, #3967
  static InitialScreen1 + #912, #3967
  static InitialScreen1 + #913, #3967
  static InitialScreen1 + #914, #3967
  static InitialScreen1 + #915, #3967
  static InitialScreen1 + #916, #3967
  static InitialScreen1 + #917, #3967
  static InitialScreen1 + #918, #3967
  static InitialScreen1 + #919, #2825

  ;Linha 23
  static InitialScreen1 + #920, #2825
  static InitialScreen1 + #921, #3967
  static InitialScreen1 + #922, #3967
  static InitialScreen1 + #923, #3967
  static InitialScreen1 + #924, #3967
  static InitialScreen1 + #925, #3967
  static InitialScreen1 + #926, #3967
  static InitialScreen1 + #927, #3967
  static InitialScreen1 + #928, #3967
  static InitialScreen1 + #929, #3967
  static InitialScreen1 + #930, #3967
  static InitialScreen1 + #931, #3967
  static InitialScreen1 + #932, #3967
  static InitialScreen1 + #933, #3967
  static InitialScreen1 + #934, #3967
  static InitialScreen1 + #935, #3967
  static InitialScreen1 + #936, #3967
  static InitialScreen1 + #937, #3967
  static InitialScreen1 + #938, #3967
  static InitialScreen1 + #939, #3967
  static InitialScreen1 + #940, #3967
  static InitialScreen1 + #941, #3967
  static InitialScreen1 + #942, #3967
  static InitialScreen1 + #943, #3967
  static InitialScreen1 + #944, #3967
  static InitialScreen1 + #945, #3967
  static InitialScreen1 + #946, #3967
  static InitialScreen1 + #947, #3967
  static InitialScreen1 + #948, #3967
  static InitialScreen1 + #949, #3967
  static InitialScreen1 + #950, #3967
  static InitialScreen1 + #951, #3967
  static InitialScreen1 + #952, #3967
  static InitialScreen1 + #953, #3967
  static InitialScreen1 + #954, #3967
  static InitialScreen1 + #955, #3967
  static InitialScreen1 + #956, #3967
  static InitialScreen1 + #957, #3967
  static InitialScreen1 + #958, #3967
  static InitialScreen1 + #959, #2825

  ;Linha 24
  static InitialScreen1 + #960, #2825
  static InitialScreen1 + #961, #3967
  static InitialScreen1 + #962, #3967
  static InitialScreen1 + #963, #3967
  static InitialScreen1 + #964, #3967
  static InitialScreen1 + #965, #3967
  static InitialScreen1 + #966, #3967
  static InitialScreen1 + #967, #3967
  static InitialScreen1 + #968, #3967
  static InitialScreen1 + #969, #3967
  static InitialScreen1 + #970, #3967
  static InitialScreen1 + #971, #3967
  static InitialScreen1 + #972, #3967
  static InitialScreen1 + #973, #3967
  static InitialScreen1 + #974, #3967
  static InitialScreen1 + #975, #3967
  static InitialScreen1 + #976, #2882
  static InitialScreen1 + #977, #2885
  static InitialScreen1 + #978, #2900
  static InitialScreen1 + #979, #3967
  static InitialScreen1 + #980, #2901
  static InitialScreen1 + #981, #2899
  static InitialScreen1 + #982, #2896
  static InitialScreen1 + #983, #3967
  static InitialScreen1 + #984, #3967
  static InitialScreen1 + #985, #3967
  static InitialScreen1 + #986, #3967
  static InitialScreen1 + #987, #3967
  static InitialScreen1 + #988, #3967
  static InitialScreen1 + #989, #3967
  static InitialScreen1 + #990, #3967
  static InitialScreen1 + #991, #3967
  static InitialScreen1 + #992, #3967
  static InitialScreen1 + #993, #3967
  static InitialScreen1 + #994, #3967
  static InitialScreen1 + #995, #3967
  static InitialScreen1 + #996, #3967
  static InitialScreen1 + #997, #3967
  static InitialScreen1 + #998, #3967
  static InitialScreen1 + #999, #2825

  ;Linha 25
  static InitialScreen1 + #1000, #2825
  static InitialScreen1 + #1001, #3967
  static InitialScreen1 + #1002, #3967
  static InitialScreen1 + #1003, #3967
  static InitialScreen1 + #1004, #3967
  static InitialScreen1 + #1005, #3967
  static InitialScreen1 + #1006, #3967
  static InitialScreen1 + #1007, #3967
  static InitialScreen1 + #1008, #3967
  static InitialScreen1 + #1009, #3967
  static InitialScreen1 + #1010, #3967
  static InitialScreen1 + #1011, #3967
  static InitialScreen1 + #1012, #3967
  static InitialScreen1 + #1013, #3967
  static InitialScreen1 + #1014, #3967
  static InitialScreen1 + #1015, #3967
  static InitialScreen1 + #1016, #3967
  static InitialScreen1 + #1017, #3967
  static InitialScreen1 + #1018, #3967
  static InitialScreen1 + #1019, #3967
  static InitialScreen1 + #1020, #3967
  static InitialScreen1 + #1021, #3967
  static InitialScreen1 + #1022, #3967
  static InitialScreen1 + #1023, #3967
  static InitialScreen1 + #1024, #3967
  static InitialScreen1 + #1025, #3967
  static InitialScreen1 + #1026, #3967
  static InitialScreen1 + #1027, #3967
  static InitialScreen1 + #1028, #3967
  static InitialScreen1 + #1029, #3967
  static InitialScreen1 + #1030, #3967
  static InitialScreen1 + #1031, #3967
  static InitialScreen1 + #1032, #3967
  static InitialScreen1 + #1033, #3967
  static InitialScreen1 + #1034, #3967
  static InitialScreen1 + #1035, #3967
  static InitialScreen1 + #1036, #3967
  static InitialScreen1 + #1037, #3967
  static InitialScreen1 + #1038, #3967
  static InitialScreen1 + #1039, #2825

  ;Linha 26
  static InitialScreen1 + #1040, #2825
  static InitialScreen1 + #1041, #3967
  static InitialScreen1 + #1042, #3967
  static InitialScreen1 + #1043, #3967
  static InitialScreen1 + #1044, #3967
  static InitialScreen1 + #1045, #3967
  static InitialScreen1 + #1046, #3967
  static InitialScreen1 + #1047, #3967
  static InitialScreen1 + #1048, #3967
  static InitialScreen1 + #1049, #3967
  static InitialScreen1 + #1050, #3967
  static InitialScreen1 + #1051, #3967
  static InitialScreen1 + #1052, #3967
  static InitialScreen1 + #1053, #2907
  static InitialScreen1 + #1054, #3967
  static InitialScreen1 + #1055, #2879
  static InitialScreen1 + #1056, #3967
  static InitialScreen1 + #1057, #2900
  static InitialScreen1 + #1058, #2933
  static InitialScreen1 + #1059, #2932
  static InitialScreen1 + #1060, #2927
  static InitialScreen1 + #1061, #2930
  static InitialScreen1 + #1062, #2921
  static InitialScreen1 + #1063, #2913
  static InitialScreen1 + #1064, #2924
  static InitialScreen1 + #1065, #2909
  static InitialScreen1 + #1066, #3967
  static InitialScreen1 + #1067, #3967
  static InitialScreen1 + #1068, #3967
  static InitialScreen1 + #1069, #3967
  static InitialScreen1 + #1070, #3967
  static InitialScreen1 + #1071, #3967
  static InitialScreen1 + #1072, #3967
  static InitialScreen1 + #1073, #3967
  static InitialScreen1 + #1074, #3967
  static InitialScreen1 + #1075, #3967
  static InitialScreen1 + #1076, #3967
  static InitialScreen1 + #1077, #3967
  static InitialScreen1 + #1078, #3967
  static InitialScreen1 + #1079, #2825

  ;Linha 27
  static InitialScreen1 + #1080, #2825
  static InitialScreen1 + #1081, #3967
  static InitialScreen1 + #1082, #3967
  static InitialScreen1 + #1083, #3967
  static InitialScreen1 + #1084, #3967
  static InitialScreen1 + #1085, #3967
  static InitialScreen1 + #1086, #3967
  static InitialScreen1 + #1087, #3967
  static InitialScreen1 + #1088, #3967
  static InitialScreen1 + #1089, #3967
  static InitialScreen1 + #1090, #3967
  static InitialScreen1 + #1091, #3967
  static InitialScreen1 + #1092, #3967
  static InitialScreen1 + #1093, #2907
  static InitialScreen1 + #1094, #2885
  static InitialScreen1 + #1095, #2926
  static InitialScreen1 + #1096, #2932
  static InitialScreen1 + #1097, #2917
  static InitialScreen1 + #1098, #2930
  static InitialScreen1 + #1099, #3967
  static InitialScreen1 + #1100, #2890
  static InitialScreen1 + #1101, #2927
  static InitialScreen1 + #1102, #2919
  static InitialScreen1 + #1103, #2913
  static InitialScreen1 + #1104, #2930
  static InitialScreen1 + #1105, #2909
  static InitialScreen1 + #1106, #3967
  static InitialScreen1 + #1107, #3967
  static InitialScreen1 + #1108, #3967
  static InitialScreen1 + #1109, #3967
  static InitialScreen1 + #1110, #3967
  static InitialScreen1 + #1111, #3967
  static InitialScreen1 + #1112, #3967
  static InitialScreen1 + #1113, #3967
  static InitialScreen1 + #1114, #3967
  static InitialScreen1 + #1115, #3967
  static InitialScreen1 + #1116, #3967
  static InitialScreen1 + #1117, #3967
  static InitialScreen1 + #1118, #3967
  static InitialScreen1 + #1119, #2825

  ;Linha 28
  static InitialScreen1 + #1120, #2825
  static InitialScreen1 + #1121, #3967
  static InitialScreen1 + #1122, #3967
  static InitialScreen1 + #1123, #3967
  static InitialScreen1 + #1124, #3967
  static InitialScreen1 + #1125, #3967
  static InitialScreen1 + #1126, #3967
  static InitialScreen1 + #1127, #3967
  static InitialScreen1 + #1128, #3967
  static InitialScreen1 + #1129, #3967
  static InitialScreen1 + #1130, #3967
  static InitialScreen1 + #1131, #3967
  static InitialScreen1 + #1132, #3967
  static InitialScreen1 + #1133, #3967
  static InitialScreen1 + #1134, #3967
  static InitialScreen1 + #1135, #3967
  static InitialScreen1 + #1136, #3967
  static InitialScreen1 + #1137, #3967
  static InitialScreen1 + #1138, #3967
  static InitialScreen1 + #1139, #3967
  static InitialScreen1 + #1140, #3967
  static InitialScreen1 + #1141, #3967
  static InitialScreen1 + #1142, #3967
  static InitialScreen1 + #1143, #3967
  static InitialScreen1 + #1144, #3967
  static InitialScreen1 + #1145, #3967
  static InitialScreen1 + #1146, #3967
  static InitialScreen1 + #1147, #3967
  static InitialScreen1 + #1148, #3967
  static InitialScreen1 + #1149, #3967
  static InitialScreen1 + #1150, #3967
  static InitialScreen1 + #1151, #3967
  static InitialScreen1 + #1152, #3967
  static InitialScreen1 + #1153, #3967
  static InitialScreen1 + #1154, #3967
  static InitialScreen1 + #1155, #3967
  static InitialScreen1 + #1156, #3967
  static InitialScreen1 + #1157, #3967
  static InitialScreen1 + #1158, #3967
  static InitialScreen1 + #1159, #2825

  ;Linha 29
  static InitialScreen1 + #1160, #2825
  static InitialScreen1 + #1161, #2825
  static InitialScreen1 + #1162, #2825
  static InitialScreen1 + #1163, #2825
  static InitialScreen1 + #1164, #2825
  static InitialScreen1 + #1165, #2825
  static InitialScreen1 + #1166, #2825
  static InitialScreen1 + #1167, #2825
  static InitialScreen1 + #1168, #2825
  static InitialScreen1 + #1169, #2825
  static InitialScreen1 + #1170, #2825
  static InitialScreen1 + #1171, #2825
  static InitialScreen1 + #1172, #2825
  static InitialScreen1 + #1173, #2825
  static InitialScreen1 + #1174, #2825
  static InitialScreen1 + #1175, #2825
  static InitialScreen1 + #1176, #2825
  static InitialScreen1 + #1177, #2825
  static InitialScreen1 + #1178, #2825
  static InitialScreen1 + #1179, #2825
  static InitialScreen1 + #1180, #2825
  static InitialScreen1 + #1181, #2825
  static InitialScreen1 + #1182, #2825
  static InitialScreen1 + #1183, #2825
  static InitialScreen1 + #1184, #2825
  static InitialScreen1 + #1185, #2825
  static InitialScreen1 + #1186, #2825
  static InitialScreen1 + #1187, #2825
  static InitialScreen1 + #1188, #2825
  static InitialScreen1 + #1189, #2825
  static InitialScreen1 + #1190, #2825
  static InitialScreen1 + #1191, #2825
  static InitialScreen1 + #1192, #2825
  static InitialScreen1 + #1193, #2825
  static InitialScreen1 + #1194, #2825
  static InitialScreen1 + #1195, #2825
  static InitialScreen1 + #1196, #2825
  static InitialScreen1 + #1197, #2825
  static InitialScreen1 + #1198, #2825
  static InitialScreen1 + #1199, #2825
;

InitialScreen2 : var #1200
  ;Linha 0
  static InitialScreen2 + #0, #2825
  static InitialScreen2 + #1, #2825
  static InitialScreen2 + #2, #2825
  static InitialScreen2 + #3, #2825
  static InitialScreen2 + #4, #2825
  static InitialScreen2 + #5, #2825
  static InitialScreen2 + #6, #2825
  static InitialScreen2 + #7, #2825
  static InitialScreen2 + #8, #2825
  static InitialScreen2 + #9, #2825
  static InitialScreen2 + #10, #2825
  static InitialScreen2 + #11, #2825
  static InitialScreen2 + #12, #2825
  static InitialScreen2 + #13, #2825
  static InitialScreen2 + #14, #2825
  static InitialScreen2 + #15, #2825
  static InitialScreen2 + #16, #2825
  static InitialScreen2 + #17, #2825
  static InitialScreen2 + #18, #2825
  static InitialScreen2 + #19, #2825
  static InitialScreen2 + #20, #2825
  static InitialScreen2 + #21, #2825
  static InitialScreen2 + #22, #2825
  static InitialScreen2 + #23, #2825
  static InitialScreen2 + #24, #2825
  static InitialScreen2 + #25, #2825
  static InitialScreen2 + #26, #2825
  static InitialScreen2 + #27, #2825
  static InitialScreen2 + #28, #2825
  static InitialScreen2 + #29, #2825
  static InitialScreen2 + #30, #2825
  static InitialScreen2 + #31, #2825
  static InitialScreen2 + #32, #2825
  static InitialScreen2 + #33, #2825
  static InitialScreen2 + #34, #2825
  static InitialScreen2 + #35, #2825
  static InitialScreen2 + #36, #2825
  static InitialScreen2 + #37, #2825
  static InitialScreen2 + #38, #2825
  static InitialScreen2 + #39, #2825

  ;Linha 1
  static InitialScreen2 + #40, #2825
  static InitialScreen2 + #41, #3967
  static InitialScreen2 + #42, #3967
  static InitialScreen2 + #43, #3967
  static InitialScreen2 + #44, #3967
  static InitialScreen2 + #45, #3967
  static InitialScreen2 + #46, #3967
  static InitialScreen2 + #47, #3967
  static InitialScreen2 + #48, #3967
  static InitialScreen2 + #49, #3967
  static InitialScreen2 + #50, #3967
  static InitialScreen2 + #51, #3967
  static InitialScreen2 + #52, #3967
  static InitialScreen2 + #53, #3967
  static InitialScreen2 + #54, #3967
  static InitialScreen2 + #55, #3967
  static InitialScreen2 + #56, #3967
  static InitialScreen2 + #57, #3967
  static InitialScreen2 + #58, #3967
  static InitialScreen2 + #59, #3967
  static InitialScreen2 + #60, #3967
  static InitialScreen2 + #61, #3967
  static InitialScreen2 + #62, #3967
  static InitialScreen2 + #63, #3967
  static InitialScreen2 + #64, #3967
  static InitialScreen2 + #65, #3967
  static InitialScreen2 + #66, #3967
  static InitialScreen2 + #67, #3967
  static InitialScreen2 + #68, #3967
  static InitialScreen2 + #69, #3967
  static InitialScreen2 + #70, #3967
  static InitialScreen2 + #71, #3967
  static InitialScreen2 + #72, #3967
  static InitialScreen2 + #73, #3967
  static InitialScreen2 + #74, #3967
  static InitialScreen2 + #75, #3967
  static InitialScreen2 + #76, #3967
  static InitialScreen2 + #77, #3967
  static InitialScreen2 + #78, #3967
  static InitialScreen2 + #79, #2825

  ;Linha 2
  static InitialScreen2 + #80, #2825
  static InitialScreen2 + #81, #3967
  static InitialScreen2 + #82, #3967
  static InitialScreen2 + #83, #3967
  static InitialScreen2 + #84, #3967
  static InitialScreen2 + #85, #3967
  static InitialScreen2 + #86, #3967
  static InitialScreen2 + #87, #3967
  static InitialScreen2 + #88, #3967
  static InitialScreen2 + #89, #3967
  static InitialScreen2 + #90, #3967
  static InitialScreen2 + #91, #3967
  static InitialScreen2 + #92, #3967
  static InitialScreen2 + #93, #3967
  static InitialScreen2 + #94, #3967
  static InitialScreen2 + #95, #3967
  static InitialScreen2 + #96, #3967
  static InitialScreen2 + #97, #3967
  static InitialScreen2 + #98, #3967
  static InitialScreen2 + #99, #3967
  static InitialScreen2 + #100, #3967
  static InitialScreen2 + #101, #3967
  static InitialScreen2 + #102, #3967
  static InitialScreen2 + #103, #3967
  static InitialScreen2 + #104, #3967
  static InitialScreen2 + #105, #3967
  static InitialScreen2 + #106, #3967
  static InitialScreen2 + #107, #3967
  static InitialScreen2 + #108, #3967
  static InitialScreen2 + #109, #3967
  static InitialScreen2 + #110, #3967
  static InitialScreen2 + #111, #3967
  static InitialScreen2 + #112, #3967
  static InitialScreen2 + #113, #3967
  static InitialScreen2 + #114, #3967
  static InitialScreen2 + #115, #3967
  static InitialScreen2 + #116, #3967
  static InitialScreen2 + #117, #3967
  static InitialScreen2 + #118, #3967
  static InitialScreen2 + #119, #2825

  ;Linha 3
  static InitialScreen2 + #120, #2825
  static InitialScreen2 + #121, #3967
  static InitialScreen2 + #122, #3967
  static InitialScreen2 + #123, #3967
  static InitialScreen2 + #124, #3967
  static InitialScreen2 + #125, #3967
  static InitialScreen2 + #126, #3967
  static InitialScreen2 + #127, #3967
  static InitialScreen2 + #128, #3967
  static InitialScreen2 + #129, #3967
  static InitialScreen2 + #130, #3967
  static InitialScreen2 + #131, #3967
  static InitialScreen2 + #132, #3967
  static InitialScreen2 + #133, #3967
  static InitialScreen2 + #134, #3967
  static InitialScreen2 + #135, #3967
  static InitialScreen2 + #136, #3967
  static InitialScreen2 + #137, #3967
  static InitialScreen2 + #138, #3967
  static InitialScreen2 + #139, #3967
  static InitialScreen2 + #140, #3967
  static InitialScreen2 + #141, #2313
  static InitialScreen2 + #142, #3967
  static InitialScreen2 + #143, #3967
  static InitialScreen2 + #144, #3967
  static InitialScreen2 + #145, #3967
  static InitialScreen2 + #146, #3967
  static InitialScreen2 + #147, #3967
  static InitialScreen2 + #148, #3967
  static InitialScreen2 + #149, #3967
  static InitialScreen2 + #150, #3967
  static InitialScreen2 + #151, #3967
  static InitialScreen2 + #152, #3967
  static InitialScreen2 + #153, #3967
  static InitialScreen2 + #154, #3967
  static InitialScreen2 + #155, #3967
  static InitialScreen2 + #156, #3967
  static InitialScreen2 + #157, #3967
  static InitialScreen2 + #158, #3967
  static InitialScreen2 + #159, #2825

  ;Linha 4
  static InitialScreen2 + #160, #2825
  static InitialScreen2 + #161, #3967
  static InitialScreen2 + #162, #3967
  static InitialScreen2 + #163, #3967
  static InitialScreen2 + #164, #3967
  static InitialScreen2 + #165, #3967
  static InitialScreen2 + #166, #3967
  static InitialScreen2 + #167, #3967
  static InitialScreen2 + #168, #3967
  static InitialScreen2 + #169, #3967
  static InitialScreen2 + #170, #3967
  static InitialScreen2 + #171, #3967
  static InitialScreen2 + #172, #3967
  static InitialScreen2 + #173, #3967
  static InitialScreen2 + #174, #3967
  static InitialScreen2 + #175, #3967
  static InitialScreen2 + #176, #3967
  static InitialScreen2 + #177, #3967
  static InitialScreen2 + #178, #3967
  static InitialScreen2 + #179, #3967
  static InitialScreen2 + #180, #2313
  static InitialScreen2 + #181, #2313
  static InitialScreen2 + #182, #3967
  static InitialScreen2 + #183, #3967
  static InitialScreen2 + #184, #3967
  static InitialScreen2 + #185, #3967
  static InitialScreen2 + #186, #3967
  static InitialScreen2 + #187, #3967
  static InitialScreen2 + #188, #3967
  static InitialScreen2 + #189, #3967
  static InitialScreen2 + #190, #3967
  static InitialScreen2 + #191, #3967
  static InitialScreen2 + #192, #3967
  static InitialScreen2 + #193, #3967
  static InitialScreen2 + #194, #3967
  static InitialScreen2 + #195, #3967
  static InitialScreen2 + #196, #3967
  static InitialScreen2 + #197, #3967
  static InitialScreen2 + #198, #3967
  static InitialScreen2 + #199, #2825

  ;Linha 5
  static InitialScreen2 + #200, #2825
  static InitialScreen2 + #201, #3967
  static InitialScreen2 + #202, #3967
  static InitialScreen2 + #203, #3967
  static InitialScreen2 + #204, #3967
  static InitialScreen2 + #205, #3967
  static InitialScreen2 + #206, #3967
  static InitialScreen2 + #207, #3967
  static InitialScreen2 + #208, #3967
  static InitialScreen2 + #209, #3967
  static InitialScreen2 + #210, #3967
  static InitialScreen2 + #211, #3967
  static InitialScreen2 + #212, #3967
  static InitialScreen2 + #213, #3967
  static InitialScreen2 + #214, #3967
  static InitialScreen2 + #215, #3967
  static InitialScreen2 + #216, #3967
  static InitialScreen2 + #217, #3967
  static InitialScreen2 + #218, #2313
  static InitialScreen2 + #219, #3967
  static InitialScreen2 + #220, #2313
  static InitialScreen2 + #221, #2313
  static InitialScreen2 + #222, #3967
  static InitialScreen2 + #223, #3967
  static InitialScreen2 + #224, #3967
  static InitialScreen2 + #225, #3967
  static InitialScreen2 + #226, #3967
  static InitialScreen2 + #227, #3967
  static InitialScreen2 + #228, #3967
  static InitialScreen2 + #229, #3967
  static InitialScreen2 + #230, #3967
  static InitialScreen2 + #231, #3967
  static InitialScreen2 + #232, #3967
  static InitialScreen2 + #233, #3967
  static InitialScreen2 + #234, #3967
  static InitialScreen2 + #235, #3967
  static InitialScreen2 + #236, #3967
  static InitialScreen2 + #237, #3967
  static InitialScreen2 + #238, #3967
  static InitialScreen2 + #239, #2825

  ;Linha 6
  static InitialScreen2 + #240, #2825
  static InitialScreen2 + #241, #3967
  static InitialScreen2 + #242, #3967
  static InitialScreen2 + #243, #3967
  static InitialScreen2 + #244, #3967
  static InitialScreen2 + #245, #3967
  static InitialScreen2 + #246, #3967
  static InitialScreen2 + #247, #3967
  static InitialScreen2 + #248, #3967
  static InitialScreen2 + #249, #3967
  static InitialScreen2 + #250, #3967
  static InitialScreen2 + #251, #3967
  static InitialScreen2 + #252, #3967
  static InitialScreen2 + #253, #3967
  static InitialScreen2 + #254, #3967
  static InitialScreen2 + #255, #3967
  static InitialScreen2 + #256, #3967
  static InitialScreen2 + #257, #2313
  static InitialScreen2 + #258, #3967
  static InitialScreen2 + #259, #3967
  static InitialScreen2 + #260, #2313
  static InitialScreen2 + #261, #2313
  static InitialScreen2 + #262, #2313
  static InitialScreen2 + #263, #3967
  static InitialScreen2 + #264, #3967
  static InitialScreen2 + #265, #3967
  static InitialScreen2 + #266, #3967
  static InitialScreen2 + #267, #3967
  static InitialScreen2 + #268, #3967
  static InitialScreen2 + #269, #3967
  static InitialScreen2 + #270, #3967
  static InitialScreen2 + #271, #3967
  static InitialScreen2 + #272, #3967
  static InitialScreen2 + #273, #3967
  static InitialScreen2 + #274, #3967
  static InitialScreen2 + #275, #3967
  static InitialScreen2 + #276, #3967
  static InitialScreen2 + #277, #3967
  static InitialScreen2 + #278, #3967
  static InitialScreen2 + #279, #2825

  ;Linha 7
  static InitialScreen2 + #280, #2825
  static InitialScreen2 + #281, #3967
  static InitialScreen2 + #282, #3967
  static InitialScreen2 + #283, #3967
  static InitialScreen2 + #284, #3967
  static InitialScreen2 + #285, #3967
  static InitialScreen2 + #286, #3967
  static InitialScreen2 + #287, #3967
  static InitialScreen2 + #288, #3967
  static InitialScreen2 + #289, #3967
  static InitialScreen2 + #290, #3967
  static InitialScreen2 + #291, #3967
  static InitialScreen2 + #292, #3967
  static InitialScreen2 + #293, #3967
  static InitialScreen2 + #294, #3967
  static InitialScreen2 + #295, #3967
  static InitialScreen2 + #296, #2313
  static InitialScreen2 + #297, #2313
  static InitialScreen2 + #298, #3967
  static InitialScreen2 + #299, #2313
  static InitialScreen2 + #300, #2313
  static InitialScreen2 + #301, #2313
  static InitialScreen2 + #302, #2313
  static InitialScreen2 + #303, #2313
  static InitialScreen2 + #304, #3967
  static InitialScreen2 + #305, #3967
  static InitialScreen2 + #306, #3967
  static InitialScreen2 + #307, #3967
  static InitialScreen2 + #308, #3967
  static InitialScreen2 + #309, #3967
  static InitialScreen2 + #310, #3967
  static InitialScreen2 + #311, #3967
  static InitialScreen2 + #312, #3967
  static InitialScreen2 + #313, #3967
  static InitialScreen2 + #314, #3967
  static InitialScreen2 + #315, #3967
  static InitialScreen2 + #316, #3967
  static InitialScreen2 + #317, #3967
  static InitialScreen2 + #318, #3967
  static InitialScreen2 + #319, #2825

  ;Linha 8
  static InitialScreen2 + #320, #2825
  static InitialScreen2 + #321, #3967
  static InitialScreen2 + #322, #3967
  static InitialScreen2 + #323, #3967
  static InitialScreen2 + #324, #3967
  static InitialScreen2 + #325, #3967
  static InitialScreen2 + #326, #3967
  static InitialScreen2 + #327, #3967
  static InitialScreen2 + #328, #3967
  static InitialScreen2 + #329, #3967
  static InitialScreen2 + #330, #3967
  static InitialScreen2 + #331, #3967
  static InitialScreen2 + #332, #3967
  static InitialScreen2 + #333, #3967
  static InitialScreen2 + #334, #3967
  static InitialScreen2 + #335, #2313
  static InitialScreen2 + #336, #2313
  static InitialScreen2 + #337, #2313
  static InitialScreen2 + #338, #2313
  static InitialScreen2 + #339, #2313
  static InitialScreen2 + #340, #2313
  static InitialScreen2 + #341, #2313
  static InitialScreen2 + #342, #2313
  static InitialScreen2 + #343, #2313
  static InitialScreen2 + #344, #3967
  static InitialScreen2 + #345, #3967
  static InitialScreen2 + #346, #3967
  static InitialScreen2 + #347, #3967
  static InitialScreen2 + #348, #3967
  static InitialScreen2 + #349, #3967
  static InitialScreen2 + #350, #3967
  static InitialScreen2 + #351, #3967
  static InitialScreen2 + #352, #3967
  static InitialScreen2 + #353, #3967
  static InitialScreen2 + #354, #3967
  static InitialScreen2 + #355, #3967
  static InitialScreen2 + #356, #3967
  static InitialScreen2 + #357, #3967
  static InitialScreen2 + #358, #3967
  static InitialScreen2 + #359, #2825

  ;Linha 9
  static InitialScreen2 + #360, #2825
  static InitialScreen2 + #361, #3967
  static InitialScreen2 + #362, #3967
  static InitialScreen2 + #363, #3967
  static InitialScreen2 + #364, #3967
  static InitialScreen2 + #365, #3967
  static InitialScreen2 + #366, #3967
  static InitialScreen2 + #367, #3967
  static InitialScreen2 + #368, #3967
  static InitialScreen2 + #369, #3967
  static InitialScreen2 + #370, #3967
  static InitialScreen2 + #371, #3967
  static InitialScreen2 + #372, #3967
  static InitialScreen2 + #373, #3967
  static InitialScreen2 + #374, #2313
  static InitialScreen2 + #375, #2313
  static InitialScreen2 + #376, #2313
  static InitialScreen2 + #377, #2313
  static InitialScreen2 + #378, #2313
  static InitialScreen2 + #379, #9
  static InitialScreen2 + #380, #2313
  static InitialScreen2 + #381, #2313
  static InitialScreen2 + #382, #2313
  static InitialScreen2 + #383, #2313
  static InitialScreen2 + #384, #2313
  static InitialScreen2 + #385, #3967
  static InitialScreen2 + #386, #3967
  static InitialScreen2 + #387, #3967
  static InitialScreen2 + #388, #3967
  static InitialScreen2 + #389, #3967
  static InitialScreen2 + #390, #3967
  static InitialScreen2 + #391, #3967
  static InitialScreen2 + #392, #3967
  static InitialScreen2 + #393, #3967
  static InitialScreen2 + #394, #3967
  static InitialScreen2 + #395, #3967
  static InitialScreen2 + #396, #3967
  static InitialScreen2 + #397, #3967
  static InitialScreen2 + #398, #3967
  static InitialScreen2 + #399, #2825

  ;Linha 10
  static InitialScreen2 + #400, #2825
  static InitialScreen2 + #401, #3967
  static InitialScreen2 + #402, #3967
  static InitialScreen2 + #403, #3967
  static InitialScreen2 + #404, #3967
  static InitialScreen2 + #405, #3967
  static InitialScreen2 + #406, #3967
  static InitialScreen2 + #407, #3967
  static InitialScreen2 + #408, #3967
  static InitialScreen2 + #409, #3967
  static InitialScreen2 + #410, #3967
  static InitialScreen2 + #411, #3967
  static InitialScreen2 + #412, #3967
  static InitialScreen2 + #413, #3967
  static InitialScreen2 + #414, #2313
  static InitialScreen2 + #415, #2313
  static InitialScreen2 + #416, #2313
  static InitialScreen2 + #417, #2313
  static InitialScreen2 + #418, #9
  static InitialScreen2 + #419, #9
  static InitialScreen2 + #420, #9
  static InitialScreen2 + #421, #2313
  static InitialScreen2 + #422, #2313
  static InitialScreen2 + #423, #2313
  static InitialScreen2 + #424, #2313
  static InitialScreen2 + #425, #3967
  static InitialScreen2 + #426, #3967
  static InitialScreen2 + #427, #3967
  static InitialScreen2 + #428, #3967
  static InitialScreen2 + #429, #3967
  static InitialScreen2 + #430, #3967
  static InitialScreen2 + #431, #3967
  static InitialScreen2 + #432, #3967
  static InitialScreen2 + #433, #3967
  static InitialScreen2 + #434, #3967
  static InitialScreen2 + #435, #3967
  static InitialScreen2 + #436, #3967
  static InitialScreen2 + #437, #3967
  static InitialScreen2 + #438, #3967
  static InitialScreen2 + #439, #2825

  ;Linha 11
  static InitialScreen2 + #440, #2825
  static InitialScreen2 + #441, #3967
  static InitialScreen2 + #442, #3967
  static InitialScreen2 + #443, #3967
  static InitialScreen2 + #444, #3967
  static InitialScreen2 + #445, #3967
  static InitialScreen2 + #446, #3967
  static InitialScreen2 + #447, #3967
  static InitialScreen2 + #448, #3967
  static InitialScreen2 + #449, #3967
  static InitialScreen2 + #450, #3967
  static InitialScreen2 + #451, #3967
  static InitialScreen2 + #452, #3967
  static InitialScreen2 + #453, #3967
  static InitialScreen2 + #454, #2313
  static InitialScreen2 + #455, #2313
  static InitialScreen2 + #456, #2313
  static InitialScreen2 + #457, #9
  static InitialScreen2 + #458, #9
  static InitialScreen2 + #459, #2313
  static InitialScreen2 + #460, #9
  static InitialScreen2 + #461, #9
  static InitialScreen2 + #462, #2313
  static InitialScreen2 + #463, #2313
  static InitialScreen2 + #464, #2313
  static InitialScreen2 + #465, #3967
  static InitialScreen2 + #466, #3967
  static InitialScreen2 + #467, #3967
  static InitialScreen2 + #468, #3967
  static InitialScreen2 + #469, #3967
  static InitialScreen2 + #470, #3967
  static InitialScreen2 + #471, #3967
  static InitialScreen2 + #472, #3967
  static InitialScreen2 + #473, #3967
  static InitialScreen2 + #474, #3967
  static InitialScreen2 + #475, #3967
  static InitialScreen2 + #476, #3967
  static InitialScreen2 + #477, #3967
  static InitialScreen2 + #478, #3967
  static InitialScreen2 + #479, #2825

  ;Linha 12
  static InitialScreen2 + #480, #2825
  static InitialScreen2 + #481, #3967
  static InitialScreen2 + #482, #3967
  static InitialScreen2 + #483, #3967
  static InitialScreen2 + #484, #3967
  static InitialScreen2 + #485, #3967
  static InitialScreen2 + #486, #3967
  static InitialScreen2 + #487, #3967
  static InitialScreen2 + #488, #3967
  static InitialScreen2 + #489, #3967
  static InitialScreen2 + #490, #3967
  static InitialScreen2 + #491, #3967
  static InitialScreen2 + #492, #3967
  static InitialScreen2 + #493, #2313
  static InitialScreen2 + #494, #2313
  static InitialScreen2 + #495, #2313
  static InitialScreen2 + #496, #9
  static InitialScreen2 + #497, #9
  static InitialScreen2 + #498, #9
  static InitialScreen2 + #499, #9
  static InitialScreen2 + #500, #9
  static InitialScreen2 + #501, #9
  static InitialScreen2 + #502, #9
  static InitialScreen2 + #503, #2313
  static InitialScreen2 + #504, #2313
  static InitialScreen2 + #505, #2313
  static InitialScreen2 + #506, #3967
  static InitialScreen2 + #507, #3967
  static InitialScreen2 + #508, #3967
  static InitialScreen2 + #509, #3967
  static InitialScreen2 + #510, #3967
  static InitialScreen2 + #511, #3967
  static InitialScreen2 + #512, #3967
  static InitialScreen2 + #513, #3967
  static InitialScreen2 + #514, #3967
  static InitialScreen2 + #515, #3967
  static InitialScreen2 + #516, #3967
  static InitialScreen2 + #517, #3967
  static InitialScreen2 + #518, #3967
  static InitialScreen2 + #519, #2825

  ;Linha 13
  static InitialScreen2 + #520, #2825
  static InitialScreen2 + #521, #3967
  static InitialScreen2 + #522, #3967
  static InitialScreen2 + #523, #3967
  static InitialScreen2 + #524, #3967
  static InitialScreen2 + #525, #3967
  static InitialScreen2 + #526, #3967
  static InitialScreen2 + #527, #3967
  static InitialScreen2 + #528, #3967
  static InitialScreen2 + #529, #3967
  static InitialScreen2 + #530, #3967
  static InitialScreen2 + #531, #3967
  static InitialScreen2 + #532, #3967
  static InitialScreen2 + #533, #2313
  static InitialScreen2 + #534, #2313
  static InitialScreen2 + #535, #9
  static InitialScreen2 + #536, #9
  static InitialScreen2 + #537, #9
  static InitialScreen2 + #538, #9
  static InitialScreen2 + #539, #9
  static InitialScreen2 + #540, #9
  static InitialScreen2 + #541, #9
  static InitialScreen2 + #542, #9
  static InitialScreen2 + #543, #9
  static InitialScreen2 + #544, #2313
  static InitialScreen2 + #545, #2313
  static InitialScreen2 + #546, #3967
  static InitialScreen2 + #547, #3967
  static InitialScreen2 + #548, #3967
  static InitialScreen2 + #549, #3967
  static InitialScreen2 + #550, #3967
  static InitialScreen2 + #551, #3967
  static InitialScreen2 + #552, #3967
  static InitialScreen2 + #553, #3967
  static InitialScreen2 + #554, #3967
  static InitialScreen2 + #555, #3967
  static InitialScreen2 + #556, #3967
  static InitialScreen2 + #557, #3967
  static InitialScreen2 + #558, #3967
  static InitialScreen2 + #559, #2825

  ;Linha 14
  static InitialScreen2 + #560, #2825
  static InitialScreen2 + #561, #3967
  static InitialScreen2 + #562, #3967
  static InitialScreen2 + #563, #3967
  static InitialScreen2 + #564, #3967
  static InitialScreen2 + #565, #3967
  static InitialScreen2 + #566, #3967
  static InitialScreen2 + #567, #3967
  static InitialScreen2 + #568, #3967
  static InitialScreen2 + #569, #3967
  static InitialScreen2 + #570, #3967
  static InitialScreen2 + #571, #3967
  static InitialScreen2 + #572, #3967
  static InitialScreen2 + #573, #2313
  static InitialScreen2 + #574, #9
  static InitialScreen2 + #575, #9
  static InitialScreen2 + #576, #2313
  static InitialScreen2 + #577, #9
  static InitialScreen2 + #578, #9
  static InitialScreen2 + #579, #2313
  static InitialScreen2 + #580, #9
  static InitialScreen2 + #581, #9
  static InitialScreen2 + #582, #2313
  static InitialScreen2 + #583, #9
  static InitialScreen2 + #584, #9
  static InitialScreen2 + #585, #2313
  static InitialScreen2 + #586, #3967
  static InitialScreen2 + #587, #3967
  static InitialScreen2 + #588, #3967
  static InitialScreen2 + #589, #3967
  static InitialScreen2 + #590, #3967
  static InitialScreen2 + #591, #3967
  static InitialScreen2 + #592, #3967
  static InitialScreen2 + #593, #3967
  static InitialScreen2 + #594, #3967
  static InitialScreen2 + #595, #3967
  static InitialScreen2 + #596, #3967
  static InitialScreen2 + #597, #3967
  static InitialScreen2 + #598, #3967
  static InitialScreen2 + #599, #2825

  ;Linha 15
  static InitialScreen2 + #600, #2825
  static InitialScreen2 + #601, #3967
  static InitialScreen2 + #602, #3967
  static InitialScreen2 + #603, #3967
  static InitialScreen2 + #604, #3967
  static InitialScreen2 + #605, #3967
  static InitialScreen2 + #606, #3967
  static InitialScreen2 + #607, #3967
  static InitialScreen2 + #608, #3967
  static InitialScreen2 + #609, #3967
  static InitialScreen2 + #610, #3967
  static InitialScreen2 + #611, #3967
  static InitialScreen2 + #612, #3967
  static InitialScreen2 + #613, #2313
  static InitialScreen2 + #614, #2313
  static InitialScreen2 + #615, #9
  static InitialScreen2 + #616, #9
  static InitialScreen2 + #617, #9
  static InitialScreen2 + #618, #9
  static InitialScreen2 + #619, #9
  static InitialScreen2 + #620, #9
  static InitialScreen2 + #621, #9
  static InitialScreen2 + #622, #9
  static InitialScreen2 + #623, #9
  static InitialScreen2 + #624, #2313
  static InitialScreen2 + #625, #2313
  static InitialScreen2 + #626, #3967
  static InitialScreen2 + #627, #3967
  static InitialScreen2 + #628, #3967
  static InitialScreen2 + #629, #3967
  static InitialScreen2 + #630, #3967
  static InitialScreen2 + #631, #3967
  static InitialScreen2 + #632, #3967
  static InitialScreen2 + #633, #3967
  static InitialScreen2 + #634, #3967
  static InitialScreen2 + #635, #3967
  static InitialScreen2 + #636, #3967
  static InitialScreen2 + #637, #3967
  static InitialScreen2 + #638, #3967
  static InitialScreen2 + #639, #2825

  ;Linha 16
  static InitialScreen2 + #640, #2825
  static InitialScreen2 + #641, #3967
  static InitialScreen2 + #642, #3967
  static InitialScreen2 + #643, #3967
  static InitialScreen2 + #644, #3967
  static InitialScreen2 + #645, #3967
  static InitialScreen2 + #646, #3967
  static InitialScreen2 + #647, #3967
  static InitialScreen2 + #648, #3967
  static InitialScreen2 + #649, #3967
  static InitialScreen2 + #650, #3967
  static InitialScreen2 + #651, #3967
  static InitialScreen2 + #652, #3967
  static InitialScreen2 + #653, #3967
  static InitialScreen2 + #654, #2313
  static InitialScreen2 + #655, #2313
  static InitialScreen2 + #656, #9
  static InitialScreen2 + #657, #9
  static InitialScreen2 + #658, #9
  static InitialScreen2 + #659, #9
  static InitialScreen2 + #660, #9
  static InitialScreen2 + #661, #9
  static InitialScreen2 + #662, #9
  static InitialScreen2 + #663, #2313
  static InitialScreen2 + #664, #2313
  static InitialScreen2 + #665, #3967
  static InitialScreen2 + #666, #3967
  static InitialScreen2 + #667, #3967
  static InitialScreen2 + #668, #3967
  static InitialScreen2 + #669, #3967
  static InitialScreen2 + #670, #3967
  static InitialScreen2 + #671, #3967
  static InitialScreen2 + #672, #3967
  static InitialScreen2 + #673, #3967
  static InitialScreen2 + #674, #3967
  static InitialScreen2 + #675, #3967
  static InitialScreen2 + #676, #3967
  static InitialScreen2 + #677, #3967
  static InitialScreen2 + #678, #3967
  static InitialScreen2 + #679, #2825

  ;Linha 17
  static InitialScreen2 + #680, #2825
  static InitialScreen2 + #681, #3967
  static InitialScreen2 + #682, #3967
  static InitialScreen2 + #683, #3967
  static InitialScreen2 + #684, #3967
  static InitialScreen2 + #685, #3967
  static InitialScreen2 + #686, #3967
  static InitialScreen2 + #687, #3967
  static InitialScreen2 + #688, #3967
  static InitialScreen2 + #689, #3967
  static InitialScreen2 + #690, #3967
  static InitialScreen2 + #691, #3967
  static InitialScreen2 + #692, #3967
  static InitialScreen2 + #693, #3967
  static InitialScreen2 + #694, #3967
  static InitialScreen2 + #695, #2313
  static InitialScreen2 + #696, #2313
  static InitialScreen2 + #697, #9
  static InitialScreen2 + #698, #9
  static InitialScreen2 + #699, #2313
  static InitialScreen2 + #700, #9
  static InitialScreen2 + #701, #9
  static InitialScreen2 + #702, #2313
  static InitialScreen2 + #703, #2313
  static InitialScreen2 + #704, #3967
  static InitialScreen2 + #705, #3967
  static InitialScreen2 + #706, #3967
  static InitialScreen2 + #707, #3967
  static InitialScreen2 + #708, #3967
  static InitialScreen2 + #709, #3967
  static InitialScreen2 + #710, #3967
  static InitialScreen2 + #711, #3967
  static InitialScreen2 + #712, #3967
  static InitialScreen2 + #713, #3967
  static InitialScreen2 + #714, #3967
  static InitialScreen2 + #715, #3967
  static InitialScreen2 + #716, #3967
  static InitialScreen2 + #717, #3967
  static InitialScreen2 + #718, #3967
  static InitialScreen2 + #719, #2825

  ;Linha 18
  static InitialScreen2 + #720, #2825
  static InitialScreen2 + #721, #3967
  static InitialScreen2 + #722, #3967
  static InitialScreen2 + #723, #3967
  static InitialScreen2 + #724, #3967
  static InitialScreen2 + #725, #3967
  static InitialScreen2 + #726, #3967
  static InitialScreen2 + #727, #3967
  static InitialScreen2 + #728, #3967
  static InitialScreen2 + #729, #3967
  static InitialScreen2 + #730, #3967
  static InitialScreen2 + #731, #3967
  static InitialScreen2 + #732, #3967
  static InitialScreen2 + #733, #3967
  static InitialScreen2 + #734, #3967
  static InitialScreen2 + #735, #3967
  static InitialScreen2 + #736, #2313
  static InitialScreen2 + #737, #2313
  static InitialScreen2 + #738, #9
  static InitialScreen2 + #739, #9
  static InitialScreen2 + #740, #9
  static InitialScreen2 + #741, #2313
  static InitialScreen2 + #742, #2313
  static InitialScreen2 + #743, #3967
  static InitialScreen2 + #744, #3967
  static InitialScreen2 + #745, #3967
  static InitialScreen2 + #746, #3967
  static InitialScreen2 + #747, #3967
  static InitialScreen2 + #748, #3967
  static InitialScreen2 + #749, #3967
  static InitialScreen2 + #750, #3967
  static InitialScreen2 + #751, #3967
  static InitialScreen2 + #752, #3967
  static InitialScreen2 + #753, #3967
  static InitialScreen2 + #754, #3967
  static InitialScreen2 + #755, #3967
  static InitialScreen2 + #756, #3967
  static InitialScreen2 + #757, #3967
  static InitialScreen2 + #758, #3967
  static InitialScreen2 + #759, #2825

  ;Linha 19
  static InitialScreen2 + #760, #2825
  static InitialScreen2 + #761, #3967
  static InitialScreen2 + #762, #3967
  static InitialScreen2 + #763, #3967
  static InitialScreen2 + #764, #3967
  static InitialScreen2 + #765, #3967
  static InitialScreen2 + #766, #3967
  static InitialScreen2 + #767, #3967
  static InitialScreen2 + #768, #3967
  static InitialScreen2 + #769, #3967
  static InitialScreen2 + #770, #3967
  static InitialScreen2 + #771, #3967
  static InitialScreen2 + #772, #3967
  static InitialScreen2 + #773, #3967
  static InitialScreen2 + #774, #3967
  static InitialScreen2 + #775, #3967
  static InitialScreen2 + #776, #3967
  static InitialScreen2 + #777, #2313
  static InitialScreen2 + #778, #2313
  static InitialScreen2 + #779, #9
  static InitialScreen2 + #780, #2313
  static InitialScreen2 + #781, #2313
  static InitialScreen2 + #782, #3967
  static InitialScreen2 + #783, #3967
  static InitialScreen2 + #784, #3967
  static InitialScreen2 + #785, #3967
  static InitialScreen2 + #786, #3967
  static InitialScreen2 + #787, #3967
  static InitialScreen2 + #788, #3967
  static InitialScreen2 + #789, #3967
  static InitialScreen2 + #790, #3967
  static InitialScreen2 + #791, #3967
  static InitialScreen2 + #792, #3967
  static InitialScreen2 + #793, #3967
  static InitialScreen2 + #794, #3967
  static InitialScreen2 + #795, #3967
  static InitialScreen2 + #796, #3967
  static InitialScreen2 + #797, #3967
  static InitialScreen2 + #798, #3967
  static InitialScreen2 + #799, #2825

  ;Linha 20
  static InitialScreen2 + #800, #2825
  static InitialScreen2 + #801, #3967
  static InitialScreen2 + #802, #3967
  static InitialScreen2 + #803, #3967
  static InitialScreen2 + #804, #3967
  static InitialScreen2 + #805, #3967
  static InitialScreen2 + #806, #3967
  static InitialScreen2 + #807, #3967
  static InitialScreen2 + #808, #3967
  static InitialScreen2 + #809, #3967
  static InitialScreen2 + #810, #3967
  static InitialScreen2 + #811, #3967
  static InitialScreen2 + #812, #3967
  static InitialScreen2 + #813, #3967
  static InitialScreen2 + #814, #3967
  static InitialScreen2 + #815, #3967
  static InitialScreen2 + #816, #3967
  static InitialScreen2 + #817, #3967
  static InitialScreen2 + #818, #2313
  static InitialScreen2 + #819, #2313
  static InitialScreen2 + #820, #2313
  static InitialScreen2 + #821, #3967
  static InitialScreen2 + #822, #3967
  static InitialScreen2 + #823, #3967
  static InitialScreen2 + #824, #3967
  static InitialScreen2 + #825, #3967
  static InitialScreen2 + #826, #3967
  static InitialScreen2 + #827, #3967
  static InitialScreen2 + #828, #3967
  static InitialScreen2 + #829, #3967
  static InitialScreen2 + #830, #3967
  static InitialScreen2 + #831, #3967
  static InitialScreen2 + #832, #3967
  static InitialScreen2 + #833, #3967
  static InitialScreen2 + #834, #3967
  static InitialScreen2 + #835, #3967
  static InitialScreen2 + #836, #3967
  static InitialScreen2 + #837, #3967
  static InitialScreen2 + #838, #3967
  static InitialScreen2 + #839, #2825

  ;Linha 21
  static InitialScreen2 + #840, #2825
  static InitialScreen2 + #841, #3967
  static InitialScreen2 + #842, #3967
  static InitialScreen2 + #843, #3967
  static InitialScreen2 + #844, #3967
  static InitialScreen2 + #845, #3967
  static InitialScreen2 + #846, #3967
  static InitialScreen2 + #847, #3967
  static InitialScreen2 + #848, #3967
  static InitialScreen2 + #849, #3967
  static InitialScreen2 + #850, #3967
  static InitialScreen2 + #851, #3967
  static InitialScreen2 + #852, #3967
  static InitialScreen2 + #853, #3967
  static InitialScreen2 + #854, #3967
  static InitialScreen2 + #855, #3967
  static InitialScreen2 + #856, #3967
  static InitialScreen2 + #857, #3967
  static InitialScreen2 + #858, #3967
  static InitialScreen2 + #859, #2313
  static InitialScreen2 + #860, #3967
  static InitialScreen2 + #861, #3967
  static InitialScreen2 + #862, #3967
  static InitialScreen2 + #863, #3967
  static InitialScreen2 + #864, #3967
  static InitialScreen2 + #865, #3967
  static InitialScreen2 + #866, #3967
  static InitialScreen2 + #867, #3967
  static InitialScreen2 + #868, #3967
  static InitialScreen2 + #869, #3967
  static InitialScreen2 + #870, #3967
  static InitialScreen2 + #871, #3967
  static InitialScreen2 + #872, #3967
  static InitialScreen2 + #873, #3967
  static InitialScreen2 + #874, #3967
  static InitialScreen2 + #875, #3967
  static InitialScreen2 + #876, #3967
  static InitialScreen2 + #877, #3967
  static InitialScreen2 + #878, #3967
  static InitialScreen2 + #879, #2825

  ;Linha 22
  static InitialScreen2 + #880, #2825
  static InitialScreen2 + #881, #3967
  static InitialScreen2 + #882, #3967
  static InitialScreen2 + #883, #3967
  static InitialScreen2 + #884, #3967
  static InitialScreen2 + #885, #3967
  static InitialScreen2 + #886, #3967
  static InitialScreen2 + #887, #3967
  static InitialScreen2 + #888, #3967
  static InitialScreen2 + #889, #3967
  static InitialScreen2 + #890, #3967
  static InitialScreen2 + #891, #3967
  static InitialScreen2 + #892, #3967
  static InitialScreen2 + #893, #3967
  static InitialScreen2 + #894, #3967
  static InitialScreen2 + #895, #3967
  static InitialScreen2 + #896, #3967
  static InitialScreen2 + #897, #3967
  static InitialScreen2 + #898, #3967
  static InitialScreen2 + #899, #3967
  static InitialScreen2 + #900, #3967
  static InitialScreen2 + #901, #3967
  static InitialScreen2 + #902, #3967
  static InitialScreen2 + #903, #3967
  static InitialScreen2 + #904, #3967
  static InitialScreen2 + #905, #3967
  static InitialScreen2 + #906, #3967
  static InitialScreen2 + #907, #3967
  static InitialScreen2 + #908, #3967
  static InitialScreen2 + #909, #3967
  static InitialScreen2 + #910, #3967
  static InitialScreen2 + #911, #3967
  static InitialScreen2 + #912, #3967
  static InitialScreen2 + #913, #3967
  static InitialScreen2 + #914, #3967
  static InitialScreen2 + #915, #3967
  static InitialScreen2 + #916, #3967
  static InitialScreen2 + #917, #3967
  static InitialScreen2 + #918, #3967
  static InitialScreen2 + #919, #2825

  ;Linha 23
  static InitialScreen2 + #920, #2825
  static InitialScreen2 + #921, #3967
  static InitialScreen2 + #922, #3967
  static InitialScreen2 + #923, #3967
  static InitialScreen2 + #924, #3967
  static InitialScreen2 + #925, #3967
  static InitialScreen2 + #926, #3967
  static InitialScreen2 + #927, #3967
  static InitialScreen2 + #928, #3967
  static InitialScreen2 + #929, #3967
  static InitialScreen2 + #930, #3967
  static InitialScreen2 + #931, #3967
  static InitialScreen2 + #932, #3967
  static InitialScreen2 + #933, #3967
  static InitialScreen2 + #934, #3967
  static InitialScreen2 + #935, #3967
  static InitialScreen2 + #936, #3967
  static InitialScreen2 + #937, #3967
  static InitialScreen2 + #938, #3967
  static InitialScreen2 + #939, #3967
  static InitialScreen2 + #940, #3967
  static InitialScreen2 + #941, #3967
  static InitialScreen2 + #942, #3967
  static InitialScreen2 + #943, #3967
  static InitialScreen2 + #944, #3967
  static InitialScreen2 + #945, #3967
  static InitialScreen2 + #946, #3967
  static InitialScreen2 + #947, #3967
  static InitialScreen2 + #948, #3967
  static InitialScreen2 + #949, #3967
  static InitialScreen2 + #950, #3967
  static InitialScreen2 + #951, #3967
  static InitialScreen2 + #952, #3967
  static InitialScreen2 + #953, #3967
  static InitialScreen2 + #954, #3967
  static InitialScreen2 + #955, #3967
  static InitialScreen2 + #956, #3967
  static InitialScreen2 + #957, #3967
  static InitialScreen2 + #958, #3967
  static InitialScreen2 + #959, #2825

  ;Linha 24
  static InitialScreen2 + #960, #2825
  static InitialScreen2 + #961, #3967
  static InitialScreen2 + #962, #3967
  static InitialScreen2 + #963, #3967
  static InitialScreen2 + #964, #3967
  static InitialScreen2 + #965, #3967
  static InitialScreen2 + #966, #3967
  static InitialScreen2 + #967, #3967
  static InitialScreen2 + #968, #3967
  static InitialScreen2 + #969, #3967
  static InitialScreen2 + #970, #3967
  static InitialScreen2 + #971, #3967
  static InitialScreen2 + #972, #3967
  static InitialScreen2 + #973, #3967
  static InitialScreen2 + #974, #3967
  static InitialScreen2 + #975, #3967
  static InitialScreen2 + #976, #2882
  static InitialScreen2 + #977, #2885
  static InitialScreen2 + #978, #2900
  static InitialScreen2 + #979, #3967
  static InitialScreen2 + #980, #2901
  static InitialScreen2 + #981, #2899
  static InitialScreen2 + #982, #2896
  static InitialScreen2 + #983, #3967
  static InitialScreen2 + #984, #3967
  static InitialScreen2 + #985, #3967
  static InitialScreen2 + #986, #3967
  static InitialScreen2 + #987, #3967
  static InitialScreen2 + #988, #3967
  static InitialScreen2 + #989, #3967
  static InitialScreen2 + #990, #3967
  static InitialScreen2 + #991, #3967
  static InitialScreen2 + #992, #3967
  static InitialScreen2 + #993, #3967
  static InitialScreen2 + #994, #3967
  static InitialScreen2 + #995, #3967
  static InitialScreen2 + #996, #3967
  static InitialScreen2 + #997, #3967
  static InitialScreen2 + #998, #3967
  static InitialScreen2 + #999, #2825

  ;Linha 25
  static InitialScreen2 + #1000, #2825
  static InitialScreen2 + #1001, #3967
  static InitialScreen2 + #1002, #3967
  static InitialScreen2 + #1003, #3967
  static InitialScreen2 + #1004, #3967
  static InitialScreen2 + #1005, #3967
  static InitialScreen2 + #1006, #3967
  static InitialScreen2 + #1007, #3967
  static InitialScreen2 + #1008, #3967
  static InitialScreen2 + #1009, #3967
  static InitialScreen2 + #1010, #3967
  static InitialScreen2 + #1011, #3967
  static InitialScreen2 + #1012, #3967
  static InitialScreen2 + #1013, #3967
  static InitialScreen2 + #1014, #3967
  static InitialScreen2 + #1015, #3967
  static InitialScreen2 + #1016, #3967
  static InitialScreen2 + #1017, #3967
  static InitialScreen2 + #1018, #3967
  static InitialScreen2 + #1019, #3967
  static InitialScreen2 + #1020, #3967
  static InitialScreen2 + #1021, #3967
  static InitialScreen2 + #1022, #3967
  static InitialScreen2 + #1023, #3967
  static InitialScreen2 + #1024, #3967
  static InitialScreen2 + #1025, #3967
  static InitialScreen2 + #1026, #3967
  static InitialScreen2 + #1027, #3967
  static InitialScreen2 + #1028, #3967
  static InitialScreen2 + #1029, #3967
  static InitialScreen2 + #1030, #3967
  static InitialScreen2 + #1031, #3967
  static InitialScreen2 + #1032, #3967
  static InitialScreen2 + #1033, #3967
  static InitialScreen2 + #1034, #3967
  static InitialScreen2 + #1035, #3967
  static InitialScreen2 + #1036, #3967
  static InitialScreen2 + #1037, #3967
  static InitialScreen2 + #1038, #3967
  static InitialScreen2 + #1039, #2825

  ;Linha 26
  static InitialScreen2 + #1040, #2825
  static InitialScreen2 + #1041, #3967
  static InitialScreen2 + #1042, #3967
  static InitialScreen2 + #1043, #3967
  static InitialScreen2 + #1044, #3967
  static InitialScreen2 + #1045, #3967
  static InitialScreen2 + #1046, #3967
  static InitialScreen2 + #1047, #3967
  static InitialScreen2 + #1048, #3967
  static InitialScreen2 + #1049, #3967
  static InitialScreen2 + #1050, #3967
  static InitialScreen2 + #1051, #3967
  static InitialScreen2 + #1052, #3967
  static InitialScreen2 + #1053, #2907
  static InitialScreen2 + #1054, #3967
  static InitialScreen2 + #1055, #2879
  static InitialScreen2 + #1056, #3967
  static InitialScreen2 + #1057, #2900
  static InitialScreen2 + #1058, #2933
  static InitialScreen2 + #1059, #2932
  static InitialScreen2 + #1060, #2927
  static InitialScreen2 + #1061, #2930
  static InitialScreen2 + #1062, #2921
  static InitialScreen2 + #1063, #2913
  static InitialScreen2 + #1064, #2924
  static InitialScreen2 + #1065, #2909
  static InitialScreen2 + #1066, #3967
  static InitialScreen2 + #1067, #3967
  static InitialScreen2 + #1068, #3967
  static InitialScreen2 + #1069, #3967
  static InitialScreen2 + #1070, #3967
  static InitialScreen2 + #1071, #3967
  static InitialScreen2 + #1072, #3967
  static InitialScreen2 + #1073, #3967
  static InitialScreen2 + #1074, #3967
  static InitialScreen2 + #1075, #3967
  static InitialScreen2 + #1076, #3967
  static InitialScreen2 + #1077, #3967
  static InitialScreen2 + #1078, #3967
  static InitialScreen2 + #1079, #2825

  ;Linha 27
  static InitialScreen2 + #1080, #2825
  static InitialScreen2 + #1081, #3967
  static InitialScreen2 + #1082, #3967
  static InitialScreen2 + #1083, #3967
  static InitialScreen2 + #1084, #3967
  static InitialScreen2 + #1085, #3967
  static InitialScreen2 + #1086, #3967
  static InitialScreen2 + #1087, #3967
  static InitialScreen2 + #1088, #3967
  static InitialScreen2 + #1089, #3967
  static InitialScreen2 + #1090, #3967
  static InitialScreen2 + #1091, #3967
  static InitialScreen2 + #1092, #3967
  static InitialScreen2 + #1093, #2907
  static InitialScreen2 + #1094, #2885
  static InitialScreen2 + #1095, #2926
  static InitialScreen2 + #1096, #2932
  static InitialScreen2 + #1097, #2917
  static InitialScreen2 + #1098, #2930
  static InitialScreen2 + #1099, #3967
  static InitialScreen2 + #1100, #2890
  static InitialScreen2 + #1101, #2927
  static InitialScreen2 + #1102, #2919
  static InitialScreen2 + #1103, #2913
  static InitialScreen2 + #1104, #2930
  static InitialScreen2 + #1105, #2909
  static InitialScreen2 + #1106, #3967
  static InitialScreen2 + #1107, #3967
  static InitialScreen2 + #1108, #3967
  static InitialScreen2 + #1109, #3967
  static InitialScreen2 + #1110, #3967
  static InitialScreen2 + #1111, #3967
  static InitialScreen2 + #1112, #3967
  static InitialScreen2 + #1113, #3967
  static InitialScreen2 + #1114, #3967
  static InitialScreen2 + #1115, #3967
  static InitialScreen2 + #1116, #3967
  static InitialScreen2 + #1117, #3967
  static InitialScreen2 + #1118, #3967
  static InitialScreen2 + #1119, #2825

  ;Linha 28
  static InitialScreen2 + #1120, #2825
  static InitialScreen2 + #1121, #3967
  static InitialScreen2 + #1122, #3967
  static InitialScreen2 + #1123, #3967
  static InitialScreen2 + #1124, #3967
  static InitialScreen2 + #1125, #3967
  static InitialScreen2 + #1126, #3967
  static InitialScreen2 + #1127, #3967
  static InitialScreen2 + #1128, #3967
  static InitialScreen2 + #1129, #3967
  static InitialScreen2 + #1130, #3967
  static InitialScreen2 + #1131, #3967
  static InitialScreen2 + #1132, #3967
  static InitialScreen2 + #1133, #3967
  static InitialScreen2 + #1134, #3967
  static InitialScreen2 + #1135, #3967
  static InitialScreen2 + #1136, #3967
  static InitialScreen2 + #1137, #3967
  static InitialScreen2 + #1138, #3967
  static InitialScreen2 + #1139, #3967
  static InitialScreen2 + #1140, #3967
  static InitialScreen2 + #1141, #3967
  static InitialScreen2 + #1142, #3967
  static InitialScreen2 + #1143, #3967
  static InitialScreen2 + #1144, #3967
  static InitialScreen2 + #1145, #3967
  static InitialScreen2 + #1146, #3967
  static InitialScreen2 + #1147, #3967
  static InitialScreen2 + #1148, #3967
  static InitialScreen2 + #1149, #3967
  static InitialScreen2 + #1150, #3967
  static InitialScreen2 + #1151, #3967
  static InitialScreen2 + #1152, #3967
  static InitialScreen2 + #1153, #3967
  static InitialScreen2 + #1154, #3967
  static InitialScreen2 + #1155, #3967
  static InitialScreen2 + #1156, #3967
  static InitialScreen2 + #1157, #3967
  static InitialScreen2 + #1158, #3967
  static InitialScreen2 + #1159, #2825

  ;Linha 29
  static InitialScreen2 + #1160, #2825
  static InitialScreen2 + #1161, #2825
  static InitialScreen2 + #1162, #2825
  static InitialScreen2 + #1163, #2825
  static InitialScreen2 + #1164, #2825
  static InitialScreen2 + #1165, #2825
  static InitialScreen2 + #1166, #2825
  static InitialScreen2 + #1167, #2825
  static InitialScreen2 + #1168, #2825
  static InitialScreen2 + #1169, #2825
  static InitialScreen2 + #1170, #2825
  static InitialScreen2 + #1171, #2825
  static InitialScreen2 + #1172, #2825
  static InitialScreen2 + #1173, #2825
  static InitialScreen2 + #1174, #2825
  static InitialScreen2 + #1175, #2825
  static InitialScreen2 + #1176, #2825
  static InitialScreen2 + #1177, #2825
  static InitialScreen2 + #1178, #2825
  static InitialScreen2 + #1179, #2825
  static InitialScreen2 + #1180, #2825
  static InitialScreen2 + #1181, #2825
  static InitialScreen2 + #1182, #2825
  static InitialScreen2 + #1183, #2825
  static InitialScreen2 + #1184, #2825
  static InitialScreen2 + #1185, #2825
  static InitialScreen2 + #1186, #2825
  static InitialScreen2 + #1187, #2825
  static InitialScreen2 + #1188, #2825
  static InitialScreen2 + #1189, #2825
  static InitialScreen2 + #1190, #2825
  static InitialScreen2 + #1191, #2825
  static InitialScreen2 + #1192, #2825
  static InitialScreen2 + #1193, #2825
  static InitialScreen2 + #1194, #2825
  static InitialScreen2 + #1195, #2825
  static InitialScreen2 + #1196, #2825
  static InitialScreen2 + #1197, #2825
  static InitialScreen2 + #1198, #2825
  static InitialScreen2 + #1199, #2825
;

InitialScreen3 : var #1200
  ;Linha 0
  static InitialScreen3 + #0, #2825
  static InitialScreen3 + #1, #2825
  static InitialScreen3 + #2, #2825
  static InitialScreen3 + #3, #2825
  static InitialScreen3 + #4, #2825
  static InitialScreen3 + #5, #2825
  static InitialScreen3 + #6, #2825
  static InitialScreen3 + #7, #2825
  static InitialScreen3 + #8, #2825
  static InitialScreen3 + #9, #2825
  static InitialScreen3 + #10, #2825
  static InitialScreen3 + #11, #2825
  static InitialScreen3 + #12, #2825
  static InitialScreen3 + #13, #2825
  static InitialScreen3 + #14, #2825
  static InitialScreen3 + #15, #2825
  static InitialScreen3 + #16, #2825
  static InitialScreen3 + #17, #2825
  static InitialScreen3 + #18, #2825
  static InitialScreen3 + #19, #2825
  static InitialScreen3 + #20, #2825
  static InitialScreen3 + #21, #2825
  static InitialScreen3 + #22, #2825
  static InitialScreen3 + #23, #2825
  static InitialScreen3 + #24, #2825
  static InitialScreen3 + #25, #2825
  static InitialScreen3 + #26, #2825
  static InitialScreen3 + #27, #2825
  static InitialScreen3 + #28, #2825
  static InitialScreen3 + #29, #2825
  static InitialScreen3 + #30, #2825
  static InitialScreen3 + #31, #2825
  static InitialScreen3 + #32, #2825
  static InitialScreen3 + #33, #2825
  static InitialScreen3 + #34, #2825
  static InitialScreen3 + #35, #2825
  static InitialScreen3 + #36, #2825
  static InitialScreen3 + #37, #2825
  static InitialScreen3 + #38, #2825
  static InitialScreen3 + #39, #2825

  ;Linha 1
  static InitialScreen3 + #40, #2825
  static InitialScreen3 + #41, #3967
  static InitialScreen3 + #42, #3967
  static InitialScreen3 + #43, #3967
  static InitialScreen3 + #44, #3967
  static InitialScreen3 + #45, #3967
  static InitialScreen3 + #46, #3967
  static InitialScreen3 + #47, #3967
  static InitialScreen3 + #48, #3967
  static InitialScreen3 + #49, #3967
  static InitialScreen3 + #50, #3967
  static InitialScreen3 + #51, #3967
  static InitialScreen3 + #52, #3967
  static InitialScreen3 + #53, #3967
  static InitialScreen3 + #54, #3967
  static InitialScreen3 + #55, #3967
  static InitialScreen3 + #56, #3967
  static InitialScreen3 + #57, #3967
  static InitialScreen3 + #58, #3967
  static InitialScreen3 + #59, #3967
  static InitialScreen3 + #60, #3967
  static InitialScreen3 + #61, #3967
  static InitialScreen3 + #62, #3967
  static InitialScreen3 + #63, #3967
  static InitialScreen3 + #64, #3967
  static InitialScreen3 + #65, #3967
  static InitialScreen3 + #66, #3967
  static InitialScreen3 + #67, #3967
  static InitialScreen3 + #68, #3967
  static InitialScreen3 + #69, #3967
  static InitialScreen3 + #70, #3967
  static InitialScreen3 + #71, #3967
  static InitialScreen3 + #72, #3967
  static InitialScreen3 + #73, #3967
  static InitialScreen3 + #74, #3967
  static InitialScreen3 + #75, #3967
  static InitialScreen3 + #76, #3967
  static InitialScreen3 + #77, #3967
  static InitialScreen3 + #78, #3967
  static InitialScreen3 + #79, #2825

  ;Linha 2
  static InitialScreen3 + #80, #2825
  static InitialScreen3 + #81, #3967
  static InitialScreen3 + #82, #3967
  static InitialScreen3 + #83, #3967
  static InitialScreen3 + #84, #3967
  static InitialScreen3 + #85, #3967
  static InitialScreen3 + #86, #3967
  static InitialScreen3 + #87, #3967
  static InitialScreen3 + #88, #3967
  static InitialScreen3 + #89, #3967
  static InitialScreen3 + #90, #3967
  static InitialScreen3 + #91, #3967
  static InitialScreen3 + #92, #3967
  static InitialScreen3 + #93, #3967
  static InitialScreen3 + #94, #3967
  static InitialScreen3 + #95, #3967
  static InitialScreen3 + #96, #3967
  static InitialScreen3 + #97, #3967
  static InitialScreen3 + #98, #3967
  static InitialScreen3 + #99, #3967
  static InitialScreen3 + #100, #3967
  static InitialScreen3 + #101, #3967
  static InitialScreen3 + #102, #2313
  static InitialScreen3 + #103, #2313
  static InitialScreen3 + #104, #3967
  static InitialScreen3 + #105, #3967
  static InitialScreen3 + #106, #3967
  static InitialScreen3 + #107, #3967
  static InitialScreen3 + #108, #3967
  static InitialScreen3 + #109, #3967
  static InitialScreen3 + #110, #3967
  static InitialScreen3 + #111, #3967
  static InitialScreen3 + #112, #3967
  static InitialScreen3 + #113, #3967
  static InitialScreen3 + #114, #3967
  static InitialScreen3 + #115, #3967
  static InitialScreen3 + #116, #3967
  static InitialScreen3 + #117, #3967
  static InitialScreen3 + #118, #3967
  static InitialScreen3 + #119, #2825

  ;Linha 3
  static InitialScreen3 + #120, #2825
  static InitialScreen3 + #121, #3967
  static InitialScreen3 + #122, #3967
  static InitialScreen3 + #123, #3967
  static InitialScreen3 + #124, #3967
  static InitialScreen3 + #125, #3967
  static InitialScreen3 + #126, #3967
  static InitialScreen3 + #127, #3967
  static InitialScreen3 + #128, #3967
  static InitialScreen3 + #129, #3967
  static InitialScreen3 + #130, #3967
  static InitialScreen3 + #131, #3967
  static InitialScreen3 + #132, #3967
  static InitialScreen3 + #133, #3967
  static InitialScreen3 + #134, #3967
  static InitialScreen3 + #135, #3967
  static InitialScreen3 + #136, #3967
  static InitialScreen3 + #137, #3967
  static InitialScreen3 + #138, #3967
  static InitialScreen3 + #139, #3967
  static InitialScreen3 + #140, #3967
  static InitialScreen3 + #141, #2313
  static InitialScreen3 + #142, #2313
  static InitialScreen3 + #143, #3967
  static InitialScreen3 + #144, #3967
  static InitialScreen3 + #145, #3967
  static InitialScreen3 + #146, #3967
  static InitialScreen3 + #147, #3967
  static InitialScreen3 + #148, #3967
  static InitialScreen3 + #149, #3967
  static InitialScreen3 + #150, #3967
  static InitialScreen3 + #151, #3967
  static InitialScreen3 + #152, #3967
  static InitialScreen3 + #153, #3967
  static InitialScreen3 + #154, #3967
  static InitialScreen3 + #155, #3967
  static InitialScreen3 + #156, #3967
  static InitialScreen3 + #157, #3967
  static InitialScreen3 + #158, #3967
  static InitialScreen3 + #159, #2825

  ;Linha 4
  static InitialScreen3 + #160, #2825
  static InitialScreen3 + #161, #3967
  static InitialScreen3 + #162, #3967
  static InitialScreen3 + #163, #3967
  static InitialScreen3 + #164, #3967
  static InitialScreen3 + #165, #3967
  static InitialScreen3 + #166, #3967
  static InitialScreen3 + #167, #3967
  static InitialScreen3 + #168, #3967
  static InitialScreen3 + #169, #3967
  static InitialScreen3 + #170, #3967
  static InitialScreen3 + #171, #3967
  static InitialScreen3 + #172, #3967
  static InitialScreen3 + #173, #3967
  static InitialScreen3 + #174, #3967
  static InitialScreen3 + #175, #3967
  static InitialScreen3 + #176, #3967
  static InitialScreen3 + #177, #3967
  static InitialScreen3 + #178, #3967
  static InitialScreen3 + #179, #3967
  static InitialScreen3 + #180, #2313
  static InitialScreen3 + #181, #2313
  static InitialScreen3 + #182, #3967
  static InitialScreen3 + #183, #3967
  static InitialScreen3 + #184, #3967
  static InitialScreen3 + #185, #3967
  static InitialScreen3 + #186, #3967
  static InitialScreen3 + #187, #3967
  static InitialScreen3 + #188, #3967
  static InitialScreen3 + #189, #3967
  static InitialScreen3 + #190, #3967
  static InitialScreen3 + #191, #3967
  static InitialScreen3 + #192, #3967
  static InitialScreen3 + #193, #3967
  static InitialScreen3 + #194, #3967
  static InitialScreen3 + #195, #3967
  static InitialScreen3 + #196, #3967
  static InitialScreen3 + #197, #3967
  static InitialScreen3 + #198, #3967
  static InitialScreen3 + #199, #2825

  ;Linha 5
  static InitialScreen3 + #200, #2825
  static InitialScreen3 + #201, #3967
  static InitialScreen3 + #202, #3967
  static InitialScreen3 + #203, #3967
  static InitialScreen3 + #204, #3967
  static InitialScreen3 + #205, #3967
  static InitialScreen3 + #206, #3967
  static InitialScreen3 + #207, #3967
  static InitialScreen3 + #208, #3967
  static InitialScreen3 + #209, #3967
  static InitialScreen3 + #210, #3967
  static InitialScreen3 + #211, #3967
  static InitialScreen3 + #212, #3967
  static InitialScreen3 + #213, #3967
  static InitialScreen3 + #214, #3967
  static InitialScreen3 + #215, #3967
  static InitialScreen3 + #216, #3967
  static InitialScreen3 + #217, #3967
  static InitialScreen3 + #218, #2313
  static InitialScreen3 + #219, #3967
  static InitialScreen3 + #220, #2313
  static InitialScreen3 + #221, #2313
  static InitialScreen3 + #222, #3967
  static InitialScreen3 + #223, #3967
  static InitialScreen3 + #224, #3967
  static InitialScreen3 + #225, #2313
  static InitialScreen3 + #226, #3967
  static InitialScreen3 + #227, #3967
  static InitialScreen3 + #228, #3967
  static InitialScreen3 + #229, #3967
  static InitialScreen3 + #230, #3967
  static InitialScreen3 + #231, #3967
  static InitialScreen3 + #232, #3967
  static InitialScreen3 + #233, #3967
  static InitialScreen3 + #234, #3967
  static InitialScreen3 + #235, #3967
  static InitialScreen3 + #236, #3967
  static InitialScreen3 + #237, #3967
  static InitialScreen3 + #238, #3967
  static InitialScreen3 + #239, #2825

  ;Linha 6
  static InitialScreen3 + #240, #2825
  static InitialScreen3 + #241, #3967
  static InitialScreen3 + #242, #3967
  static InitialScreen3 + #243, #3967
  static InitialScreen3 + #244, #3967
  static InitialScreen3 + #245, #3967
  static InitialScreen3 + #246, #3967
  static InitialScreen3 + #247, #3967
  static InitialScreen3 + #248, #3967
  static InitialScreen3 + #249, #3967
  static InitialScreen3 + #250, #3967
  static InitialScreen3 + #251, #3967
  static InitialScreen3 + #252, #3967
  static InitialScreen3 + #253, #3967
  static InitialScreen3 + #254, #3967
  static InitialScreen3 + #255, #3967
  static InitialScreen3 + #256, #3967
  static InitialScreen3 + #257, #2313
  static InitialScreen3 + #258, #3967
  static InitialScreen3 + #259, #3967
  static InitialScreen3 + #260, #2313
  static InitialScreen3 + #261, #2313
  static InitialScreen3 + #262, #2313
  static InitialScreen3 + #263, #3967
  static InitialScreen3 + #264, #2313
  static InitialScreen3 + #265, #3967
  static InitialScreen3 + #266, #3967
  static InitialScreen3 + #267, #3967
  static InitialScreen3 + #268, #3967
  static InitialScreen3 + #269, #3967
  static InitialScreen3 + #270, #3967
  static InitialScreen3 + #271, #3967
  static InitialScreen3 + #272, #3967
  static InitialScreen3 + #273, #3967
  static InitialScreen3 + #274, #3967
  static InitialScreen3 + #275, #3967
  static InitialScreen3 + #276, #3967
  static InitialScreen3 + #277, #3967
  static InitialScreen3 + #278, #3967
  static InitialScreen3 + #279, #2825

  ;Linha 7
  static InitialScreen3 + #280, #2825
  static InitialScreen3 + #281, #3967
  static InitialScreen3 + #282, #3967
  static InitialScreen3 + #283, #3967
  static InitialScreen3 + #284, #3967
  static InitialScreen3 + #285, #3967
  static InitialScreen3 + #286, #3967
  static InitialScreen3 + #287, #3967
  static InitialScreen3 + #288, #3967
  static InitialScreen3 + #289, #3967
  static InitialScreen3 + #290, #3967
  static InitialScreen3 + #291, #3967
  static InitialScreen3 + #292, #3967
  static InitialScreen3 + #293, #3967
  static InitialScreen3 + #294, #3967
  static InitialScreen3 + #295, #3967
  static InitialScreen3 + #296, #2313
  static InitialScreen3 + #297, #2313
  static InitialScreen3 + #298, #3967
  static InitialScreen3 + #299, #2313
  static InitialScreen3 + #300, #2313
  static InitialScreen3 + #301, #2313
  static InitialScreen3 + #302, #2313
  static InitialScreen3 + #303, #2313
  static InitialScreen3 + #304, #2313
  static InitialScreen3 + #305, #3967
  static InitialScreen3 + #306, #3967
  static InitialScreen3 + #307, #3967
  static InitialScreen3 + #308, #3967
  static InitialScreen3 + #309, #3967
  static InitialScreen3 + #310, #3967
  static InitialScreen3 + #311, #3967
  static InitialScreen3 + #312, #3967
  static InitialScreen3 + #313, #3967
  static InitialScreen3 + #314, #3967
  static InitialScreen3 + #315, #3967
  static InitialScreen3 + #316, #3967
  static InitialScreen3 + #317, #3967
  static InitialScreen3 + #318, #3967
  static InitialScreen3 + #319, #2825

  ;Linha 8
  static InitialScreen3 + #320, #2825
  static InitialScreen3 + #321, #3967
  static InitialScreen3 + #322, #3967
  static InitialScreen3 + #323, #3967
  static InitialScreen3 + #324, #3967
  static InitialScreen3 + #325, #3967
  static InitialScreen3 + #326, #3967
  static InitialScreen3 + #327, #3967
  static InitialScreen3 + #328, #3967
  static InitialScreen3 + #329, #3967
  static InitialScreen3 + #330, #3967
  static InitialScreen3 + #331, #3967
  static InitialScreen3 + #332, #3967
  static InitialScreen3 + #333, #3967
  static InitialScreen3 + #334, #3967
  static InitialScreen3 + #335, #2313
  static InitialScreen3 + #336, #2313
  static InitialScreen3 + #337, #2313
  static InitialScreen3 + #338, #2313
  static InitialScreen3 + #339, #2313
  static InitialScreen3 + #340, #2313
  static InitialScreen3 + #341, #2313
  static InitialScreen3 + #342, #2313
  static InitialScreen3 + #343, #2313
  static InitialScreen3 + #344, #3967
  static InitialScreen3 + #345, #3967
  static InitialScreen3 + #346, #3967
  static InitialScreen3 + #347, #3967
  static InitialScreen3 + #348, #3967
  static InitialScreen3 + #349, #3967
  static InitialScreen3 + #350, #3967
  static InitialScreen3 + #351, #3967
  static InitialScreen3 + #352, #3967
  static InitialScreen3 + #353, #3967
  static InitialScreen3 + #354, #3967
  static InitialScreen3 + #355, #3967
  static InitialScreen3 + #356, #3967
  static InitialScreen3 + #357, #3967
  static InitialScreen3 + #358, #3967
  static InitialScreen3 + #359, #2825

  ;Linha 9
  static InitialScreen3 + #360, #2825
  static InitialScreen3 + #361, #3967
  static InitialScreen3 + #362, #3967
  static InitialScreen3 + #363, #3967
  static InitialScreen3 + #364, #3967
  static InitialScreen3 + #365, #3967
  static InitialScreen3 + #366, #3967
  static InitialScreen3 + #367, #3967
  static InitialScreen3 + #368, #3967
  static InitialScreen3 + #369, #3967
  static InitialScreen3 + #370, #3967
  static InitialScreen3 + #371, #3967
  static InitialScreen3 + #372, #3967
  static InitialScreen3 + #373, #3967
  static InitialScreen3 + #374, #2313
  static InitialScreen3 + #375, #2313
  static InitialScreen3 + #376, #2313
  static InitialScreen3 + #377, #2313
  static InitialScreen3 + #378, #2313
  static InitialScreen3 + #379, #9
  static InitialScreen3 + #380, #2313
  static InitialScreen3 + #381, #2313
  static InitialScreen3 + #382, #2313
  static InitialScreen3 + #383, #2313
  static InitialScreen3 + #384, #2313
  static InitialScreen3 + #385, #3967
  static InitialScreen3 + #386, #3967
  static InitialScreen3 + #387, #3967
  static InitialScreen3 + #388, #3967
  static InitialScreen3 + #389, #3967
  static InitialScreen3 + #390, #3967
  static InitialScreen3 + #391, #3967
  static InitialScreen3 + #392, #3967
  static InitialScreen3 + #393, #3967
  static InitialScreen3 + #394, #3967
  static InitialScreen3 + #395, #3967
  static InitialScreen3 + #396, #3967
  static InitialScreen3 + #397, #3967
  static InitialScreen3 + #398, #3967
  static InitialScreen3 + #399, #2825

  ;Linha 10
  static InitialScreen3 + #400, #2825
  static InitialScreen3 + #401, #3967
  static InitialScreen3 + #402, #3967
  static InitialScreen3 + #403, #3967
  static InitialScreen3 + #404, #3967
  static InitialScreen3 + #405, #3967
  static InitialScreen3 + #406, #3967
  static InitialScreen3 + #407, #3967
  static InitialScreen3 + #408, #3967
  static InitialScreen3 + #409, #3967
  static InitialScreen3 + #410, #3967
  static InitialScreen3 + #411, #3967
  static InitialScreen3 + #412, #3967
  static InitialScreen3 + #413, #3967
  static InitialScreen3 + #414, #2313
  static InitialScreen3 + #415, #2313
  static InitialScreen3 + #416, #2313
  static InitialScreen3 + #417, #2313
  static InitialScreen3 + #418, #9
  static InitialScreen3 + #419, #9
  static InitialScreen3 + #420, #9
  static InitialScreen3 + #421, #2313
  static InitialScreen3 + #422, #2313
  static InitialScreen3 + #423, #2313
  static InitialScreen3 + #424, #2313
  static InitialScreen3 + #425, #3967
  static InitialScreen3 + #426, #3967
  static InitialScreen3 + #427, #3967
  static InitialScreen3 + #428, #3967
  static InitialScreen3 + #429, #3967
  static InitialScreen3 + #430, #3967
  static InitialScreen3 + #431, #3967
  static InitialScreen3 + #432, #3967
  static InitialScreen3 + #433, #3967
  static InitialScreen3 + #434, #3967
  static InitialScreen3 + #435, #3967
  static InitialScreen3 + #436, #3967
  static InitialScreen3 + #437, #3967
  static InitialScreen3 + #438, #3967
  static InitialScreen3 + #439, #2825

  ;Linha 11
  static InitialScreen3 + #440, #2825
  static InitialScreen3 + #441, #3967
  static InitialScreen3 + #442, #3967
  static InitialScreen3 + #443, #3967
  static InitialScreen3 + #444, #3967
  static InitialScreen3 + #445, #3967
  static InitialScreen3 + #446, #3967
  static InitialScreen3 + #447, #3967
  static InitialScreen3 + #448, #3967
  static InitialScreen3 + #449, #3967
  static InitialScreen3 + #450, #3967
  static InitialScreen3 + #451, #3967
  static InitialScreen3 + #452, #3967
  static InitialScreen3 + #453, #3967
  static InitialScreen3 + #454, #2313
  static InitialScreen3 + #455, #2313
  static InitialScreen3 + #456, #2313
  static InitialScreen3 + #457, #9
  static InitialScreen3 + #458, #9
  static InitialScreen3 + #459, #2313
  static InitialScreen3 + #460, #9
  static InitialScreen3 + #461, #9
  static InitialScreen3 + #462, #2313
  static InitialScreen3 + #463, #2313
  static InitialScreen3 + #464, #2313
  static InitialScreen3 + #465, #3967
  static InitialScreen3 + #466, #3967
  static InitialScreen3 + #467, #3967
  static InitialScreen3 + #468, #3967
  static InitialScreen3 + #469, #3967
  static InitialScreen3 + #470, #3967
  static InitialScreen3 + #471, #3967
  static InitialScreen3 + #472, #3967
  static InitialScreen3 + #473, #3967
  static InitialScreen3 + #474, #3967
  static InitialScreen3 + #475, #3967
  static InitialScreen3 + #476, #3967
  static InitialScreen3 + #477, #3967
  static InitialScreen3 + #478, #3967
  static InitialScreen3 + #479, #2825

  ;Linha 12
  static InitialScreen3 + #480, #2825
  static InitialScreen3 + #481, #3967
  static InitialScreen3 + #482, #3967
  static InitialScreen3 + #483, #3967
  static InitialScreen3 + #484, #3967
  static InitialScreen3 + #485, #3967
  static InitialScreen3 + #486, #3967
  static InitialScreen3 + #487, #3967
  static InitialScreen3 + #488, #3967
  static InitialScreen3 + #489, #3967
  static InitialScreen3 + #490, #3967
  static InitialScreen3 + #491, #3967
  static InitialScreen3 + #492, #3967
  static InitialScreen3 + #493, #2313
  static InitialScreen3 + #494, #2313
  static InitialScreen3 + #495, #2313
  static InitialScreen3 + #496, #9
  static InitialScreen3 + #497, #9
  static InitialScreen3 + #498, #9
  static InitialScreen3 + #499, #9
  static InitialScreen3 + #500, #9
  static InitialScreen3 + #501, #9
  static InitialScreen3 + #502, #9
  static InitialScreen3 + #503, #2313
  static InitialScreen3 + #504, #2313
  static InitialScreen3 + #505, #2313
  static InitialScreen3 + #506, #3967
  static InitialScreen3 + #507, #3967
  static InitialScreen3 + #508, #3967
  static InitialScreen3 + #509, #3967
  static InitialScreen3 + #510, #3967
  static InitialScreen3 + #511, #3967
  static InitialScreen3 + #512, #3967
  static InitialScreen3 + #513, #3967
  static InitialScreen3 + #514, #3967
  static InitialScreen3 + #515, #3967
  static InitialScreen3 + #516, #3967
  static InitialScreen3 + #517, #3967
  static InitialScreen3 + #518, #3967
  static InitialScreen3 + #519, #2825

  ;Linha 13
  static InitialScreen3 + #520, #2825
  static InitialScreen3 + #521, #3967
  static InitialScreen3 + #522, #3967
  static InitialScreen3 + #523, #3967
  static InitialScreen3 + #524, #3967
  static InitialScreen3 + #525, #3967
  static InitialScreen3 + #526, #3967
  static InitialScreen3 + #527, #3967
  static InitialScreen3 + #528, #3967
  static InitialScreen3 + #529, #3967
  static InitialScreen3 + #530, #3967
  static InitialScreen3 + #531, #3967
  static InitialScreen3 + #532, #3967
  static InitialScreen3 + #533, #2313
  static InitialScreen3 + #534, #2313
  static InitialScreen3 + #535, #9
  static InitialScreen3 + #536, #9
  static InitialScreen3 + #537, #9
  static InitialScreen3 + #538, #9
  static InitialScreen3 + #539, #9
  static InitialScreen3 + #540, #9
  static InitialScreen3 + #541, #9
  static InitialScreen3 + #542, #9
  static InitialScreen3 + #543, #9
  static InitialScreen3 + #544, #2313
  static InitialScreen3 + #545, #2313
  static InitialScreen3 + #546, #3967
  static InitialScreen3 + #547, #3967
  static InitialScreen3 + #548, #3967
  static InitialScreen3 + #549, #3967
  static InitialScreen3 + #550, #3967
  static InitialScreen3 + #551, #3967
  static InitialScreen3 + #552, #3967
  static InitialScreen3 + #553, #3967
  static InitialScreen3 + #554, #3967
  static InitialScreen3 + #555, #3967
  static InitialScreen3 + #556, #3967
  static InitialScreen3 + #557, #3967
  static InitialScreen3 + #558, #3967
  static InitialScreen3 + #559, #2825

  ;Linha 14
  static InitialScreen3 + #560, #2825
  static InitialScreen3 + #561, #3967
  static InitialScreen3 + #562, #3967
  static InitialScreen3 + #563, #3967
  static InitialScreen3 + #564, #3967
  static InitialScreen3 + #565, #3967
  static InitialScreen3 + #566, #3967
  static InitialScreen3 + #567, #3967
  static InitialScreen3 + #568, #3967
  static InitialScreen3 + #569, #3967
  static InitialScreen3 + #570, #3967
  static InitialScreen3 + #571, #3967
  static InitialScreen3 + #572, #3967
  static InitialScreen3 + #573, #2313
  static InitialScreen3 + #574, #9
  static InitialScreen3 + #575, #9
  static InitialScreen3 + #576, #2313
  static InitialScreen3 + #577, #9
  static InitialScreen3 + #578, #9
  static InitialScreen3 + #579, #2313
  static InitialScreen3 + #580, #9
  static InitialScreen3 + #581, #9
  static InitialScreen3 + #582, #2313
  static InitialScreen3 + #583, #9
  static InitialScreen3 + #584, #9
  static InitialScreen3 + #585, #2313
  static InitialScreen3 + #586, #3967
  static InitialScreen3 + #587, #3967
  static InitialScreen3 + #588, #3967
  static InitialScreen3 + #589, #3967
  static InitialScreen3 + #590, #3967
  static InitialScreen3 + #591, #3967
  static InitialScreen3 + #592, #3967
  static InitialScreen3 + #593, #3967
  static InitialScreen3 + #594, #3967
  static InitialScreen3 + #595, #3967
  static InitialScreen3 + #596, #3967
  static InitialScreen3 + #597, #3967
  static InitialScreen3 + #598, #3967
  static InitialScreen3 + #599, #2825

  ;Linha 15
  static InitialScreen3 + #600, #2825
  static InitialScreen3 + #601, #3967
  static InitialScreen3 + #602, #3967
  static InitialScreen3 + #603, #3967
  static InitialScreen3 + #604, #3967
  static InitialScreen3 + #605, #3967
  static InitialScreen3 + #606, #3967
  static InitialScreen3 + #607, #3967
  static InitialScreen3 + #608, #3967
  static InitialScreen3 + #609, #3967
  static InitialScreen3 + #610, #3967
  static InitialScreen3 + #611, #3967
  static InitialScreen3 + #612, #3967
  static InitialScreen3 + #613, #2313
  static InitialScreen3 + #614, #2313
  static InitialScreen3 + #615, #9
  static InitialScreen3 + #616, #9
  static InitialScreen3 + #617, #9
  static InitialScreen3 + #618, #9
  static InitialScreen3 + #619, #9
  static InitialScreen3 + #620, #9
  static InitialScreen3 + #621, #9
  static InitialScreen3 + #622, #9
  static InitialScreen3 + #623, #9
  static InitialScreen3 + #624, #2313
  static InitialScreen3 + #625, #2313
  static InitialScreen3 + #626, #3967
  static InitialScreen3 + #627, #3967
  static InitialScreen3 + #628, #3967
  static InitialScreen3 + #629, #3967
  static InitialScreen3 + #630, #3967
  static InitialScreen3 + #631, #3967
  static InitialScreen3 + #632, #3967
  static InitialScreen3 + #633, #3967
  static InitialScreen3 + #634, #3967
  static InitialScreen3 + #635, #3967
  static InitialScreen3 + #636, #3967
  static InitialScreen3 + #637, #3967
  static InitialScreen3 + #638, #3967
  static InitialScreen3 + #639, #2825

  ;Linha 16
  static InitialScreen3 + #640, #2825
  static InitialScreen3 + #641, #3967
  static InitialScreen3 + #642, #3967
  static InitialScreen3 + #643, #3967
  static InitialScreen3 + #644, #3967
  static InitialScreen3 + #645, #3967
  static InitialScreen3 + #646, #3967
  static InitialScreen3 + #647, #3967
  static InitialScreen3 + #648, #3967
  static InitialScreen3 + #649, #3967
  static InitialScreen3 + #650, #3967
  static InitialScreen3 + #651, #3967
  static InitialScreen3 + #652, #3967
  static InitialScreen3 + #653, #3967
  static InitialScreen3 + #654, #2313
  static InitialScreen3 + #655, #2313
  static InitialScreen3 + #656, #9
  static InitialScreen3 + #657, #9
  static InitialScreen3 + #658, #9
  static InitialScreen3 + #659, #9
  static InitialScreen3 + #660, #9
  static InitialScreen3 + #661, #9
  static InitialScreen3 + #662, #9
  static InitialScreen3 + #663, #2313
  static InitialScreen3 + #664, #2313
  static InitialScreen3 + #665, #3967
  static InitialScreen3 + #666, #3967
  static InitialScreen3 + #667, #3967
  static InitialScreen3 + #668, #3967
  static InitialScreen3 + #669, #3967
  static InitialScreen3 + #670, #3967
  static InitialScreen3 + #671, #3967
  static InitialScreen3 + #672, #3967
  static InitialScreen3 + #673, #3967
  static InitialScreen3 + #674, #3967
  static InitialScreen3 + #675, #3967
  static InitialScreen3 + #676, #3967
  static InitialScreen3 + #677, #3967
  static InitialScreen3 + #678, #3967
  static InitialScreen3 + #679, #2825

  ;Linha 17
  static InitialScreen3 + #680, #2825
  static InitialScreen3 + #681, #3967
  static InitialScreen3 + #682, #3967
  static InitialScreen3 + #683, #3967
  static InitialScreen3 + #684, #3967
  static InitialScreen3 + #685, #3967
  static InitialScreen3 + #686, #3967
  static InitialScreen3 + #687, #3967
  static InitialScreen3 + #688, #3967
  static InitialScreen3 + #689, #3967
  static InitialScreen3 + #690, #3967
  static InitialScreen3 + #691, #3967
  static InitialScreen3 + #692, #3967
  static InitialScreen3 + #693, #3967
  static InitialScreen3 + #694, #3967
  static InitialScreen3 + #695, #2313
  static InitialScreen3 + #696, #2313
  static InitialScreen3 + #697, #9
  static InitialScreen3 + #698, #9
  static InitialScreen3 + #699, #2313
  static InitialScreen3 + #700, #9
  static InitialScreen3 + #701, #9
  static InitialScreen3 + #702, #2313
  static InitialScreen3 + #703, #2313
  static InitialScreen3 + #704, #3967
  static InitialScreen3 + #705, #3967
  static InitialScreen3 + #706, #3967
  static InitialScreen3 + #707, #3967
  static InitialScreen3 + #708, #3967
  static InitialScreen3 + #709, #3967
  static InitialScreen3 + #710, #3967
  static InitialScreen3 + #711, #3967
  static InitialScreen3 + #712, #3967
  static InitialScreen3 + #713, #3967
  static InitialScreen3 + #714, #3967
  static InitialScreen3 + #715, #3967
  static InitialScreen3 + #716, #3967
  static InitialScreen3 + #717, #3967
  static InitialScreen3 + #718, #3967
  static InitialScreen3 + #719, #2825

  ;Linha 18
  static InitialScreen3 + #720, #2825
  static InitialScreen3 + #721, #3967
  static InitialScreen3 + #722, #3967
  static InitialScreen3 + #723, #3967
  static InitialScreen3 + #724, #3967
  static InitialScreen3 + #725, #3967
  static InitialScreen3 + #726, #3967
  static InitialScreen3 + #727, #3967
  static InitialScreen3 + #728, #3967
  static InitialScreen3 + #729, #3967
  static InitialScreen3 + #730, #3967
  static InitialScreen3 + #731, #3967
  static InitialScreen3 + #732, #3967
  static InitialScreen3 + #733, #3967
  static InitialScreen3 + #734, #3967
  static InitialScreen3 + #735, #3967
  static InitialScreen3 + #736, #2313
  static InitialScreen3 + #737, #2313
  static InitialScreen3 + #738, #9
  static InitialScreen3 + #739, #9
  static InitialScreen3 + #740, #9
  static InitialScreen3 + #741, #2313
  static InitialScreen3 + #742, #2313
  static InitialScreen3 + #743, #3967
  static InitialScreen3 + #744, #3967
  static InitialScreen3 + #745, #3967
  static InitialScreen3 + #746, #3967
  static InitialScreen3 + #747, #3967
  static InitialScreen3 + #748, #3967
  static InitialScreen3 + #749, #3967
  static InitialScreen3 + #750, #3967
  static InitialScreen3 + #751, #3967
  static InitialScreen3 + #752, #3967
  static InitialScreen3 + #753, #3967
  static InitialScreen3 + #754, #3967
  static InitialScreen3 + #755, #3967
  static InitialScreen3 + #756, #3967
  static InitialScreen3 + #757, #3967
  static InitialScreen3 + #758, #3967
  static InitialScreen3 + #759, #2825

  ;Linha 19
  static InitialScreen3 + #760, #2825
  static InitialScreen3 + #761, #3967
  static InitialScreen3 + #762, #3967
  static InitialScreen3 + #763, #3967
  static InitialScreen3 + #764, #3967
  static InitialScreen3 + #765, #3967
  static InitialScreen3 + #766, #3967
  static InitialScreen3 + #767, #3967
  static InitialScreen3 + #768, #3967
  static InitialScreen3 + #769, #3967
  static InitialScreen3 + #770, #3967
  static InitialScreen3 + #771, #3967
  static InitialScreen3 + #772, #3967
  static InitialScreen3 + #773, #3967
  static InitialScreen3 + #774, #3967
  static InitialScreen3 + #775, #3967
  static InitialScreen3 + #776, #3967
  static InitialScreen3 + #777, #2313
  static InitialScreen3 + #778, #2313
  static InitialScreen3 + #779, #9
  static InitialScreen3 + #780, #2313
  static InitialScreen3 + #781, #2313
  static InitialScreen3 + #782, #3967
  static InitialScreen3 + #783, #3967
  static InitialScreen3 + #784, #3967
  static InitialScreen3 + #785, #3967
  static InitialScreen3 + #786, #3967
  static InitialScreen3 + #787, #3967
  static InitialScreen3 + #788, #3967
  static InitialScreen3 + #789, #3967
  static InitialScreen3 + #790, #3967
  static InitialScreen3 + #791, #3967
  static InitialScreen3 + #792, #3967
  static InitialScreen3 + #793, #3967
  static InitialScreen3 + #794, #3967
  static InitialScreen3 + #795, #3967
  static InitialScreen3 + #796, #3967
  static InitialScreen3 + #797, #3967
  static InitialScreen3 + #798, #3967
  static InitialScreen3 + #799, #2825

  ;Linha 20
  static InitialScreen3 + #800, #2825
  static InitialScreen3 + #801, #3967
  static InitialScreen3 + #802, #3967
  static InitialScreen3 + #803, #3967
  static InitialScreen3 + #804, #3967
  static InitialScreen3 + #805, #3967
  static InitialScreen3 + #806, #3967
  static InitialScreen3 + #807, #3967
  static InitialScreen3 + #808, #3967
  static InitialScreen3 + #809, #3967
  static InitialScreen3 + #810, #3967
  static InitialScreen3 + #811, #3967
  static InitialScreen3 + #812, #3967
  static InitialScreen3 + #813, #3967
  static InitialScreen3 + #814, #3967
  static InitialScreen3 + #815, #3967
  static InitialScreen3 + #816, #3967
  static InitialScreen3 + #817, #3967
  static InitialScreen3 + #818, #2313
  static InitialScreen3 + #819, #2313
  static InitialScreen3 + #820, #2313
  static InitialScreen3 + #821, #3967
  static InitialScreen3 + #822, #3967
  static InitialScreen3 + #823, #3967
  static InitialScreen3 + #824, #3967
  static InitialScreen3 + #825, #3967
  static InitialScreen3 + #826, #3967
  static InitialScreen3 + #827, #3967
  static InitialScreen3 + #828, #3967
  static InitialScreen3 + #829, #3967
  static InitialScreen3 + #830, #3967
  static InitialScreen3 + #831, #3967
  static InitialScreen3 + #832, #3967
  static InitialScreen3 + #833, #3967
  static InitialScreen3 + #834, #3967
  static InitialScreen3 + #835, #3967
  static InitialScreen3 + #836, #3967
  static InitialScreen3 + #837, #3967
  static InitialScreen3 + #838, #3967
  static InitialScreen3 + #839, #2825

  ;Linha 21
  static InitialScreen3 + #840, #2825
  static InitialScreen3 + #841, #3967
  static InitialScreen3 + #842, #3967
  static InitialScreen3 + #843, #3967
  static InitialScreen3 + #844, #3967
  static InitialScreen3 + #845, #3967
  static InitialScreen3 + #846, #3967
  static InitialScreen3 + #847, #3967
  static InitialScreen3 + #848, #3967
  static InitialScreen3 + #849, #3967
  static InitialScreen3 + #850, #3967
  static InitialScreen3 + #851, #3967
  static InitialScreen3 + #852, #3967
  static InitialScreen3 + #853, #3967
  static InitialScreen3 + #854, #3967
  static InitialScreen3 + #855, #3967
  static InitialScreen3 + #856, #3967
  static InitialScreen3 + #857, #3967
  static InitialScreen3 + #858, #3967
  static InitialScreen3 + #859, #2313
  static InitialScreen3 + #860, #3967
  static InitialScreen3 + #861, #3967
  static InitialScreen3 + #862, #3967
  static InitialScreen3 + #863, #3967
  static InitialScreen3 + #864, #3967
  static InitialScreen3 + #865, #3967
  static InitialScreen3 + #866, #3967
  static InitialScreen3 + #867, #3967
  static InitialScreen3 + #868, #3967
  static InitialScreen3 + #869, #3967
  static InitialScreen3 + #870, #3967
  static InitialScreen3 + #871, #3967
  static InitialScreen3 + #872, #3967
  static InitialScreen3 + #873, #3967
  static InitialScreen3 + #874, #3967
  static InitialScreen3 + #875, #3967
  static InitialScreen3 + #876, #3967
  static InitialScreen3 + #877, #3967
  static InitialScreen3 + #878, #3967
  static InitialScreen3 + #879, #2825

  ;Linha 22
  static InitialScreen3 + #880, #2825
  static InitialScreen3 + #881, #3967
  static InitialScreen3 + #882, #3967
  static InitialScreen3 + #883, #3967
  static InitialScreen3 + #884, #3967
  static InitialScreen3 + #885, #3967
  static InitialScreen3 + #886, #3967
  static InitialScreen3 + #887, #3967
  static InitialScreen3 + #888, #3967
  static InitialScreen3 + #889, #3967
  static InitialScreen3 + #890, #3967
  static InitialScreen3 + #891, #3967
  static InitialScreen3 + #892, #3967
  static InitialScreen3 + #893, #3967
  static InitialScreen3 + #894, #3967
  static InitialScreen3 + #895, #3967
  static InitialScreen3 + #896, #3967
  static InitialScreen3 + #897, #3967
  static InitialScreen3 + #898, #3967
  static InitialScreen3 + #899, #3967
  static InitialScreen3 + #900, #3967
  static InitialScreen3 + #901, #3967
  static InitialScreen3 + #902, #3967
  static InitialScreen3 + #903, #3967
  static InitialScreen3 + #904, #3967
  static InitialScreen3 + #905, #3967
  static InitialScreen3 + #906, #3967
  static InitialScreen3 + #907, #3967
  static InitialScreen3 + #908, #3967
  static InitialScreen3 + #909, #3967
  static InitialScreen3 + #910, #3967
  static InitialScreen3 + #911, #3967
  static InitialScreen3 + #912, #3967
  static InitialScreen3 + #913, #3967
  static InitialScreen3 + #914, #3967
  static InitialScreen3 + #915, #3967
  static InitialScreen3 + #916, #3967
  static InitialScreen3 + #917, #3967
  static InitialScreen3 + #918, #3967
  static InitialScreen3 + #919, #2825

  ;Linha 23
  static InitialScreen3 + #920, #2825
  static InitialScreen3 + #921, #3967
  static InitialScreen3 + #922, #3967
  static InitialScreen3 + #923, #3967
  static InitialScreen3 + #924, #3967
  static InitialScreen3 + #925, #3967
  static InitialScreen3 + #926, #3967
  static InitialScreen3 + #927, #3967
  static InitialScreen3 + #928, #3967
  static InitialScreen3 + #929, #3967
  static InitialScreen3 + #930, #3967
  static InitialScreen3 + #931, #3967
  static InitialScreen3 + #932, #3967
  static InitialScreen3 + #933, #3967
  static InitialScreen3 + #934, #3967
  static InitialScreen3 + #935, #3967
  static InitialScreen3 + #936, #3967
  static InitialScreen3 + #937, #3967
  static InitialScreen3 + #938, #3967
  static InitialScreen3 + #939, #3967
  static InitialScreen3 + #940, #3967
  static InitialScreen3 + #941, #3967
  static InitialScreen3 + #942, #3967
  static InitialScreen3 + #943, #3967
  static InitialScreen3 + #944, #3967
  static InitialScreen3 + #945, #3967
  static InitialScreen3 + #946, #3967
  static InitialScreen3 + #947, #3967
  static InitialScreen3 + #948, #3967
  static InitialScreen3 + #949, #3967
  static InitialScreen3 + #950, #3967
  static InitialScreen3 + #951, #3967
  static InitialScreen3 + #952, #3967
  static InitialScreen3 + #953, #3967
  static InitialScreen3 + #954, #3967
  static InitialScreen3 + #955, #3967
  static InitialScreen3 + #956, #3967
  static InitialScreen3 + #957, #3967
  static InitialScreen3 + #958, #3967
  static InitialScreen3 + #959, #2825

  ;Linha 24
  static InitialScreen3 + #960, #2825
  static InitialScreen3 + #961, #3967
  static InitialScreen3 + #962, #3967
  static InitialScreen3 + #963, #3967
  static InitialScreen3 + #964, #3967
  static InitialScreen3 + #965, #3967
  static InitialScreen3 + #966, #3967
  static InitialScreen3 + #967, #3967
  static InitialScreen3 + #968, #3967
  static InitialScreen3 + #969, #3967
  static InitialScreen3 + #970, #3967
  static InitialScreen3 + #971, #3967
  static InitialScreen3 + #972, #3967
  static InitialScreen3 + #973, #3967
  static InitialScreen3 + #974, #3967
  static InitialScreen3 + #975, #3967
  static InitialScreen3 + #976, #2882
  static InitialScreen3 + #977, #2885
  static InitialScreen3 + #978, #2900
  static InitialScreen3 + #979, #3967
  static InitialScreen3 + #980, #2901
  static InitialScreen3 + #981, #2899
  static InitialScreen3 + #982, #2896
  static InitialScreen3 + #983, #3967
  static InitialScreen3 + #984, #3967
  static InitialScreen3 + #985, #3967
  static InitialScreen3 + #986, #3967
  static InitialScreen3 + #987, #3967
  static InitialScreen3 + #988, #3967
  static InitialScreen3 + #989, #3967
  static InitialScreen3 + #990, #3967
  static InitialScreen3 + #991, #3967
  static InitialScreen3 + #992, #3967
  static InitialScreen3 + #993, #3967
  static InitialScreen3 + #994, #3967
  static InitialScreen3 + #995, #3967
  static InitialScreen3 + #996, #3967
  static InitialScreen3 + #997, #3967
  static InitialScreen3 + #998, #3967
  static InitialScreen3 + #999, #2825

  ;Linha 25
  static InitialScreen3 + #1000, #2825
  static InitialScreen3 + #1001, #3967
  static InitialScreen3 + #1002, #3967
  static InitialScreen3 + #1003, #3967
  static InitialScreen3 + #1004, #3967
  static InitialScreen3 + #1005, #3967
  static InitialScreen3 + #1006, #3967
  static InitialScreen3 + #1007, #3967
  static InitialScreen3 + #1008, #3967
  static InitialScreen3 + #1009, #3967
  static InitialScreen3 + #1010, #3967
  static InitialScreen3 + #1011, #3967
  static InitialScreen3 + #1012, #3967
  static InitialScreen3 + #1013, #3967
  static InitialScreen3 + #1014, #3967
  static InitialScreen3 + #1015, #3967
  static InitialScreen3 + #1016, #3967
  static InitialScreen3 + #1017, #3967
  static InitialScreen3 + #1018, #3967
  static InitialScreen3 + #1019, #3967
  static InitialScreen3 + #1020, #3967
  static InitialScreen3 + #1021, #3967
  static InitialScreen3 + #1022, #3967
  static InitialScreen3 + #1023, #3967
  static InitialScreen3 + #1024, #3967
  static InitialScreen3 + #1025, #3967
  static InitialScreen3 + #1026, #3967
  static InitialScreen3 + #1027, #3967
  static InitialScreen3 + #1028, #3967
  static InitialScreen3 + #1029, #3967
  static InitialScreen3 + #1030, #3967
  static InitialScreen3 + #1031, #3967
  static InitialScreen3 + #1032, #3967
  static InitialScreen3 + #1033, #3967
  static InitialScreen3 + #1034, #3967
  static InitialScreen3 + #1035, #3967
  static InitialScreen3 + #1036, #3967
  static InitialScreen3 + #1037, #3967
  static InitialScreen3 + #1038, #3967
  static InitialScreen3 + #1039, #2825

  ;Linha 26
  static InitialScreen3 + #1040, #2825
  static InitialScreen3 + #1041, #3967
  static InitialScreen3 + #1042, #3967
  static InitialScreen3 + #1043, #3967
  static InitialScreen3 + #1044, #3967
  static InitialScreen3 + #1045, #3967
  static InitialScreen3 + #1046, #3967
  static InitialScreen3 + #1047, #3967
  static InitialScreen3 + #1048, #3967
  static InitialScreen3 + #1049, #3967
  static InitialScreen3 + #1050, #3967
  static InitialScreen3 + #1051, #3967
  static InitialScreen3 + #1052, #3967
  static InitialScreen3 + #1053, #2907
  static InitialScreen3 + #1054, #3967
  static InitialScreen3 + #1055, #2879
  static InitialScreen3 + #1056, #3967
  static InitialScreen3 + #1057, #2900
  static InitialScreen3 + #1058, #2933
  static InitialScreen3 + #1059, #2932
  static InitialScreen3 + #1060, #2927
  static InitialScreen3 + #1061, #2930
  static InitialScreen3 + #1062, #2921
  static InitialScreen3 + #1063, #2913
  static InitialScreen3 + #1064, #2924
  static InitialScreen3 + #1065, #2909
  static InitialScreen3 + #1066, #3967
  static InitialScreen3 + #1067, #3967
  static InitialScreen3 + #1068, #3967
  static InitialScreen3 + #1069, #3967
  static InitialScreen3 + #1070, #3967
  static InitialScreen3 + #1071, #3967
  static InitialScreen3 + #1072, #3967
  static InitialScreen3 + #1073, #3967
  static InitialScreen3 + #1074, #3967
  static InitialScreen3 + #1075, #3967
  static InitialScreen3 + #1076, #3967
  static InitialScreen3 + #1077, #3967
  static InitialScreen3 + #1078, #3967
  static InitialScreen3 + #1079, #2825

  ;Linha 27
  static InitialScreen3 + #1080, #2825
  static InitialScreen3 + #1081, #3967
  static InitialScreen3 + #1082, #3967
  static InitialScreen3 + #1083, #3967
  static InitialScreen3 + #1084, #3967
  static InitialScreen3 + #1085, #3967
  static InitialScreen3 + #1086, #3967
  static InitialScreen3 + #1087, #3967
  static InitialScreen3 + #1088, #3967
  static InitialScreen3 + #1089, #3967
  static InitialScreen3 + #1090, #3967
  static InitialScreen3 + #1091, #3967
  static InitialScreen3 + #1092, #3967
  static InitialScreen3 + #1093, #2907
  static InitialScreen3 + #1094, #2885
  static InitialScreen3 + #1095, #2926
  static InitialScreen3 + #1096, #2932
  static InitialScreen3 + #1097, #2917
  static InitialScreen3 + #1098, #2930
  static InitialScreen3 + #1099, #3967
  static InitialScreen3 + #1100, #2890
  static InitialScreen3 + #1101, #2927
  static InitialScreen3 + #1102, #2919
  static InitialScreen3 + #1103, #2913
  static InitialScreen3 + #1104, #2930
  static InitialScreen3 + #1105, #2909
  static InitialScreen3 + #1106, #3967
  static InitialScreen3 + #1107, #3967
  static InitialScreen3 + #1108, #3967
  static InitialScreen3 + #1109, #3967
  static InitialScreen3 + #1110, #3967
  static InitialScreen3 + #1111, #3967
  static InitialScreen3 + #1112, #3967
  static InitialScreen3 + #1113, #3967
  static InitialScreen3 + #1114, #3967
  static InitialScreen3 + #1115, #3967
  static InitialScreen3 + #1116, #3967
  static InitialScreen3 + #1117, #3967
  static InitialScreen3 + #1118, #3967
  static InitialScreen3 + #1119, #2825

  ;Linha 28
  static InitialScreen3 + #1120, #2825
  static InitialScreen3 + #1121, #3967
  static InitialScreen3 + #1122, #3967
  static InitialScreen3 + #1123, #3967
  static InitialScreen3 + #1124, #3967
  static InitialScreen3 + #1125, #3967
  static InitialScreen3 + #1126, #3967
  static InitialScreen3 + #1127, #3967
  static InitialScreen3 + #1128, #3967
  static InitialScreen3 + #1129, #3967
  static InitialScreen3 + #1130, #3967
  static InitialScreen3 + #1131, #3967
  static InitialScreen3 + #1132, #3967
  static InitialScreen3 + #1133, #3967
  static InitialScreen3 + #1134, #3967
  static InitialScreen3 + #1135, #3967
  static InitialScreen3 + #1136, #3967
  static InitialScreen3 + #1137, #3967
  static InitialScreen3 + #1138, #3967
  static InitialScreen3 + #1139, #3967
  static InitialScreen3 + #1140, #3967
  static InitialScreen3 + #1141, #3967
  static InitialScreen3 + #1142, #3967
  static InitialScreen3 + #1143, #3967
  static InitialScreen3 + #1144, #3967
  static InitialScreen3 + #1145, #3967
  static InitialScreen3 + #1146, #3967
  static InitialScreen3 + #1147, #3967
  static InitialScreen3 + #1148, #3967
  static InitialScreen3 + #1149, #3967
  static InitialScreen3 + #1150, #3967
  static InitialScreen3 + #1151, #3967
  static InitialScreen3 + #1152, #3967
  static InitialScreen3 + #1153, #3967
  static InitialScreen3 + #1154, #3967
  static InitialScreen3 + #1155, #3967
  static InitialScreen3 + #1156, #3967
  static InitialScreen3 + #1157, #3967
  static InitialScreen3 + #1158, #3967
  static InitialScreen3 + #1159, #2825

  ;Linha 29
  static InitialScreen3 + #1160, #2825
  static InitialScreen3 + #1161, #2825
  static InitialScreen3 + #1162, #2825
  static InitialScreen3 + #1163, #2825
  static InitialScreen3 + #1164, #2825
  static InitialScreen3 + #1165, #2825
  static InitialScreen3 + #1166, #2825
  static InitialScreen3 + #1167, #2825
  static InitialScreen3 + #1168, #2825
  static InitialScreen3 + #1169, #2825
  static InitialScreen3 + #1170, #2825
  static InitialScreen3 + #1171, #2825
  static InitialScreen3 + #1172, #2825
  static InitialScreen3 + #1173, #2825
  static InitialScreen3 + #1174, #2825
  static InitialScreen3 + #1175, #2825
  static InitialScreen3 + #1176, #2825
  static InitialScreen3 + #1177, #2825
  static InitialScreen3 + #1178, #2825
  static InitialScreen3 + #1179, #2825
  static InitialScreen3 + #1180, #2825
  static InitialScreen3 + #1181, #2825
  static InitialScreen3 + #1182, #2825
  static InitialScreen3 + #1183, #2825
  static InitialScreen3 + #1184, #2825
  static InitialScreen3 + #1185, #2825
  static InitialScreen3 + #1186, #2825
  static InitialScreen3 + #1187, #2825
  static InitialScreen3 + #1188, #2825
  static InitialScreen3 + #1189, #2825
  static InitialScreen3 + #1190, #2825
  static InitialScreen3 + #1191, #2825
  static InitialScreen3 + #1192, #2825
  static InitialScreen3 + #1193, #2825
  static InitialScreen3 + #1194, #2825
  static InitialScreen3 + #1195, #2825
  static InitialScreen3 + #1196, #2825
  static InitialScreen3 + #1197, #2825
  static InitialScreen3 + #1198, #2825
  static InitialScreen3 + #1199, #2825
;

LoseScreen1 : var #1200
  ;Linha 0
  static LoseScreen1 + #0, #127
  static LoseScreen1 + #1, #127
  static LoseScreen1 + #2, #127
  static LoseScreen1 + #3, #127
  static LoseScreen1 + #4, #127
  static LoseScreen1 + #5, #127
  static LoseScreen1 + #6, #127
  static LoseScreen1 + #7, #127
  static LoseScreen1 + #8, #127
  static LoseScreen1 + #9, #127
  static LoseScreen1 + #10, #127
  static LoseScreen1 + #11, #127
  static LoseScreen1 + #12, #127
  static LoseScreen1 + #13, #127
  static LoseScreen1 + #14, #127
  static LoseScreen1 + #15, #127
  static LoseScreen1 + #16, #127
  static LoseScreen1 + #17, #127
  static LoseScreen1 + #18, #127
  static LoseScreen1 + #19, #127
  static LoseScreen1 + #20, #127
  static LoseScreen1 + #21, #127
  static LoseScreen1 + #22, #127
  static LoseScreen1 + #23, #127
  static LoseScreen1 + #24, #127
  static LoseScreen1 + #25, #127
  static LoseScreen1 + #26, #3967
  static LoseScreen1 + #27, #127
  static LoseScreen1 + #28, #127
  static LoseScreen1 + #29, #127
  static LoseScreen1 + #30, #127
  static LoseScreen1 + #31, #127
  static LoseScreen1 + #32, #127
  static LoseScreen1 + #33, #127
  static LoseScreen1 + #34, #127
  static LoseScreen1 + #35, #127
  static LoseScreen1 + #36, #127
  static LoseScreen1 + #37, #127
  static LoseScreen1 + #38, #127
  static LoseScreen1 + #39, #127

  ;Linha 1
  static LoseScreen1 + #40, #127
  static LoseScreen1 + #41, #127
  static LoseScreen1 + #42, #127
  static LoseScreen1 + #43, #127
  static LoseScreen1 + #44, #127
  static LoseScreen1 + #45, #127
  static LoseScreen1 + #46, #127
  static LoseScreen1 + #47, #127
  static LoseScreen1 + #48, #127
  static LoseScreen1 + #49, #127
  static LoseScreen1 + #50, #127
  static LoseScreen1 + #51, #127
  static LoseScreen1 + #52, #127
  static LoseScreen1 + #53, #127
  static LoseScreen1 + #54, #127
  static LoseScreen1 + #55, #127
  static LoseScreen1 + #56, #127
  static LoseScreen1 + #57, #127
  static LoseScreen1 + #58, #127
  static LoseScreen1 + #59, #127
  static LoseScreen1 + #60, #127
  static LoseScreen1 + #61, #127
  static LoseScreen1 + #62, #127
  static LoseScreen1 + #63, #127
  static LoseScreen1 + #64, #127
  static LoseScreen1 + #65, #3967
  static LoseScreen1 + #66, #3967
  static LoseScreen1 + #67, #127
  static LoseScreen1 + #68, #127
  static LoseScreen1 + #69, #127
  static LoseScreen1 + #70, #9
  static LoseScreen1 + #71, #9
  static LoseScreen1 + #72, #9
  static LoseScreen1 + #73, #9
  static LoseScreen1 + #74, #9
  static LoseScreen1 + #75, #127
  static LoseScreen1 + #76, #127
  static LoseScreen1 + #77, #127
  static LoseScreen1 + #78, #127
  static LoseScreen1 + #79, #127

  ;Linha 2
  static LoseScreen1 + #80, #127
  static LoseScreen1 + #81, #127
  static LoseScreen1 + #82, #127
  static LoseScreen1 + #83, #127
  static LoseScreen1 + #84, #127
  static LoseScreen1 + #85, #127
  static LoseScreen1 + #86, #127
  static LoseScreen1 + #87, #127
  static LoseScreen1 + #88, #127
  static LoseScreen1 + #89, #127
  static LoseScreen1 + #90, #127
  static LoseScreen1 + #91, #127
  static LoseScreen1 + #92, #127
  static LoseScreen1 + #93, #127
  static LoseScreen1 + #94, #127
  static LoseScreen1 + #95, #127
  static LoseScreen1 + #96, #127
  static LoseScreen1 + #97, #127
  static LoseScreen1 + #98, #127
  static LoseScreen1 + #99, #127
  static LoseScreen1 + #100, #127
  static LoseScreen1 + #101, #127
  static LoseScreen1 + #102, #127
  static LoseScreen1 + #103, #3967
  static LoseScreen1 + #104, #3967
  static LoseScreen1 + #105, #127
  static LoseScreen1 + #106, #127
  static LoseScreen1 + #107, #127
  static LoseScreen1 + #108, #127
  static LoseScreen1 + #109, #127
  static LoseScreen1 + #110, #9
  static LoseScreen1 + #111, #265
  static LoseScreen1 + #112, #265
  static LoseScreen1 + #113, #265
  static LoseScreen1 + #114, #9
  static LoseScreen1 + #115, #127
  static LoseScreen1 + #116, #127
  static LoseScreen1 + #117, #127
  static LoseScreen1 + #118, #127
  static LoseScreen1 + #119, #127

  ;Linha 3
  static LoseScreen1 + #120, #127
  static LoseScreen1 + #121, #127
  static LoseScreen1 + #122, #127
  static LoseScreen1 + #123, #127
  static LoseScreen1 + #124, #127
  static LoseScreen1 + #125, #127
  static LoseScreen1 + #126, #127
  static LoseScreen1 + #127, #127
  static LoseScreen1 + #128, #127
  static LoseScreen1 + #129, #127
  static LoseScreen1 + #130, #127
  static LoseScreen1 + #131, #127
  static LoseScreen1 + #132, #127
  static LoseScreen1 + #133, #127
  static LoseScreen1 + #134, #127
  static LoseScreen1 + #135, #127
  static LoseScreen1 + #136, #127
  static LoseScreen1 + #137, #127
  static LoseScreen1 + #138, #127
  static LoseScreen1 + #139, #127
  static LoseScreen1 + #140, #127
  static LoseScreen1 + #141, #127
  static LoseScreen1 + #142, #3967
  static LoseScreen1 + #143, #3967
  static LoseScreen1 + #144, #3967
  static LoseScreen1 + #145, #127
  static LoseScreen1 + #146, #3967
  static LoseScreen1 + #147, #265
  static LoseScreen1 + #148, #127
  static LoseScreen1 + #149, #127
  static LoseScreen1 + #150, #265
  static LoseScreen1 + #151, #3967
  static LoseScreen1 + #152, #265
  static LoseScreen1 + #153, #3856
  static LoseScreen1 + #154, #265
  static LoseScreen1 + #155, #127
  static LoseScreen1 + #156, #127
  static LoseScreen1 + #157, #265
  static LoseScreen1 + #158, #127
  static LoseScreen1 + #159, #127

  ;Linha 4
  static LoseScreen1 + #160, #127
  static LoseScreen1 + #161, #127
  static LoseScreen1 + #162, #127
  static LoseScreen1 + #163, #127
  static LoseScreen1 + #164, #127
  static LoseScreen1 + #165, #127
  static LoseScreen1 + #166, #127
  static LoseScreen1 + #167, #127
  static LoseScreen1 + #168, #127
  static LoseScreen1 + #169, #127
  static LoseScreen1 + #170, #127
  static LoseScreen1 + #171, #127
  static LoseScreen1 + #172, #127
  static LoseScreen1 + #173, #127
  static LoseScreen1 + #174, #127
  static LoseScreen1 + #175, #127
  static LoseScreen1 + #176, #127
  static LoseScreen1 + #177, #127
  static LoseScreen1 + #178, #127
  static LoseScreen1 + #179, #127
  static LoseScreen1 + #180, #127
  static LoseScreen1 + #181, #127
  static LoseScreen1 + #182, #127
  static LoseScreen1 + #183, #127
  static LoseScreen1 + #184, #127
  static LoseScreen1 + #185, #127
  static LoseScreen1 + #186, #3967
  static LoseScreen1 + #187, #265
  static LoseScreen1 + #188, #265
  static LoseScreen1 + #189, #127
  static LoseScreen1 + #190, #265
  static LoseScreen1 + #191, #265
  static LoseScreen1 + #192, #3849
  static LoseScreen1 + #193, #265
  static LoseScreen1 + #194, #265
  static LoseScreen1 + #195, #3967
  static LoseScreen1 + #196, #265
  static LoseScreen1 + #197, #265
  static LoseScreen1 + #198, #127
  static LoseScreen1 + #199, #127

  ;Linha 5
  static LoseScreen1 + #200, #2057
  static LoseScreen1 + #201, #2057
  static LoseScreen1 + #202, #2057
  static LoseScreen1 + #203, #2057
  static LoseScreen1 + #204, #127
  static LoseScreen1 + #205, #127
  static LoseScreen1 + #206, #127
  static LoseScreen1 + #207, #127
  static LoseScreen1 + #208, #127
  static LoseScreen1 + #209, #127
  static LoseScreen1 + #210, #127
  static LoseScreen1 + #211, #127
  static LoseScreen1 + #212, #127
  static LoseScreen1 + #213, #127
  static LoseScreen1 + #214, #127
  static LoseScreen1 + #215, #127
  static LoseScreen1 + #216, #127
  static LoseScreen1 + #217, #127
  static LoseScreen1 + #218, #127
  static LoseScreen1 + #219, #127
  static LoseScreen1 + #220, #127
  static LoseScreen1 + #221, #127
  static LoseScreen1 + #222, #127
  static LoseScreen1 + #223, #127
  static LoseScreen1 + #224, #127
  static LoseScreen1 + #225, #127
  static LoseScreen1 + #226, #3967
  static LoseScreen1 + #227, #265
  static LoseScreen1 + #228, #265
  static LoseScreen1 + #229, #127
  static LoseScreen1 + #230, #265
  static LoseScreen1 + #231, #265
  static LoseScreen1 + #232, #3849
  static LoseScreen1 + #233, #265
  static LoseScreen1 + #234, #265
  static LoseScreen1 + #235, #127
  static LoseScreen1 + #236, #265
  static LoseScreen1 + #237, #265
  static LoseScreen1 + #238, #127
  static LoseScreen1 + #239, #127

  ;Linha 6
  static LoseScreen1 + #240, #265
  static LoseScreen1 + #241, #265
  static LoseScreen1 + #242, #265
  static LoseScreen1 + #243, #2057
  static LoseScreen1 + #244, #127
  static LoseScreen1 + #245, #127
  static LoseScreen1 + #246, #127
  static LoseScreen1 + #247, #127
  static LoseScreen1 + #248, #127
  static LoseScreen1 + #249, #127
  static LoseScreen1 + #250, #127
  static LoseScreen1 + #251, #127
  static LoseScreen1 + #252, #127
  static LoseScreen1 + #253, #127
  static LoseScreen1 + #254, #127
  static LoseScreen1 + #255, #127
  static LoseScreen1 + #256, #127
  static LoseScreen1 + #257, #127
  static LoseScreen1 + #258, #127
  static LoseScreen1 + #259, #127
  static LoseScreen1 + #260, #127
  static LoseScreen1 + #261, #127
  static LoseScreen1 + #262, #3849
  static LoseScreen1 + #263, #127
  static LoseScreen1 + #264, #127
  static LoseScreen1 + #265, #127
  static LoseScreen1 + #266, #3967
  static LoseScreen1 + #267, #265
  static LoseScreen1 + #268, #265
  static LoseScreen1 + #269, #3967
  static LoseScreen1 + #270, #127
  static LoseScreen1 + #271, #265
  static LoseScreen1 + #272, #265
  static LoseScreen1 + #273, #265
  static LoseScreen1 + #274, #127
  static LoseScreen1 + #275, #127
  static LoseScreen1 + #276, #265
  static LoseScreen1 + #277, #265
  static LoseScreen1 + #278, #127
  static LoseScreen1 + #279, #127

  ;Linha 7
  static LoseScreen1 + #280, #265
  static LoseScreen1 + #281, #265
  static LoseScreen1 + #282, #265
  static LoseScreen1 + #283, #2057
  static LoseScreen1 + #284, #2057
  static LoseScreen1 + #285, #127
  static LoseScreen1 + #286, #127
  static LoseScreen1 + #287, #127
  static LoseScreen1 + #288, #127
  static LoseScreen1 + #289, #127
  static LoseScreen1 + #290, #127
  static LoseScreen1 + #291, #127
  static LoseScreen1 + #292, #127
  static LoseScreen1 + #293, #127
  static LoseScreen1 + #294, #127
  static LoseScreen1 + #295, #127
  static LoseScreen1 + #296, #127
  static LoseScreen1 + #297, #127
  static LoseScreen1 + #298, #127
  static LoseScreen1 + #299, #127
  static LoseScreen1 + #300, #3849
  static LoseScreen1 + #301, #3849
  static LoseScreen1 + #302, #3849
  static LoseScreen1 + #303, #3849
  static LoseScreen1 + #304, #3849
  static LoseScreen1 + #305, #3849
  static LoseScreen1 + #306, #3967
  static LoseScreen1 + #307, #1289
  static LoseScreen1 + #308, #1289
  static LoseScreen1 + #309, #1289
  static LoseScreen1 + #310, #1289
  static LoseScreen1 + #311, #1289
  static LoseScreen1 + #312, #1289
  static LoseScreen1 + #313, #1289
  static LoseScreen1 + #314, #1289
  static LoseScreen1 + #315, #1289
  static LoseScreen1 + #316, #1289
  static LoseScreen1 + #317, #1289
  static LoseScreen1 + #318, #127
  static LoseScreen1 + #319, #127

  ;Linha 8
  static LoseScreen1 + #320, #265
  static LoseScreen1 + #321, #265
  static LoseScreen1 + #322, #265
  static LoseScreen1 + #323, #265
  static LoseScreen1 + #324, #2057
  static LoseScreen1 + #325, #127
  static LoseScreen1 + #326, #127
  static LoseScreen1 + #327, #127
  static LoseScreen1 + #328, #127
  static LoseScreen1 + #329, #127
  static LoseScreen1 + #330, #127
  static LoseScreen1 + #331, #127
  static LoseScreen1 + #332, #127
  static LoseScreen1 + #333, #127
  static LoseScreen1 + #334, #127
  static LoseScreen1 + #335, #127
  static LoseScreen1 + #336, #127
  static LoseScreen1 + #337, #127
  static LoseScreen1 + #338, #127
  static LoseScreen1 + #339, #3849
  static LoseScreen1 + #340, #3849
  static LoseScreen1 + #341, #127
  static LoseScreen1 + #342, #3849
  static LoseScreen1 + #343, #3849
  static LoseScreen1 + #344, #3849
  static LoseScreen1 + #345, #3849
  static LoseScreen1 + #346, #127
  static LoseScreen1 + #347, #1289
  static LoseScreen1 + #348, #1289
  static LoseScreen1 + #349, #1289
  static LoseScreen1 + #350, #1289
  static LoseScreen1 + #351, #1289
  static LoseScreen1 + #352, #1289
  static LoseScreen1 + #353, #1289
  static LoseScreen1 + #354, #1289
  static LoseScreen1 + #355, #1289
  static LoseScreen1 + #356, #1289
  static LoseScreen1 + #357, #1289
  static LoseScreen1 + #358, #127
  static LoseScreen1 + #359, #127

  ;Linha 9
  static LoseScreen1 + #360, #265
  static LoseScreen1 + #361, #265
  static LoseScreen1 + #362, #265
  static LoseScreen1 + #363, #265
  static LoseScreen1 + #364, #265
  static LoseScreen1 + #365, #2057
  static LoseScreen1 + #366, #127
  static LoseScreen1 + #367, #127
  static LoseScreen1 + #368, #127
  static LoseScreen1 + #369, #127
  static LoseScreen1 + #370, #127
  static LoseScreen1 + #371, #127
  static LoseScreen1 + #372, #127
  static LoseScreen1 + #373, #127
  static LoseScreen1 + #374, #127
  static LoseScreen1 + #375, #127
  static LoseScreen1 + #376, #127
  static LoseScreen1 + #377, #3849
  static LoseScreen1 + #378, #3849
  static LoseScreen1 + #379, #3849
  static LoseScreen1 + #380, #3849
  static LoseScreen1 + #381, #3849
  static LoseScreen1 + #382, #3849
  static LoseScreen1 + #383, #3849
  static LoseScreen1 + #384, #3849
  static LoseScreen1 + #385, #3849
  static LoseScreen1 + #386, #3849
  static LoseScreen1 + #387, #127
  static LoseScreen1 + #388, #3967
  static LoseScreen1 + #389, #1289
  static LoseScreen1 + #390, #1289
  static LoseScreen1 + #391, #1289
  static LoseScreen1 + #392, #1289
  static LoseScreen1 + #393, #1289
  static LoseScreen1 + #394, #1289
  static LoseScreen1 + #395, #1289
  static LoseScreen1 + #396, #3967
  static LoseScreen1 + #397, #127
  static LoseScreen1 + #398, #127
  static LoseScreen1 + #399, #127

  ;Linha 10
  static LoseScreen1 + #400, #265
  static LoseScreen1 + #401, #265
  static LoseScreen1 + #402, #265
  static LoseScreen1 + #403, #265
  static LoseScreen1 + #404, #265
  static LoseScreen1 + #405, #2057
  static LoseScreen1 + #406, #2057
  static LoseScreen1 + #407, #127
  static LoseScreen1 + #408, #127
  static LoseScreen1 + #409, #127
  static LoseScreen1 + #410, #127
  static LoseScreen1 + #411, #127
  static LoseScreen1 + #412, #127
  static LoseScreen1 + #413, #127
  static LoseScreen1 + #414, #127
  static LoseScreen1 + #415, #127
  static LoseScreen1 + #416, #127
  static LoseScreen1 + #417, #2057
  static LoseScreen1 + #418, #2057
  static LoseScreen1 + #419, #2057
  static LoseScreen1 + #420, #3849
  static LoseScreen1 + #421, #3849
  static LoseScreen1 + #422, #3849
  static LoseScreen1 + #423, #3849
  static LoseScreen1 + #424, #3849
  static LoseScreen1 + #425, #3849
  static LoseScreen1 + #426, #3849
  static LoseScreen1 + #427, #127
  static LoseScreen1 + #428, #127
  static LoseScreen1 + #429, #3967
  static LoseScreen1 + #430, #1289
  static LoseScreen1 + #431, #1289
  static LoseScreen1 + #432, #1289
  static LoseScreen1 + #433, #1289
  static LoseScreen1 + #434, #1289
  static LoseScreen1 + #435, #127
  static LoseScreen1 + #436, #127
  static LoseScreen1 + #437, #127
  static LoseScreen1 + #438, #127
  static LoseScreen1 + #439, #127

  ;Linha 11
  static LoseScreen1 + #440, #265
  static LoseScreen1 + #441, #265
  static LoseScreen1 + #442, #265
  static LoseScreen1 + #443, #265
  static LoseScreen1 + #444, #265
  static LoseScreen1 + #445, #265
  static LoseScreen1 + #446, #2057
  static LoseScreen1 + #447, #127
  static LoseScreen1 + #448, #127
  static LoseScreen1 + #449, #127
  static LoseScreen1 + #450, #127
  static LoseScreen1 + #451, #127
  static LoseScreen1 + #452, #127
  static LoseScreen1 + #453, #127
  static LoseScreen1 + #454, #127
  static LoseScreen1 + #455, #2057
  static LoseScreen1 + #456, #2057
  static LoseScreen1 + #457, #3967
  static LoseScreen1 + #458, #3849
  static LoseScreen1 + #459, #2057
  static LoseScreen1 + #460, #2057
  static LoseScreen1 + #461, #3849
  static LoseScreen1 + #462, #3849
  static LoseScreen1 + #463, #3849
  static LoseScreen1 + #464, #3849
  static LoseScreen1 + #465, #3849
  static LoseScreen1 + #466, #3849
  static LoseScreen1 + #467, #127
  static LoseScreen1 + #468, #127
  static LoseScreen1 + #469, #3967
  static LoseScreen1 + #470, #1289
  static LoseScreen1 + #471, #1289
  static LoseScreen1 + #472, #1289
  static LoseScreen1 + #473, #1289
  static LoseScreen1 + #474, #127
  static LoseScreen1 + #475, #127
  static LoseScreen1 + #476, #127
  static LoseScreen1 + #477, #127
  static LoseScreen1 + #478, #127
  static LoseScreen1 + #479, #127

  ;Linha 12
  static LoseScreen1 + #480, #265
  static LoseScreen1 + #481, #3967
  static LoseScreen1 + #482, #3967
  static LoseScreen1 + #483, #265
  static LoseScreen1 + #484, #265
  static LoseScreen1 + #485, #265
  static LoseScreen1 + #486, #2057
  static LoseScreen1 + #487, #127
  static LoseScreen1 + #488, #127
  static LoseScreen1 + #489, #127
  static LoseScreen1 + #490, #127
  static LoseScreen1 + #491, #127
  static LoseScreen1 + #492, #127
  static LoseScreen1 + #493, #127
  static LoseScreen1 + #494, #2057
  static LoseScreen1 + #495, #3967
  static LoseScreen1 + #496, #3967
  static LoseScreen1 + #497, #3967
  static LoseScreen1 + #498, #2057
  static LoseScreen1 + #499, #3849
  static LoseScreen1 + #500, #2057
  static LoseScreen1 + #501, #2057
  static LoseScreen1 + #502, #3849
  static LoseScreen1 + #503, #3849
  static LoseScreen1 + #504, #3849
  static LoseScreen1 + #505, #3849
  static LoseScreen1 + #506, #3849
  static LoseScreen1 + #507, #127
  static LoseScreen1 + #508, #127
  static LoseScreen1 + #509, #127
  static LoseScreen1 + #510, #1289
  static LoseScreen1 + #511, #1289
  static LoseScreen1 + #512, #1289
  static LoseScreen1 + #513, #1289
  static LoseScreen1 + #514, #127
  static LoseScreen1 + #515, #127
  static LoseScreen1 + #516, #127
  static LoseScreen1 + #517, #127
  static LoseScreen1 + #518, #127
  static LoseScreen1 + #519, #127

  ;Linha 13
  static LoseScreen1 + #520, #265
  static LoseScreen1 + #521, #3967
  static LoseScreen1 + #522, #265
  static LoseScreen1 + #523, #265
  static LoseScreen1 + #524, #265
  static LoseScreen1 + #525, #265
  static LoseScreen1 + #526, #2057
  static LoseScreen1 + #527, #127
  static LoseScreen1 + #528, #127
  static LoseScreen1 + #529, #127
  static LoseScreen1 + #530, #127
  static LoseScreen1 + #531, #127
  static LoseScreen1 + #532, #127
  static LoseScreen1 + #533, #2057
  static LoseScreen1 + #534, #3967
  static LoseScreen1 + #535, #3967
  static LoseScreen1 + #536, #127
  static LoseScreen1 + #537, #2057
  static LoseScreen1 + #538, #3967
  static LoseScreen1 + #539, #3967
  static LoseScreen1 + #540, #2057
  static LoseScreen1 + #541, #2057
  static LoseScreen1 + #542, #3849
  static LoseScreen1 + #543, #3849
  static LoseScreen1 + #544, #3849
  static LoseScreen1 + #545, #3849
  static LoseScreen1 + #546, #127
  static LoseScreen1 + #547, #127
  static LoseScreen1 + #548, #127
  static LoseScreen1 + #549, #127
  static LoseScreen1 + #550, #1289
  static LoseScreen1 + #551, #1289
  static LoseScreen1 + #552, #1289
  static LoseScreen1 + #553, #1289
  static LoseScreen1 + #554, #127
  static LoseScreen1 + #555, #127
  static LoseScreen1 + #556, #127
  static LoseScreen1 + #557, #127
  static LoseScreen1 + #558, #127
  static LoseScreen1 + #559, #127

  ;Linha 14
  static LoseScreen1 + #560, #265
  static LoseScreen1 + #561, #3967
  static LoseScreen1 + #562, #265
  static LoseScreen1 + #563, #265
  static LoseScreen1 + #564, #265
  static LoseScreen1 + #565, #2057
  static LoseScreen1 + #566, #2057
  static LoseScreen1 + #567, #127
  static LoseScreen1 + #568, #127
  static LoseScreen1 + #569, #3967
  static LoseScreen1 + #570, #3967
  static LoseScreen1 + #571, #3967
  static LoseScreen1 + #572, #2057
  static LoseScreen1 + #573, #2057
  static LoseScreen1 + #574, #3967
  static LoseScreen1 + #575, #127
  static LoseScreen1 + #576, #2057
  static LoseScreen1 + #577, #3967
  static LoseScreen1 + #578, #3967
  static LoseScreen1 + #579, #3967
  static LoseScreen1 + #580, #2057
  static LoseScreen1 + #581, #127
  static LoseScreen1 + #582, #3849
  static LoseScreen1 + #583, #3849
  static LoseScreen1 + #584, #3849
  static LoseScreen1 + #585, #3849
  static LoseScreen1 + #586, #127
  static LoseScreen1 + #587, #127
  static LoseScreen1 + #588, #127
  static LoseScreen1 + #589, #127
  static LoseScreen1 + #590, #1289
  static LoseScreen1 + #591, #1289
  static LoseScreen1 + #592, #1289
  static LoseScreen1 + #593, #1289
  static LoseScreen1 + #594, #127
  static LoseScreen1 + #595, #127
  static LoseScreen1 + #596, #127
  static LoseScreen1 + #597, #127
  static LoseScreen1 + #598, #127
  static LoseScreen1 + #599, #127

  ;Linha 15
  static LoseScreen1 + #600, #265
  static LoseScreen1 + #601, #265
  static LoseScreen1 + #602, #3967
  static LoseScreen1 + #603, #265
  static LoseScreen1 + #604, #265
  static LoseScreen1 + #605, #2057
  static LoseScreen1 + #606, #127
  static LoseScreen1 + #607, #127
  static LoseScreen1 + #608, #3967
  static LoseScreen1 + #609, #3967
  static LoseScreen1 + #610, #3967
  static LoseScreen1 + #611, #2057
  static LoseScreen1 + #612, #3967
  static LoseScreen1 + #613, #3967
  static LoseScreen1 + #614, #3967
  static LoseScreen1 + #615, #2057
  static LoseScreen1 + #616, #3967
  static LoseScreen1 + #617, #3967
  static LoseScreen1 + #618, #127
  static LoseScreen1 + #619, #2057
  static LoseScreen1 + #620, #2057
  static LoseScreen1 + #621, #127
  static LoseScreen1 + #622, #3849
  static LoseScreen1 + #623, #3849
  static LoseScreen1 + #624, #3849
  static LoseScreen1 + #625, #127
  static LoseScreen1 + #626, #127
  static LoseScreen1 + #627, #127
  static LoseScreen1 + #628, #127
  static LoseScreen1 + #629, #127
  static LoseScreen1 + #630, #1289
  static LoseScreen1 + #631, #1289
  static LoseScreen1 + #632, #1289
  static LoseScreen1 + #633, #1289
  static LoseScreen1 + #634, #127
  static LoseScreen1 + #635, #127
  static LoseScreen1 + #636, #127
  static LoseScreen1 + #637, #127
  static LoseScreen1 + #638, #127
  static LoseScreen1 + #639, #127

  ;Linha 16
  static LoseScreen1 + #640, #265
  static LoseScreen1 + #641, #265
  static LoseScreen1 + #642, #265
  static LoseScreen1 + #643, #265
  static LoseScreen1 + #644, #2057
  static LoseScreen1 + #645, #2057
  static LoseScreen1 + #646, #127
  static LoseScreen1 + #647, #3967
  static LoseScreen1 + #648, #3967
  static LoseScreen1 + #649, #3967
  static LoseScreen1 + #650, #2057
  static LoseScreen1 + #651, #3967
  static LoseScreen1 + #652, #3967
  static LoseScreen1 + #653, #3967
  static LoseScreen1 + #654, #2057
  static LoseScreen1 + #655, #3967
  static LoseScreen1 + #656, #3967
  static LoseScreen1 + #657, #127
  static LoseScreen1 + #658, #2057
  static LoseScreen1 + #659, #2057
  static LoseScreen1 + #660, #127
  static LoseScreen1 + #661, #127
  static LoseScreen1 + #662, #3849
  static LoseScreen1 + #663, #127
  static LoseScreen1 + #664, #127
  static LoseScreen1 + #665, #127
  static LoseScreen1 + #666, #127
  static LoseScreen1 + #667, #127
  static LoseScreen1 + #668, #127
  static LoseScreen1 + #669, #3967
  static LoseScreen1 + #670, #1033
  static LoseScreen1 + #671, #1033
  static LoseScreen1 + #672, #1033
  static LoseScreen1 + #673, #1033
  static LoseScreen1 + #674, #3967
  static LoseScreen1 + #675, #127
  static LoseScreen1 + #676, #127
  static LoseScreen1 + #677, #127
  static LoseScreen1 + #678, #127
  static LoseScreen1 + #679, #127

  ;Linha 17
  static LoseScreen1 + #680, #265
  static LoseScreen1 + #681, #265
  static LoseScreen1 + #682, #265
  static LoseScreen1 + #683, #2057
  static LoseScreen1 + #684, #2057
  static LoseScreen1 + #685, #127
  static LoseScreen1 + #686, #3967
  static LoseScreen1 + #687, #3967
  static LoseScreen1 + #688, #3967
  static LoseScreen1 + #689, #2057
  static LoseScreen1 + #690, #2057
  static LoseScreen1 + #691, #3967
  static LoseScreen1 + #692, #3967
  static LoseScreen1 + #693, #2057
  static LoseScreen1 + #694, #127
  static LoseScreen1 + #695, #127
  static LoseScreen1 + #696, #2057
  static LoseScreen1 + #697, #2057
  static LoseScreen1 + #698, #2057
  static LoseScreen1 + #699, #127
  static LoseScreen1 + #700, #127
  static LoseScreen1 + #701, #127
  static LoseScreen1 + #702, #127
  static LoseScreen1 + #703, #127
  static LoseScreen1 + #704, #127
  static LoseScreen1 + #705, #127
  static LoseScreen1 + #706, #127
  static LoseScreen1 + #707, #127
  static LoseScreen1 + #708, #127
  static LoseScreen1 + #709, #1033
  static LoseScreen1 + #710, #1033
  static LoseScreen1 + #711, #3967
  static LoseScreen1 + #712, #127
  static LoseScreen1 + #713, #1033
  static LoseScreen1 + #714, #1033
  static LoseScreen1 + #715, #127
  static LoseScreen1 + #716, #127
  static LoseScreen1 + #717, #127
  static LoseScreen1 + #718, #127
  static LoseScreen1 + #719, #127

  ;Linha 18
  static LoseScreen1 + #720, #265
  static LoseScreen1 + #721, #265
  static LoseScreen1 + #722, #265
  static LoseScreen1 + #723, #2057
  static LoseScreen1 + #724, #127
  static LoseScreen1 + #725, #127
  static LoseScreen1 + #726, #3967
  static LoseScreen1 + #727, #3967
  static LoseScreen1 + #728, #2057
  static LoseScreen1 + #729, #3967
  static LoseScreen1 + #730, #3967
  static LoseScreen1 + #731, #2057
  static LoseScreen1 + #732, #2057
  static LoseScreen1 + #733, #127
  static LoseScreen1 + #734, #2057
  static LoseScreen1 + #735, #2057
  static LoseScreen1 + #736, #2057
  static LoseScreen1 + #737, #127
  static LoseScreen1 + #738, #127
  static LoseScreen1 + #739, #127
  static LoseScreen1 + #740, #127
  static LoseScreen1 + #741, #127
  static LoseScreen1 + #742, #127
  static LoseScreen1 + #743, #127
  static LoseScreen1 + #744, #127
  static LoseScreen1 + #745, #127
  static LoseScreen1 + #746, #127
  static LoseScreen1 + #747, #127
  static LoseScreen1 + #748, #3967
  static LoseScreen1 + #749, #1033
  static LoseScreen1 + #750, #1033
  static LoseScreen1 + #751, #3967
  static LoseScreen1 + #752, #127
  static LoseScreen1 + #753, #1033
  static LoseScreen1 + #754, #1033
  static LoseScreen1 + #755, #3967
  static LoseScreen1 + #756, #3967
  static LoseScreen1 + #757, #127
  static LoseScreen1 + #758, #127
  static LoseScreen1 + #759, #127

  ;Linha 19
  static LoseScreen1 + #760, #265
  static LoseScreen1 + #761, #265
  static LoseScreen1 + #762, #2057
  static LoseScreen1 + #763, #127
  static LoseScreen1 + #764, #127
  static LoseScreen1 + #765, #3967
  static LoseScreen1 + #766, #3967
  static LoseScreen1 + #767, #3967
  static LoseScreen1 + #768, #2057
  static LoseScreen1 + #769, #3849
  static LoseScreen1 + #770, #3849
  static LoseScreen1 + #771, #3849
  static LoseScreen1 + #772, #3967
  static LoseScreen1 + #773, #2057
  static LoseScreen1 + #774, #2057
  static LoseScreen1 + #775, #2057
  static LoseScreen1 + #776, #265
  static LoseScreen1 + #777, #127
  static LoseScreen1 + #778, #127
  static LoseScreen1 + #779, #127
  static LoseScreen1 + #780, #127
  static LoseScreen1 + #781, #127
  static LoseScreen1 + #782, #127
  static LoseScreen1 + #783, #127
  static LoseScreen1 + #784, #127
  static LoseScreen1 + #785, #127
  static LoseScreen1 + #786, #127
  static LoseScreen1 + #787, #127
  static LoseScreen1 + #788, #3967
  static LoseScreen1 + #789, #1033
  static LoseScreen1 + #790, #1033
  static LoseScreen1 + #791, #3967
  static LoseScreen1 + #792, #127
  static LoseScreen1 + #793, #1033
  static LoseScreen1 + #794, #1033
  static LoseScreen1 + #795, #127
  static LoseScreen1 + #796, #127
  static LoseScreen1 + #797, #127
  static LoseScreen1 + #798, #127
  static LoseScreen1 + #799, #127

  ;Linha 20
  static LoseScreen1 + #800, #2057
  static LoseScreen1 + #801, #2057
  static LoseScreen1 + #802, #127
  static LoseScreen1 + #803, #127
  static LoseScreen1 + #804, #127
  static LoseScreen1 + #805, #3967
  static LoseScreen1 + #806, #3967
  static LoseScreen1 + #807, #2057
  static LoseScreen1 + #808, #2057
  static LoseScreen1 + #809, #3849
  static LoseScreen1 + #810, #3849
  static LoseScreen1 + #811, #3849
  static LoseScreen1 + #812, #3967
  static LoseScreen1 + #813, #2057
  static LoseScreen1 + #814, #265
  static LoseScreen1 + #815, #265
  static LoseScreen1 + #816, #265
  static LoseScreen1 + #817, #127
  static LoseScreen1 + #818, #127
  static LoseScreen1 + #819, #127
  static LoseScreen1 + #820, #127
  static LoseScreen1 + #821, #127
  static LoseScreen1 + #822, #127
  static LoseScreen1 + #823, #127
  static LoseScreen1 + #824, #127
  static LoseScreen1 + #825, #127
  static LoseScreen1 + #826, #127
  static LoseScreen1 + #827, #127
  static LoseScreen1 + #828, #3967
  static LoseScreen1 + #829, #1033
  static LoseScreen1 + #830, #1033
  static LoseScreen1 + #831, #3967
  static LoseScreen1 + #832, #127
  static LoseScreen1 + #833, #1033
  static LoseScreen1 + #834, #1033
  static LoseScreen1 + #835, #127
  static LoseScreen1 + #836, #127
  static LoseScreen1 + #837, #127
  static LoseScreen1 + #838, #127
  static LoseScreen1 + #839, #127

  ;Linha 21
  static LoseScreen1 + #840, #127
  static LoseScreen1 + #841, #2057
  static LoseScreen1 + #842, #2057
  static LoseScreen1 + #843, #127
  static LoseScreen1 + #844, #127
  static LoseScreen1 + #845, #3967
  static LoseScreen1 + #846, #2057
  static LoseScreen1 + #847, #2057
  static LoseScreen1 + #848, #3849
  static LoseScreen1 + #849, #3849
  static LoseScreen1 + #850, #3849
  static LoseScreen1 + #851, #3849
  static LoseScreen1 + #852, #2057
  static LoseScreen1 + #853, #2057
  static LoseScreen1 + #854, #265
  static LoseScreen1 + #855, #265
  static LoseScreen1 + #856, #265
  static LoseScreen1 + #857, #127
  static LoseScreen1 + #858, #127
  static LoseScreen1 + #859, #127
  static LoseScreen1 + #860, #127
  static LoseScreen1 + #861, #127
  static LoseScreen1 + #862, #127
  static LoseScreen1 + #863, #127
  static LoseScreen1 + #864, #127
  static LoseScreen1 + #865, #127
  static LoseScreen1 + #866, #127
  static LoseScreen1 + #867, #127
  static LoseScreen1 + #868, #3967
  static LoseScreen1 + #869, #1033
  static LoseScreen1 + #870, #1033
  static LoseScreen1 + #871, #3967
  static LoseScreen1 + #872, #127
  static LoseScreen1 + #873, #1033
  static LoseScreen1 + #874, #1033
  static LoseScreen1 + #875, #127
  static LoseScreen1 + #876, #127
  static LoseScreen1 + #877, #127
  static LoseScreen1 + #878, #127
  static LoseScreen1 + #879, #127

  ;Linha 22
  static LoseScreen1 + #880, #127
  static LoseScreen1 + #881, #127
  static LoseScreen1 + #882, #127
  static LoseScreen1 + #883, #2057
  static LoseScreen1 + #884, #2057
  static LoseScreen1 + #885, #3967
  static LoseScreen1 + #886, #2057
  static LoseScreen1 + #887, #3849
  static LoseScreen1 + #888, #3849
  static LoseScreen1 + #889, #3849
  static LoseScreen1 + #890, #2057
  static LoseScreen1 + #891, #2057
  static LoseScreen1 + #892, #2057
  static LoseScreen1 + #893, #265
  static LoseScreen1 + #894, #265
  static LoseScreen1 + #895, #265
  static LoseScreen1 + #896, #265
  static LoseScreen1 + #897, #127
  static LoseScreen1 + #898, #127
  static LoseScreen1 + #899, #127
  static LoseScreen1 + #900, #127
  static LoseScreen1 + #901, #127
  static LoseScreen1 + #902, #127
  static LoseScreen1 + #903, #127
  static LoseScreen1 + #904, #127
  static LoseScreen1 + #905, #127
  static LoseScreen1 + #906, #127
  static LoseScreen1 + #907, #3967
  static LoseScreen1 + #908, #1033
  static LoseScreen1 + #909, #1033
  static LoseScreen1 + #910, #1033
  static LoseScreen1 + #911, #127
  static LoseScreen1 + #912, #127
  static LoseScreen1 + #913, #1033
  static LoseScreen1 + #914, #1033
  static LoseScreen1 + #915, #1033
  static LoseScreen1 + #916, #127
  static LoseScreen1 + #917, #127
  static LoseScreen1 + #918, #127
  static LoseScreen1 + #919, #127

  ;Linha 23
  static LoseScreen1 + #920, #127
  static LoseScreen1 + #921, #127
  static LoseScreen1 + #922, #127
  static LoseScreen1 + #923, #127
  static LoseScreen1 + #924, #2057
  static LoseScreen1 + #925, #3967
  static LoseScreen1 + #926, #2057
  static LoseScreen1 + #927, #3849
  static LoseScreen1 + #928, #3849
  static LoseScreen1 + #929, #3849
  static LoseScreen1 + #930, #2057
  static LoseScreen1 + #931, #2057
  static LoseScreen1 + #932, #265
  static LoseScreen1 + #933, #265
  static LoseScreen1 + #934, #265
  static LoseScreen1 + #935, #3967
  static LoseScreen1 + #936, #3967
  static LoseScreen1 + #937, #127
  static LoseScreen1 + #938, #127
  static LoseScreen1 + #939, #127
  static LoseScreen1 + #940, #127
  static LoseScreen1 + #941, #127
  static LoseScreen1 + #942, #127
  static LoseScreen1 + #943, #127
  static LoseScreen1 + #944, #127
  static LoseScreen1 + #945, #127
  static LoseScreen1 + #946, #127
  static LoseScreen1 + #947, #127
  static LoseScreen1 + #948, #127
  static LoseScreen1 + #949, #127
  static LoseScreen1 + #950, #127
  static LoseScreen1 + #951, #127
  static LoseScreen1 + #952, #127
  static LoseScreen1 + #953, #127
  static LoseScreen1 + #954, #127
  static LoseScreen1 + #955, #127
  static LoseScreen1 + #956, #127
  static LoseScreen1 + #957, #127
  static LoseScreen1 + #958, #127
  static LoseScreen1 + #959, #127

  ;Linha 24
  static LoseScreen1 + #960, #127
  static LoseScreen1 + #961, #127
  static LoseScreen1 + #962, #127
  static LoseScreen1 + #963, #127
  static LoseScreen1 + #964, #2057
  static LoseScreen1 + #965, #3967
  static LoseScreen1 + #966, #2057
  static LoseScreen1 + #967, #3849
  static LoseScreen1 + #968, #3849
  static LoseScreen1 + #969, #2057
  static LoseScreen1 + #970, #2057
  static LoseScreen1 + #971, #2057
  static LoseScreen1 + #972, #265
  static LoseScreen1 + #973, #265
  static LoseScreen1 + #974, #3967
  static LoseScreen1 + #975, #3967
  static LoseScreen1 + #976, #127
  static LoseScreen1 + #977, #127
  static LoseScreen1 + #978, #127
  static LoseScreen1 + #979, #127
  static LoseScreen1 + #980, #127
  static LoseScreen1 + #981, #127
  static LoseScreen1 + #982, #127
  static LoseScreen1 + #983, #127
  static LoseScreen1 + #984, #127
  static LoseScreen1 + #985, #127
  static LoseScreen1 + #986, #127
  static LoseScreen1 + #987, #127
  static LoseScreen1 + #988, #127
  static LoseScreen1 + #989, #127
  static LoseScreen1 + #990, #127
  static LoseScreen1 + #991, #127
  static LoseScreen1 + #992, #127
  static LoseScreen1 + #993, #127
  static LoseScreen1 + #994, #127
  static LoseScreen1 + #995, #127
  static LoseScreen1 + #996, #127
  static LoseScreen1 + #997, #127
  static LoseScreen1 + #998, #127
  static LoseScreen1 + #999, #127

  ;Linha 25
  static LoseScreen1 + #1000, #127
  static LoseScreen1 + #1001, #127
  static LoseScreen1 + #1002, #127
  static LoseScreen1 + #1003, #127
  static LoseScreen1 + #1004, #2057
  static LoseScreen1 + #1005, #3967
  static LoseScreen1 + #1006, #2057
  static LoseScreen1 + #1007, #3849
  static LoseScreen1 + #1008, #3849
  static LoseScreen1 + #1009, #2057
  static LoseScreen1 + #1010, #2057
  static LoseScreen1 + #1011, #265
  static LoseScreen1 + #1012, #265
  static LoseScreen1 + #1013, #265
  static LoseScreen1 + #1014, #3967
  static LoseScreen1 + #1015, #3967
  static LoseScreen1 + #1016, #127
  static LoseScreen1 + #1017, #127
  static LoseScreen1 + #1018, #127
  static LoseScreen1 + #1019, #127
  static LoseScreen1 + #1020, #127
  static LoseScreen1 + #1021, #127
  static LoseScreen1 + #1022, #127
  static LoseScreen1 + #1023, #127
  static LoseScreen1 + #1024, #127
  static LoseScreen1 + #1025, #127
  static LoseScreen1 + #1026, #127
  static LoseScreen1 + #1027, #127
  static LoseScreen1 + #1028, #127
  static LoseScreen1 + #1029, #127
  static LoseScreen1 + #1030, #127
  static LoseScreen1 + #1031, #127
  static LoseScreen1 + #1032, #127
  static LoseScreen1 + #1033, #127
  static LoseScreen1 + #1034, #127
  static LoseScreen1 + #1035, #127
  static LoseScreen1 + #1036, #127
  static LoseScreen1 + #1037, #127
  static LoseScreen1 + #1038, #127
  static LoseScreen1 + #1039, #127

  ;Linha 26
  static LoseScreen1 + #1040, #127
  static LoseScreen1 + #1041, #127
  static LoseScreen1 + #1042, #127
  static LoseScreen1 + #1043, #2057
  static LoseScreen1 + #1044, #2057
  static LoseScreen1 + #1045, #127
  static LoseScreen1 + #1046, #2057
  static LoseScreen1 + #1047, #3849
  static LoseScreen1 + #1048, #3849
  static LoseScreen1 + #1049, #2057
  static LoseScreen1 + #1050, #265
  static LoseScreen1 + #1051, #265
  static LoseScreen1 + #1052, #265
  static LoseScreen1 + #1053, #265
  static LoseScreen1 + #1054, #3967
  static LoseScreen1 + #1055, #3967
  static LoseScreen1 + #1056, #127
  static LoseScreen1 + #1057, #127
  static LoseScreen1 + #1058, #127
  static LoseScreen1 + #1059, #127
  static LoseScreen1 + #1060, #127
  static LoseScreen1 + #1061, #127
  static LoseScreen1 + #1062, #127
  static LoseScreen1 + #1063, #127
  static LoseScreen1 + #1064, #127
  static LoseScreen1 + #1065, #127
  static LoseScreen1 + #1066, #127
  static LoseScreen1 + #1067, #127
  static LoseScreen1 + #1068, #127
  static LoseScreen1 + #1069, #127
  static LoseScreen1 + #1070, #127
  static LoseScreen1 + #1071, #127
  static LoseScreen1 + #1072, #127
  static LoseScreen1 + #1073, #127
  static LoseScreen1 + #1074, #127
  static LoseScreen1 + #1075, #127
  static LoseScreen1 + #1076, #127
  static LoseScreen1 + #1077, #127
  static LoseScreen1 + #1078, #127
  static LoseScreen1 + #1079, #127

  ;Linha 27
  static LoseScreen1 + #1080, #127
  static LoseScreen1 + #1081, #127
  static LoseScreen1 + #1082, #127
  static LoseScreen1 + #1083, #2057
  static LoseScreen1 + #1084, #2057
  static LoseScreen1 + #1085, #2057
  static LoseScreen1 + #1086, #2057
  static LoseScreen1 + #1087, #2057
  static LoseScreen1 + #1088, #2057
  static LoseScreen1 + #1089, #265
  static LoseScreen1 + #1090, #265
  static LoseScreen1 + #1091, #265
  static LoseScreen1 + #1092, #265
  static LoseScreen1 + #1093, #3967
  static LoseScreen1 + #1094, #3967
  static LoseScreen1 + #1095, #3967
  static LoseScreen1 + #1096, #127
  static LoseScreen1 + #1097, #127
  static LoseScreen1 + #1098, #127
  static LoseScreen1 + #1099, #127
  static LoseScreen1 + #1100, #127
  static LoseScreen1 + #1101, #127
  static LoseScreen1 + #1102, #127
  static LoseScreen1 + #1103, #127
  static LoseScreen1 + #1104, #127
  static LoseScreen1 + #1105, #127
  static LoseScreen1 + #1106, #127
  static LoseScreen1 + #1107, #127
  static LoseScreen1 + #1108, #127
  static LoseScreen1 + #1109, #127
  static LoseScreen1 + #1110, #127
  static LoseScreen1 + #1111, #127
  static LoseScreen1 + #1112, #127
  static LoseScreen1 + #1113, #127
  static LoseScreen1 + #1114, #127
  static LoseScreen1 + #1115, #127
  static LoseScreen1 + #1116, #127
  static LoseScreen1 + #1117, #127
  static LoseScreen1 + #1118, #127
  static LoseScreen1 + #1119, #127

  ;Linha 28
  static LoseScreen1 + #1120, #127
  static LoseScreen1 + #1121, #127
  static LoseScreen1 + #1122, #127
  static LoseScreen1 + #1123, #127
  static LoseScreen1 + #1124, #127
  static LoseScreen1 + #1125, #127
  static LoseScreen1 + #1126, #127
  static LoseScreen1 + #1127, #2057
  static LoseScreen1 + #1128, #265
  static LoseScreen1 + #1129, #265
  static LoseScreen1 + #1130, #265
  static LoseScreen1 + #1131, #265
  static LoseScreen1 + #1132, #3967
  static LoseScreen1 + #1133, #3967
  static LoseScreen1 + #1134, #3967
  static LoseScreen1 + #1135, #127
  static LoseScreen1 + #1136, #127
  static LoseScreen1 + #1137, #127
  static LoseScreen1 + #1138, #127
  static LoseScreen1 + #1139, #127
  static LoseScreen1 + #1140, #127
  static LoseScreen1 + #1141, #127
  static LoseScreen1 + #1142, #127
  static LoseScreen1 + #1143, #127
  static LoseScreen1 + #1144, #127
  static LoseScreen1 + #1145, #127
  static LoseScreen1 + #1146, #127
  static LoseScreen1 + #1147, #127
  static LoseScreen1 + #1148, #127
  static LoseScreen1 + #1149, #127
  static LoseScreen1 + #1150, #127
  static LoseScreen1 + #1151, #127
  static LoseScreen1 + #1152, #127
  static LoseScreen1 + #1153, #127
  static LoseScreen1 + #1154, #127
  static LoseScreen1 + #1155, #127
  static LoseScreen1 + #1156, #127
  static LoseScreen1 + #1157, #127
  static LoseScreen1 + #1158, #127
  static LoseScreen1 + #1159, #127

  ;Linha 29
  static LoseScreen1 + #1160, #127
  static LoseScreen1 + #1161, #127
  static LoseScreen1 + #1162, #127
  static LoseScreen1 + #1163, #127
  static LoseScreen1 + #1164, #127
  static LoseScreen1 + #1165, #127
  static LoseScreen1 + #1166, #127
  static LoseScreen1 + #1167, #2057
  static LoseScreen1 + #1168, #265
  static LoseScreen1 + #1169, #265
  static LoseScreen1 + #1170, #265
  static LoseScreen1 + #1171, #265
  static LoseScreen1 + #1172, #3967
  static LoseScreen1 + #1173, #3967
  static LoseScreen1 + #1174, #3967
  static LoseScreen1 + #1175, #127
  static LoseScreen1 + #1176, #127
  static LoseScreen1 + #1177, #127
  static LoseScreen1 + #1178, #127
  static LoseScreen1 + #1179, #127
  static LoseScreen1 + #1180, #127
  static LoseScreen1 + #1181, #127
  static LoseScreen1 + #1182, #127
  static LoseScreen1 + #1183, #127
  static LoseScreen1 + #1184, #127
  static LoseScreen1 + #1185, #127
  static LoseScreen1 + #1186, #127
  static LoseScreen1 + #1187, #127
  static LoseScreen1 + #1188, #127
  static LoseScreen1 + #1189, #127
  static LoseScreen1 + #1190, #127
  static LoseScreen1 + #1191, #127
  static LoseScreen1 + #1192, #127
  static LoseScreen1 + #1193, #127
  static LoseScreen1 + #1194, #127
  static LoseScreen1 + #1195, #127
  static LoseScreen1 + #1196, #127
  static LoseScreen1 + #1197, #127
  static LoseScreen1 + #1198, #127
  static LoseScreen1 + #1199, #127
;

LoseScreen2 : var #1200
  ;Linha 0
  static LoseScreen2 + #0, #127
  static LoseScreen2 + #1, #127
  static LoseScreen2 + #2, #127
  static LoseScreen2 + #3, #127
  static LoseScreen2 + #4, #127
  static LoseScreen2 + #5, #127
  static LoseScreen2 + #6, #127
  static LoseScreen2 + #7, #127
  static LoseScreen2 + #8, #127
  static LoseScreen2 + #9, #127
  static LoseScreen2 + #10, #127
  static LoseScreen2 + #11, #127
  static LoseScreen2 + #12, #127
  static LoseScreen2 + #13, #127
  static LoseScreen2 + #14, #127
  static LoseScreen2 + #15, #127
  static LoseScreen2 + #16, #127
  static LoseScreen2 + #17, #127
  static LoseScreen2 + #18, #127
  static LoseScreen2 + #19, #127
  static LoseScreen2 + #20, #127
  static LoseScreen2 + #21, #127
  static LoseScreen2 + #22, #127
  static LoseScreen2 + #23, #127
  static LoseScreen2 + #24, #127
  static LoseScreen2 + #25, #127
  static LoseScreen2 + #26, #3967
  static LoseScreen2 + #27, #127
  static LoseScreen2 + #28, #127
  static LoseScreen2 + #29, #127
  static LoseScreen2 + #30, #127
  static LoseScreen2 + #31, #127
  static LoseScreen2 + #32, #127
  static LoseScreen2 + #33, #127
  static LoseScreen2 + #34, #127
  static LoseScreen2 + #35, #127
  static LoseScreen2 + #36, #127
  static LoseScreen2 + #37, #127
  static LoseScreen2 + #38, #127
  static LoseScreen2 + #39, #127

  ;Linha 1
  static LoseScreen2 + #40, #127
  static LoseScreen2 + #41, #127
  static LoseScreen2 + #42, #127
  static LoseScreen2 + #43, #127
  static LoseScreen2 + #44, #127
  static LoseScreen2 + #45, #127
  static LoseScreen2 + #46, #127
  static LoseScreen2 + #47, #127
  static LoseScreen2 + #48, #127
  static LoseScreen2 + #49, #127
  static LoseScreen2 + #50, #127
  static LoseScreen2 + #51, #127
  static LoseScreen2 + #52, #127
  static LoseScreen2 + #53, #127
  static LoseScreen2 + #54, #127
  static LoseScreen2 + #55, #127
  static LoseScreen2 + #56, #127
  static LoseScreen2 + #57, #127
  static LoseScreen2 + #58, #127
  static LoseScreen2 + #59, #127
  static LoseScreen2 + #60, #127
  static LoseScreen2 + #61, #127
  static LoseScreen2 + #62, #127
  static LoseScreen2 + #63, #127
  static LoseScreen2 + #64, #127
  static LoseScreen2 + #65, #3967
  static LoseScreen2 + #66, #3967
  static LoseScreen2 + #67, #127
  static LoseScreen2 + #68, #127
  static LoseScreen2 + #69, #127
  static LoseScreen2 + #70, #9
  static LoseScreen2 + #71, #9
  static LoseScreen2 + #72, #9
  static LoseScreen2 + #73, #9
  static LoseScreen2 + #74, #9
  static LoseScreen2 + #75, #127
  static LoseScreen2 + #76, #127
  static LoseScreen2 + #77, #127
  static LoseScreen2 + #78, #127
  static LoseScreen2 + #79, #127

  ;Linha 2
  static LoseScreen2 + #80, #127
  static LoseScreen2 + #81, #127
  static LoseScreen2 + #82, #127
  static LoseScreen2 + #83, #127
  static LoseScreen2 + #84, #127
  static LoseScreen2 + #85, #127
  static LoseScreen2 + #86, #127
  static LoseScreen2 + #87, #127
  static LoseScreen2 + #88, #127
  static LoseScreen2 + #89, #127
  static LoseScreen2 + #90, #127
  static LoseScreen2 + #91, #127
  static LoseScreen2 + #92, #127
  static LoseScreen2 + #93, #127
  static LoseScreen2 + #94, #127
  static LoseScreen2 + #95, #127
  static LoseScreen2 + #96, #127
  static LoseScreen2 + #97, #127
  static LoseScreen2 + #98, #127
  static LoseScreen2 + #99, #127
  static LoseScreen2 + #100, #127
  static LoseScreen2 + #101, #127
  static LoseScreen2 + #102, #127
  static LoseScreen2 + #103, #3967
  static LoseScreen2 + #104, #3967
  static LoseScreen2 + #105, #127
  static LoseScreen2 + #106, #127
  static LoseScreen2 + #107, #127
  static LoseScreen2 + #108, #127
  static LoseScreen2 + #109, #127
  static LoseScreen2 + #110, #9
  static LoseScreen2 + #111, #265
  static LoseScreen2 + #112, #265
  static LoseScreen2 + #113, #265
  static LoseScreen2 + #114, #9
  static LoseScreen2 + #115, #127
  static LoseScreen2 + #116, #127
  static LoseScreen2 + #117, #127
  static LoseScreen2 + #118, #127
  static LoseScreen2 + #119, #127

  ;Linha 3
  static LoseScreen2 + #120, #127
  static LoseScreen2 + #121, #127
  static LoseScreen2 + #122, #127
  static LoseScreen2 + #123, #127
  static LoseScreen2 + #124, #127
  static LoseScreen2 + #125, #127
  static LoseScreen2 + #126, #127
  static LoseScreen2 + #127, #127
  static LoseScreen2 + #128, #127
  static LoseScreen2 + #129, #127
  static LoseScreen2 + #130, #127
  static LoseScreen2 + #131, #127
  static LoseScreen2 + #132, #127
  static LoseScreen2 + #133, #127
  static LoseScreen2 + #134, #127
  static LoseScreen2 + #135, #127
  static LoseScreen2 + #136, #127
  static LoseScreen2 + #137, #127
  static LoseScreen2 + #138, #127
  static LoseScreen2 + #139, #127
  static LoseScreen2 + #140, #127
  static LoseScreen2 + #141, #127
  static LoseScreen2 + #142, #3967
  static LoseScreen2 + #143, #3967
  static LoseScreen2 + #144, #3967
  static LoseScreen2 + #145, #127
  static LoseScreen2 + #146, #3967
  static LoseScreen2 + #147, #265
  static LoseScreen2 + #148, #127
  static LoseScreen2 + #149, #127
  static LoseScreen2 + #150, #265
  static LoseScreen2 + #151, #3967
  static LoseScreen2 + #152, #265
  static LoseScreen2 + #153, #3856
  static LoseScreen2 + #154, #265
  static LoseScreen2 + #155, #127
  static LoseScreen2 + #156, #127
  static LoseScreen2 + #157, #265
  static LoseScreen2 + #158, #127
  static LoseScreen2 + #159, #127

  ;Linha 4
  static LoseScreen2 + #160, #127
  static LoseScreen2 + #161, #127
  static LoseScreen2 + #162, #127
  static LoseScreen2 + #163, #127
  static LoseScreen2 + #164, #127
  static LoseScreen2 + #165, #127
  static LoseScreen2 + #166, #127
  static LoseScreen2 + #167, #127
  static LoseScreen2 + #168, #127
  static LoseScreen2 + #169, #127
  static LoseScreen2 + #170, #127
  static LoseScreen2 + #171, #127
  static LoseScreen2 + #172, #127
  static LoseScreen2 + #173, #127
  static LoseScreen2 + #174, #127
  static LoseScreen2 + #175, #127
  static LoseScreen2 + #176, #127
  static LoseScreen2 + #177, #127
  static LoseScreen2 + #178, #127
  static LoseScreen2 + #179, #127
  static LoseScreen2 + #180, #127
  static LoseScreen2 + #181, #127
  static LoseScreen2 + #182, #127
  static LoseScreen2 + #183, #127
  static LoseScreen2 + #184, #127
  static LoseScreen2 + #185, #127
  static LoseScreen2 + #186, #3967
  static LoseScreen2 + #187, #265
  static LoseScreen2 + #188, #265
  static LoseScreen2 + #189, #127
  static LoseScreen2 + #190, #265
  static LoseScreen2 + #191, #265
  static LoseScreen2 + #192, #3849
  static LoseScreen2 + #193, #265
  static LoseScreen2 + #194, #265
  static LoseScreen2 + #195, #3967
  static LoseScreen2 + #196, #265
  static LoseScreen2 + #197, #265
  static LoseScreen2 + #198, #127
  static LoseScreen2 + #199, #127

  ;Linha 5
  static LoseScreen2 + #200, #2057
  static LoseScreen2 + #201, #2057
  static LoseScreen2 + #202, #2057
  static LoseScreen2 + #203, #2057
  static LoseScreen2 + #204, #127
  static LoseScreen2 + #205, #127
  static LoseScreen2 + #206, #127
  static LoseScreen2 + #207, #127
  static LoseScreen2 + #208, #127
  static LoseScreen2 + #209, #127
  static LoseScreen2 + #210, #127
  static LoseScreen2 + #211, #127
  static LoseScreen2 + #212, #127
  static LoseScreen2 + #213, #127
  static LoseScreen2 + #214, #127
  static LoseScreen2 + #215, #127
  static LoseScreen2 + #216, #127
  static LoseScreen2 + #217, #127
  static LoseScreen2 + #218, #127
  static LoseScreen2 + #219, #127
  static LoseScreen2 + #220, #127
  static LoseScreen2 + #221, #127
  static LoseScreen2 + #222, #127
  static LoseScreen2 + #223, #127
  static LoseScreen2 + #224, #127
  static LoseScreen2 + #225, #127
  static LoseScreen2 + #226, #3967
  static LoseScreen2 + #227, #265
  static LoseScreen2 + #228, #265
  static LoseScreen2 + #229, #127
  static LoseScreen2 + #230, #265
  static LoseScreen2 + #231, #265
  static LoseScreen2 + #232, #3849
  static LoseScreen2 + #233, #265
  static LoseScreen2 + #234, #265
  static LoseScreen2 + #235, #127
  static LoseScreen2 + #236, #265
  static LoseScreen2 + #237, #265
  static LoseScreen2 + #238, #127
  static LoseScreen2 + #239, #127

  ;Linha 6
  static LoseScreen2 + #240, #265
  static LoseScreen2 + #241, #265
  static LoseScreen2 + #242, #265
  static LoseScreen2 + #243, #2057
  static LoseScreen2 + #244, #127
  static LoseScreen2 + #245, #127
  static LoseScreen2 + #246, #127
  static LoseScreen2 + #247, #127
  static LoseScreen2 + #248, #127
  static LoseScreen2 + #249, #127
  static LoseScreen2 + #250, #127
  static LoseScreen2 + #251, #127
  static LoseScreen2 + #252, #127
  static LoseScreen2 + #253, #127
  static LoseScreen2 + #254, #127
  static LoseScreen2 + #255, #127
  static LoseScreen2 + #256, #127
  static LoseScreen2 + #257, #127
  static LoseScreen2 + #258, #127
  static LoseScreen2 + #259, #127
  static LoseScreen2 + #260, #127
  static LoseScreen2 + #261, #127
  static LoseScreen2 + #262, #127
  static LoseScreen2 + #263, #127
  static LoseScreen2 + #264, #127
  static LoseScreen2 + #265, #127
  static LoseScreen2 + #266, #3967
  static LoseScreen2 + #267, #265
  static LoseScreen2 + #268, #265
  static LoseScreen2 + #269, #3967
  static LoseScreen2 + #270, #127
  static LoseScreen2 + #271, #265
  static LoseScreen2 + #272, #265
  static LoseScreen2 + #273, #265
  static LoseScreen2 + #274, #127
  static LoseScreen2 + #275, #127
  static LoseScreen2 + #276, #265
  static LoseScreen2 + #277, #265
  static LoseScreen2 + #278, #127
  static LoseScreen2 + #279, #127

  ;Linha 7
  static LoseScreen2 + #280, #265
  static LoseScreen2 + #281, #265
  static LoseScreen2 + #282, #265
  static LoseScreen2 + #283, #2057
  static LoseScreen2 + #284, #2057
  static LoseScreen2 + #285, #127
  static LoseScreen2 + #286, #127
  static LoseScreen2 + #287, #127
  static LoseScreen2 + #288, #127
  static LoseScreen2 + #289, #127
  static LoseScreen2 + #290, #127
  static LoseScreen2 + #291, #127
  static LoseScreen2 + #292, #127
  static LoseScreen2 + #293, #127
  static LoseScreen2 + #294, #127
  static LoseScreen2 + #295, #127
  static LoseScreen2 + #296, #127
  static LoseScreen2 + #297, #127
  static LoseScreen2 + #298, #127
  static LoseScreen2 + #299, #127
  static LoseScreen2 + #300, #2313
  static LoseScreen2 + #301, #127
  static LoseScreen2 + #302, #127
  static LoseScreen2 + #303, #127
  static LoseScreen2 + #304, #127
  static LoseScreen2 + #305, #127
  static LoseScreen2 + #306, #3967
  static LoseScreen2 + #307, #1289
  static LoseScreen2 + #308, #1289
  static LoseScreen2 + #309, #1289
  static LoseScreen2 + #310, #1289
  static LoseScreen2 + #311, #1289
  static LoseScreen2 + #312, #1289
  static LoseScreen2 + #313, #1289
  static LoseScreen2 + #314, #1289
  static LoseScreen2 + #315, #1289
  static LoseScreen2 + #316, #1289
  static LoseScreen2 + #317, #1289
  static LoseScreen2 + #318, #127
  static LoseScreen2 + #319, #127

  ;Linha 8
  static LoseScreen2 + #320, #265
  static LoseScreen2 + #321, #265
  static LoseScreen2 + #322, #265
  static LoseScreen2 + #323, #265
  static LoseScreen2 + #324, #2057
  static LoseScreen2 + #325, #127
  static LoseScreen2 + #326, #127
  static LoseScreen2 + #327, #127
  static LoseScreen2 + #328, #127
  static LoseScreen2 + #329, #127
  static LoseScreen2 + #330, #127
  static LoseScreen2 + #331, #127
  static LoseScreen2 + #332, #127
  static LoseScreen2 + #333, #127
  static LoseScreen2 + #334, #127
  static LoseScreen2 + #335, #127
  static LoseScreen2 + #336, #127
  static LoseScreen2 + #337, #127
  static LoseScreen2 + #338, #127
  static LoseScreen2 + #339, #127
  static LoseScreen2 + #340, #2313
  static LoseScreen2 + #341, #127
  static LoseScreen2 + #342, #2313
  static LoseScreen2 + #343, #127
  static LoseScreen2 + #344, #2313
  static LoseScreen2 + #345, #127
  static LoseScreen2 + #346, #127
  static LoseScreen2 + #347, #1289
  static LoseScreen2 + #348, #1289
  static LoseScreen2 + #349, #1289
  static LoseScreen2 + #350, #1289
  static LoseScreen2 + #351, #1289
  static LoseScreen2 + #352, #1289
  static LoseScreen2 + #353, #1289
  static LoseScreen2 + #354, #1289
  static LoseScreen2 + #355, #1289
  static LoseScreen2 + #356, #1289
  static LoseScreen2 + #357, #1289
  static LoseScreen2 + #358, #127
  static LoseScreen2 + #359, #127

  ;Linha 9
  static LoseScreen2 + #360, #265
  static LoseScreen2 + #361, #265
  static LoseScreen2 + #362, #265
  static LoseScreen2 + #363, #265
  static LoseScreen2 + #364, #265
  static LoseScreen2 + #365, #2057
  static LoseScreen2 + #366, #127
  static LoseScreen2 + #367, #127
  static LoseScreen2 + #368, #127
  static LoseScreen2 + #369, #127
  static LoseScreen2 + #370, #127
  static LoseScreen2 + #371, #127
  static LoseScreen2 + #372, #127
  static LoseScreen2 + #373, #127
  static LoseScreen2 + #374, #127
  static LoseScreen2 + #375, #127
  static LoseScreen2 + #376, #127
  static LoseScreen2 + #377, #127
  static LoseScreen2 + #378, #127
  static LoseScreen2 + #379, #2057
  static LoseScreen2 + #380, #2313
  static LoseScreen2 + #381, #2313
  static LoseScreen2 + #382, #2313
  static LoseScreen2 + #383, #2313
  static LoseScreen2 + #384, #2313
  static LoseScreen2 + #385, #2313
  static LoseScreen2 + #386, #2313
  static LoseScreen2 + #387, #127
  static LoseScreen2 + #388, #3967
  static LoseScreen2 + #389, #1289
  static LoseScreen2 + #390, #1289
  static LoseScreen2 + #391, #1289
  static LoseScreen2 + #392, #1289
  static LoseScreen2 + #393, #1289
  static LoseScreen2 + #394, #1289
  static LoseScreen2 + #395, #1289
  static LoseScreen2 + #396, #3967
  static LoseScreen2 + #397, #127
  static LoseScreen2 + #398, #127
  static LoseScreen2 + #399, #127

  ;Linha 10
  static LoseScreen2 + #400, #265
  static LoseScreen2 + #401, #265
  static LoseScreen2 + #402, #265
  static LoseScreen2 + #403, #265
  static LoseScreen2 + #404, #265
  static LoseScreen2 + #405, #2057
  static LoseScreen2 + #406, #2057
  static LoseScreen2 + #407, #127
  static LoseScreen2 + #408, #127
  static LoseScreen2 + #409, #127
  static LoseScreen2 + #410, #127
  static LoseScreen2 + #411, #127
  static LoseScreen2 + #412, #127
  static LoseScreen2 + #413, #127
  static LoseScreen2 + #414, #127
  static LoseScreen2 + #415, #127
  static LoseScreen2 + #416, #127
  static LoseScreen2 + #417, #2057
  static LoseScreen2 + #418, #2057
  static LoseScreen2 + #419, #2313
  static LoseScreen2 + #420, #2825
  static LoseScreen2 + #421, #2825
  static LoseScreen2 + #422, #2825
  static LoseScreen2 + #423, #2313
  static LoseScreen2 + #424, #2313
  static LoseScreen2 + #425, #2313
  static LoseScreen2 + #426, #127
  static LoseScreen2 + #427, #127
  static LoseScreen2 + #428, #127
  static LoseScreen2 + #429, #3967
  static LoseScreen2 + #430, #1289
  static LoseScreen2 + #431, #1289
  static LoseScreen2 + #432, #1289
  static LoseScreen2 + #433, #1289
  static LoseScreen2 + #434, #1289
  static LoseScreen2 + #435, #127
  static LoseScreen2 + #436, #127
  static LoseScreen2 + #437, #127
  static LoseScreen2 + #438, #127
  static LoseScreen2 + #439, #127

  ;Linha 11
  static LoseScreen2 + #440, #265
  static LoseScreen2 + #441, #265
  static LoseScreen2 + #442, #265
  static LoseScreen2 + #443, #265
  static LoseScreen2 + #444, #265
  static LoseScreen2 + #445, #265
  static LoseScreen2 + #446, #2057
  static LoseScreen2 + #447, #127
  static LoseScreen2 + #448, #127
  static LoseScreen2 + #449, #127
  static LoseScreen2 + #450, #127
  static LoseScreen2 + #451, #127
  static LoseScreen2 + #452, #127
  static LoseScreen2 + #453, #127
  static LoseScreen2 + #454, #127
  static LoseScreen2 + #455, #2057
  static LoseScreen2 + #456, #2057
  static LoseScreen2 + #457, #3967
  static LoseScreen2 + #458, #3967
  static LoseScreen2 + #459, #2825
  static LoseScreen2 + #460, #2825
  static LoseScreen2 + #461, #2825
  static LoseScreen2 + #462, #2825
  static LoseScreen2 + #463, #2825
  static LoseScreen2 + #464, #2313
  static LoseScreen2 + #465, #127
  static LoseScreen2 + #466, #127
  static LoseScreen2 + #467, #127
  static LoseScreen2 + #468, #127
  static LoseScreen2 + #469, #3967
  static LoseScreen2 + #470, #1289
  static LoseScreen2 + #471, #1289
  static LoseScreen2 + #472, #1289
  static LoseScreen2 + #473, #1289
  static LoseScreen2 + #474, #127
  static LoseScreen2 + #475, #127
  static LoseScreen2 + #476, #127
  static LoseScreen2 + #477, #127
  static LoseScreen2 + #478, #127
  static LoseScreen2 + #479, #127

  ;Linha 12
  static LoseScreen2 + #480, #265
  static LoseScreen2 + #481, #3967
  static LoseScreen2 + #482, #3967
  static LoseScreen2 + #483, #265
  static LoseScreen2 + #484, #265
  static LoseScreen2 + #485, #265
  static LoseScreen2 + #486, #2057
  static LoseScreen2 + #487, #127
  static LoseScreen2 + #488, #127
  static LoseScreen2 + #489, #127
  static LoseScreen2 + #490, #127
  static LoseScreen2 + #491, #127
  static LoseScreen2 + #492, #127
  static LoseScreen2 + #493, #127
  static LoseScreen2 + #494, #2057
  static LoseScreen2 + #495, #3967
  static LoseScreen2 + #496, #3967
  static LoseScreen2 + #497, #3967
  static LoseScreen2 + #498, #2057
  static LoseScreen2 + #499, #2825
  static LoseScreen2 + #500, #2825
  static LoseScreen2 + #501, #2825
  static LoseScreen2 + #502, #2825
  static LoseScreen2 + #503, #2825
  static LoseScreen2 + #504, #2313
  static LoseScreen2 + #505, #127
  static LoseScreen2 + #506, #127
  static LoseScreen2 + #507, #127
  static LoseScreen2 + #508, #127
  static LoseScreen2 + #509, #127
  static LoseScreen2 + #510, #1289
  static LoseScreen2 + #511, #1289
  static LoseScreen2 + #512, #1289
  static LoseScreen2 + #513, #1289
  static LoseScreen2 + #514, #127
  static LoseScreen2 + #515, #127
  static LoseScreen2 + #516, #127
  static LoseScreen2 + #517, #127
  static LoseScreen2 + #518, #127
  static LoseScreen2 + #519, #127

  ;Linha 13
  static LoseScreen2 + #520, #265
  static LoseScreen2 + #521, #3967
  static LoseScreen2 + #522, #265
  static LoseScreen2 + #523, #265
  static LoseScreen2 + #524, #265
  static LoseScreen2 + #525, #265
  static LoseScreen2 + #526, #2057
  static LoseScreen2 + #527, #127
  static LoseScreen2 + #528, #127
  static LoseScreen2 + #529, #127
  static LoseScreen2 + #530, #127
  static LoseScreen2 + #531, #127
  static LoseScreen2 + #532, #127
  static LoseScreen2 + #533, #2057
  static LoseScreen2 + #534, #3967
  static LoseScreen2 + #535, #3967
  static LoseScreen2 + #536, #127
  static LoseScreen2 + #537, #2057
  static LoseScreen2 + #538, #3967
  static LoseScreen2 + #539, #3967
  static LoseScreen2 + #540, #2057
  static LoseScreen2 + #541, #2057
  static LoseScreen2 + #542, #2825
  static LoseScreen2 + #543, #2313
  static LoseScreen2 + #544, #2313
  static LoseScreen2 + #545, #2313
  static LoseScreen2 + #546, #127
  static LoseScreen2 + #547, #127
  static LoseScreen2 + #548, #127
  static LoseScreen2 + #549, #127
  static LoseScreen2 + #550, #1289
  static LoseScreen2 + #551, #1289
  static LoseScreen2 + #552, #1289
  static LoseScreen2 + #553, #1289
  static LoseScreen2 + #554, #127
  static LoseScreen2 + #555, #127
  static LoseScreen2 + #556, #127
  static LoseScreen2 + #557, #127
  static LoseScreen2 + #558, #127
  static LoseScreen2 + #559, #127

  ;Linha 14
  static LoseScreen2 + #560, #265
  static LoseScreen2 + #561, #3967
  static LoseScreen2 + #562, #265
  static LoseScreen2 + #563, #265
  static LoseScreen2 + #564, #265
  static LoseScreen2 + #565, #2057
  static LoseScreen2 + #566, #2057
  static LoseScreen2 + #567, #127
  static LoseScreen2 + #568, #127
  static LoseScreen2 + #569, #3967
  static LoseScreen2 + #570, #3967
  static LoseScreen2 + #571, #3967
  static LoseScreen2 + #572, #2057
  static LoseScreen2 + #573, #2057
  static LoseScreen2 + #574, #3967
  static LoseScreen2 + #575, #127
  static LoseScreen2 + #576, #2057
  static LoseScreen2 + #577, #3967
  static LoseScreen2 + #578, #3967
  static LoseScreen2 + #579, #3967
  static LoseScreen2 + #580, #2057
  static LoseScreen2 + #581, #127
  static LoseScreen2 + #582, #2313
  static LoseScreen2 + #583, #2313
  static LoseScreen2 + #584, #2313
  static LoseScreen2 + #585, #2313
  static LoseScreen2 + #586, #127
  static LoseScreen2 + #587, #127
  static LoseScreen2 + #588, #127
  static LoseScreen2 + #589, #127
  static LoseScreen2 + #590, #1289
  static LoseScreen2 + #591, #1289
  static LoseScreen2 + #592, #1289
  static LoseScreen2 + #593, #1289
  static LoseScreen2 + #594, #127
  static LoseScreen2 + #595, #127
  static LoseScreen2 + #596, #127
  static LoseScreen2 + #597, #127
  static LoseScreen2 + #598, #127
  static LoseScreen2 + #599, #127

  ;Linha 15
  static LoseScreen2 + #600, #265
  static LoseScreen2 + #601, #265
  static LoseScreen2 + #602, #3967
  static LoseScreen2 + #603, #265
  static LoseScreen2 + #604, #265
  static LoseScreen2 + #605, #2057
  static LoseScreen2 + #606, #127
  static LoseScreen2 + #607, #127
  static LoseScreen2 + #608, #3967
  static LoseScreen2 + #609, #3967
  static LoseScreen2 + #610, #3967
  static LoseScreen2 + #611, #2057
  static LoseScreen2 + #612, #3967
  static LoseScreen2 + #613, #3967
  static LoseScreen2 + #614, #3967
  static LoseScreen2 + #615, #2057
  static LoseScreen2 + #616, #3967
  static LoseScreen2 + #617, #3967
  static LoseScreen2 + #618, #127
  static LoseScreen2 + #619, #2057
  static LoseScreen2 + #620, #2057
  static LoseScreen2 + #621, #127
  static LoseScreen2 + #622, #127
  static LoseScreen2 + #623, #2313
  static LoseScreen2 + #624, #2313
  static LoseScreen2 + #625, #127
  static LoseScreen2 + #626, #127
  static LoseScreen2 + #627, #127
  static LoseScreen2 + #628, #127
  static LoseScreen2 + #629, #127
  static LoseScreen2 + #630, #1289
  static LoseScreen2 + #631, #1289
  static LoseScreen2 + #632, #1289
  static LoseScreen2 + #633, #1289
  static LoseScreen2 + #634, #127
  static LoseScreen2 + #635, #127
  static LoseScreen2 + #636, #127
  static LoseScreen2 + #637, #127
  static LoseScreen2 + #638, #127
  static LoseScreen2 + #639, #127

  ;Linha 16
  static LoseScreen2 + #640, #265
  static LoseScreen2 + #641, #265
  static LoseScreen2 + #642, #265
  static LoseScreen2 + #643, #265
  static LoseScreen2 + #644, #2057
  static LoseScreen2 + #645, #2057
  static LoseScreen2 + #646, #127
  static LoseScreen2 + #647, #3967
  static LoseScreen2 + #648, #3967
  static LoseScreen2 + #649, #3967
  static LoseScreen2 + #650, #2057
  static LoseScreen2 + #651, #3967
  static LoseScreen2 + #652, #3967
  static LoseScreen2 + #653, #3967
  static LoseScreen2 + #654, #2057
  static LoseScreen2 + #655, #3967
  static LoseScreen2 + #656, #3967
  static LoseScreen2 + #657, #127
  static LoseScreen2 + #658, #2057
  static LoseScreen2 + #659, #2057
  static LoseScreen2 + #660, #127
  static LoseScreen2 + #661, #127
  static LoseScreen2 + #662, #127
  static LoseScreen2 + #663, #127
  static LoseScreen2 + #664, #127
  static LoseScreen2 + #665, #127
  static LoseScreen2 + #666, #127
  static LoseScreen2 + #667, #127
  static LoseScreen2 + #668, #127
  static LoseScreen2 + #669, #3967
  static LoseScreen2 + #670, #1033
  static LoseScreen2 + #671, #1033
  static LoseScreen2 + #672, #1033
  static LoseScreen2 + #673, #1033
  static LoseScreen2 + #674, #3967
  static LoseScreen2 + #675, #127
  static LoseScreen2 + #676, #127
  static LoseScreen2 + #677, #127
  static LoseScreen2 + #678, #127
  static LoseScreen2 + #679, #127

  ;Linha 17
  static LoseScreen2 + #680, #265
  static LoseScreen2 + #681, #265
  static LoseScreen2 + #682, #265
  static LoseScreen2 + #683, #2057
  static LoseScreen2 + #684, #2057
  static LoseScreen2 + #685, #127
  static LoseScreen2 + #686, #3967
  static LoseScreen2 + #687, #3967
  static LoseScreen2 + #688, #3967
  static LoseScreen2 + #689, #2057
  static LoseScreen2 + #690, #2057
  static LoseScreen2 + #691, #3967
  static LoseScreen2 + #692, #3967
  static LoseScreen2 + #693, #2057
  static LoseScreen2 + #694, #127
  static LoseScreen2 + #695, #127
  static LoseScreen2 + #696, #2057
  static LoseScreen2 + #697, #2057
  static LoseScreen2 + #698, #2057
  static LoseScreen2 + #699, #127
  static LoseScreen2 + #700, #127
  static LoseScreen2 + #701, #127
  static LoseScreen2 + #702, #127
  static LoseScreen2 + #703, #127
  static LoseScreen2 + #704, #127
  static LoseScreen2 + #705, #127
  static LoseScreen2 + #706, #127
  static LoseScreen2 + #707, #127
  static LoseScreen2 + #708, #127
  static LoseScreen2 + #709, #1033
  static LoseScreen2 + #710, #1033
  static LoseScreen2 + #711, #3967
  static LoseScreen2 + #712, #127
  static LoseScreen2 + #713, #1033
  static LoseScreen2 + #714, #1033
  static LoseScreen2 + #715, #127
  static LoseScreen2 + #716, #127
  static LoseScreen2 + #717, #127
  static LoseScreen2 + #718, #127
  static LoseScreen2 + #719, #127

  ;Linha 18
  static LoseScreen2 + #720, #265
  static LoseScreen2 + #721, #265
  static LoseScreen2 + #722, #265
  static LoseScreen2 + #723, #2057
  static LoseScreen2 + #724, #127
  static LoseScreen2 + #725, #127
  static LoseScreen2 + #726, #3967
  static LoseScreen2 + #727, #3967
  static LoseScreen2 + #728, #2057
  static LoseScreen2 + #729, #3967
  static LoseScreen2 + #730, #3967
  static LoseScreen2 + #731, #2057
  static LoseScreen2 + #732, #2057
  static LoseScreen2 + #733, #127
  static LoseScreen2 + #734, #2057
  static LoseScreen2 + #735, #2057
  static LoseScreen2 + #736, #2057
  static LoseScreen2 + #737, #127
  static LoseScreen2 + #738, #127
  static LoseScreen2 + #739, #127
  static LoseScreen2 + #740, #127
  static LoseScreen2 + #741, #127
  static LoseScreen2 + #742, #127
  static LoseScreen2 + #743, #127
  static LoseScreen2 + #744, #127
  static LoseScreen2 + #745, #127
  static LoseScreen2 + #746, #127
  static LoseScreen2 + #747, #127
  static LoseScreen2 + #748, #3967
  static LoseScreen2 + #749, #1033
  static LoseScreen2 + #750, #1033
  static LoseScreen2 + #751, #3967
  static LoseScreen2 + #752, #127
  static LoseScreen2 + #753, #1033
  static LoseScreen2 + #754, #1033
  static LoseScreen2 + #755, #3967
  static LoseScreen2 + #756, #3967
  static LoseScreen2 + #757, #127
  static LoseScreen2 + #758, #127
  static LoseScreen2 + #759, #127

  ;Linha 19
  static LoseScreen2 + #760, #265
  static LoseScreen2 + #761, #265
  static LoseScreen2 + #762, #2057
  static LoseScreen2 + #763, #127
  static LoseScreen2 + #764, #127
  static LoseScreen2 + #765, #3967
  static LoseScreen2 + #766, #3967
  static LoseScreen2 + #767, #3967
  static LoseScreen2 + #768, #2057
  static LoseScreen2 + #769, #3849
  static LoseScreen2 + #770, #3849
  static LoseScreen2 + #771, #3849
  static LoseScreen2 + #772, #3967
  static LoseScreen2 + #773, #2057
  static LoseScreen2 + #774, #2057
  static LoseScreen2 + #775, #2057
  static LoseScreen2 + #776, #265
  static LoseScreen2 + #777, #127
  static LoseScreen2 + #778, #127
  static LoseScreen2 + #779, #127
  static LoseScreen2 + #780, #127
  static LoseScreen2 + #781, #127
  static LoseScreen2 + #782, #127
  static LoseScreen2 + #783, #127
  static LoseScreen2 + #784, #127
  static LoseScreen2 + #785, #127
  static LoseScreen2 + #786, #127
  static LoseScreen2 + #787, #127
  static LoseScreen2 + #788, #3967
  static LoseScreen2 + #789, #1033
  static LoseScreen2 + #790, #1033
  static LoseScreen2 + #791, #3967
  static LoseScreen2 + #792, #127
  static LoseScreen2 + #793, #1033
  static LoseScreen2 + #794, #1033
  static LoseScreen2 + #795, #127
  static LoseScreen2 + #796, #127
  static LoseScreen2 + #797, #127
  static LoseScreen2 + #798, #127
  static LoseScreen2 + #799, #127

  ;Linha 20
  static LoseScreen2 + #800, #2057
  static LoseScreen2 + #801, #2057
  static LoseScreen2 + #802, #127
  static LoseScreen2 + #803, #127
  static LoseScreen2 + #804, #127
  static LoseScreen2 + #805, #3967
  static LoseScreen2 + #806, #3967
  static LoseScreen2 + #807, #2057
  static LoseScreen2 + #808, #2057
  static LoseScreen2 + #809, #3849
  static LoseScreen2 + #810, #3849
  static LoseScreen2 + #811, #3849
  static LoseScreen2 + #812, #3967
  static LoseScreen2 + #813, #2057
  static LoseScreen2 + #814, #265
  static LoseScreen2 + #815, #265
  static LoseScreen2 + #816, #265
  static LoseScreen2 + #817, #127
  static LoseScreen2 + #818, #127
  static LoseScreen2 + #819, #127
  static LoseScreen2 + #820, #127
  static LoseScreen2 + #821, #127
  static LoseScreen2 + #822, #127
  static LoseScreen2 + #823, #127
  static LoseScreen2 + #824, #127
  static LoseScreen2 + #825, #127
  static LoseScreen2 + #826, #127
  static LoseScreen2 + #827, #127
  static LoseScreen2 + #828, #3967
  static LoseScreen2 + #829, #1033
  static LoseScreen2 + #830, #1033
  static LoseScreen2 + #831, #3967
  static LoseScreen2 + #832, #127
  static LoseScreen2 + #833, #1033
  static LoseScreen2 + #834, #1033
  static LoseScreen2 + #835, #127
  static LoseScreen2 + #836, #127
  static LoseScreen2 + #837, #127
  static LoseScreen2 + #838, #127
  static LoseScreen2 + #839, #127

  ;Linha 21
  static LoseScreen2 + #840, #127
  static LoseScreen2 + #841, #2057
  static LoseScreen2 + #842, #2057
  static LoseScreen2 + #843, #127
  static LoseScreen2 + #844, #127
  static LoseScreen2 + #845, #3967
  static LoseScreen2 + #846, #2057
  static LoseScreen2 + #847, #2057
  static LoseScreen2 + #848, #3849
  static LoseScreen2 + #849, #3849
  static LoseScreen2 + #850, #3849
  static LoseScreen2 + #851, #3849
  static LoseScreen2 + #852, #2057
  static LoseScreen2 + #853, #2057
  static LoseScreen2 + #854, #265
  static LoseScreen2 + #855, #265
  static LoseScreen2 + #856, #265
  static LoseScreen2 + #857, #127
  static LoseScreen2 + #858, #127
  static LoseScreen2 + #859, #127
  static LoseScreen2 + #860, #127
  static LoseScreen2 + #861, #127
  static LoseScreen2 + #862, #127
  static LoseScreen2 + #863, #127
  static LoseScreen2 + #864, #127
  static LoseScreen2 + #865, #127
  static LoseScreen2 + #866, #127
  static LoseScreen2 + #867, #127
  static LoseScreen2 + #868, #3967
  static LoseScreen2 + #869, #1033
  static LoseScreen2 + #870, #1033
  static LoseScreen2 + #871, #3967
  static LoseScreen2 + #872, #127
  static LoseScreen2 + #873, #1033
  static LoseScreen2 + #874, #1033
  static LoseScreen2 + #875, #127
  static LoseScreen2 + #876, #127
  static LoseScreen2 + #877, #127
  static LoseScreen2 + #878, #127
  static LoseScreen2 + #879, #127

  ;Linha 22
  static LoseScreen2 + #880, #127
  static LoseScreen2 + #881, #127
  static LoseScreen2 + #882, #127
  static LoseScreen2 + #883, #2057
  static LoseScreen2 + #884, #2057
  static LoseScreen2 + #885, #3967
  static LoseScreen2 + #886, #2057
  static LoseScreen2 + #887, #3849
  static LoseScreen2 + #888, #3849
  static LoseScreen2 + #889, #3849
  static LoseScreen2 + #890, #2057
  static LoseScreen2 + #891, #2057
  static LoseScreen2 + #892, #2057
  static LoseScreen2 + #893, #265
  static LoseScreen2 + #894, #265
  static LoseScreen2 + #895, #265
  static LoseScreen2 + #896, #265
  static LoseScreen2 + #897, #127
  static LoseScreen2 + #898, #127
  static LoseScreen2 + #899, #127
  static LoseScreen2 + #900, #127
  static LoseScreen2 + #901, #127
  static LoseScreen2 + #902, #127
  static LoseScreen2 + #903, #127
  static LoseScreen2 + #904, #127
  static LoseScreen2 + #905, #127
  static LoseScreen2 + #906, #127
  static LoseScreen2 + #907, #3967
  static LoseScreen2 + #908, #1033
  static LoseScreen2 + #909, #1033
  static LoseScreen2 + #910, #1033
  static LoseScreen2 + #911, #127
  static LoseScreen2 + #912, #127
  static LoseScreen2 + #913, #1033
  static LoseScreen2 + #914, #1033
  static LoseScreen2 + #915, #1033
  static LoseScreen2 + #916, #127
  static LoseScreen2 + #917, #127
  static LoseScreen2 + #918, #127
  static LoseScreen2 + #919, #127

  ;Linha 23
  static LoseScreen2 + #920, #127
  static LoseScreen2 + #921, #127
  static LoseScreen2 + #922, #127
  static LoseScreen2 + #923, #127
  static LoseScreen2 + #924, #2057
  static LoseScreen2 + #925, #3967
  static LoseScreen2 + #926, #2057
  static LoseScreen2 + #927, #3849
  static LoseScreen2 + #928, #3849
  static LoseScreen2 + #929, #3849
  static LoseScreen2 + #930, #2057
  static LoseScreen2 + #931, #2057
  static LoseScreen2 + #932, #265
  static LoseScreen2 + #933, #265
  static LoseScreen2 + #934, #265
  static LoseScreen2 + #935, #3967
  static LoseScreen2 + #936, #3967
  static LoseScreen2 + #937, #127
  static LoseScreen2 + #938, #127
  static LoseScreen2 + #939, #127
  static LoseScreen2 + #940, #127
  static LoseScreen2 + #941, #127
  static LoseScreen2 + #942, #127
  static LoseScreen2 + #943, #127
  static LoseScreen2 + #944, #127
  static LoseScreen2 + #945, #127
  static LoseScreen2 + #946, #127
  static LoseScreen2 + #947, #127
  static LoseScreen2 + #948, #127
  static LoseScreen2 + #949, #127
  static LoseScreen2 + #950, #127
  static LoseScreen2 + #951, #127
  static LoseScreen2 + #952, #127
  static LoseScreen2 + #953, #127
  static LoseScreen2 + #954, #127
  static LoseScreen2 + #955, #127
  static LoseScreen2 + #956, #127
  static LoseScreen2 + #957, #127
  static LoseScreen2 + #958, #127
  static LoseScreen2 + #959, #127

  ;Linha 24
  static LoseScreen2 + #960, #127
  static LoseScreen2 + #961, #127
  static LoseScreen2 + #962, #127
  static LoseScreen2 + #963, #127
  static LoseScreen2 + #964, #2057
  static LoseScreen2 + #965, #3967
  static LoseScreen2 + #966, #2057
  static LoseScreen2 + #967, #3849
  static LoseScreen2 + #968, #3849
  static LoseScreen2 + #969, #2057
  static LoseScreen2 + #970, #2057
  static LoseScreen2 + #971, #2057
  static LoseScreen2 + #972, #265
  static LoseScreen2 + #973, #265
  static LoseScreen2 + #974, #3967
  static LoseScreen2 + #975, #3967
  static LoseScreen2 + #976, #127
  static LoseScreen2 + #977, #127
  static LoseScreen2 + #978, #127
  static LoseScreen2 + #979, #127
  static LoseScreen2 + #980, #127
  static LoseScreen2 + #981, #127
  static LoseScreen2 + #982, #127
  static LoseScreen2 + #983, #127
  static LoseScreen2 + #984, #127
  static LoseScreen2 + #985, #127
  static LoseScreen2 + #986, #127
  static LoseScreen2 + #987, #127
  static LoseScreen2 + #988, #127
  static LoseScreen2 + #989, #127
  static LoseScreen2 + #990, #127
  static LoseScreen2 + #991, #127
  static LoseScreen2 + #992, #127
  static LoseScreen2 + #993, #127
  static LoseScreen2 + #994, #127
  static LoseScreen2 + #995, #127
  static LoseScreen2 + #996, #127
  static LoseScreen2 + #997, #127
  static LoseScreen2 + #998, #127
  static LoseScreen2 + #999, #127

  ;Linha 25
  static LoseScreen2 + #1000, #127
  static LoseScreen2 + #1001, #127
  static LoseScreen2 + #1002, #127
  static LoseScreen2 + #1003, #127
  static LoseScreen2 + #1004, #2057
  static LoseScreen2 + #1005, #3967
  static LoseScreen2 + #1006, #2057
  static LoseScreen2 + #1007, #3849
  static LoseScreen2 + #1008, #3849
  static LoseScreen2 + #1009, #2057
  static LoseScreen2 + #1010, #2057
  static LoseScreen2 + #1011, #265
  static LoseScreen2 + #1012, #265
  static LoseScreen2 + #1013, #265
  static LoseScreen2 + #1014, #3967
  static LoseScreen2 + #1015, #3967
  static LoseScreen2 + #1016, #127
  static LoseScreen2 + #1017, #127
  static LoseScreen2 + #1018, #127
  static LoseScreen2 + #1019, #127
  static LoseScreen2 + #1020, #127
  static LoseScreen2 + #1021, #127
  static LoseScreen2 + #1022, #127
  static LoseScreen2 + #1023, #127
  static LoseScreen2 + #1024, #127
  static LoseScreen2 + #1025, #127
  static LoseScreen2 + #1026, #127
  static LoseScreen2 + #1027, #127
  static LoseScreen2 + #1028, #127
  static LoseScreen2 + #1029, #127
  static LoseScreen2 + #1030, #127
  static LoseScreen2 + #1031, #127
  static LoseScreen2 + #1032, #127
  static LoseScreen2 + #1033, #127
  static LoseScreen2 + #1034, #127
  static LoseScreen2 + #1035, #127
  static LoseScreen2 + #1036, #127
  static LoseScreen2 + #1037, #127
  static LoseScreen2 + #1038, #127
  static LoseScreen2 + #1039, #127

  ;Linha 26
  static LoseScreen2 + #1040, #127
  static LoseScreen2 + #1041, #127
  static LoseScreen2 + #1042, #127
  static LoseScreen2 + #1043, #2057
  static LoseScreen2 + #1044, #2057
  static LoseScreen2 + #1045, #127
  static LoseScreen2 + #1046, #2057
  static LoseScreen2 + #1047, #3849
  static LoseScreen2 + #1048, #3849
  static LoseScreen2 + #1049, #2057
  static LoseScreen2 + #1050, #265
  static LoseScreen2 + #1051, #265
  static LoseScreen2 + #1052, #265
  static LoseScreen2 + #1053, #265
  static LoseScreen2 + #1054, #3967
  static LoseScreen2 + #1055, #3967
  static LoseScreen2 + #1056, #127
  static LoseScreen2 + #1057, #127
  static LoseScreen2 + #1058, #127
  static LoseScreen2 + #1059, #127
  static LoseScreen2 + #1060, #127
  static LoseScreen2 + #1061, #127
  static LoseScreen2 + #1062, #127
  static LoseScreen2 + #1063, #127
  static LoseScreen2 + #1064, #127
  static LoseScreen2 + #1065, #127
  static LoseScreen2 + #1066, #127
  static LoseScreen2 + #1067, #127
  static LoseScreen2 + #1068, #127
  static LoseScreen2 + #1069, #127
  static LoseScreen2 + #1070, #127
  static LoseScreen2 + #1071, #127
  static LoseScreen2 + #1072, #127
  static LoseScreen2 + #1073, #127
  static LoseScreen2 + #1074, #127
  static LoseScreen2 + #1075, #127
  static LoseScreen2 + #1076, #127
  static LoseScreen2 + #1077, #127
  static LoseScreen2 + #1078, #127
  static LoseScreen2 + #1079, #127

  ;Linha 27
  static LoseScreen2 + #1080, #127
  static LoseScreen2 + #1081, #127
  static LoseScreen2 + #1082, #127
  static LoseScreen2 + #1083, #2057
  static LoseScreen2 + #1084, #2057
  static LoseScreen2 + #1085, #2057
  static LoseScreen2 + #1086, #2057
  static LoseScreen2 + #1087, #2057
  static LoseScreen2 + #1088, #2057
  static LoseScreen2 + #1089, #265
  static LoseScreen2 + #1090, #265
  static LoseScreen2 + #1091, #265
  static LoseScreen2 + #1092, #265
  static LoseScreen2 + #1093, #3967
  static LoseScreen2 + #1094, #3967
  static LoseScreen2 + #1095, #3967
  static LoseScreen2 + #1096, #127
  static LoseScreen2 + #1097, #127
  static LoseScreen2 + #1098, #127
  static LoseScreen2 + #1099, #127
  static LoseScreen2 + #1100, #127
  static LoseScreen2 + #1101, #127
  static LoseScreen2 + #1102, #127
  static LoseScreen2 + #1103, #127
  static LoseScreen2 + #1104, #127
  static LoseScreen2 + #1105, #127
  static LoseScreen2 + #1106, #127
  static LoseScreen2 + #1107, #127
  static LoseScreen2 + #1108, #127
  static LoseScreen2 + #1109, #127
  static LoseScreen2 + #1110, #127
  static LoseScreen2 + #1111, #127
  static LoseScreen2 + #1112, #127
  static LoseScreen2 + #1113, #127
  static LoseScreen2 + #1114, #127
  static LoseScreen2 + #1115, #127
  static LoseScreen2 + #1116, #127
  static LoseScreen2 + #1117, #127
  static LoseScreen2 + #1118, #127
  static LoseScreen2 + #1119, #127

  ;Linha 28
  static LoseScreen2 + #1120, #127
  static LoseScreen2 + #1121, #127
  static LoseScreen2 + #1122, #127
  static LoseScreen2 + #1123, #127
  static LoseScreen2 + #1124, #127
  static LoseScreen2 + #1125, #127
  static LoseScreen2 + #1126, #127
  static LoseScreen2 + #1127, #2057
  static LoseScreen2 + #1128, #265
  static LoseScreen2 + #1129, #265
  static LoseScreen2 + #1130, #265
  static LoseScreen2 + #1131, #265
  static LoseScreen2 + #1132, #3967
  static LoseScreen2 + #1133, #3967
  static LoseScreen2 + #1134, #3967
  static LoseScreen2 + #1135, #127
  static LoseScreen2 + #1136, #127
  static LoseScreen2 + #1137, #127
  static LoseScreen2 + #1138, #127
  static LoseScreen2 + #1139, #127
  static LoseScreen2 + #1140, #127
  static LoseScreen2 + #1141, #127
  static LoseScreen2 + #1142, #127
  static LoseScreen2 + #1143, #127
  static LoseScreen2 + #1144, #127
  static LoseScreen2 + #1145, #127
  static LoseScreen2 + #1146, #127
  static LoseScreen2 + #1147, #127
  static LoseScreen2 + #1148, #127
  static LoseScreen2 + #1149, #127
  static LoseScreen2 + #1150, #127
  static LoseScreen2 + #1151, #127
  static LoseScreen2 + #1152, #127
  static LoseScreen2 + #1153, #127
  static LoseScreen2 + #1154, #127
  static LoseScreen2 + #1155, #127
  static LoseScreen2 + #1156, #127
  static LoseScreen2 + #1157, #127
  static LoseScreen2 + #1158, #127
  static LoseScreen2 + #1159, #127

  ;Linha 29
  static LoseScreen2 + #1160, #127
  static LoseScreen2 + #1161, #127
  static LoseScreen2 + #1162, #127
  static LoseScreen2 + #1163, #127
  static LoseScreen2 + #1164, #127
  static LoseScreen2 + #1165, #127
  static LoseScreen2 + #1166, #127
  static LoseScreen2 + #1167, #2057
  static LoseScreen2 + #1168, #265
  static LoseScreen2 + #1169, #265
  static LoseScreen2 + #1170, #265
  static LoseScreen2 + #1171, #265
  static LoseScreen2 + #1172, #3967
  static LoseScreen2 + #1173, #3967
  static LoseScreen2 + #1174, #3967
  static LoseScreen2 + #1175, #127
  static LoseScreen2 + #1176, #127
  static LoseScreen2 + #1177, #127
  static LoseScreen2 + #1178, #127
  static LoseScreen2 + #1179, #127
  static LoseScreen2 + #1180, #127
  static LoseScreen2 + #1181, #127
  static LoseScreen2 + #1182, #127
  static LoseScreen2 + #1183, #127
  static LoseScreen2 + #1184, #127
  static LoseScreen2 + #1185, #127
  static LoseScreen2 + #1186, #127
  static LoseScreen2 + #1187, #127
  static LoseScreen2 + #1188, #127
  static LoseScreen2 + #1189, #127
  static LoseScreen2 + #1190, #127
  static LoseScreen2 + #1191, #127
  static LoseScreen2 + #1192, #127
  static LoseScreen2 + #1193, #127
  static LoseScreen2 + #1194, #127
  static LoseScreen2 + #1195, #127
  static LoseScreen2 + #1196, #127
  static LoseScreen2 + #1197, #127
  static LoseScreen2 + #1198, #127
  static LoseScreen2 + #1199, #127
;

LoseScreen3 : var #1200
  ;Linha 0
  static LoseScreen3 + #0, #127
  static LoseScreen3 + #1, #127
  static LoseScreen3 + #2, #127
  static LoseScreen3 + #3, #127
  static LoseScreen3 + #4, #127
  static LoseScreen3 + #5, #127
  static LoseScreen3 + #6, #127
  static LoseScreen3 + #7, #127
  static LoseScreen3 + #8, #127
  static LoseScreen3 + #9, #127
  static LoseScreen3 + #10, #127
  static LoseScreen3 + #11, #127
  static LoseScreen3 + #12, #127
  static LoseScreen3 + #13, #127
  static LoseScreen3 + #14, #127
  static LoseScreen3 + #15, #127
  static LoseScreen3 + #16, #127
  static LoseScreen3 + #17, #127
  static LoseScreen3 + #18, #127
  static LoseScreen3 + #19, #127
  static LoseScreen3 + #20, #127
  static LoseScreen3 + #21, #127
  static LoseScreen3 + #22, #127
  static LoseScreen3 + #23, #127
  static LoseScreen3 + #24, #127
  static LoseScreen3 + #25, #127
  static LoseScreen3 + #26, #127
  static LoseScreen3 + #27, #127
  static LoseScreen3 + #28, #127
  static LoseScreen3 + #29, #127
  static LoseScreen3 + #30, #127
  static LoseScreen3 + #31, #127
  static LoseScreen3 + #32, #127
  static LoseScreen3 + #33, #127
  static LoseScreen3 + #34, #127
  static LoseScreen3 + #35, #127
  static LoseScreen3 + #36, #127
  static LoseScreen3 + #37, #127
  static LoseScreen3 + #38, #127
  static LoseScreen3 + #39, #127

  ;Linha 1
  static LoseScreen3 + #40, #127
  static LoseScreen3 + #41, #127
  static LoseScreen3 + #42, #127
  static LoseScreen3 + #43, #127
  static LoseScreen3 + #44, #127
  static LoseScreen3 + #45, #127
  static LoseScreen3 + #46, #127
  static LoseScreen3 + #47, #127
  static LoseScreen3 + #48, #127
  static LoseScreen3 + #49, #127
  static LoseScreen3 + #50, #127
  static LoseScreen3 + #51, #127
  static LoseScreen3 + #52, #127
  static LoseScreen3 + #53, #127
  static LoseScreen3 + #54, #127
  static LoseScreen3 + #55, #127
  static LoseScreen3 + #56, #127
  static LoseScreen3 + #57, #127
  static LoseScreen3 + #58, #127
  static LoseScreen3 + #59, #127
  static LoseScreen3 + #60, #127
  static LoseScreen3 + #61, #127
  static LoseScreen3 + #62, #127
  static LoseScreen3 + #63, #127
  static LoseScreen3 + #64, #127
  static LoseScreen3 + #65, #127
  static LoseScreen3 + #66, #127
  static LoseScreen3 + #67, #127
  static LoseScreen3 + #68, #127
  static LoseScreen3 + #69, #127
  static LoseScreen3 + #70, #127
  static LoseScreen3 + #71, #127
  static LoseScreen3 + #72, #127
  static LoseScreen3 + #73, #127
  static LoseScreen3 + #74, #127
  static LoseScreen3 + #75, #127
  static LoseScreen3 + #76, #127
  static LoseScreen3 + #77, #127
  static LoseScreen3 + #78, #127
  static LoseScreen3 + #79, #127

  ;Linha 2
  static LoseScreen3 + #80, #127
  static LoseScreen3 + #81, #127
  static LoseScreen3 + #82, #127
  static LoseScreen3 + #83, #127
  static LoseScreen3 + #84, #127
  static LoseScreen3 + #85, #127
  static LoseScreen3 + #86, #127
  static LoseScreen3 + #87, #127
  static LoseScreen3 + #88, #127
  static LoseScreen3 + #89, #127
  static LoseScreen3 + #90, #127
  static LoseScreen3 + #91, #127
  static LoseScreen3 + #92, #127
  static LoseScreen3 + #93, #127
  static LoseScreen3 + #94, #127
  static LoseScreen3 + #95, #127
  static LoseScreen3 + #96, #127
  static LoseScreen3 + #97, #127
  static LoseScreen3 + #98, #127
  static LoseScreen3 + #99, #127
  static LoseScreen3 + #100, #127
  static LoseScreen3 + #101, #127
  static LoseScreen3 + #102, #127
  static LoseScreen3 + #103, #127
  static LoseScreen3 + #104, #127
  static LoseScreen3 + #105, #127
  static LoseScreen3 + #106, #127
  static LoseScreen3 + #107, #127
  static LoseScreen3 + #108, #127
  static LoseScreen3 + #109, #127
  static LoseScreen3 + #110, #127
  static LoseScreen3 + #111, #127
  static LoseScreen3 + #112, #127
  static LoseScreen3 + #113, #127
  static LoseScreen3 + #114, #127
  static LoseScreen3 + #115, #127
  static LoseScreen3 + #116, #127
  static LoseScreen3 + #117, #127
  static LoseScreen3 + #118, #127
  static LoseScreen3 + #119, #127

  ;Linha 3
  static LoseScreen3 + #120, #127
  static LoseScreen3 + #121, #127
  static LoseScreen3 + #122, #127
  static LoseScreen3 + #123, #2313
  static LoseScreen3 + #124, #2313
  static LoseScreen3 + #125, #2313
  static LoseScreen3 + #126, #2313
  static LoseScreen3 + #127, #2313
  static LoseScreen3 + #128, #2313
  static LoseScreen3 + #129, #2313
  static LoseScreen3 + #130, #2313
  static LoseScreen3 + #131, #2313
  static LoseScreen3 + #132, #2313
  static LoseScreen3 + #133, #2313
  static LoseScreen3 + #134, #2313
  static LoseScreen3 + #135, #2313
  static LoseScreen3 + #136, #2313
  static LoseScreen3 + #137, #2313
  static LoseScreen3 + #138, #2313
  static LoseScreen3 + #139, #2313
  static LoseScreen3 + #140, #2313
  static LoseScreen3 + #141, #2313
  static LoseScreen3 + #142, #2313
  static LoseScreen3 + #143, #2313
  static LoseScreen3 + #144, #2313
  static LoseScreen3 + #145, #2313
  static LoseScreen3 + #146, #2313
  static LoseScreen3 + #147, #2313
  static LoseScreen3 + #148, #2313
  static LoseScreen3 + #149, #2313
  static LoseScreen3 + #150, #2313
  static LoseScreen3 + #151, #2313
  static LoseScreen3 + #152, #2313
  static LoseScreen3 + #153, #2313
  static LoseScreen3 + #154, #2313
  static LoseScreen3 + #155, #2313
  static LoseScreen3 + #156, #2313
  static LoseScreen3 + #157, #127
  static LoseScreen3 + #158, #127
  static LoseScreen3 + #159, #127

  ;Linha 4
  static LoseScreen3 + #160, #127
  static LoseScreen3 + #161, #127
  static LoseScreen3 + #162, #127
  static LoseScreen3 + #163, #2313
  static LoseScreen3 + #164, #127
  static LoseScreen3 + #165, #127
  static LoseScreen3 + #166, #127
  static LoseScreen3 + #167, #127
  static LoseScreen3 + #168, #127
  static LoseScreen3 + #169, #127
  static LoseScreen3 + #170, #127
  static LoseScreen3 + #171, #127
  static LoseScreen3 + #172, #127
  static LoseScreen3 + #173, #127
  static LoseScreen3 + #174, #127
  static LoseScreen3 + #175, #127
  static LoseScreen3 + #176, #127
  static LoseScreen3 + #177, #127
  static LoseScreen3 + #178, #127
  static LoseScreen3 + #179, #127
  static LoseScreen3 + #180, #127
  static LoseScreen3 + #181, #3967
  static LoseScreen3 + #182, #127
  static LoseScreen3 + #183, #127
  static LoseScreen3 + #184, #127
  static LoseScreen3 + #185, #127
  static LoseScreen3 + #186, #127
  static LoseScreen3 + #187, #127
  static LoseScreen3 + #188, #127
  static LoseScreen3 + #189, #127
  static LoseScreen3 + #190, #127
  static LoseScreen3 + #191, #127
  static LoseScreen3 + #192, #127
  static LoseScreen3 + #193, #127
  static LoseScreen3 + #194, #127
  static LoseScreen3 + #195, #127
  static LoseScreen3 + #196, #2313
  static LoseScreen3 + #197, #127
  static LoseScreen3 + #198, #127
  static LoseScreen3 + #199, #127

  ;Linha 5
  static LoseScreen3 + #200, #127
  static LoseScreen3 + #201, #127
  static LoseScreen3 + #202, #127
  static LoseScreen3 + #203, #2313
  static LoseScreen3 + #204, #127
  static LoseScreen3 + #205, #2313
  static LoseScreen3 + #206, #127
  static LoseScreen3 + #207, #127
  static LoseScreen3 + #208, #127
  static LoseScreen3 + #209, #2313
  static LoseScreen3 + #210, #127
  static LoseScreen3 + #211, #127
  static LoseScreen3 + #212, #2313
  static LoseScreen3 + #213, #127
  static LoseScreen3 + #214, #127
  static LoseScreen3 + #215, #127
  static LoseScreen3 + #216, #2313
  static LoseScreen3 + #217, #2313
  static LoseScreen3 + #218, #127
  static LoseScreen3 + #219, #2313
  static LoseScreen3 + #220, #2313
  static LoseScreen3 + #221, #3967
  static LoseScreen3 + #222, #127
  static LoseScreen3 + #223, #127
  static LoseScreen3 + #224, #127
  static LoseScreen3 + #225, #127
  static LoseScreen3 + #226, #127
  static LoseScreen3 + #227, #127
  static LoseScreen3 + #228, #127
  static LoseScreen3 + #229, #127
  static LoseScreen3 + #230, #127
  static LoseScreen3 + #231, #127
  static LoseScreen3 + #232, #127
  static LoseScreen3 + #233, #127
  static LoseScreen3 + #234, #127
  static LoseScreen3 + #235, #127
  static LoseScreen3 + #236, #2313
  static LoseScreen3 + #237, #127
  static LoseScreen3 + #238, #127
  static LoseScreen3 + #239, #127

  ;Linha 6
  static LoseScreen3 + #240, #127
  static LoseScreen3 + #241, #127
  static LoseScreen3 + #242, #127
  static LoseScreen3 + #243, #2313
  static LoseScreen3 + #244, #127
  static LoseScreen3 + #245, #2313
  static LoseScreen3 + #246, #3967
  static LoseScreen3 + #247, #127
  static LoseScreen3 + #248, #3967
  static LoseScreen3 + #249, #2313
  static LoseScreen3 + #250, #127
  static LoseScreen3 + #251, #2313
  static LoseScreen3 + #252, #127
  static LoseScreen3 + #253, #2313
  static LoseScreen3 + #254, #127
  static LoseScreen3 + #255, #2313
  static LoseScreen3 + #256, #127
  static LoseScreen3 + #257, #127
  static LoseScreen3 + #258, #127
  static LoseScreen3 + #259, #2313
  static LoseScreen3 + #260, #3967
  static LoseScreen3 + #261, #3967
  static LoseScreen3 + #262, #127
  static LoseScreen3 + #263, #127
  static LoseScreen3 + #264, #127
  static LoseScreen3 + #265, #127
  static LoseScreen3 + #266, #127
  static LoseScreen3 + #267, #3967
  static LoseScreen3 + #268, #3967
  static LoseScreen3 + #269, #3967
  static LoseScreen3 + #270, #127
  static LoseScreen3 + #271, #127
  static LoseScreen3 + #272, #3967
  static LoseScreen3 + #273, #3967
  static LoseScreen3 + #274, #127
  static LoseScreen3 + #275, #127
  static LoseScreen3 + #276, #2313
  static LoseScreen3 + #277, #127
  static LoseScreen3 + #278, #127
  static LoseScreen3 + #279, #127

  ;Linha 7
  static LoseScreen3 + #280, #127
  static LoseScreen3 + #281, #127
  static LoseScreen3 + #282, #127
  static LoseScreen3 + #283, #2313
  static LoseScreen3 + #284, #127
  static LoseScreen3 + #285, #2313
  static LoseScreen3 + #286, #3967
  static LoseScreen3 + #287, #127
  static LoseScreen3 + #288, #3967
  static LoseScreen3 + #289, #2313
  static LoseScreen3 + #290, #127
  static LoseScreen3 + #291, #2313
  static LoseScreen3 + #292, #127
  static LoseScreen3 + #293, #2313
  static LoseScreen3 + #294, #127
  static LoseScreen3 + #295, #2313
  static LoseScreen3 + #296, #127
  static LoseScreen3 + #297, #127
  static LoseScreen3 + #298, #127
  static LoseScreen3 + #299, #2313
  static LoseScreen3 + #300, #2313
  static LoseScreen3 + #301, #3967
  static LoseScreen3 + #302, #127
  static LoseScreen3 + #303, #127
  static LoseScreen3 + #304, #127
  static LoseScreen3 + #305, #127
  static LoseScreen3 + #306, #127
  static LoseScreen3 + #307, #3967
  static LoseScreen3 + #308, #3967
  static LoseScreen3 + #309, #127
  static LoseScreen3 + #310, #3967
  static LoseScreen3 + #311, #3967
  static LoseScreen3 + #312, #3967
  static LoseScreen3 + #313, #3967
  static LoseScreen3 + #314, #127
  static LoseScreen3 + #315, #127
  static LoseScreen3 + #316, #2313
  static LoseScreen3 + #317, #3967
  static LoseScreen3 + #318, #127
  static LoseScreen3 + #319, #127

  ;Linha 8
  static LoseScreen3 + #320, #127
  static LoseScreen3 + #321, #127
  static LoseScreen3 + #322, #127
  static LoseScreen3 + #323, #2313
  static LoseScreen3 + #324, #127
  static LoseScreen3 + #325, #127
  static LoseScreen3 + #326, #2313
  static LoseScreen3 + #327, #3967
  static LoseScreen3 + #328, #2313
  static LoseScreen3 + #329, #127
  static LoseScreen3 + #330, #127
  static LoseScreen3 + #331, #2313
  static LoseScreen3 + #332, #127
  static LoseScreen3 + #333, #2313
  static LoseScreen3 + #334, #127
  static LoseScreen3 + #335, #2313
  static LoseScreen3 + #336, #127
  static LoseScreen3 + #337, #127
  static LoseScreen3 + #338, #127
  static LoseScreen3 + #339, #2313
  static LoseScreen3 + #340, #3967
  static LoseScreen3 + #341, #3967
  static LoseScreen3 + #342, #127
  static LoseScreen3 + #343, #127
  static LoseScreen3 + #344, #127
  static LoseScreen3 + #345, #127
  static LoseScreen3 + #346, #127
  static LoseScreen3 + #347, #3967
  static LoseScreen3 + #348, #3967
  static LoseScreen3 + #349, #3967
  static LoseScreen3 + #350, #3967
  static LoseScreen3 + #351, #3967
  static LoseScreen3 + #352, #127
  static LoseScreen3 + #353, #127
  static LoseScreen3 + #354, #127
  static LoseScreen3 + #355, #127
  static LoseScreen3 + #356, #2313
  static LoseScreen3 + #357, #3967
  static LoseScreen3 + #358, #127
  static LoseScreen3 + #359, #127

  ;Linha 9
  static LoseScreen3 + #360, #127
  static LoseScreen3 + #361, #127
  static LoseScreen3 + #362, #127
  static LoseScreen3 + #363, #2313
  static LoseScreen3 + #364, #127
  static LoseScreen3 + #365, #127
  static LoseScreen3 + #366, #127
  static LoseScreen3 + #367, #2313
  static LoseScreen3 + #368, #127
  static LoseScreen3 + #369, #127
  static LoseScreen3 + #370, #127
  static LoseScreen3 + #371, #127
  static LoseScreen3 + #372, #2313
  static LoseScreen3 + #373, #127
  static LoseScreen3 + #374, #127
  static LoseScreen3 + #375, #127
  static LoseScreen3 + #376, #2313
  static LoseScreen3 + #377, #2313
  static LoseScreen3 + #378, #127
  static LoseScreen3 + #379, #2313
  static LoseScreen3 + #380, #2313
  static LoseScreen3 + #381, #3967
  static LoseScreen3 + #382, #127
  static LoseScreen3 + #383, #127
  static LoseScreen3 + #384, #127
  static LoseScreen3 + #385, #127
  static LoseScreen3 + #386, #127
  static LoseScreen3 + #387, #127
  static LoseScreen3 + #388, #3967
  static LoseScreen3 + #389, #3967
  static LoseScreen3 + #390, #3967
  static LoseScreen3 + #391, #3967
  static LoseScreen3 + #392, #127
  static LoseScreen3 + #393, #127
  static LoseScreen3 + #394, #127
  static LoseScreen3 + #395, #127
  static LoseScreen3 + #396, #2313
  static LoseScreen3 + #397, #3967
  static LoseScreen3 + #398, #127
  static LoseScreen3 + #399, #127

  ;Linha 10
  static LoseScreen3 + #400, #127
  static LoseScreen3 + #401, #127
  static LoseScreen3 + #402, #127
  static LoseScreen3 + #403, #2313
  static LoseScreen3 + #404, #127
  static LoseScreen3 + #405, #127
  static LoseScreen3 + #406, #127
  static LoseScreen3 + #407, #127
  static LoseScreen3 + #408, #127
  static LoseScreen3 + #409, #127
  static LoseScreen3 + #410, #127
  static LoseScreen3 + #411, #127
  static LoseScreen3 + #412, #127
  static LoseScreen3 + #413, #127
  static LoseScreen3 + #414, #127
  static LoseScreen3 + #415, #127
  static LoseScreen3 + #416, #127
  static LoseScreen3 + #417, #127
  static LoseScreen3 + #418, #3967
  static LoseScreen3 + #419, #3967
  static LoseScreen3 + #420, #127
  static LoseScreen3 + #421, #127
  static LoseScreen3 + #422, #127
  static LoseScreen3 + #423, #127
  static LoseScreen3 + #424, #127
  static LoseScreen3 + #425, #127
  static LoseScreen3 + #426, #127
  static LoseScreen3 + #427, #127
  static LoseScreen3 + #428, #3967
  static LoseScreen3 + #429, #3967
  static LoseScreen3 + #430, #3967
  static LoseScreen3 + #431, #3967
  static LoseScreen3 + #432, #127
  static LoseScreen3 + #433, #127
  static LoseScreen3 + #434, #127
  static LoseScreen3 + #435, #127
  static LoseScreen3 + #436, #2313
  static LoseScreen3 + #437, #3967
  static LoseScreen3 + #438, #127
  static LoseScreen3 + #439, #127

  ;Linha 11
  static LoseScreen3 + #440, #127
  static LoseScreen3 + #441, #127
  static LoseScreen3 + #442, #127
  static LoseScreen3 + #443, #2313
  static LoseScreen3 + #444, #127
  static LoseScreen3 + #445, #2313
  static LoseScreen3 + #446, #2313
  static LoseScreen3 + #447, #127
  static LoseScreen3 + #448, #127
  static LoseScreen3 + #449, #2313
  static LoseScreen3 + #450, #2313
  static LoseScreen3 + #451, #127
  static LoseScreen3 + #452, #2313
  static LoseScreen3 + #453, #2313
  static LoseScreen3 + #454, #127
  static LoseScreen3 + #455, #127
  static LoseScreen3 + #456, #2313
  static LoseScreen3 + #457, #2313
  static LoseScreen3 + #458, #127
  static LoseScreen3 + #459, #127
  static LoseScreen3 + #460, #2313
  static LoseScreen3 + #461, #2313
  static LoseScreen3 + #462, #127
  static LoseScreen3 + #463, #2313
  static LoseScreen3 + #464, #127
  static LoseScreen3 + #465, #2313
  static LoseScreen3 + #466, #3967
  static LoseScreen3 + #467, #2313
  static LoseScreen3 + #468, #3967
  static LoseScreen3 + #469, #3967
  static LoseScreen3 + #470, #127
  static LoseScreen3 + #471, #127
  static LoseScreen3 + #472, #127
  static LoseScreen3 + #473, #127
  static LoseScreen3 + #474, #127
  static LoseScreen3 + #475, #127
  static LoseScreen3 + #476, #2313
  static LoseScreen3 + #477, #3967
  static LoseScreen3 + #478, #127
  static LoseScreen3 + #479, #127

  ;Linha 12
  static LoseScreen3 + #480, #127
  static LoseScreen3 + #481, #127
  static LoseScreen3 + #482, #127
  static LoseScreen3 + #483, #2313
  static LoseScreen3 + #484, #127
  static LoseScreen3 + #485, #2313
  static LoseScreen3 + #486, #127
  static LoseScreen3 + #487, #2313
  static LoseScreen3 + #488, #127
  static LoseScreen3 + #489, #2313
  static LoseScreen3 + #490, #127
  static LoseScreen3 + #491, #127
  static LoseScreen3 + #492, #2313
  static LoseScreen3 + #493, #127
  static LoseScreen3 + #494, #2313
  static LoseScreen3 + #495, #127
  static LoseScreen3 + #496, #2313
  static LoseScreen3 + #497, #127
  static LoseScreen3 + #498, #2313
  static LoseScreen3 + #499, #127
  static LoseScreen3 + #500, #2313
  static LoseScreen3 + #501, #127
  static LoseScreen3 + #502, #127
  static LoseScreen3 + #503, #2313
  static LoseScreen3 + #504, #127
  static LoseScreen3 + #505, #2313
  static LoseScreen3 + #506, #3967
  static LoseScreen3 + #507, #2313
  static LoseScreen3 + #508, #3967
  static LoseScreen3 + #509, #3967
  static LoseScreen3 + #510, #127
  static LoseScreen3 + #511, #127
  static LoseScreen3 + #512, #127
  static LoseScreen3 + #513, #127
  static LoseScreen3 + #514, #127
  static LoseScreen3 + #515, #127
  static LoseScreen3 + #516, #2313
  static LoseScreen3 + #517, #3967
  static LoseScreen3 + #518, #127
  static LoseScreen3 + #519, #127

  ;Linha 13
  static LoseScreen3 + #520, #127
  static LoseScreen3 + #521, #127
  static LoseScreen3 + #522, #127
  static LoseScreen3 + #523, #2313
  static LoseScreen3 + #524, #127
  static LoseScreen3 + #525, #2313
  static LoseScreen3 + #526, #127
  static LoseScreen3 + #527, #2313
  static LoseScreen3 + #528, #127
  static LoseScreen3 + #529, #2313
  static LoseScreen3 + #530, #2313
  static LoseScreen3 + #531, #127
  static LoseScreen3 + #532, #2313
  static LoseScreen3 + #533, #127
  static LoseScreen3 + #534, #2313
  static LoseScreen3 + #535, #127
  static LoseScreen3 + #536, #2313
  static LoseScreen3 + #537, #127
  static LoseScreen3 + #538, #2313
  static LoseScreen3 + #539, #127
  static LoseScreen3 + #540, #2313
  static LoseScreen3 + #541, #2313
  static LoseScreen3 + #542, #127
  static LoseScreen3 + #543, #2313
  static LoseScreen3 + #544, #3967
  static LoseScreen3 + #545, #2313
  static LoseScreen3 + #546, #3967
  static LoseScreen3 + #547, #2313
  static LoseScreen3 + #548, #3967
  static LoseScreen3 + #549, #3967
  static LoseScreen3 + #550, #127
  static LoseScreen3 + #551, #127
  static LoseScreen3 + #552, #127
  static LoseScreen3 + #553, #127
  static LoseScreen3 + #554, #127
  static LoseScreen3 + #555, #127
  static LoseScreen3 + #556, #2313
  static LoseScreen3 + #557, #3967
  static LoseScreen3 + #558, #127
  static LoseScreen3 + #559, #127

  ;Linha 14
  static LoseScreen3 + #560, #127
  static LoseScreen3 + #561, #127
  static LoseScreen3 + #562, #127
  static LoseScreen3 + #563, #2313
  static LoseScreen3 + #564, #127
  static LoseScreen3 + #565, #2313
  static LoseScreen3 + #566, #2313
  static LoseScreen3 + #567, #127
  static LoseScreen3 + #568, #127
  static LoseScreen3 + #569, #2313
  static LoseScreen3 + #570, #127
  static LoseScreen3 + #571, #127
  static LoseScreen3 + #572, #2313
  static LoseScreen3 + #573, #2313
  static LoseScreen3 + #574, #127
  static LoseScreen3 + #575, #127
  static LoseScreen3 + #576, #2313
  static LoseScreen3 + #577, #127
  static LoseScreen3 + #578, #2313
  static LoseScreen3 + #579, #127
  static LoseScreen3 + #580, #2313
  static LoseScreen3 + #581, #127
  static LoseScreen3 + #582, #127
  static LoseScreen3 + #583, #2313
  static LoseScreen3 + #584, #3967
  static LoseScreen3 + #585, #2313
  static LoseScreen3 + #586, #3967
  static LoseScreen3 + #587, #127
  static LoseScreen3 + #588, #3967
  static LoseScreen3 + #589, #3967
  static LoseScreen3 + #590, #127
  static LoseScreen3 + #591, #127
  static LoseScreen3 + #592, #127
  static LoseScreen3 + #593, #127
  static LoseScreen3 + #594, #127
  static LoseScreen3 + #595, #127
  static LoseScreen3 + #596, #2313
  static LoseScreen3 + #597, #3967
  static LoseScreen3 + #598, #127
  static LoseScreen3 + #599, #127

  ;Linha 15
  static LoseScreen3 + #600, #127
  static LoseScreen3 + #601, #127
  static LoseScreen3 + #602, #127
  static LoseScreen3 + #603, #2313
  static LoseScreen3 + #604, #127
  static LoseScreen3 + #605, #2313
  static LoseScreen3 + #606, #127
  static LoseScreen3 + #607, #127
  static LoseScreen3 + #608, #127
  static LoseScreen3 + #609, #2313
  static LoseScreen3 + #610, #2313
  static LoseScreen3 + #611, #127
  static LoseScreen3 + #612, #2313
  static LoseScreen3 + #613, #127
  static LoseScreen3 + #614, #2313
  static LoseScreen3 + #615, #127
  static LoseScreen3 + #616, #2313
  static LoseScreen3 + #617, #2313
  static LoseScreen3 + #618, #127
  static LoseScreen3 + #619, #3967
  static LoseScreen3 + #620, #2313
  static LoseScreen3 + #621, #2313
  static LoseScreen3 + #622, #127
  static LoseScreen3 + #623, #127
  static LoseScreen3 + #624, #2313
  static LoseScreen3 + #625, #3967
  static LoseScreen3 + #626, #127
  static LoseScreen3 + #627, #2313
  static LoseScreen3 + #628, #3967
  static LoseScreen3 + #629, #3967
  static LoseScreen3 + #630, #127
  static LoseScreen3 + #631, #127
  static LoseScreen3 + #632, #127
  static LoseScreen3 + #633, #127
  static LoseScreen3 + #634, #127
  static LoseScreen3 + #635, #127
  static LoseScreen3 + #636, #2313
  static LoseScreen3 + #637, #3967
  static LoseScreen3 + #638, #127
  static LoseScreen3 + #639, #127

  ;Linha 16
  static LoseScreen3 + #640, #127
  static LoseScreen3 + #641, #127
  static LoseScreen3 + #642, #127
  static LoseScreen3 + #643, #2313
  static LoseScreen3 + #644, #127
  static LoseScreen3 + #645, #127
  static LoseScreen3 + #646, #127
  static LoseScreen3 + #647, #127
  static LoseScreen3 + #648, #127
  static LoseScreen3 + #649, #127
  static LoseScreen3 + #650, #127
  static LoseScreen3 + #651, #127
  static LoseScreen3 + #652, #127
  static LoseScreen3 + #653, #127
  static LoseScreen3 + #654, #127
  static LoseScreen3 + #655, #127
  static LoseScreen3 + #656, #127
  static LoseScreen3 + #657, #127
  static LoseScreen3 + #658, #127
  static LoseScreen3 + #659, #127
  static LoseScreen3 + #660, #127
  static LoseScreen3 + #661, #127
  static LoseScreen3 + #662, #127
  static LoseScreen3 + #663, #127
  static LoseScreen3 + #664, #127
  static LoseScreen3 + #665, #127
  static LoseScreen3 + #666, #127
  static LoseScreen3 + #667, #127
  static LoseScreen3 + #668, #127
  static LoseScreen3 + #669, #3967
  static LoseScreen3 + #670, #127
  static LoseScreen3 + #671, #127
  static LoseScreen3 + #672, #127
  static LoseScreen3 + #673, #127
  static LoseScreen3 + #674, #127
  static LoseScreen3 + #675, #127
  static LoseScreen3 + #676, #2313
  static LoseScreen3 + #677, #3967
  static LoseScreen3 + #678, #127
  static LoseScreen3 + #679, #127

  ;Linha 17
  static LoseScreen3 + #680, #127
  static LoseScreen3 + #681, #127
  static LoseScreen3 + #682, #127
  static LoseScreen3 + #683, #2313
  static LoseScreen3 + #684, #127
  static LoseScreen3 + #685, #127
  static LoseScreen3 + #686, #127
  static LoseScreen3 + #687, #127
  static LoseScreen3 + #688, #127
  static LoseScreen3 + #689, #127
  static LoseScreen3 + #690, #127
  static LoseScreen3 + #691, #127
  static LoseScreen3 + #692, #127
  static LoseScreen3 + #693, #127
  static LoseScreen3 + #694, #127
  static LoseScreen3 + #695, #127
  static LoseScreen3 + #696, #127
  static LoseScreen3 + #697, #127
  static LoseScreen3 + #698, #127
  static LoseScreen3 + #699, #127
  static LoseScreen3 + #700, #127
  static LoseScreen3 + #701, #127
  static LoseScreen3 + #702, #3967
  static LoseScreen3 + #703, #127
  static LoseScreen3 + #704, #127
  static LoseScreen3 + #705, #127
  static LoseScreen3 + #706, #127
  static LoseScreen3 + #707, #127
  static LoseScreen3 + #708, #127
  static LoseScreen3 + #709, #127
  static LoseScreen3 + #710, #127
  static LoseScreen3 + #711, #127
  static LoseScreen3 + #712, #127
  static LoseScreen3 + #713, #127
  static LoseScreen3 + #714, #127
  static LoseScreen3 + #715, #127
  static LoseScreen3 + #716, #2313
  static LoseScreen3 + #717, #127
  static LoseScreen3 + #718, #127
  static LoseScreen3 + #719, #127

  ;Linha 18
  static LoseScreen3 + #720, #127
  static LoseScreen3 + #721, #127
  static LoseScreen3 + #722, #127
  static LoseScreen3 + #723, #2313
  static LoseScreen3 + #724, #127
  static LoseScreen3 + #725, #2383
  static LoseScreen3 + #726, #127
  static LoseScreen3 + #727, #2369
  static LoseScreen3 + #728, #2375
  static LoseScreen3 + #729, #2377
  static LoseScreen3 + #730, #2383
  static LoseScreen3 + #731, #2388
  static LoseScreen3 + #732, #2369
  static LoseScreen3 + #733, #127
  static LoseScreen3 + #734, #2390
  static LoseScreen3 + #735, #2373
  static LoseScreen3 + #736, #2377
  static LoseScreen3 + #737, #2383
  static LoseScreen3 + #738, #3967
  static LoseScreen3 + #739, #2371
  static LoseScreen3 + #740, #2383
  static LoseScreen3 + #741, #2370
  static LoseScreen3 + #742, #2386
  static LoseScreen3 + #743, #2369
  static LoseScreen3 + #744, #2386
  static LoseScreen3 + #745, #3967
  static LoseScreen3 + #746, #2369
  static LoseScreen3 + #747, #3967
  static LoseScreen3 + #748, #2375
  static LoseScreen3 + #749, #2386
  static LoseScreen3 + #750, #2369
  static LoseScreen3 + #751, #2382
  static LoseScreen3 + #752, #2369
  static LoseScreen3 + #753, #3967
  static LoseScreen3 + #754, #127
  static LoseScreen3 + #755, #127
  static LoseScreen3 + #756, #2313
  static LoseScreen3 + #757, #127
  static LoseScreen3 + #758, #127
  static LoseScreen3 + #759, #127

  ;Linha 19
  static LoseScreen3 + #760, #127
  static LoseScreen3 + #761, #127
  static LoseScreen3 + #762, #127
  static LoseScreen3 + #763, #2313
  static LoseScreen3 + #764, #127
  static LoseScreen3 + #765, #127
  static LoseScreen3 + #766, #127
  static LoseScreen3 + #767, #127
  static LoseScreen3 + #768, #127
  static LoseScreen3 + #769, #127
  static LoseScreen3 + #770, #127
  static LoseScreen3 + #771, #127
  static LoseScreen3 + #772, #127
  static LoseScreen3 + #773, #127
  static LoseScreen3 + #774, #127
  static LoseScreen3 + #775, #127
  static LoseScreen3 + #776, #127
  static LoseScreen3 + #777, #127
  static LoseScreen3 + #778, #127
  static LoseScreen3 + #779, #127
  static LoseScreen3 + #780, #127
  static LoseScreen3 + #781, #127
  static LoseScreen3 + #782, #127
  static LoseScreen3 + #783, #127
  static LoseScreen3 + #784, #127
  static LoseScreen3 + #785, #127
  static LoseScreen3 + #786, #127
  static LoseScreen3 + #787, #127
  static LoseScreen3 + #788, #127
  static LoseScreen3 + #789, #127
  static LoseScreen3 + #790, #127
  static LoseScreen3 + #791, #127
  static LoseScreen3 + #792, #127
  static LoseScreen3 + #793, #127
  static LoseScreen3 + #794, #127
  static LoseScreen3 + #795, #127
  static LoseScreen3 + #796, #2313
  static LoseScreen3 + #797, #127
  static LoseScreen3 + #798, #127
  static LoseScreen3 + #799, #127

  ;Linha 20
  static LoseScreen3 + #800, #127
  static LoseScreen3 + #801, #127
  static LoseScreen3 + #802, #127
  static LoseScreen3 + #803, #2313
  static LoseScreen3 + #804, #127
  static LoseScreen3 + #805, #3967
  static LoseScreen3 + #806, #3967
  static LoseScreen3 + #807, #3967
  static LoseScreen3 + #808, #127
  static LoseScreen3 + #809, #3967
  static LoseScreen3 + #810, #3967
  static LoseScreen3 + #811, #3967
  static LoseScreen3 + #812, #3967
  static LoseScreen3 + #813, #3967
  static LoseScreen3 + #814, #3967
  static LoseScreen3 + #815, #3967
  static LoseScreen3 + #816, #3967
  static LoseScreen3 + #817, #3967
  static LoseScreen3 + #818, #3967
  static LoseScreen3 + #819, #3967
  static LoseScreen3 + #820, #3967
  static LoseScreen3 + #821, #3967
  static LoseScreen3 + #822, #3967
  static LoseScreen3 + #823, #3967
  static LoseScreen3 + #824, #3967
  static LoseScreen3 + #825, #3967
  static LoseScreen3 + #826, #3967
  static LoseScreen3 + #827, #3967
  static LoseScreen3 + #828, #3967
  static LoseScreen3 + #829, #3967
  static LoseScreen3 + #830, #3967
  static LoseScreen3 + #831, #127
  static LoseScreen3 + #832, #127
  static LoseScreen3 + #833, #127
  static LoseScreen3 + #834, #127
  static LoseScreen3 + #835, #127
  static LoseScreen3 + #836, #2313
  static LoseScreen3 + #837, #127
  static LoseScreen3 + #838, #127
  static LoseScreen3 + #839, #127

  ;Linha 21
  static LoseScreen3 + #840, #127
  static LoseScreen3 + #841, #127
  static LoseScreen3 + #842, #127
  static LoseScreen3 + #843, #2313
  static LoseScreen3 + #844, #127
  static LoseScreen3 + #845, #3967
  static LoseScreen3 + #846, #3967
  static LoseScreen3 + #847, #3967
  static LoseScreen3 + #848, #3967
  static LoseScreen3 + #849, #3967
  static LoseScreen3 + #850, #2893
  static LoseScreen3 + #851, #2881
  static LoseScreen3 + #852, #2889
  static LoseScreen3 + #853, #2899
  static LoseScreen3 + #854, #3967
  static LoseScreen3 + #855, #2899
  static LoseScreen3 + #856, #2895
  static LoseScreen3 + #857, #2898
  static LoseScreen3 + #858, #2900
  static LoseScreen3 + #859, #2885
  static LoseScreen3 + #860, #3967
  static LoseScreen3 + #861, #2894
  static LoseScreen3 + #862, #2881
  static LoseScreen3 + #863, #3967
  static LoseScreen3 + #864, #2896
  static LoseScreen3 + #865, #2898
  static LoseScreen3 + #866, #2895
  static LoseScreen3 + #867, #2904
  static LoseScreen3 + #868, #2889
  static LoseScreen3 + #869, #2893
  static LoseScreen3 + #870, #2881
  static LoseScreen3 + #871, #2849
  static LoseScreen3 + #872, #127
  static LoseScreen3 + #873, #127
  static LoseScreen3 + #874, #127
  static LoseScreen3 + #875, #127
  static LoseScreen3 + #876, #2313
  static LoseScreen3 + #877, #127
  static LoseScreen3 + #878, #127
  static LoseScreen3 + #879, #127

  ;Linha 22
  static LoseScreen3 + #880, #127
  static LoseScreen3 + #881, #127
  static LoseScreen3 + #882, #127
  static LoseScreen3 + #883, #2313
  static LoseScreen3 + #884, #127
  static LoseScreen3 + #885, #127
  static LoseScreen3 + #886, #127
  static LoseScreen3 + #887, #127
  static LoseScreen3 + #888, #127
  static LoseScreen3 + #889, #127
  static LoseScreen3 + #890, #3967
  static LoseScreen3 + #891, #3967
  static LoseScreen3 + #892, #3967
  static LoseScreen3 + #893, #3967
  static LoseScreen3 + #894, #3967
  static LoseScreen3 + #895, #3967
  static LoseScreen3 + #896, #3967
  static LoseScreen3 + #897, #3967
  static LoseScreen3 + #898, #3967
  static LoseScreen3 + #899, #127
  static LoseScreen3 + #900, #127
  static LoseScreen3 + #901, #127
  static LoseScreen3 + #902, #3967
  static LoseScreen3 + #903, #3967
  static LoseScreen3 + #904, #3967
  static LoseScreen3 + #905, #3967
  static LoseScreen3 + #906, #3967
  static LoseScreen3 + #907, #3967
  static LoseScreen3 + #908, #3967
  static LoseScreen3 + #909, #3967
  static LoseScreen3 + #910, #3967
  static LoseScreen3 + #911, #3967
  static LoseScreen3 + #912, #3967
  static LoseScreen3 + #913, #3967
  static LoseScreen3 + #914, #3967
  static LoseScreen3 + #915, #3967
  static LoseScreen3 + #916, #2313
  static LoseScreen3 + #917, #127
  static LoseScreen3 + #918, #127
  static LoseScreen3 + #919, #127

  ;Linha 23
  static LoseScreen3 + #920, #127
  static LoseScreen3 + #921, #127
  static LoseScreen3 + #922, #127
  static LoseScreen3 + #923, #2313
  static LoseScreen3 + #924, #127
  static LoseScreen3 + #925, #127
  static LoseScreen3 + #926, #127
  static LoseScreen3 + #927, #127
  static LoseScreen3 + #928, #127
  static LoseScreen3 + #929, #127
  static LoseScreen3 + #930, #127
  static LoseScreen3 + #931, #127
  static LoseScreen3 + #932, #127
  static LoseScreen3 + #933, #3967
  static LoseScreen3 + #934, #3967
  static LoseScreen3 + #935, #3967
  static LoseScreen3 + #936, #3967
  static LoseScreen3 + #937, #3967
  static LoseScreen3 + #938, #3967
  static LoseScreen3 + #939, #3967
  static LoseScreen3 + #940, #3967
  static LoseScreen3 + #941, #3967
  static LoseScreen3 + #942, #3967
  static LoseScreen3 + #943, #3967
  static LoseScreen3 + #944, #3967
  static LoseScreen3 + #945, #3967
  static LoseScreen3 + #946, #3967
  static LoseScreen3 + #947, #3967
  static LoseScreen3 + #948, #3967
  static LoseScreen3 + #949, #3967
  static LoseScreen3 + #950, #3967
  static LoseScreen3 + #951, #3967
  static LoseScreen3 + #952, #3967
  static LoseScreen3 + #953, #3967
  static LoseScreen3 + #954, #3967
  static LoseScreen3 + #955, #3967
  static LoseScreen3 + #956, #2313
  static LoseScreen3 + #957, #127
  static LoseScreen3 + #958, #127
  static LoseScreen3 + #959, #127

  ;Linha 24
  static LoseScreen3 + #960, #127
  static LoseScreen3 + #961, #127
  static LoseScreen3 + #962, #127
  static LoseScreen3 + #963, #2313
  static LoseScreen3 + #964, #2313
  static LoseScreen3 + #965, #2313
  static LoseScreen3 + #966, #2313
  static LoseScreen3 + #967, #2313
  static LoseScreen3 + #968, #2313
  static LoseScreen3 + #969, #2313
  static LoseScreen3 + #970, #2313
  static LoseScreen3 + #971, #2313
  static LoseScreen3 + #972, #2313
  static LoseScreen3 + #973, #2313
  static LoseScreen3 + #974, #2313
  static LoseScreen3 + #975, #2313
  static LoseScreen3 + #976, #2313
  static LoseScreen3 + #977, #2313
  static LoseScreen3 + #978, #2313
  static LoseScreen3 + #979, #2313
  static LoseScreen3 + #980, #2313
  static LoseScreen3 + #981, #2313
  static LoseScreen3 + #982, #2313
  static LoseScreen3 + #983, #2313
  static LoseScreen3 + #984, #2313
  static LoseScreen3 + #985, #2313
  static LoseScreen3 + #986, #2313
  static LoseScreen3 + #987, #2313
  static LoseScreen3 + #988, #2313
  static LoseScreen3 + #989, #2313
  static LoseScreen3 + #990, #2313
  static LoseScreen3 + #991, #2313
  static LoseScreen3 + #992, #2313
  static LoseScreen3 + #993, #2313
  static LoseScreen3 + #994, #2313
  static LoseScreen3 + #995, #2313
  static LoseScreen3 + #996, #2313
  static LoseScreen3 + #997, #127
  static LoseScreen3 + #998, #127
  static LoseScreen3 + #999, #127

  ;Linha 25
  static LoseScreen3 + #1000, #127
  static LoseScreen3 + #1001, #127
  static LoseScreen3 + #1002, #127
  static LoseScreen3 + #1003, #127
  static LoseScreen3 + #1004, #127
  static LoseScreen3 + #1005, #127
  static LoseScreen3 + #1006, #127
  static LoseScreen3 + #1007, #127
  static LoseScreen3 + #1008, #127
  static LoseScreen3 + #1009, #127
  static LoseScreen3 + #1010, #127
  static LoseScreen3 + #1011, #127
  static LoseScreen3 + #1012, #127
  static LoseScreen3 + #1013, #127
  static LoseScreen3 + #1014, #127
  static LoseScreen3 + #1015, #127
  static LoseScreen3 + #1016, #127
  static LoseScreen3 + #1017, #127
  static LoseScreen3 + #1018, #127
  static LoseScreen3 + #1019, #127
  static LoseScreen3 + #1020, #127
  static LoseScreen3 + #1021, #127
  static LoseScreen3 + #1022, #127
  static LoseScreen3 + #1023, #127
  static LoseScreen3 + #1024, #127
  static LoseScreen3 + #1025, #127
  static LoseScreen3 + #1026, #127
  static LoseScreen3 + #1027, #127
  static LoseScreen3 + #1028, #127
  static LoseScreen3 + #1029, #127
  static LoseScreen3 + #1030, #127
  static LoseScreen3 + #1031, #127
  static LoseScreen3 + #1032, #127
  static LoseScreen3 + #1033, #127
  static LoseScreen3 + #1034, #127
  static LoseScreen3 + #1035, #127
  static LoseScreen3 + #1036, #127
  static LoseScreen3 + #1037, #127
  static LoseScreen3 + #1038, #127
  static LoseScreen3 + #1039, #127

  ;Linha 26
  static LoseScreen3 + #1040, #127
  static LoseScreen3 + #1041, #127
  static LoseScreen3 + #1042, #127
  static LoseScreen3 + #1043, #127
  static LoseScreen3 + #1044, #127
  static LoseScreen3 + #1045, #127
  static LoseScreen3 + #1046, #127
  static LoseScreen3 + #1047, #127
  static LoseScreen3 + #1048, #127
  static LoseScreen3 + #1049, #127
  static LoseScreen3 + #1050, #127
  static LoseScreen3 + #1051, #127
  static LoseScreen3 + #1052, #127
  static LoseScreen3 + #1053, #127
  static LoseScreen3 + #1054, #127
  static LoseScreen3 + #1055, #127
  static LoseScreen3 + #1056, #127
  static LoseScreen3 + #1057, #127
  static LoseScreen3 + #1058, #127
  static LoseScreen3 + #1059, #127
  static LoseScreen3 + #1060, #127
  static LoseScreen3 + #1061, #127
  static LoseScreen3 + #1062, #127
  static LoseScreen3 + #1063, #127
  static LoseScreen3 + #1064, #127
  static LoseScreen3 + #1065, #127
  static LoseScreen3 + #1066, #127
  static LoseScreen3 + #1067, #127
  static LoseScreen3 + #1068, #127
  static LoseScreen3 + #1069, #127
  static LoseScreen3 + #1070, #127
  static LoseScreen3 + #1071, #127
  static LoseScreen3 + #1072, #127
  static LoseScreen3 + #1073, #127
  static LoseScreen3 + #1074, #127
  static LoseScreen3 + #1075, #127
  static LoseScreen3 + #1076, #127
  static LoseScreen3 + #1077, #127
  static LoseScreen3 + #1078, #127
  static LoseScreen3 + #1079, #127

  ;Linha 27
  static LoseScreen3 + #1080, #127
  static LoseScreen3 + #1081, #127
  static LoseScreen3 + #1082, #127
  static LoseScreen3 + #1083, #127
  static LoseScreen3 + #1084, #127
  static LoseScreen3 + #1085, #127
  static LoseScreen3 + #1086, #127
  static LoseScreen3 + #1087, #127
  static LoseScreen3 + #1088, #127
  static LoseScreen3 + #1089, #127
  static LoseScreen3 + #1090, #127
  static LoseScreen3 + #1091, #127
  static LoseScreen3 + #1092, #127
  static LoseScreen3 + #1093, #127
  static LoseScreen3 + #1094, #127
  static LoseScreen3 + #1095, #127
  static LoseScreen3 + #1096, #127
  static LoseScreen3 + #1097, #127
  static LoseScreen3 + #1098, #127
  static LoseScreen3 + #1099, #127
  static LoseScreen3 + #1100, #127
  static LoseScreen3 + #1101, #127
  static LoseScreen3 + #1102, #127
  static LoseScreen3 + #1103, #127
  static LoseScreen3 + #1104, #127
  static LoseScreen3 + #1105, #127
  static LoseScreen3 + #1106, #127
  static LoseScreen3 + #1107, #127
  static LoseScreen3 + #1108, #127
  static LoseScreen3 + #1109, #127
  static LoseScreen3 + #1110, #127
  static LoseScreen3 + #1111, #127
  static LoseScreen3 + #1112, #127
  static LoseScreen3 + #1113, #127
  static LoseScreen3 + #1114, #127
  static LoseScreen3 + #1115, #127
  static LoseScreen3 + #1116, #127
  static LoseScreen3 + #1117, #127
  static LoseScreen3 + #1118, #127
  static LoseScreen3 + #1119, #127

  ;Linha 28
  static LoseScreen3 + #1120, #127
  static LoseScreen3 + #1121, #127
  static LoseScreen3 + #1122, #127
  static LoseScreen3 + #1123, #127
  static LoseScreen3 + #1124, #127
  static LoseScreen3 + #1125, #127
  static LoseScreen3 + #1126, #127
  static LoseScreen3 + #1127, #127
  static LoseScreen3 + #1128, #127
  static LoseScreen3 + #1129, #127
  static LoseScreen3 + #1130, #127
  static LoseScreen3 + #1131, #127
  static LoseScreen3 + #1132, #127
  static LoseScreen3 + #1133, #127
  static LoseScreen3 + #1134, #127
  static LoseScreen3 + #1135, #127
  static LoseScreen3 + #1136, #127
  static LoseScreen3 + #1137, #127
  static LoseScreen3 + #1138, #127
  static LoseScreen3 + #1139, #127
  static LoseScreen3 + #1140, #127
  static LoseScreen3 + #1141, #127
  static LoseScreen3 + #1142, #127
  static LoseScreen3 + #1143, #127
  static LoseScreen3 + #1144, #127
  static LoseScreen3 + #1145, #127
  static LoseScreen3 + #1146, #127
  static LoseScreen3 + #1147, #127
  static LoseScreen3 + #1148, #127
  static LoseScreen3 + #1149, #127
  static LoseScreen3 + #1150, #127
  static LoseScreen3 + #1151, #127
  static LoseScreen3 + #1152, #127
  static LoseScreen3 + #1153, #127
  static LoseScreen3 + #1154, #127
  static LoseScreen3 + #1155, #127
  static LoseScreen3 + #1156, #127
  static LoseScreen3 + #1157, #127
  static LoseScreen3 + #1158, #127
  static LoseScreen3 + #1159, #127

  ;Linha 29
  static LoseScreen3 + #1160, #127
  static LoseScreen3 + #1161, #127
  static LoseScreen3 + #1162, #127
  static LoseScreen3 + #1163, #127
  static LoseScreen3 + #1164, #127
  static LoseScreen3 + #1165, #127
  static LoseScreen3 + #1166, #127
  static LoseScreen3 + #1167, #127
  static LoseScreen3 + #1168, #127
  static LoseScreen3 + #1169, #127
  static LoseScreen3 + #1170, #127
  static LoseScreen3 + #1171, #127
  static LoseScreen3 + #1172, #127
  static LoseScreen3 + #1173, #127
  static LoseScreen3 + #1174, #127
  static LoseScreen3 + #1175, #127
  static LoseScreen3 + #1176, #127
  static LoseScreen3 + #1177, #127
  static LoseScreen3 + #1178, #127
  static LoseScreen3 + #1179, #127
  static LoseScreen3 + #1180, #127
  static LoseScreen3 + #1181, #127
  static LoseScreen3 + #1182, #127
  static LoseScreen3 + #1183, #127
  static LoseScreen3 + #1184, #127
  static LoseScreen3 + #1185, #127
  static LoseScreen3 + #1186, #127
  static LoseScreen3 + #1187, #127
  static LoseScreen3 + #1188, #127
  static LoseScreen3 + #1189, #127
  static LoseScreen3 + #1190, #127
  static LoseScreen3 + #1191, #127
  static LoseScreen3 + #1192, #127
  static LoseScreen3 + #1193, #127
  static LoseScreen3 + #1194, #127
  static LoseScreen3 + #1195, #127
  static LoseScreen3 + #1196, #127
  static LoseScreen3 + #1197, #127
  static LoseScreen3 + #1198, #127
  static LoseScreen3 + #1199, #127
;

StopScreen : var #1200
  ;Linha 0
  static StopScreen + #0, #2825
  static StopScreen + #1, #2825
  static StopScreen + #2, #2825
  static StopScreen + #3, #2825
  static StopScreen + #4, #2825
  static StopScreen + #5, #2825
  static StopScreen + #6, #3967
  static StopScreen + #7, #3967
  static StopScreen + #8, #127
  static StopScreen + #9, #127
  static StopScreen + #10, #127
  static StopScreen + #11, #127
  static StopScreen + #12, #127
  static StopScreen + #13, #127
  static StopScreen + #14, #127
  static StopScreen + #15, #127
  static StopScreen + #16, #127
  static StopScreen + #17, #127
  static StopScreen + #18, #127
  static StopScreen + #19, #127
  static StopScreen + #20, #127
  static StopScreen + #21, #127
  static StopScreen + #22, #127
  static StopScreen + #23, #127
  static StopScreen + #24, #127
  static StopScreen + #25, #127
  static StopScreen + #26, #127
  static StopScreen + #27, #127
  static StopScreen + #28, #127
  static StopScreen + #29, #127
  static StopScreen + #30, #127
  static StopScreen + #31, #127
  static StopScreen + #32, #127
  static StopScreen + #33, #127
  static StopScreen + #34, #2825
  static StopScreen + #35, #2825
  static StopScreen + #36, #2825
  static StopScreen + #37, #2825
  static StopScreen + #38, #2825
  static StopScreen + #39, #2825

  ;Linha 1
  static StopScreen + #40, #2313
  static StopScreen + #41, #2825
  static StopScreen + #42, #2825
  static StopScreen + #43, #2825
  static StopScreen + #44, #2825
  static StopScreen + #45, #2313
  static StopScreen + #46, #3967
  static StopScreen + #47, #3967
  static StopScreen + #48, #127
  static StopScreen + #49, #127
  static StopScreen + #50, #127
  static StopScreen + #51, #127
  static StopScreen + #52, #127
  static StopScreen + #53, #127
  static StopScreen + #54, #127
  static StopScreen + #55, #127
  static StopScreen + #56, #127
  static StopScreen + #57, #127
  static StopScreen + #58, #127
  static StopScreen + #59, #127
  static StopScreen + #60, #127
  static StopScreen + #61, #127
  static StopScreen + #62, #127
  static StopScreen + #63, #127
  static StopScreen + #64, #127
  static StopScreen + #65, #127
  static StopScreen + #66, #127
  static StopScreen + #67, #127
  static StopScreen + #68, #127
  static StopScreen + #69, #127
  static StopScreen + #70, #127
  static StopScreen + #71, #127
  static StopScreen + #72, #127
  static StopScreen + #73, #3967
  static StopScreen + #74, #2313
  static StopScreen + #75, #2825
  static StopScreen + #76, #2825
  static StopScreen + #77, #2825
  static StopScreen + #78, #2825
  static StopScreen + #79, #2313

  ;Linha 2
  static StopScreen + #80, #2313
  static StopScreen + #81, #2825
  static StopScreen + #82, #2825
  static StopScreen + #83, #2825
  static StopScreen + #84, #2313
  static StopScreen + #85, #2313
  static StopScreen + #86, #265
  static StopScreen + #87, #265
  static StopScreen + #88, #265
  static StopScreen + #89, #265
  static StopScreen + #90, #265
  static StopScreen + #91, #265
  static StopScreen + #92, #265
  static StopScreen + #93, #265
  static StopScreen + #94, #265
  static StopScreen + #95, #265
  static StopScreen + #96, #265
  static StopScreen + #97, #265
  static StopScreen + #98, #265
  static StopScreen + #99, #265
  static StopScreen + #100, #265
  static StopScreen + #101, #265
  static StopScreen + #102, #265
  static StopScreen + #103, #265
  static StopScreen + #104, #265
  static StopScreen + #105, #265
  static StopScreen + #106, #265
  static StopScreen + #107, #265
  static StopScreen + #108, #265
  static StopScreen + #109, #265
  static StopScreen + #110, #265
  static StopScreen + #111, #265
  static StopScreen + #112, #265
  static StopScreen + #113, #265
  static StopScreen + #114, #2313
  static StopScreen + #115, #2313
  static StopScreen + #116, #2825
  static StopScreen + #117, #2825
  static StopScreen + #118, #2825
  static StopScreen + #119, #2313

  ;Linha 3
  static StopScreen + #120, #2313
  static StopScreen + #121, #2825
  static StopScreen + #122, #2313
  static StopScreen + #123, #2313
  static StopScreen + #124, #2313
  static StopScreen + #125, #2313
  static StopScreen + #126, #127
  static StopScreen + #127, #127
  static StopScreen + #128, #3967
  static StopScreen + #129, #265
  static StopScreen + #130, #265
  static StopScreen + #131, #265
  static StopScreen + #132, #265
  static StopScreen + #133, #265
  static StopScreen + #134, #265
  static StopScreen + #135, #265
  static StopScreen + #136, #265
  static StopScreen + #137, #265
  static StopScreen + #138, #265
  static StopScreen + #139, #265
  static StopScreen + #140, #265
  static StopScreen + #141, #265
  static StopScreen + #142, #265
  static StopScreen + #143, #265
  static StopScreen + #144, #265
  static StopScreen + #145, #265
  static StopScreen + #146, #265
  static StopScreen + #147, #265
  static StopScreen + #148, #265
  static StopScreen + #149, #265
  static StopScreen + #150, #265
  static StopScreen + #151, #3967
  static StopScreen + #152, #3967
  static StopScreen + #153, #3967
  static StopScreen + #154, #2313
  static StopScreen + #155, #2313
  static StopScreen + #156, #2313
  static StopScreen + #157, #2313
  static StopScreen + #158, #2825
  static StopScreen + #159, #2313

  ;Linha 4
  static StopScreen + #160, #2313
  static StopScreen + #161, #2825
  static StopScreen + #162, #2313
  static StopScreen + #163, #2313
  static StopScreen + #164, #2313
  static StopScreen + #165, #2313
  static StopScreen + #166, #127
  static StopScreen + #167, #127
  static StopScreen + #168, #127
  static StopScreen + #169, #265
  static StopScreen + #170, #265
  static StopScreen + #171, #265
  static StopScreen + #172, #265
  static StopScreen + #173, #265
  static StopScreen + #174, #265
  static StopScreen + #175, #265
  static StopScreen + #176, #265
  static StopScreen + #177, #265
  static StopScreen + #178, #265
  static StopScreen + #179, #265
  static StopScreen + #180, #265
  static StopScreen + #181, #265
  static StopScreen + #182, #265
  static StopScreen + #183, #265
  static StopScreen + #184, #265
  static StopScreen + #185, #265
  static StopScreen + #186, #265
  static StopScreen + #187, #265
  static StopScreen + #188, #265
  static StopScreen + #189, #265
  static StopScreen + #190, #265
  static StopScreen + #191, #3967
  static StopScreen + #192, #3967
  static StopScreen + #193, #3967
  static StopScreen + #194, #2313
  static StopScreen + #195, #2313
  static StopScreen + #196, #2313
  static StopScreen + #197, #2313
  static StopScreen + #198, #2825
  static StopScreen + #199, #2313

  ;Linha 5
  static StopScreen + #200, #2313
  static StopScreen + #201, #2825
  static StopScreen + #202, #2313
  static StopScreen + #203, #2313
  static StopScreen + #204, #2313
  static StopScreen + #205, #2313
  static StopScreen + #206, #127
  static StopScreen + #207, #127
  static StopScreen + #208, #127
  static StopScreen + #209, #265
  static StopScreen + #210, #265
  static StopScreen + #211, #265
  static StopScreen + #212, #2825
  static StopScreen + #213, #2825
  static StopScreen + #214, #2825
  static StopScreen + #215, #3967
  static StopScreen + #216, #2825
  static StopScreen + #217, #2825
  static StopScreen + #218, #2825
  static StopScreen + #219, #3967
  static StopScreen + #220, #2825
  static StopScreen + #221, #2825
  static StopScreen + #222, #2825
  static StopScreen + #223, #3967
  static StopScreen + #224, #2825
  static StopScreen + #225, #2825
  static StopScreen + #226, #2825
  static StopScreen + #227, #3967
  static StopScreen + #228, #265
  static StopScreen + #229, #265
  static StopScreen + #230, #265
  static StopScreen + #231, #3967
  static StopScreen + #232, #3967
  static StopScreen + #233, #3967
  static StopScreen + #234, #2313
  static StopScreen + #235, #2313
  static StopScreen + #236, #2313
  static StopScreen + #237, #2313
  static StopScreen + #238, #2825
  static StopScreen + #239, #2313

  ;Linha 6
  static StopScreen + #240, #2313
  static StopScreen + #241, #2825
  static StopScreen + #242, #2313
  static StopScreen + #243, #2313
  static StopScreen + #244, #2313
  static StopScreen + #245, #2313
  static StopScreen + #246, #127
  static StopScreen + #247, #127
  static StopScreen + #248, #265
  static StopScreen + #249, #265
  static StopScreen + #250, #265
  static StopScreen + #251, #265
  static StopScreen + #252, #265
  static StopScreen + #253, #2825
  static StopScreen + #254, #3967
  static StopScreen + #255, #265
  static StopScreen + #256, #2825
  static StopScreen + #257, #3967
  static StopScreen + #258, #2825
  static StopScreen + #259, #3967
  static StopScreen + #260, #2825
  static StopScreen + #261, #3967
  static StopScreen + #262, #3967
  static StopScreen + #263, #3967
  static StopScreen + #264, #2825
  static StopScreen + #265, #3967
  static StopScreen + #266, #2825
  static StopScreen + #267, #3967
  static StopScreen + #268, #265
  static StopScreen + #269, #265
  static StopScreen + #270, #265
  static StopScreen + #271, #265
  static StopScreen + #272, #3967
  static StopScreen + #273, #3967
  static StopScreen + #274, #2313
  static StopScreen + #275, #2313
  static StopScreen + #276, #2313
  static StopScreen + #277, #2313
  static StopScreen + #278, #2825
  static StopScreen + #279, #2313

  ;Linha 7
  static StopScreen + #280, #2313
  static StopScreen + #281, #2313
  static StopScreen + #282, #2313
  static StopScreen + #283, #2313
  static StopScreen + #284, #2313
  static StopScreen + #285, #2313
  static StopScreen + #286, #127
  static StopScreen + #287, #265
  static StopScreen + #288, #265
  static StopScreen + #289, #265
  static StopScreen + #290, #265
  static StopScreen + #291, #2825
  static StopScreen + #292, #3967
  static StopScreen + #293, #2825
  static StopScreen + #294, #3967
  static StopScreen + #295, #265
  static StopScreen + #296, #2825
  static StopScreen + #297, #3967
  static StopScreen + #298, #2825
  static StopScreen + #299, #3967
  static StopScreen + #300, #2825
  static StopScreen + #301, #3967
  static StopScreen + #302, #2825
  static StopScreen + #303, #3967
  static StopScreen + #304, #2825
  static StopScreen + #305, #3967
  static StopScreen + #306, #2825
  static StopScreen + #307, #3967
  static StopScreen + #308, #265
  static StopScreen + #309, #265
  static StopScreen + #310, #265
  static StopScreen + #311, #265
  static StopScreen + #312, #265
  static StopScreen + #313, #3967
  static StopScreen + #314, #2313
  static StopScreen + #315, #2313
  static StopScreen + #316, #2313
  static StopScreen + #317, #2313
  static StopScreen + #318, #2313
  static StopScreen + #319, #2313

  ;Linha 8
  static StopScreen + #320, #2313
  static StopScreen + #321, #2825
  static StopScreen + #322, #2313
  static StopScreen + #323, #2313
  static StopScreen + #324, #2313
  static StopScreen + #325, #2313
  static StopScreen + #326, #265
  static StopScreen + #327, #265
  static StopScreen + #328, #265
  static StopScreen + #329, #265
  static StopScreen + #330, #265
  static StopScreen + #331, #2825
  static StopScreen + #332, #2825
  static StopScreen + #333, #2825
  static StopScreen + #334, #3967
  static StopScreen + #335, #265
  static StopScreen + #336, #2825
  static StopScreen + #337, #2825
  static StopScreen + #338, #2825
  static StopScreen + #339, #3967
  static StopScreen + #340, #2825
  static StopScreen + #341, #2825
  static StopScreen + #342, #2825
  static StopScreen + #343, #3967
  static StopScreen + #344, #2825
  static StopScreen + #345, #2825
  static StopScreen + #346, #2825
  static StopScreen + #347, #3967
  static StopScreen + #348, #265
  static StopScreen + #349, #265
  static StopScreen + #350, #265
  static StopScreen + #351, #265
  static StopScreen + #352, #265
  static StopScreen + #353, #265
  static StopScreen + #354, #2313
  static StopScreen + #355, #2313
  static StopScreen + #356, #2313
  static StopScreen + #357, #2313
  static StopScreen + #358, #2825
  static StopScreen + #359, #2313

  ;Linha 9
  static StopScreen + #360, #2313
  static StopScreen + #361, #2313
  static StopScreen + #362, #2313
  static StopScreen + #363, #2313
  static StopScreen + #364, #2313
  static StopScreen + #365, #2313
  static StopScreen + #366, #265
  static StopScreen + #367, #265
  static StopScreen + #368, #265
  static StopScreen + #369, #265
  static StopScreen + #370, #265
  static StopScreen + #371, #265
  static StopScreen + #372, #265
  static StopScreen + #373, #265
  static StopScreen + #374, #265
  static StopScreen + #375, #265
  static StopScreen + #376, #265
  static StopScreen + #377, #265
  static StopScreen + #378, #265
  static StopScreen + #379, #265
  static StopScreen + #380, #265
  static StopScreen + #381, #265
  static StopScreen + #382, #265
  static StopScreen + #383, #265
  static StopScreen + #384, #265
  static StopScreen + #385, #265
  static StopScreen + #386, #265
  static StopScreen + #387, #265
  static StopScreen + #388, #265
  static StopScreen + #389, #265
  static StopScreen + #390, #265
  static StopScreen + #391, #265
  static StopScreen + #392, #265
  static StopScreen + #393, #265
  static StopScreen + #394, #2313
  static StopScreen + #395, #2313
  static StopScreen + #396, #2313
  static StopScreen + #397, #2313
  static StopScreen + #398, #2313
  static StopScreen + #399, #2313

  ;Linha 10
  static StopScreen + #400, #2313
  static StopScreen + #401, #2313
  static StopScreen + #402, #2313
  static StopScreen + #403, #2313
  static StopScreen + #404, #2313
  static StopScreen + #405, #2313
  static StopScreen + #406, #265
  static StopScreen + #407, #2825
  static StopScreen + #408, #2825
  static StopScreen + #409, #265
  static StopScreen + #410, #265
  static StopScreen + #411, #265
  static StopScreen + #412, #2825
  static StopScreen + #413, #265
  static StopScreen + #414, #265
  static StopScreen + #415, #2825
  static StopScreen + #416, #265
  static StopScreen + #417, #2825
  static StopScreen + #418, #265
  static StopScreen + #419, #2825
  static StopScreen + #420, #2825
  static StopScreen + #421, #265
  static StopScreen + #422, #265
  static StopScreen + #423, #2825
  static StopScreen + #424, #265
  static StopScreen + #425, #265
  static StopScreen + #426, #2825
  static StopScreen + #427, #2825
  static StopScreen + #428, #265
  static StopScreen + #429, #265
  static StopScreen + #430, #2825
  static StopScreen + #431, #2825
  static StopScreen + #432, #2825
  static StopScreen + #433, #265
  static StopScreen + #434, #2313
  static StopScreen + #435, #2313
  static StopScreen + #436, #2313
  static StopScreen + #437, #2313
  static StopScreen + #438, #2313
  static StopScreen + #439, #2313

  ;Linha 11
  static StopScreen + #440, #2313
  static StopScreen + #441, #2313
  static StopScreen + #442, #2313
  static StopScreen + #443, #2313
  static StopScreen + #444, #2313
  static StopScreen + #445, #2313
  static StopScreen + #446, #265
  static StopScreen + #447, #2825
  static StopScreen + #448, #265
  static StopScreen + #449, #2825
  static StopScreen + #450, #265
  static StopScreen + #451, #2825
  static StopScreen + #452, #265
  static StopScreen + #453, #2825
  static StopScreen + #454, #265
  static StopScreen + #455, #2825
  static StopScreen + #456, #265
  static StopScreen + #457, #2825
  static StopScreen + #458, #265
  static StopScreen + #459, #2825
  static StopScreen + #460, #265
  static StopScreen + #461, #265
  static StopScreen + #462, #2825
  static StopScreen + #463, #265
  static StopScreen + #464, #2825
  static StopScreen + #465, #265
  static StopScreen + #466, #2825
  static StopScreen + #467, #265
  static StopScreen + #468, #2825
  static StopScreen + #469, #265
  static StopScreen + #470, #2825
  static StopScreen + #471, #265
  static StopScreen + #472, #2825
  static StopScreen + #473, #265
  static StopScreen + #474, #2313
  static StopScreen + #475, #2313
  static StopScreen + #476, #2313
  static StopScreen + #477, #2313
  static StopScreen + #478, #2313
  static StopScreen + #479, #2313

  ;Linha 12
  static StopScreen + #480, #2313
  static StopScreen + #481, #2313
  static StopScreen + #482, #2313
  static StopScreen + #483, #2313
  static StopScreen + #484, #2313
  static StopScreen + #485, #2313
  static StopScreen + #486, #265
  static StopScreen + #487, #2825
  static StopScreen + #488, #2825
  static StopScreen + #489, #265
  static StopScreen + #490, #265
  static StopScreen + #491, #2825
  static StopScreen + #492, #2825
  static StopScreen + #493, #2825
  static StopScreen + #494, #265
  static StopScreen + #495, #2825
  static StopScreen + #496, #265
  static StopScreen + #497, #2825
  static StopScreen + #498, #265
  static StopScreen + #499, #265
  static StopScreen + #500, #2825
  static StopScreen + #501, #265
  static StopScreen + #502, #2825
  static StopScreen + #503, #2825
  static StopScreen + #504, #2825
  static StopScreen + #505, #265
  static StopScreen + #506, #2825
  static StopScreen + #507, #265
  static StopScreen + #508, #2825
  static StopScreen + #509, #265
  static StopScreen + #510, #2825
  static StopScreen + #511, #265
  static StopScreen + #512, #2825
  static StopScreen + #513, #265
  static StopScreen + #514, #2313
  static StopScreen + #515, #2313
  static StopScreen + #516, #2313
  static StopScreen + #517, #2313
  static StopScreen + #518, #2313
  static StopScreen + #519, #2313

  ;Linha 13
  static StopScreen + #520, #2313
  static StopScreen + #521, #2313
  static StopScreen + #522, #2313
  static StopScreen + #523, #2313
  static StopScreen + #524, #2313
  static StopScreen + #525, #2313
  static StopScreen + #526, #265
  static StopScreen + #527, #2825
  static StopScreen + #528, #265
  static StopScreen + #529, #265
  static StopScreen + #530, #265
  static StopScreen + #531, #2825
  static StopScreen + #532, #265
  static StopScreen + #533, #2825
  static StopScreen + #534, #265
  static StopScreen + #535, #265
  static StopScreen + #536, #2825
  static StopScreen + #537, #265
  static StopScreen + #538, #265
  static StopScreen + #539, #2825
  static StopScreen + #540, #2825
  static StopScreen + #541, #265
  static StopScreen + #542, #2825
  static StopScreen + #543, #265
  static StopScreen + #544, #2825
  static StopScreen + #545, #265
  static StopScreen + #546, #2825
  static StopScreen + #547, #2825
  static StopScreen + #548, #265
  static StopScreen + #549, #265
  static StopScreen + #550, #2825
  static StopScreen + #551, #2825
  static StopScreen + #552, #2825
  static StopScreen + #553, #265
  static StopScreen + #554, #2313
  static StopScreen + #555, #2313
  static StopScreen + #556, #2313
  static StopScreen + #557, #2313
  static StopScreen + #558, #2313
  static StopScreen + #559, #2313

  ;Linha 14
  static StopScreen + #560, #2313
  static StopScreen + #561, #2313
  static StopScreen + #562, #2313
  static StopScreen + #563, #2313
  static StopScreen + #564, #2313
  static StopScreen + #565, #2313
  static StopScreen + #566, #3967
  static StopScreen + #567, #265
  static StopScreen + #568, #265
  static StopScreen + #569, #265
  static StopScreen + #570, #265
  static StopScreen + #571, #265
  static StopScreen + #572, #265
  static StopScreen + #573, #265
  static StopScreen + #574, #265
  static StopScreen + #575, #265
  static StopScreen + #576, #265
  static StopScreen + #577, #265
  static StopScreen + #578, #265
  static StopScreen + #579, #265
  static StopScreen + #580, #265
  static StopScreen + #581, #265
  static StopScreen + #582, #265
  static StopScreen + #583, #265
  static StopScreen + #584, #265
  static StopScreen + #585, #265
  static StopScreen + #586, #265
  static StopScreen + #587, #265
  static StopScreen + #588, #265
  static StopScreen + #589, #265
  static StopScreen + #590, #265
  static StopScreen + #591, #265
  static StopScreen + #592, #265
  static StopScreen + #593, #265
  static StopScreen + #594, #2313
  static StopScreen + #595, #2313
  static StopScreen + #596, #2313
  static StopScreen + #597, #2313
  static StopScreen + #598, #2313
  static StopScreen + #599, #2313

  ;Linha 15
  static StopScreen + #600, #2313
  static StopScreen + #601, #2313
  static StopScreen + #602, #2313
  static StopScreen + #603, #2313
  static StopScreen + #604, #2313
  static StopScreen + #605, #2313
  static StopScreen + #606, #127
  static StopScreen + #607, #127
  static StopScreen + #608, #265
  static StopScreen + #609, #265
  static StopScreen + #610, #265
  static StopScreen + #611, #265
  static StopScreen + #612, #265
  static StopScreen + #613, #265
  static StopScreen + #614, #265
  static StopScreen + #615, #265
  static StopScreen + #616, #265
  static StopScreen + #617, #265
  static StopScreen + #618, #265
  static StopScreen + #619, #265
  static StopScreen + #620, #265
  static StopScreen + #621, #265
  static StopScreen + #622, #265
  static StopScreen + #623, #265
  static StopScreen + #624, #265
  static StopScreen + #625, #265
  static StopScreen + #626, #265
  static StopScreen + #627, #265
  static StopScreen + #628, #265
  static StopScreen + #629, #265
  static StopScreen + #630, #265
  static StopScreen + #631, #265
  static StopScreen + #632, #265
  static StopScreen + #633, #3967
  static StopScreen + #634, #2313
  static StopScreen + #635, #2313
  static StopScreen + #636, #2313
  static StopScreen + #637, #2313
  static StopScreen + #638, #2313
  static StopScreen + #639, #2313

  ;Linha 16
  static StopScreen + #640, #2313
  static StopScreen + #641, #2313
  static StopScreen + #642, #2313
  static StopScreen + #643, #2313
  static StopScreen + #644, #2313
  static StopScreen + #645, #2313
  static StopScreen + #646, #127
  static StopScreen + #647, #127
  static StopScreen + #648, #3967
  static StopScreen + #649, #265
  static StopScreen + #650, #265
  static StopScreen + #651, #265
  static StopScreen + #652, #265
  static StopScreen + #653, #265
  static StopScreen + #654, #265
  static StopScreen + #655, #265
  static StopScreen + #656, #1801
  static StopScreen + #657, #265
  static StopScreen + #658, #1801
  static StopScreen + #659, #265
  static StopScreen + #660, #265
  static StopScreen + #661, #265
  static StopScreen + #662, #265
  static StopScreen + #663, #265
  static StopScreen + #664, #265
  static StopScreen + #665, #265
  static StopScreen + #666, #265
  static StopScreen + #667, #265
  static StopScreen + #668, #265
  static StopScreen + #669, #265
  static StopScreen + #670, #127
  static StopScreen + #671, #3967
  static StopScreen + #672, #127
  static StopScreen + #673, #3967
  static StopScreen + #674, #2313
  static StopScreen + #675, #2313
  static StopScreen + #676, #2313
  static StopScreen + #677, #2313
  static StopScreen + #678, #2313
  static StopScreen + #679, #2313

  ;Linha 17
  static StopScreen + #680, #2313
  static StopScreen + #681, #2313
  static StopScreen + #682, #2313
  static StopScreen + #683, #2313
  static StopScreen + #684, #2313
  static StopScreen + #685, #2313
  static StopScreen + #686, #127
  static StopScreen + #687, #3967
  static StopScreen + #688, #3967
  static StopScreen + #689, #3967
  static StopScreen + #690, #127
  static StopScreen + #691, #3967
  static StopScreen + #692, #127
  static StopScreen + #693, #127
  static StopScreen + #694, #3967
  static StopScreen + #695, #127
  static StopScreen + #696, #1801
  static StopScreen + #697, #127
  static StopScreen + #698, #1801
  static StopScreen + #699, #127
  static StopScreen + #700, #127
  static StopScreen + #701, #127
  static StopScreen + #702, #127
  static StopScreen + #703, #127
  static StopScreen + #704, #127
  static StopScreen + #705, #127
  static StopScreen + #706, #3967
  static StopScreen + #707, #127
  static StopScreen + #708, #3967
  static StopScreen + #709, #3967
  static StopScreen + #710, #3967
  static StopScreen + #711, #3967
  static StopScreen + #712, #3967
  static StopScreen + #713, #127
  static StopScreen + #714, #2313
  static StopScreen + #715, #2313
  static StopScreen + #716, #2313
  static StopScreen + #717, #2313
  static StopScreen + #718, #2313
  static StopScreen + #719, #2313

  ;Linha 18
  static StopScreen + #720, #2313
  static StopScreen + #721, #2313
  static StopScreen + #722, #2313
  static StopScreen + #723, #2313
  static StopScreen + #724, #2313
  static StopScreen + #725, #2313
  static StopScreen + #726, #127
  static StopScreen + #727, #3967
  static StopScreen + #728, #3967
  static StopScreen + #729, #3967
  static StopScreen + #730, #127
  static StopScreen + #731, #127
  static StopScreen + #732, #127
  static StopScreen + #733, #127
  static StopScreen + #734, #127
  static StopScreen + #735, #127
  static StopScreen + #736, #1801
  static StopScreen + #737, #3967
  static StopScreen + #738, #3967
  static StopScreen + #739, #127
  static StopScreen + #740, #127
  static StopScreen + #741, #127
  static StopScreen + #742, #127
  static StopScreen + #743, #127
  static StopScreen + #744, #127
  static StopScreen + #745, #3967
  static StopScreen + #746, #3967
  static StopScreen + #747, #127
  static StopScreen + #748, #127
  static StopScreen + #749, #3967
  static StopScreen + #750, #3967
  static StopScreen + #751, #3967
  static StopScreen + #752, #3967
  static StopScreen + #753, #127
  static StopScreen + #754, #2313
  static StopScreen + #755, #2313
  static StopScreen + #756, #2313
  static StopScreen + #757, #2313
  static StopScreen + #758, #2313
  static StopScreen + #759, #2313

  ;Linha 19
  static StopScreen + #760, #2313
  static StopScreen + #761, #2313
  static StopScreen + #762, #2313
  static StopScreen + #763, #2313
  static StopScreen + #764, #2313
  static StopScreen + #765, #2313
  static StopScreen + #766, #3967
  static StopScreen + #767, #3967
  static StopScreen + #768, #3967
  static StopScreen + #769, #127
  static StopScreen + #770, #127
  static StopScreen + #771, #127
  static StopScreen + #772, #127
  static StopScreen + #773, #127
  static StopScreen + #774, #3967
  static StopScreen + #775, #9
  static StopScreen + #776, #9
  static StopScreen + #777, #1801
  static StopScreen + #778, #9
  static StopScreen + #779, #127
  static StopScreen + #780, #127
  static StopScreen + #781, #127
  static StopScreen + #782, #80
  static StopScreen + #783, #65
  static StopScreen + #784, #85
  static StopScreen + #785, #83
  static StopScreen + #786, #65
  static StopScreen + #787, #127
  static StopScreen + #788, #3967
  static StopScreen + #789, #127
  static StopScreen + #790, #3967
  static StopScreen + #791, #3967
  static StopScreen + #792, #3967
  static StopScreen + #793, #3967
  static StopScreen + #794, #2313
  static StopScreen + #795, #2313
  static StopScreen + #796, #2313
  static StopScreen + #797, #2313
  static StopScreen + #798, #2313
  static StopScreen + #799, #2313

  ;Linha 20
  static StopScreen + #800, #2313
  static StopScreen + #801, #2313
  static StopScreen + #802, #2313
  static StopScreen + #803, #2313
  static StopScreen + #804, #2313
  static StopScreen + #805, #2313
  static StopScreen + #806, #3967
  static StopScreen + #807, #3967
  static StopScreen + #808, #127
  static StopScreen + #809, #127
  static StopScreen + #810, #127
  static StopScreen + #811, #127
  static StopScreen + #812, #127
  static StopScreen + #813, #127
  static StopScreen + #814, #9
  static StopScreen + #815, #265
  static StopScreen + #816, #265
  static StopScreen + #817, #1801
  static StopScreen + #818, #265
  static StopScreen + #819, #9
  static StopScreen + #820, #127
  static StopScreen + #821, #127
  static StopScreen + #822, #127
  static StopScreen + #823, #127
  static StopScreen + #824, #3967
  static StopScreen + #825, #3967
  static StopScreen + #826, #3967
  static StopScreen + #827, #3967
  static StopScreen + #828, #3967
  static StopScreen + #829, #3967
  static StopScreen + #830, #3967
  static StopScreen + #831, #3967
  static StopScreen + #832, #3967
  static StopScreen + #833, #3967
  static StopScreen + #834, #2313
  static StopScreen + #835, #2313
  static StopScreen + #836, #2313
  static StopScreen + #837, #2313
  static StopScreen + #838, #2313
  static StopScreen + #839, #2313

  ;Linha 21
  static StopScreen + #840, #2313
  static StopScreen + #841, #2313
  static StopScreen + #842, #2313
  static StopScreen + #843, #2313
  static StopScreen + #844, #2313
  static StopScreen + #845, #3967
  static StopScreen + #846, #127
  static StopScreen + #847, #127
  static StopScreen + #848, #127
  static StopScreen + #849, #127
  static StopScreen + #850, #127
  static StopScreen + #851, #127
  static StopScreen + #852, #127
  static StopScreen + #853, #127
  static StopScreen + #854, #9
  static StopScreen + #855, #265
  static StopScreen + #856, #265
  static StopScreen + #857, #265
  static StopScreen + #858, #265
  static StopScreen + #859, #9
  static StopScreen + #860, #9
  static StopScreen + #861, #127
  static StopScreen + #862, #127
  static StopScreen + #863, #80
  static StopScreen + #864, #82
  static StopScreen + #865, #79
  static StopScreen + #866, #127
  static StopScreen + #867, #127
  static StopScreen + #868, #127
  static StopScreen + #869, #127
  static StopScreen + #870, #127
  static StopScreen + #871, #127
  static StopScreen + #872, #127
  static StopScreen + #873, #3967
  static StopScreen + #874, #3967
  static StopScreen + #875, #2313
  static StopScreen + #876, #2313
  static StopScreen + #877, #2313
  static StopScreen + #878, #2313
  static StopScreen + #879, #2313

  ;Linha 22
  static StopScreen + #880, #2313
  static StopScreen + #881, #2313
  static StopScreen + #882, #2313
  static StopScreen + #883, #2313
  static StopScreen + #884, #2313
  static StopScreen + #885, #3967
  static StopScreen + #886, #127
  static StopScreen + #887, #127
  static StopScreen + #888, #127
  static StopScreen + #889, #127
  static StopScreen + #890, #127
  static StopScreen + #891, #127
  static StopScreen + #892, #127
  static StopScreen + #893, #127
  static StopScreen + #894, #9
  static StopScreen + #895, #9
  static StopScreen + #896, #9
  static StopScreen + #897, #9
  static StopScreen + #898, #9
  static StopScreen + #899, #9
  static StopScreen + #900, #3967
  static StopScreen + #901, #9
  static StopScreen + #902, #127
  static StopScreen + #903, #127
  static StopScreen + #904, #127
  static StopScreen + #905, #127
  static StopScreen + #906, #127
  static StopScreen + #907, #44
  static StopScreen + #908, #127
  static StopScreen + #909, #127
  static StopScreen + #910, #127
  static StopScreen + #911, #127
  static StopScreen + #912, #127
  static StopScreen + #913, #3967
  static StopScreen + #914, #3967
  static StopScreen + #915, #2313
  static StopScreen + #916, #2313
  static StopScreen + #917, #2313
  static StopScreen + #918, #2313
  static StopScreen + #919, #2313

  ;Linha 23
  static StopScreen + #920, #2313
  static StopScreen + #921, #2313
  static StopScreen + #922, #2313
  static StopScreen + #923, #2313
  static StopScreen + #924, #3967
  static StopScreen + #925, #3967
  static StopScreen + #926, #127
  static StopScreen + #927, #127
  static StopScreen + #928, #127
  static StopScreen + #929, #127
  static StopScreen + #930, #127
  static StopScreen + #931, #127
  static StopScreen + #932, #127
  static StopScreen + #933, #127
  static StopScreen + #934, #9
  static StopScreen + #935, #9
  static StopScreen + #936, #9
  static StopScreen + #937, #9
  static StopScreen + #938, #9
  static StopScreen + #939, #9
  static StopScreen + #940, #127
  static StopScreen + #941, #9
  static StopScreen + #942, #127
  static StopScreen + #943, #127
  static StopScreen + #944, #67
  static StopScreen + #945, #65
  static StopScreen + #946, #70
  static StopScreen + #947, #69
  static StopScreen + #948, #3967
  static StopScreen + #949, #63
  static StopScreen + #950, #63
  static StopScreen + #951, #127
  static StopScreen + #952, #127
  static StopScreen + #953, #3967
  static StopScreen + #954, #3967
  static StopScreen + #955, #3967
  static StopScreen + #956, #2313
  static StopScreen + #957, #2313
  static StopScreen + #958, #2313
  static StopScreen + #959, #2313

  ;Linha 24
  static StopScreen + #960, #2313
  static StopScreen + #961, #2313
  static StopScreen + #962, #2313
  static StopScreen + #963, #2313
  static StopScreen + #964, #3967
  static StopScreen + #965, #3967
  static StopScreen + #966, #127
  static StopScreen + #967, #127
  static StopScreen + #968, #127
  static StopScreen + #969, #127
  static StopScreen + #970, #127
  static StopScreen + #971, #127
  static StopScreen + #972, #127
  static StopScreen + #973, #127
  static StopScreen + #974, #9
  static StopScreen + #975, #9
  static StopScreen + #976, #9
  static StopScreen + #977, #9
  static StopScreen + #978, #9
  static StopScreen + #979, #9
  static StopScreen + #980, #9
  static StopScreen + #981, #3967
  static StopScreen + #982, #127
  static StopScreen + #983, #127
  static StopScreen + #984, #127
  static StopScreen + #985, #127
  static StopScreen + #986, #127
  static StopScreen + #987, #127
  static StopScreen + #988, #127
  static StopScreen + #989, #127
  static StopScreen + #990, #127
  static StopScreen + #991, #127
  static StopScreen + #992, #127
  static StopScreen + #993, #3967
  static StopScreen + #994, #3967
  static StopScreen + #995, #3967
  static StopScreen + #996, #2313
  static StopScreen + #997, #2313
  static StopScreen + #998, #2313
  static StopScreen + #999, #2313

  ;Linha 25
  static StopScreen + #1000, #2313
  static StopScreen + #1001, #2313
  static StopScreen + #1002, #2313
  static StopScreen + #1003, #3967
  static StopScreen + #1004, #3967
  static StopScreen + #1005, #3967
  static StopScreen + #1006, #127
  static StopScreen + #1007, #127
  static StopScreen + #1008, #127
  static StopScreen + #1009, #127
  static StopScreen + #1010, #127
  static StopScreen + #1011, #127
  static StopScreen + #1012, #127
  static StopScreen + #1013, #127
  static StopScreen + #1014, #3967
  static StopScreen + #1015, #9
  static StopScreen + #1016, #9
  static StopScreen + #1017, #9
  static StopScreen + #1018, #9
  static StopScreen + #1019, #3967
  static StopScreen + #1020, #3967
  static StopScreen + #1021, #3967
  static StopScreen + #1022, #127
  static StopScreen + #1023, #127
  static StopScreen + #1024, #127
  static StopScreen + #1025, #3967
  static StopScreen + #1026, #3967
  static StopScreen + #1027, #127
  static StopScreen + #1028, #127
  static StopScreen + #1029, #127
  static StopScreen + #1030, #127
  static StopScreen + #1031, #127
  static StopScreen + #1032, #127
  static StopScreen + #1033, #3967
  static StopScreen + #1034, #3967
  static StopScreen + #1035, #3967
  static StopScreen + #1036, #3967
  static StopScreen + #1037, #2313
  static StopScreen + #1038, #2313
  static StopScreen + #1039, #2313

  ;Linha 26
  static StopScreen + #1040, #2313
  static StopScreen + #1041, #2313
  static StopScreen + #1042, #2313
  static StopScreen + #1043, #3967
  static StopScreen + #1044, #3967
  static StopScreen + #1045, #3967
  static StopScreen + #1046, #127
  static StopScreen + #1047, #127
  static StopScreen + #1048, #127
  static StopScreen + #1049, #127
  static StopScreen + #1050, #127
  static StopScreen + #1051, #127
  static StopScreen + #1052, #127
  static StopScreen + #1053, #127
  static StopScreen + #1054, #127
  static StopScreen + #1055, #127
  static StopScreen + #1056, #127
  static StopScreen + #1057, #127
  static StopScreen + #1058, #127
  static StopScreen + #1059, #127
  static StopScreen + #1060, #127
  static StopScreen + #1061, #127
  static StopScreen + #1062, #127
  static StopScreen + #1063, #127
  static StopScreen + #1064, #127
  static StopScreen + #1065, #3967
  static StopScreen + #1066, #3967
  static StopScreen + #1067, #3967
  static StopScreen + #1068, #3967
  static StopScreen + #1069, #3967
  static StopScreen + #1070, #3967
  static StopScreen + #1071, #127
  static StopScreen + #1072, #3967
  static StopScreen + #1073, #3967
  static StopScreen + #1074, #3967
  static StopScreen + #1075, #3967
  static StopScreen + #1076, #3967
  static StopScreen + #1077, #2313
  static StopScreen + #1078, #2313
  static StopScreen + #1079, #2313

  ;Linha 27
  static StopScreen + #1080, #2313
  static StopScreen + #1081, #2313
  static StopScreen + #1082, #3967
  static StopScreen + #1083, #3967
  static StopScreen + #1084, #3967
  static StopScreen + #1085, #3967
  static StopScreen + #1086, #127
  static StopScreen + #1087, #3967
  static StopScreen + #1088, #127
  static StopScreen + #1089, #127
  static StopScreen + #1090, #3967
  static StopScreen + #1091, #127
  static StopScreen + #1092, #127
  static StopScreen + #1093, #127
  static StopScreen + #1094, #127
  static StopScreen + #1095, #127
  static StopScreen + #1096, #127
  static StopScreen + #1097, #127
  static StopScreen + #1098, #127
  static StopScreen + #1099, #127
  static StopScreen + #1100, #127
  static StopScreen + #1101, #127
  static StopScreen + #1102, #127
  static StopScreen + #1103, #127
  static StopScreen + #1104, #127
  static StopScreen + #1105, #127
  static StopScreen + #1106, #127
  static StopScreen + #1107, #127
  static StopScreen + #1108, #127
  static StopScreen + #1109, #127
  static StopScreen + #1110, #3967
  static StopScreen + #1111, #3967
  static StopScreen + #1112, #3967
  static StopScreen + #1113, #3967
  static StopScreen + #1114, #3967
  static StopScreen + #1115, #3967
  static StopScreen + #1116, #3967
  static StopScreen + #1117, #3967
  static StopScreen + #1118, #2313
  static StopScreen + #1119, #2313

  ;Linha 28
  static StopScreen + #1120, #2313
  static StopScreen + #1121, #3967
  static StopScreen + #1122, #3967
  static StopScreen + #1123, #3967
  static StopScreen + #1124, #3967
  static StopScreen + #1125, #3967
  static StopScreen + #1126, #2369
  static StopScreen + #1127, #2384
  static StopScreen + #1128, #2373
  static StopScreen + #1129, #2386
  static StopScreen + #1130, #2388
  static StopScreen + #1131, #2373
  static StopScreen + #1132, #3967
  static StopScreen + #1133, #2395
  static StopScreen + #1134, #2373
  static StopScreen + #1135, #2387
  static StopScreen + #1136, #2384
  static StopScreen + #1137, #2369
  static StopScreen + #1138, #2371
  static StopScreen + #1139, #2383
  static StopScreen + #1140, #2397
  static StopScreen + #1141, #3967
  static StopScreen + #1142, #2382
  static StopScreen + #1143, #2383
  static StopScreen + #1144, #2390
  static StopScreen + #1145, #2369
  static StopScreen + #1146, #2381
  static StopScreen + #1147, #2373
  static StopScreen + #1148, #2382
  static StopScreen + #1149, #2388
  static StopScreen + #1150, #2373
  static StopScreen + #1151, #2337
  static StopScreen + #1152, #2833
  static StopScreen + #1153, #1041
  static StopScreen + #1154, #529
  static StopScreen + #1155, #2321
  static StopScreen + #1156, #17
  static StopScreen + #1157, #3967
  static StopScreen + #1158, #3967
  static StopScreen + #1159, #2313

  ;Linha 29
  static StopScreen + #1160, #3967
  static StopScreen + #1161, #3967
  static StopScreen + #1162, #3967
  static StopScreen + #1163, #3967
  static StopScreen + #1164, #3967
  static StopScreen + #1165, #3967
  static StopScreen + #1166, #127
  static StopScreen + #1167, #127
  static StopScreen + #1168, #127
  static StopScreen + #1169, #127
  static StopScreen + #1170, #127
  static StopScreen + #1171, #127
  static StopScreen + #1172, #127
  static StopScreen + #1173, #127
  static StopScreen + #1174, #127
  static StopScreen + #1175, #127
  static StopScreen + #1176, #127
  static StopScreen + #1177, #127
  static StopScreen + #1178, #2319
  static StopScreen + #1179, #127
  static StopScreen + #1180, #127
  static StopScreen + #1181, #127
  static StopScreen + #1182, #127
  static StopScreen + #1183, #127
  static StopScreen + #1184, #127
  static StopScreen + #1185, #127
  static StopScreen + #1186, #127
  static StopScreen + #1187, #127
  static StopScreen + #1188, #127
  static StopScreen + #1189, #127
  static StopScreen + #1190, #127
  static StopScreen + #1191, #3967
  static StopScreen + #1192, #3967
  static StopScreen + #1193, #3967
  static StopScreen + #1194, #3967
  static StopScreen + #1195, #3967
  static StopScreen + #1196, #3967
  static StopScreen + #1197, #3967
  static StopScreen + #1198, #3967
  static StopScreen + #1199, #3967
;

WinScreen1 : var #1200
  ;Linha 0
  static WinScreen1 + #0, #127
  static WinScreen1 + #1, #127
  static WinScreen1 + #2, #127
  static WinScreen1 + #3, #127
  static WinScreen1 + #4, #127
  static WinScreen1 + #5, #127
  static WinScreen1 + #6, #127
  static WinScreen1 + #7, #127
  static WinScreen1 + #8, #127
  static WinScreen1 + #9, #127
  static WinScreen1 + #10, #127
  static WinScreen1 + #11, #127
  static WinScreen1 + #12, #127
  static WinScreen1 + #13, #127
  static WinScreen1 + #14, #127
  static WinScreen1 + #15, #127
  static WinScreen1 + #16, #127
  static WinScreen1 + #17, #3967
  static WinScreen1 + #18, #3967
  static WinScreen1 + #19, #3967
  static WinScreen1 + #20, #127
  static WinScreen1 + #21, #3967
  static WinScreen1 + #22, #3967
  static WinScreen1 + #23, #127
  static WinScreen1 + #24, #3967
  static WinScreen1 + #25, #3967
  static WinScreen1 + #26, #3967
  static WinScreen1 + #27, #3967
  static WinScreen1 + #28, #127
  static WinScreen1 + #29, #127
  static WinScreen1 + #30, #127
  static WinScreen1 + #31, #127
  static WinScreen1 + #32, #127
  static WinScreen1 + #33, #127
  static WinScreen1 + #34, #127
  static WinScreen1 + #35, #127
  static WinScreen1 + #36, #127
  static WinScreen1 + #37, #127
  static WinScreen1 + #38, #127
  static WinScreen1 + #39, #127

  ;Linha 1
  static WinScreen1 + #40, #127
  static WinScreen1 + #41, #127
  static WinScreen1 + #42, #127
  static WinScreen1 + #43, #127
  static WinScreen1 + #44, #127
  static WinScreen1 + #45, #127
  static WinScreen1 + #46, #127
  static WinScreen1 + #47, #127
  static WinScreen1 + #48, #127
  static WinScreen1 + #49, #127
  static WinScreen1 + #50, #3967
  static WinScreen1 + #51, #3967
  static WinScreen1 + #52, #3967
  static WinScreen1 + #53, #3967
  static WinScreen1 + #54, #3967
  static WinScreen1 + #55, #3967
  static WinScreen1 + #56, #3967
  static WinScreen1 + #57, #3967
  static WinScreen1 + #58, #3967
  static WinScreen1 + #59, #3967
  static WinScreen1 + #60, #3967
  static WinScreen1 + #61, #3967
  static WinScreen1 + #62, #3967
  static WinScreen1 + #63, #3967
  static WinScreen1 + #64, #3967
  static WinScreen1 + #65, #3967
  static WinScreen1 + #66, #3967
  static WinScreen1 + #67, #3967
  static WinScreen1 + #68, #127
  static WinScreen1 + #69, #127
  static WinScreen1 + #70, #127
  static WinScreen1 + #71, #127
  static WinScreen1 + #72, #127
  static WinScreen1 + #73, #127
  static WinScreen1 + #74, #127
  static WinScreen1 + #75, #127
  static WinScreen1 + #76, #127
  static WinScreen1 + #77, #127
  static WinScreen1 + #78, #127
  static WinScreen1 + #79, #127

  ;Linha 2
  static WinScreen1 + #80, #127
  static WinScreen1 + #81, #127
  static WinScreen1 + #82, #127
  static WinScreen1 + #83, #127
  static WinScreen1 + #84, #127
  static WinScreen1 + #85, #127
  static WinScreen1 + #86, #127
  static WinScreen1 + #87, #127
  static WinScreen1 + #88, #127
  static WinScreen1 + #89, #127
  static WinScreen1 + #90, #3967
  static WinScreen1 + #91, #3967
  static WinScreen1 + #92, #3967
  static WinScreen1 + #93, #3967
  static WinScreen1 + #94, #3967
  static WinScreen1 + #95, #3967
  static WinScreen1 + #96, #3967
  static WinScreen1 + #97, #3967
  static WinScreen1 + #98, #3967
  static WinScreen1 + #99, #3967
  static WinScreen1 + #100, #3967
  static WinScreen1 + #101, #3967
  static WinScreen1 + #102, #3967
  static WinScreen1 + #103, #3967
  static WinScreen1 + #104, #3967
  static WinScreen1 + #105, #3967
  static WinScreen1 + #106, #3967
  static WinScreen1 + #107, #3967
  static WinScreen1 + #108, #127
  static WinScreen1 + #109, #127
  static WinScreen1 + #110, #127
  static WinScreen1 + #111, #127
  static WinScreen1 + #112, #127
  static WinScreen1 + #113, #127
  static WinScreen1 + #114, #127
  static WinScreen1 + #115, #127
  static WinScreen1 + #116, #127
  static WinScreen1 + #117, #127
  static WinScreen1 + #118, #127
  static WinScreen1 + #119, #127

  ;Linha 3
  static WinScreen1 + #120, #127
  static WinScreen1 + #121, #127
  static WinScreen1 + #122, #127
  static WinScreen1 + #123, #3967
  static WinScreen1 + #124, #9
  static WinScreen1 + #125, #9
  static WinScreen1 + #126, #9
  static WinScreen1 + #127, #9
  static WinScreen1 + #128, #9
  static WinScreen1 + #129, #3967
  static WinScreen1 + #130, #3967
  static WinScreen1 + #131, #3967
  static WinScreen1 + #132, #3967
  static WinScreen1 + #133, #3967
  static WinScreen1 + #134, #3967
  static WinScreen1 + #135, #3967
  static WinScreen1 + #136, #9
  static WinScreen1 + #137, #9
  static WinScreen1 + #138, #9
  static WinScreen1 + #139, #9
  static WinScreen1 + #140, #9
  static WinScreen1 + #141, #3967
  static WinScreen1 + #142, #3967
  static WinScreen1 + #143, #3967
  static WinScreen1 + #144, #3967
  static WinScreen1 + #145, #127
  static WinScreen1 + #146, #127
  static WinScreen1 + #147, #127
  static WinScreen1 + #148, #127
  static WinScreen1 + #149, #127
  static WinScreen1 + #150, #127
  static WinScreen1 + #151, #127
  static WinScreen1 + #152, #127
  static WinScreen1 + #153, #127
  static WinScreen1 + #154, #127
  static WinScreen1 + #155, #127
  static WinScreen1 + #156, #127
  static WinScreen1 + #157, #127
  static WinScreen1 + #158, #127
  static WinScreen1 + #159, #127

  ;Linha 4
  static WinScreen1 + #160, #127
  static WinScreen1 + #161, #127
  static WinScreen1 + #162, #9
  static WinScreen1 + #163, #9
  static WinScreen1 + #164, #3967
  static WinScreen1 + #165, #3967
  static WinScreen1 + #166, #3967
  static WinScreen1 + #167, #3967
  static WinScreen1 + #168, #3967
  static WinScreen1 + #169, #9
  static WinScreen1 + #170, #9
  static WinScreen1 + #171, #3967
  static WinScreen1 + #172, #3967
  static WinScreen1 + #173, #3967
  static WinScreen1 + #174, #9
  static WinScreen1 + #175, #9
  static WinScreen1 + #176, #3967
  static WinScreen1 + #177, #3967
  static WinScreen1 + #178, #3967
  static WinScreen1 + #179, #3967
  static WinScreen1 + #180, #3967
  static WinScreen1 + #181, #9
  static WinScreen1 + #182, #9
  static WinScreen1 + #183, #127
  static WinScreen1 + #184, #3967
  static WinScreen1 + #185, #127
  static WinScreen1 + #186, #127
  static WinScreen1 + #187, #127
  static WinScreen1 + #188, #127
  static WinScreen1 + #189, #127
  static WinScreen1 + #190, #127
  static WinScreen1 + #191, #127
  static WinScreen1 + #192, #127
  static WinScreen1 + #193, #127
  static WinScreen1 + #194, #127
  static WinScreen1 + #195, #127
  static WinScreen1 + #196, #127
  static WinScreen1 + #197, #127
  static WinScreen1 + #198, #127
  static WinScreen1 + #199, #127

  ;Linha 5
  static WinScreen1 + #200, #127
  static WinScreen1 + #201, #9
  static WinScreen1 + #202, #3967
  static WinScreen1 + #203, #3967
  static WinScreen1 + #204, #3967
  static WinScreen1 + #205, #9
  static WinScreen1 + #206, #9
  static WinScreen1 + #207, #9
  static WinScreen1 + #208, #3967
  static WinScreen1 + #209, #3967
  static WinScreen1 + #210, #3967
  static WinScreen1 + #211, #9
  static WinScreen1 + #212, #3967
  static WinScreen1 + #213, #9
  static WinScreen1 + #214, #3967
  static WinScreen1 + #215, #3967
  static WinScreen1 + #216, #3967
  static WinScreen1 + #217, #9
  static WinScreen1 + #218, #9
  static WinScreen1 + #219, #9
  static WinScreen1 + #220, #3967
  static WinScreen1 + #221, #3967
  static WinScreen1 + #222, #3967
  static WinScreen1 + #223, #9
  static WinScreen1 + #224, #3967
  static WinScreen1 + #225, #127
  static WinScreen1 + #226, #127
  static WinScreen1 + #227, #127
  static WinScreen1 + #228, #127
  static WinScreen1 + #229, #127
  static WinScreen1 + #230, #127
  static WinScreen1 + #231, #127
  static WinScreen1 + #232, #127
  static WinScreen1 + #233, #127
  static WinScreen1 + #234, #127
  static WinScreen1 + #235, #127
  static WinScreen1 + #236, #127
  static WinScreen1 + #237, #127
  static WinScreen1 + #238, #127
  static WinScreen1 + #239, #127

  ;Linha 6
  static WinScreen1 + #240, #127
  static WinScreen1 + #241, #9
  static WinScreen1 + #242, #3967
  static WinScreen1 + #243, #3967
  static WinScreen1 + #244, #9
  static WinScreen1 + #245, #9
  static WinScreen1 + #246, #9
  static WinScreen1 + #247, #9
  static WinScreen1 + #248, #9
  static WinScreen1 + #249, #3967
  static WinScreen1 + #250, #3967
  static WinScreen1 + #251, #9
  static WinScreen1 + #252, #3967
  static WinScreen1 + #253, #9
  static WinScreen1 + #254, #3967
  static WinScreen1 + #255, #3967
  static WinScreen1 + #256, #9
  static WinScreen1 + #257, #9
  static WinScreen1 + #258, #9
  static WinScreen1 + #259, #9
  static WinScreen1 + #260, #9
  static WinScreen1 + #261, #3967
  static WinScreen1 + #262, #3967
  static WinScreen1 + #263, #9
  static WinScreen1 + #264, #3967
  static WinScreen1 + #265, #127
  static WinScreen1 + #266, #127
  static WinScreen1 + #267, #127
  static WinScreen1 + #268, #127
  static WinScreen1 + #269, #2569
  static WinScreen1 + #270, #2569
  static WinScreen1 + #271, #2569
  static WinScreen1 + #272, #2569
  static WinScreen1 + #273, #2825
  static WinScreen1 + #274, #2569
  static WinScreen1 + #275, #2569
  static WinScreen1 + #276, #2569
  static WinScreen1 + #277, #2569
  static WinScreen1 + #278, #2569
  static WinScreen1 + #279, #3967

  ;Linha 7
  static WinScreen1 + #280, #127
  static WinScreen1 + #281, #9
  static WinScreen1 + #282, #3967
  static WinScreen1 + #283, #3967
  static WinScreen1 + #284, #9
  static WinScreen1 + #285, #9
  static WinScreen1 + #286, #9
  static WinScreen1 + #287, #9
  static WinScreen1 + #288, #9
  static WinScreen1 + #289, #3967
  static WinScreen1 + #290, #127
  static WinScreen1 + #291, #9
  static WinScreen1 + #292, #3967
  static WinScreen1 + #293, #9
  static WinScreen1 + #294, #3967
  static WinScreen1 + #295, #3967
  static WinScreen1 + #296, #9
  static WinScreen1 + #297, #9
  static WinScreen1 + #298, #9
  static WinScreen1 + #299, #9
  static WinScreen1 + #300, #9
  static WinScreen1 + #301, #3967
  static WinScreen1 + #302, #3967
  static WinScreen1 + #303, #9
  static WinScreen1 + #304, #3967
  static WinScreen1 + #305, #127
  static WinScreen1 + #306, #127
  static WinScreen1 + #307, #127
  static WinScreen1 + #308, #2569
  static WinScreen1 + #309, #2569
  static WinScreen1 + #310, #2569
  static WinScreen1 + #311, #2569
  static WinScreen1 + #312, #2825
  static WinScreen1 + #313, #2569
  static WinScreen1 + #314, #2569
  static WinScreen1 + #315, #2569
  static WinScreen1 + #316, #2569
  static WinScreen1 + #317, #2569
  static WinScreen1 + #318, #2569
  static WinScreen1 + #319, #3967

  ;Linha 8
  static WinScreen1 + #320, #127
  static WinScreen1 + #321, #9
  static WinScreen1 + #322, #3967
  static WinScreen1 + #323, #3967
  static WinScreen1 + #324, #3967
  static WinScreen1 + #325, #9
  static WinScreen1 + #326, #9
  static WinScreen1 + #327, #9
  static WinScreen1 + #328, #3967
  static WinScreen1 + #329, #3967
  static WinScreen1 + #330, #1033
  static WinScreen1 + #331, #1033
  static WinScreen1 + #332, #1033
  static WinScreen1 + #333, #1033
  static WinScreen1 + #334, #1033
  static WinScreen1 + #335, #3967
  static WinScreen1 + #336, #3967
  static WinScreen1 + #337, #9
  static WinScreen1 + #338, #9
  static WinScreen1 + #339, #9
  static WinScreen1 + #340, #3967
  static WinScreen1 + #341, #3967
  static WinScreen1 + #342, #3967
  static WinScreen1 + #343, #9
  static WinScreen1 + #344, #3967
  static WinScreen1 + #345, #127
  static WinScreen1 + #346, #127
  static WinScreen1 + #347, #2569
  static WinScreen1 + #348, #2569
  static WinScreen1 + #349, #2825
  static WinScreen1 + #350, #2825
  static WinScreen1 + #351, #2825
  static WinScreen1 + #352, #2825
  static WinScreen1 + #353, #2825
  static WinScreen1 + #354, #2825
  static WinScreen1 + #355, #2569
  static WinScreen1 + #356, #2569
  static WinScreen1 + #357, #2569
  static WinScreen1 + #358, #2569
  static WinScreen1 + #359, #3967

  ;Linha 9
  static WinScreen1 + #360, #127
  static WinScreen1 + #361, #9
  static WinScreen1 + #362, #9
  static WinScreen1 + #363, #9
  static WinScreen1 + #364, #3967
  static WinScreen1 + #365, #3967
  static WinScreen1 + #366, #3967
  static WinScreen1 + #367, #127
  static WinScreen1 + #368, #1033
  static WinScreen1 + #369, #1033
  static WinScreen1 + #370, #3967
  static WinScreen1 + #371, #3967
  static WinScreen1 + #372, #3967
  static WinScreen1 + #373, #3967
  static WinScreen1 + #374, #3967
  static WinScreen1 + #375, #1033
  static WinScreen1 + #376, #1033
  static WinScreen1 + #377, #3967
  static WinScreen1 + #378, #3967
  static WinScreen1 + #379, #3967
  static WinScreen1 + #380, #3967
  static WinScreen1 + #381, #9
  static WinScreen1 + #382, #9
  static WinScreen1 + #383, #9
  static WinScreen1 + #384, #3967
  static WinScreen1 + #385, #127
  static WinScreen1 + #386, #2569
  static WinScreen1 + #387, #2569
  static WinScreen1 + #388, #2825
  static WinScreen1 + #389, #2569
  static WinScreen1 + #390, #2569
  static WinScreen1 + #391, #2825
  static WinScreen1 + #392, #2569
  static WinScreen1 + #393, #2569
  static WinScreen1 + #394, #2569
  static WinScreen1 + #395, #2569
  static WinScreen1 + #396, #2569
  static WinScreen1 + #397, #2569
  static WinScreen1 + #398, #3967
  static WinScreen1 + #399, #3967

  ;Linha 10
  static WinScreen1 + #400, #127
  static WinScreen1 + #401, #9
  static WinScreen1 + #402, #3967
  static WinScreen1 + #403, #9
  static WinScreen1 + #404, #9
  static WinScreen1 + #405, #9
  static WinScreen1 + #406, #9
  static WinScreen1 + #407, #1033
  static WinScreen1 + #408, #3967
  static WinScreen1 + #409, #3967
  static WinScreen1 + #410, #3967
  static WinScreen1 + #411, #1033
  static WinScreen1 + #412, #1033
  static WinScreen1 + #413, #1033
  static WinScreen1 + #414, #3967
  static WinScreen1 + #415, #3967
  static WinScreen1 + #416, #3967
  static WinScreen1 + #417, #1033
  static WinScreen1 + #418, #9
  static WinScreen1 + #419, #9
  static WinScreen1 + #420, #9
  static WinScreen1 + #421, #9
  static WinScreen1 + #422, #3967
  static WinScreen1 + #423, #3967
  static WinScreen1 + #424, #3967
  static WinScreen1 + #425, #2569
  static WinScreen1 + #426, #2569
  static WinScreen1 + #427, #2825
  static WinScreen1 + #428, #2569
  static WinScreen1 + #429, #2569
  static WinScreen1 + #430, #2825
  static WinScreen1 + #431, #2569
  static WinScreen1 + #432, #2569
  static WinScreen1 + #433, #2569
  static WinScreen1 + #434, #2569
  static WinScreen1 + #435, #2569
  static WinScreen1 + #436, #2569
  static WinScreen1 + #437, #127
  static WinScreen1 + #438, #2569
  static WinScreen1 + #439, #3967

  ;Linha 11
  static WinScreen1 + #440, #127
  static WinScreen1 + #441, #9
  static WinScreen1 + #442, #3967
  static WinScreen1 + #443, #3967
  static WinScreen1 + #444, #3967
  static WinScreen1 + #445, #3967
  static WinScreen1 + #446, #3967
  static WinScreen1 + #447, #1033
  static WinScreen1 + #448, #3967
  static WinScreen1 + #449, #3967
  static WinScreen1 + #450, #1033
  static WinScreen1 + #451, #1033
  static WinScreen1 + #452, #1033
  static WinScreen1 + #453, #1033
  static WinScreen1 + #454, #1033
  static WinScreen1 + #455, #127
  static WinScreen1 + #456, #127
  static WinScreen1 + #457, #1033
  static WinScreen1 + #458, #3967
  static WinScreen1 + #459, #3967
  static WinScreen1 + #460, #3967
  static WinScreen1 + #461, #3967
  static WinScreen1 + #462, #3967
  static WinScreen1 + #463, #3967
  static WinScreen1 + #464, #2569
  static WinScreen1 + #465, #2569
  static WinScreen1 + #466, #2569
  static WinScreen1 + #467, #2569
  static WinScreen1 + #468, #2825
  static WinScreen1 + #469, #2825
  static WinScreen1 + #470, #2569
  static WinScreen1 + #471, #2569
  static WinScreen1 + #472, #2569
  static WinScreen1 + #473, #2569
  static WinScreen1 + #474, #2569
  static WinScreen1 + #475, #2569
  static WinScreen1 + #476, #127
  static WinScreen1 + #477, #2569
  static WinScreen1 + #478, #2569
  static WinScreen1 + #479, #3967

  ;Linha 12
  static WinScreen1 + #480, #127
  static WinScreen1 + #481, #9
  static WinScreen1 + #482, #9
  static WinScreen1 + #483, #9
  static WinScreen1 + #484, #3967
  static WinScreen1 + #485, #3967
  static WinScreen1 + #486, #3967
  static WinScreen1 + #487, #1033
  static WinScreen1 + #488, #3967
  static WinScreen1 + #489, #3967
  static WinScreen1 + #490, #1033
  static WinScreen1 + #491, #1033
  static WinScreen1 + #492, #1033
  static WinScreen1 + #493, #1033
  static WinScreen1 + #494, #1033
  static WinScreen1 + #495, #3967
  static WinScreen1 + #496, #127
  static WinScreen1 + #497, #1033
  static WinScreen1 + #498, #3967
  static WinScreen1 + #499, #3967
  static WinScreen1 + #500, #3967
  static WinScreen1 + #501, #3967
  static WinScreen1 + #502, #3967
  static WinScreen1 + #503, #2569
  static WinScreen1 + #504, #2569
  static WinScreen1 + #505, #2569
  static WinScreen1 + #506, #2569
  static WinScreen1 + #507, #2569
  static WinScreen1 + #508, #2825
  static WinScreen1 + #509, #2825
  static WinScreen1 + #510, #2569
  static WinScreen1 + #511, #2569
  static WinScreen1 + #512, #2569
  static WinScreen1 + #513, #2569
  static WinScreen1 + #514, #2569
  static WinScreen1 + #515, #127
  static WinScreen1 + #516, #2569
  static WinScreen1 + #517, #2569
  static WinScreen1 + #518, #2569
  static WinScreen1 + #519, #3967

  ;Linha 13
  static WinScreen1 + #520, #127
  static WinScreen1 + #521, #9
  static WinScreen1 + #522, #3967
  static WinScreen1 + #523, #9
  static WinScreen1 + #524, #9
  static WinScreen1 + #525, #9
  static WinScreen1 + #526, #9
  static WinScreen1 + #527, #1033
  static WinScreen1 + #528, #3967
  static WinScreen1 + #529, #3967
  static WinScreen1 + #530, #3967
  static WinScreen1 + #531, #1033
  static WinScreen1 + #532, #1033
  static WinScreen1 + #533, #1033
  static WinScreen1 + #534, #3967
  static WinScreen1 + #535, #3967
  static WinScreen1 + #536, #3967
  static WinScreen1 + #537, #1033
  static WinScreen1 + #538, #9
  static WinScreen1 + #539, #9
  static WinScreen1 + #540, #3967
  static WinScreen1 + #541, #3967
  static WinScreen1 + #542, #2569
  static WinScreen1 + #543, #2569
  static WinScreen1 + #544, #2569
  static WinScreen1 + #545, #2569
  static WinScreen1 + #546, #2569
  static WinScreen1 + #547, #2825
  static WinScreen1 + #548, #2569
  static WinScreen1 + #549, #2569
  static WinScreen1 + #550, #2825
  static WinScreen1 + #551, #2569
  static WinScreen1 + #552, #2569
  static WinScreen1 + #553, #2569
  static WinScreen1 + #554, #127
  static WinScreen1 + #555, #2569
  static WinScreen1 + #556, #2569
  static WinScreen1 + #557, #2569
  static WinScreen1 + #558, #3967
  static WinScreen1 + #559, #3967

  ;Linha 14
  static WinScreen1 + #560, #127
  static WinScreen1 + #561, #9
  static WinScreen1 + #562, #127
  static WinScreen1 + #563, #3967
  static WinScreen1 + #564, #3967
  static WinScreen1 + #565, #3967
  static WinScreen1 + #566, #3967
  static WinScreen1 + #567, #1033
  static WinScreen1 + #568, #1033
  static WinScreen1 + #569, #1033
  static WinScreen1 + #570, #3967
  static WinScreen1 + #571, #127
  static WinScreen1 + #572, #3967
  static WinScreen1 + #573, #127
  static WinScreen1 + #574, #127
  static WinScreen1 + #575, #1033
  static WinScreen1 + #576, #1033
  static WinScreen1 + #577, #1033
  static WinScreen1 + #578, #3967
  static WinScreen1 + #579, #3967
  static WinScreen1 + #580, #3967
  static WinScreen1 + #581, #2569
  static WinScreen1 + #582, #2569
  static WinScreen1 + #583, #2569
  static WinScreen1 + #584, #2825
  static WinScreen1 + #585, #2825
  static WinScreen1 + #586, #2825
  static WinScreen1 + #587, #2825
  static WinScreen1 + #588, #2825
  static WinScreen1 + #589, #2825
  static WinScreen1 + #590, #2569
  static WinScreen1 + #591, #2569
  static WinScreen1 + #592, #2569
  static WinScreen1 + #593, #127
  static WinScreen1 + #594, #2569
  static WinScreen1 + #595, #2569
  static WinScreen1 + #596, #2569
  static WinScreen1 + #597, #127
  static WinScreen1 + #598, #2569
  static WinScreen1 + #599, #3967

  ;Linha 15
  static WinScreen1 + #600, #127
  static WinScreen1 + #601, #9
  static WinScreen1 + #602, #9
  static WinScreen1 + #603, #9
  static WinScreen1 + #604, #3967
  static WinScreen1 + #605, #3967
  static WinScreen1 + #606, #3967
  static WinScreen1 + #607, #1033
  static WinScreen1 + #608, #3967
  static WinScreen1 + #609, #1033
  static WinScreen1 + #610, #1033
  static WinScreen1 + #611, #1033
  static WinScreen1 + #612, #1033
  static WinScreen1 + #613, #1033
  static WinScreen1 + #614, #1033
  static WinScreen1 + #615, #1033
  static WinScreen1 + #616, #3967
  static WinScreen1 + #617, #1033
  static WinScreen1 + #618, #3967
  static WinScreen1 + #619, #3967
  static WinScreen1 + #620, #2569
  static WinScreen1 + #621, #2569
  static WinScreen1 + #622, #2569
  static WinScreen1 + #623, #2569
  static WinScreen1 + #624, #2569
  static WinScreen1 + #625, #2569
  static WinScreen1 + #626, #2825
  static WinScreen1 + #627, #2569
  static WinScreen1 + #628, #2569
  static WinScreen1 + #629, #2569
  static WinScreen1 + #630, #2569
  static WinScreen1 + #631, #2569
  static WinScreen1 + #632, #127
  static WinScreen1 + #633, #2569
  static WinScreen1 + #634, #2569
  static WinScreen1 + #635, #2569
  static WinScreen1 + #636, #127
  static WinScreen1 + #637, #2569
  static WinScreen1 + #638, #2569
  static WinScreen1 + #639, #3967

  ;Linha 16
  static WinScreen1 + #640, #127
  static WinScreen1 + #641, #9
  static WinScreen1 + #642, #3967
  static WinScreen1 + #643, #9
  static WinScreen1 + #644, #9
  static WinScreen1 + #645, #9
  static WinScreen1 + #646, #9
  static WinScreen1 + #647, #1033
  static WinScreen1 + #648, #3967
  static WinScreen1 + #649, #3967
  static WinScreen1 + #650, #3967
  static WinScreen1 + #651, #127
  static WinScreen1 + #652, #3967
  static WinScreen1 + #653, #3967
  static WinScreen1 + #654, #3967
  static WinScreen1 + #655, #3967
  static WinScreen1 + #656, #3967
  static WinScreen1 + #657, #1033
  static WinScreen1 + #658, #9
  static WinScreen1 + #659, #3967
  static WinScreen1 + #660, #2569
  static WinScreen1 + #661, #2569
  static WinScreen1 + #662, #2569
  static WinScreen1 + #663, #2569
  static WinScreen1 + #664, #2569
  static WinScreen1 + #665, #2569
  static WinScreen1 + #666, #2569
  static WinScreen1 + #667, #2569
  static WinScreen1 + #668, #2569
  static WinScreen1 + #669, #2569
  static WinScreen1 + #670, #2569
  static WinScreen1 + #671, #127
  static WinScreen1 + #672, #2569
  static WinScreen1 + #673, #2569
  static WinScreen1 + #674, #2569
  static WinScreen1 + #675, #127
  static WinScreen1 + #676, #2569
  static WinScreen1 + #677, #2569
  static WinScreen1 + #678, #2569
  static WinScreen1 + #679, #127

  ;Linha 17
  static WinScreen1 + #680, #127
  static WinScreen1 + #681, #9
  static WinScreen1 + #682, #127
  static WinScreen1 + #683, #3967
  static WinScreen1 + #684, #127
  static WinScreen1 + #685, #3967
  static WinScreen1 + #686, #3967
  static WinScreen1 + #687, #1033
  static WinScreen1 + #688, #1033
  static WinScreen1 + #689, #1033
  static WinScreen1 + #690, #3967
  static WinScreen1 + #691, #3967
  static WinScreen1 + #692, #3967
  static WinScreen1 + #693, #127
  static WinScreen1 + #694, #127
  static WinScreen1 + #695, #1033
  static WinScreen1 + #696, #1033
  static WinScreen1 + #697, #1033
  static WinScreen1 + #698, #3967
  static WinScreen1 + #699, #3967
  static WinScreen1 + #700, #3967
  static WinScreen1 + #701, #3967
  static WinScreen1 + #702, #3967
  static WinScreen1 + #703, #3967
  static WinScreen1 + #704, #3967
  static WinScreen1 + #705, #3967
  static WinScreen1 + #706, #3967
  static WinScreen1 + #707, #3967
  static WinScreen1 + #708, #3967
  static WinScreen1 + #709, #3967
  static WinScreen1 + #710, #127
  static WinScreen1 + #711, #2569
  static WinScreen1 + #712, #2569
  static WinScreen1 + #713, #2569
  static WinScreen1 + #714, #127
  static WinScreen1 + #715, #2569
  static WinScreen1 + #716, #2569
  static WinScreen1 + #717, #2569
  static WinScreen1 + #718, #3967
  static WinScreen1 + #719, #127

  ;Linha 18
  static WinScreen1 + #720, #127
  static WinScreen1 + #721, #127
  static WinScreen1 + #722, #9
  static WinScreen1 + #723, #3967
  static WinScreen1 + #724, #127
  static WinScreen1 + #725, #3967
  static WinScreen1 + #726, #3967
  static WinScreen1 + #727, #1033
  static WinScreen1 + #728, #3967
  static WinScreen1 + #729, #1033
  static WinScreen1 + #730, #1033
  static WinScreen1 + #731, #1033
  static WinScreen1 + #732, #1033
  static WinScreen1 + #733, #1033
  static WinScreen1 + #734, #1033
  static WinScreen1 + #735, #1033
  static WinScreen1 + #736, #3967
  static WinScreen1 + #737, #1033
  static WinScreen1 + #738, #127
  static WinScreen1 + #739, #3967
  static WinScreen1 + #740, #2569
  static WinScreen1 + #741, #2569
  static WinScreen1 + #742, #2569
  static WinScreen1 + #743, #2569
  static WinScreen1 + #744, #2569
  static WinScreen1 + #745, #2569
  static WinScreen1 + #746, #2569
  static WinScreen1 + #747, #2569
  static WinScreen1 + #748, #2569
  static WinScreen1 + #749, #2569
  static WinScreen1 + #750, #2569
  static WinScreen1 + #751, #2569
  static WinScreen1 + #752, #2569
  static WinScreen1 + #753, #127
  static WinScreen1 + #754, #2569
  static WinScreen1 + #755, #2569
  static WinScreen1 + #756, #2569
  static WinScreen1 + #757, #3967
  static WinScreen1 + #758, #2569
  static WinScreen1 + #759, #127

  ;Linha 19
  static WinScreen1 + #760, #127
  static WinScreen1 + #761, #127
  static WinScreen1 + #762, #127
  static WinScreen1 + #763, #9
  static WinScreen1 + #764, #3967
  static WinScreen1 + #765, #3967
  static WinScreen1 + #766, #3967
  static WinScreen1 + #767, #1033
  static WinScreen1 + #768, #3967
  static WinScreen1 + #769, #3967
  static WinScreen1 + #770, #3967
  static WinScreen1 + #771, #3967
  static WinScreen1 + #772, #3967
  static WinScreen1 + #773, #127
  static WinScreen1 + #774, #127
  static WinScreen1 + #775, #127
  static WinScreen1 + #776, #127
  static WinScreen1 + #777, #1033
  static WinScreen1 + #778, #9
  static WinScreen1 + #779, #3967
  static WinScreen1 + #780, #2569
  static WinScreen1 + #781, #2569
  static WinScreen1 + #782, #2569
  static WinScreen1 + #783, #2569
  static WinScreen1 + #784, #2569
  static WinScreen1 + #785, #2569
  static WinScreen1 + #786, #2569
  static WinScreen1 + #787, #2569
  static WinScreen1 + #788, #2569
  static WinScreen1 + #789, #2569
  static WinScreen1 + #790, #2569
  static WinScreen1 + #791, #2569
  static WinScreen1 + #792, #127
  static WinScreen1 + #793, #2569
  static WinScreen1 + #794, #2569
  static WinScreen1 + #795, #2569
  static WinScreen1 + #796, #127
  static WinScreen1 + #797, #2569
  static WinScreen1 + #798, #127
  static WinScreen1 + #799, #127

  ;Linha 20
  static WinScreen1 + #800, #127
  static WinScreen1 + #801, #127
  static WinScreen1 + #802, #127
  static WinScreen1 + #803, #127
  static WinScreen1 + #804, #9
  static WinScreen1 + #805, #9
  static WinScreen1 + #806, #9
  static WinScreen1 + #807, #1033
  static WinScreen1 + #808, #1033
  static WinScreen1 + #809, #1033
  static WinScreen1 + #810, #127
  static WinScreen1 + #811, #3967
  static WinScreen1 + #812, #127
  static WinScreen1 + #813, #127
  static WinScreen1 + #814, #127
  static WinScreen1 + #815, #1033
  static WinScreen1 + #816, #1033
  static WinScreen1 + #817, #1033
  static WinScreen1 + #818, #9
  static WinScreen1 + #819, #3967
  static WinScreen1 + #820, #2569
  static WinScreen1 + #821, #2569
  static WinScreen1 + #822, #2569
  static WinScreen1 + #823, #2569
  static WinScreen1 + #824, #2569
  static WinScreen1 + #825, #2569
  static WinScreen1 + #826, #2569
  static WinScreen1 + #827, #2569
  static WinScreen1 + #828, #2569
  static WinScreen1 + #829, #2569
  static WinScreen1 + #830, #2569
  static WinScreen1 + #831, #127
  static WinScreen1 + #832, #2569
  static WinScreen1 + #833, #2569
  static WinScreen1 + #834, #2569
  static WinScreen1 + #835, #127
  static WinScreen1 + #836, #2569
  static WinScreen1 + #837, #127
  static WinScreen1 + #838, #127
  static WinScreen1 + #839, #127

  ;Linha 21
  static WinScreen1 + #840, #127
  static WinScreen1 + #841, #127
  static WinScreen1 + #842, #127
  static WinScreen1 + #843, #127
  static WinScreen1 + #844, #127
  static WinScreen1 + #845, #127
  static WinScreen1 + #846, #127
  static WinScreen1 + #847, #1033
  static WinScreen1 + #848, #3967
  static WinScreen1 + #849, #1033
  static WinScreen1 + #850, #1033
  static WinScreen1 + #851, #1033
  static WinScreen1 + #852, #1033
  static WinScreen1 + #853, #1033
  static WinScreen1 + #854, #1033
  static WinScreen1 + #855, #1033
  static WinScreen1 + #856, #127
  static WinScreen1 + #857, #1033
  static WinScreen1 + #858, #127
  static WinScreen1 + #859, #3967
  static WinScreen1 + #860, #3967
  static WinScreen1 + #861, #3967
  static WinScreen1 + #862, #3967
  static WinScreen1 + #863, #3967
  static WinScreen1 + #864, #3967
  static WinScreen1 + #865, #3967
  static WinScreen1 + #866, #3967
  static WinScreen1 + #867, #3967
  static WinScreen1 + #868, #3967
  static WinScreen1 + #869, #3967
  static WinScreen1 + #870, #127
  static WinScreen1 + #871, #2569
  static WinScreen1 + #872, #2569
  static WinScreen1 + #873, #2569
  static WinScreen1 + #874, #127
  static WinScreen1 + #875, #2569
  static WinScreen1 + #876, #127
  static WinScreen1 + #877, #127
  static WinScreen1 + #878, #127
  static WinScreen1 + #879, #127

  ;Linha 22
  static WinScreen1 + #880, #127
  static WinScreen1 + #881, #127
  static WinScreen1 + #882, #127
  static WinScreen1 + #883, #127
  static WinScreen1 + #884, #127
  static WinScreen1 + #885, #127
  static WinScreen1 + #886, #127
  static WinScreen1 + #887, #1033
  static WinScreen1 + #888, #3967
  static WinScreen1 + #889, #3967
  static WinScreen1 + #890, #127
  static WinScreen1 + #891, #127
  static WinScreen1 + #892, #127
  static WinScreen1 + #893, #127
  static WinScreen1 + #894, #127
  static WinScreen1 + #895, #127
  static WinScreen1 + #896, #127
  static WinScreen1 + #897, #1033
  static WinScreen1 + #898, #127
  static WinScreen1 + #899, #127
  static WinScreen1 + #900, #2569
  static WinScreen1 + #901, #2569
  static WinScreen1 + #902, #2569
  static WinScreen1 + #903, #2569
  static WinScreen1 + #904, #2569
  static WinScreen1 + #905, #2569
  static WinScreen1 + #906, #2569
  static WinScreen1 + #907, #2569
  static WinScreen1 + #908, #2569
  static WinScreen1 + #909, #2569
  static WinScreen1 + #910, #2569
  static WinScreen1 + #911, #2569
  static WinScreen1 + #912, #2569
  static WinScreen1 + #913, #127
  static WinScreen1 + #914, #2569
  static WinScreen1 + #915, #3967
  static WinScreen1 + #916, #127
  static WinScreen1 + #917, #127
  static WinScreen1 + #918, #127
  static WinScreen1 + #919, #127

  ;Linha 23
  static WinScreen1 + #920, #127
  static WinScreen1 + #921, #127
  static WinScreen1 + #922, #127
  static WinScreen1 + #923, #127
  static WinScreen1 + #924, #3967
  static WinScreen1 + #925, #3967
  static WinScreen1 + #926, #3967
  static WinScreen1 + #927, #3967
  static WinScreen1 + #928, #1033
  static WinScreen1 + #929, #1033
  static WinScreen1 + #930, #127
  static WinScreen1 + #931, #127
  static WinScreen1 + #932, #127
  static WinScreen1 + #933, #127
  static WinScreen1 + #934, #127
  static WinScreen1 + #935, #1033
  static WinScreen1 + #936, #1033
  static WinScreen1 + #937, #3967
  static WinScreen1 + #938, #127
  static WinScreen1 + #939, #127
  static WinScreen1 + #940, #2569
  static WinScreen1 + #941, #2569
  static WinScreen1 + #942, #2569
  static WinScreen1 + #943, #2569
  static WinScreen1 + #944, #2569
  static WinScreen1 + #945, #2569
  static WinScreen1 + #946, #2569
  static WinScreen1 + #947, #2569
  static WinScreen1 + #948, #2569
  static WinScreen1 + #949, #2569
  static WinScreen1 + #950, #2569
  static WinScreen1 + #951, #2569
  static WinScreen1 + #952, #127
  static WinScreen1 + #953, #2569
  static WinScreen1 + #954, #127
  static WinScreen1 + #955, #127
  static WinScreen1 + #956, #127
  static WinScreen1 + #957, #127
  static WinScreen1 + #958, #127
  static WinScreen1 + #959, #127

  ;Linha 24
  static WinScreen1 + #960, #127
  static WinScreen1 + #961, #3967
  static WinScreen1 + #962, #3967
  static WinScreen1 + #963, #3967
  static WinScreen1 + #964, #3967
  static WinScreen1 + #965, #3967
  static WinScreen1 + #966, #3967
  static WinScreen1 + #967, #3967
  static WinScreen1 + #968, #3967
  static WinScreen1 + #969, #1033
  static WinScreen1 + #970, #1033
  static WinScreen1 + #971, #1033
  static WinScreen1 + #972, #1033
  static WinScreen1 + #973, #1033
  static WinScreen1 + #974, #1033
  static WinScreen1 + #975, #1033
  static WinScreen1 + #976, #3967
  static WinScreen1 + #977, #3967
  static WinScreen1 + #978, #3967
  static WinScreen1 + #979, #127
  static WinScreen1 + #980, #2569
  static WinScreen1 + #981, #2569
  static WinScreen1 + #982, #2569
  static WinScreen1 + #983, #2569
  static WinScreen1 + #984, #2569
  static WinScreen1 + #985, #2569
  static WinScreen1 + #986, #2569
  static WinScreen1 + #987, #2569
  static WinScreen1 + #988, #2569
  static WinScreen1 + #989, #2569
  static WinScreen1 + #990, #2569
  static WinScreen1 + #991, #127
  static WinScreen1 + #992, #2569
  static WinScreen1 + #993, #127
  static WinScreen1 + #994, #127
  static WinScreen1 + #995, #127
  static WinScreen1 + #996, #127
  static WinScreen1 + #997, #127
  static WinScreen1 + #998, #127
  static WinScreen1 + #999, #127

  ;Linha 25
  static WinScreen1 + #1000, #127
  static WinScreen1 + #1001, #3967
  static WinScreen1 + #1002, #3967
  static WinScreen1 + #1003, #3967
  static WinScreen1 + #1004, #3967
  static WinScreen1 + #1005, #3967
  static WinScreen1 + #1006, #127
  static WinScreen1 + #1007, #127
  static WinScreen1 + #1008, #3967
  static WinScreen1 + #1009, #3967
  static WinScreen1 + #1010, #1033
  static WinScreen1 + #1011, #1033
  static WinScreen1 + #1012, #1033
  static WinScreen1 + #1013, #1033
  static WinScreen1 + #1014, #1033
  static WinScreen1 + #1015, #3967
  static WinScreen1 + #1016, #3967
  static WinScreen1 + #1017, #3967
  static WinScreen1 + #1018, #127
  static WinScreen1 + #1019, #127
  static WinScreen1 + #1020, #127
  static WinScreen1 + #1021, #127
  static WinScreen1 + #1022, #127
  static WinScreen1 + #1023, #127
  static WinScreen1 + #1024, #127
  static WinScreen1 + #1025, #127
  static WinScreen1 + #1026, #3967
  static WinScreen1 + #1027, #3967
  static WinScreen1 + #1028, #3967
  static WinScreen1 + #1029, #3967
  static WinScreen1 + #1030, #127
  static WinScreen1 + #1031, #2569
  static WinScreen1 + #1032, #127
  static WinScreen1 + #1033, #127
  static WinScreen1 + #1034, #127
  static WinScreen1 + #1035, #127
  static WinScreen1 + #1036, #127
  static WinScreen1 + #1037, #127
  static WinScreen1 + #1038, #127
  static WinScreen1 + #1039, #127

  ;Linha 26
  static WinScreen1 + #1040, #127
  static WinScreen1 + #1041, #3967
  static WinScreen1 + #1042, #3967
  static WinScreen1 + #1043, #3967
  static WinScreen1 + #1044, #3967
  static WinScreen1 + #1045, #3967
  static WinScreen1 + #1046, #3967
  static WinScreen1 + #1047, #3967
  static WinScreen1 + #1048, #127
  static WinScreen1 + #1049, #127
  static WinScreen1 + #1050, #127
  static WinScreen1 + #1051, #127
  static WinScreen1 + #1052, #127
  static WinScreen1 + #1053, #127
  static WinScreen1 + #1054, #127
  static WinScreen1 + #1055, #127
  static WinScreen1 + #1056, #3967
  static WinScreen1 + #1057, #127
  static WinScreen1 + #1058, #127
  static WinScreen1 + #1059, #127
  static WinScreen1 + #1060, #2569
  static WinScreen1 + #1061, #2569
  static WinScreen1 + #1062, #2569
  static WinScreen1 + #1063, #2569
  static WinScreen1 + #1064, #2569
  static WinScreen1 + #1065, #2569
  static WinScreen1 + #1066, #2569
  static WinScreen1 + #1067, #2569
  static WinScreen1 + #1068, #2569
  static WinScreen1 + #1069, #2569
  static WinScreen1 + #1070, #2569
  static WinScreen1 + #1071, #127
  static WinScreen1 + #1072, #127
  static WinScreen1 + #1073, #127
  static WinScreen1 + #1074, #127
  static WinScreen1 + #1075, #127
  static WinScreen1 + #1076, #127
  static WinScreen1 + #1077, #127
  static WinScreen1 + #1078, #127
  static WinScreen1 + #1079, #127

  ;Linha 27
  static WinScreen1 + #1080, #127
  static WinScreen1 + #1081, #3967
  static WinScreen1 + #1082, #3967
  static WinScreen1 + #1083, #3967
  static WinScreen1 + #1084, #3967
  static WinScreen1 + #1085, #3967
  static WinScreen1 + #1086, #3967
  static WinScreen1 + #1087, #127
  static WinScreen1 + #1088, #127
  static WinScreen1 + #1089, #127
  static WinScreen1 + #1090, #127
  static WinScreen1 + #1091, #127
  static WinScreen1 + #1092, #127
  static WinScreen1 + #1093, #127
  static WinScreen1 + #1094, #127
  static WinScreen1 + #1095, #127
  static WinScreen1 + #1096, #127
  static WinScreen1 + #1097, #127
  static WinScreen1 + #1098, #127
  static WinScreen1 + #1099, #127
  static WinScreen1 + #1100, #127
  static WinScreen1 + #1101, #2569
  static WinScreen1 + #1102, #2569
  static WinScreen1 + #1103, #2569
  static WinScreen1 + #1104, #2569
  static WinScreen1 + #1105, #2569
  static WinScreen1 + #1106, #2569
  static WinScreen1 + #1107, #2569
  static WinScreen1 + #1108, #2569
  static WinScreen1 + #1109, #2569
  static WinScreen1 + #1110, #3967
  static WinScreen1 + #1111, #3967
  static WinScreen1 + #1112, #127
  static WinScreen1 + #1113, #127
  static WinScreen1 + #1114, #127
  static WinScreen1 + #1115, #127
  static WinScreen1 + #1116, #127
  static WinScreen1 + #1117, #127
  static WinScreen1 + #1118, #127
  static WinScreen1 + #1119, #127

  ;Linha 28
  static WinScreen1 + #1120, #127
  static WinScreen1 + #1121, #3967
  static WinScreen1 + #1122, #3967
  static WinScreen1 + #1123, #3967
  static WinScreen1 + #1124, #3967
  static WinScreen1 + #1125, #3967
  static WinScreen1 + #1126, #127
  static WinScreen1 + #1127, #127
  static WinScreen1 + #1128, #127
  static WinScreen1 + #1129, #127
  static WinScreen1 + #1130, #127
  static WinScreen1 + #1131, #127
  static WinScreen1 + #1132, #127
  static WinScreen1 + #1133, #127
  static WinScreen1 + #1134, #127
  static WinScreen1 + #1135, #127
  static WinScreen1 + #1136, #127
  static WinScreen1 + #1137, #127
  static WinScreen1 + #1138, #127
  static WinScreen1 + #1139, #127
  static WinScreen1 + #1140, #127
  static WinScreen1 + #1141, #127
  static WinScreen1 + #1142, #127
  static WinScreen1 + #1143, #127
  static WinScreen1 + #1144, #127
  static WinScreen1 + #1145, #127
  static WinScreen1 + #1146, #127
  static WinScreen1 + #1147, #127
  static WinScreen1 + #1148, #3967
  static WinScreen1 + #1149, #3967
  static WinScreen1 + #1150, #3967
  static WinScreen1 + #1151, #127
  static WinScreen1 + #1152, #127
  static WinScreen1 + #1153, #127
  static WinScreen1 + #1154, #127
  static WinScreen1 + #1155, #127
  static WinScreen1 + #1156, #127
  static WinScreen1 + #1157, #127
  static WinScreen1 + #1158, #127
  static WinScreen1 + #1159, #127

  ;Linha 29
  static WinScreen1 + #1160, #127
  static WinScreen1 + #1161, #127
  static WinScreen1 + #1162, #127
  static WinScreen1 + #1163, #127
  static WinScreen1 + #1164, #127
  static WinScreen1 + #1165, #127
  static WinScreen1 + #1166, #127
  static WinScreen1 + #1167, #127
  static WinScreen1 + #1168, #127
  static WinScreen1 + #1169, #127
  static WinScreen1 + #1170, #127
  static WinScreen1 + #1171, #127
  static WinScreen1 + #1172, #127
  static WinScreen1 + #1173, #127
  static WinScreen1 + #1174, #127
  static WinScreen1 + #1175, #127
  static WinScreen1 + #1176, #127
  static WinScreen1 + #1177, #127
  static WinScreen1 + #1178, #127
  static WinScreen1 + #1179, #127
  static WinScreen1 + #1180, #127
  static WinScreen1 + #1181, #127
  static WinScreen1 + #1182, #127
  static WinScreen1 + #1183, #127
  static WinScreen1 + #1184, #127
  static WinScreen1 + #1185, #127
  static WinScreen1 + #1186, #127
  static WinScreen1 + #1187, #127
  static WinScreen1 + #1188, #3967
  static WinScreen1 + #1189, #3967
  static WinScreen1 + #1190, #3967
  static WinScreen1 + #1191, #127
  static WinScreen1 + #1192, #127
  static WinScreen1 + #1193, #127
  static WinScreen1 + #1194, #127
  static WinScreen1 + #1195, #127
  static WinScreen1 + #1196, #127
  static WinScreen1 + #1197, #127
  static WinScreen1 + #1198, #127
  static WinScreen1 + #1199, #127
;

WinScreen2 : var #1200
  ;Linha 0
  static WinScreen2 + #0, #127
  static WinScreen2 + #1, #127
  static WinScreen2 + #2, #127
  static WinScreen2 + #3, #127
  static WinScreen2 + #4, #127
  static WinScreen2 + #5, #127
  static WinScreen2 + #6, #127
  static WinScreen2 + #7, #127
  static WinScreen2 + #8, #127
  static WinScreen2 + #9, #127
  static WinScreen2 + #10, #127
  static WinScreen2 + #11, #127
  static WinScreen2 + #12, #127
  static WinScreen2 + #13, #127
  static WinScreen2 + #14, #127
  static WinScreen2 + #15, #127
  static WinScreen2 + #16, #127
  static WinScreen2 + #17, #3967
  static WinScreen2 + #18, #3967
  static WinScreen2 + #19, #3967
  static WinScreen2 + #20, #127
  static WinScreen2 + #21, #3967
  static WinScreen2 + #22, #3967
  static WinScreen2 + #23, #127
  static WinScreen2 + #24, #3967
  static WinScreen2 + #25, #3967
  static WinScreen2 + #26, #3967
  static WinScreen2 + #27, #3967
  static WinScreen2 + #28, #127
  static WinScreen2 + #29, #127
  static WinScreen2 + #30, #127
  static WinScreen2 + #31, #127
  static WinScreen2 + #32, #127
  static WinScreen2 + #33, #3967
  static WinScreen2 + #34, #127
  static WinScreen2 + #35, #127
  static WinScreen2 + #36, #127
  static WinScreen2 + #37, #127
  static WinScreen2 + #38, #127
  static WinScreen2 + #39, #127

  ;Linha 1
  static WinScreen2 + #40, #127
  static WinScreen2 + #41, #127
  static WinScreen2 + #42, #3967
  static WinScreen2 + #43, #127
  static WinScreen2 + #44, #127
  static WinScreen2 + #45, #127
  static WinScreen2 + #46, #127
  static WinScreen2 + #47, #127
  static WinScreen2 + #48, #127
  static WinScreen2 + #49, #3967
  static WinScreen2 + #50, #3967
  static WinScreen2 + #51, #3967
  static WinScreen2 + #52, #3967
  static WinScreen2 + #53, #3967
  static WinScreen2 + #54, #3967
  static WinScreen2 + #55, #3967
  static WinScreen2 + #56, #3967
  static WinScreen2 + #57, #3967
  static WinScreen2 + #58, #3967
  static WinScreen2 + #59, #3967
  static WinScreen2 + #60, #3967
  static WinScreen2 + #61, #3967
  static WinScreen2 + #62, #3967
  static WinScreen2 + #63, #3967
  static WinScreen2 + #64, #3967
  static WinScreen2 + #65, #3967
  static WinScreen2 + #66, #3967
  static WinScreen2 + #67, #3967
  static WinScreen2 + #68, #127
  static WinScreen2 + #69, #127
  static WinScreen2 + #70, #127
  static WinScreen2 + #71, #3967
  static WinScreen2 + #72, #127
  static WinScreen2 + #73, #3967
  static WinScreen2 + #74, #3967
  static WinScreen2 + #75, #127
  static WinScreen2 + #76, #127
  static WinScreen2 + #77, #127
  static WinScreen2 + #78, #127
  static WinScreen2 + #79, #127

  ;Linha 2
  static WinScreen2 + #80, #127
  static WinScreen2 + #81, #127
  static WinScreen2 + #82, #3967
  static WinScreen2 + #83, #127
  static WinScreen2 + #84, #127
  static WinScreen2 + #85, #2313
  static WinScreen2 + #86, #2313
  static WinScreen2 + #87, #2313
  static WinScreen2 + #88, #2313
  static WinScreen2 + #89, #2313
  static WinScreen2 + #90, #265
  static WinScreen2 + #91, #265
  static WinScreen2 + #92, #265
  static WinScreen2 + #93, #265
  static WinScreen2 + #94, #265
  static WinScreen2 + #95, #265
  static WinScreen2 + #96, #265
  static WinScreen2 + #97, #265
  static WinScreen2 + #98, #265
  static WinScreen2 + #99, #265
  static WinScreen2 + #100, #265
  static WinScreen2 + #101, #265
  static WinScreen2 + #102, #265
  static WinScreen2 + #103, #265
  static WinScreen2 + #104, #265
  static WinScreen2 + #105, #265
  static WinScreen2 + #106, #265
  static WinScreen2 + #107, #265
  static WinScreen2 + #108, #265
  static WinScreen2 + #109, #265
  static WinScreen2 + #110, #2313
  static WinScreen2 + #111, #2313
  static WinScreen2 + #112, #2313
  static WinScreen2 + #113, #2313
  static WinScreen2 + #114, #2313
  static WinScreen2 + #115, #127
  static WinScreen2 + #116, #127
  static WinScreen2 + #117, #127
  static WinScreen2 + #118, #127
  static WinScreen2 + #119, #127

  ;Linha 3
  static WinScreen2 + #120, #127
  static WinScreen2 + #121, #127
  static WinScreen2 + #122, #3967
  static WinScreen2 + #123, #3967
  static WinScreen2 + #124, #9
  static WinScreen2 + #125, #2313
  static WinScreen2 + #126, #2313
  static WinScreen2 + #127, #2313
  static WinScreen2 + #128, #2313
  static WinScreen2 + #129, #2313
  static WinScreen2 + #130, #265
  static WinScreen2 + #131, #265
  static WinScreen2 + #132, #265
  static WinScreen2 + #133, #265
  static WinScreen2 + #134, #265
  static WinScreen2 + #135, #265
  static WinScreen2 + #136, #265
  static WinScreen2 + #137, #265
  static WinScreen2 + #138, #265
  static WinScreen2 + #139, #265
  static WinScreen2 + #140, #265
  static WinScreen2 + #141, #265
  static WinScreen2 + #142, #265
  static WinScreen2 + #143, #265
  static WinScreen2 + #144, #265
  static WinScreen2 + #145, #265
  static WinScreen2 + #146, #265
  static WinScreen2 + #147, #265
  static WinScreen2 + #148, #265
  static WinScreen2 + #149, #265
  static WinScreen2 + #150, #2313
  static WinScreen2 + #151, #2313
  static WinScreen2 + #152, #2313
  static WinScreen2 + #153, #2313
  static WinScreen2 + #154, #2313
  static WinScreen2 + #155, #127
  static WinScreen2 + #156, #127
  static WinScreen2 + #157, #127
  static WinScreen2 + #158, #127
  static WinScreen2 + #159, #127

  ;Linha 4
  static WinScreen2 + #160, #127
  static WinScreen2 + #161, #127
  static WinScreen2 + #162, #9
  static WinScreen2 + #163, #9
  static WinScreen2 + #164, #3967
  static WinScreen2 + #165, #2313
  static WinScreen2 + #166, #2313
  static WinScreen2 + #167, #2313
  static WinScreen2 + #168, #2313
  static WinScreen2 + #169, #2313
  static WinScreen2 + #170, #265
  static WinScreen2 + #171, #2825
  static WinScreen2 + #172, #2825
  static WinScreen2 + #173, #2825
  static WinScreen2 + #174, #2825
  static WinScreen2 + #175, #2852
  static WinScreen2 + #176, #265
  static WinScreen2 + #177, #265
  static WinScreen2 + #178, #265
  static WinScreen2 + #179, #2825
  static WinScreen2 + #180, #2825
  static WinScreen2 + #181, #265
  static WinScreen2 + #182, #265
  static WinScreen2 + #183, #265
  static WinScreen2 + #184, #265
  static WinScreen2 + #185, #2825
  static WinScreen2 + #186, #2825
  static WinScreen2 + #187, #2825
  static WinScreen2 + #188, #2852
  static WinScreen2 + #189, #265
  static WinScreen2 + #190, #2313
  static WinScreen2 + #191, #2313
  static WinScreen2 + #192, #2313
  static WinScreen2 + #193, #2313
  static WinScreen2 + #194, #2313
  static WinScreen2 + #195, #127
  static WinScreen2 + #196, #127
  static WinScreen2 + #197, #127
  static WinScreen2 + #198, #127
  static WinScreen2 + #199, #127

  ;Linha 5
  static WinScreen2 + #200, #127
  static WinScreen2 + #201, #9
  static WinScreen2 + #202, #3967
  static WinScreen2 + #203, #3967
  static WinScreen2 + #204, #3967
  static WinScreen2 + #205, #2313
  static WinScreen2 + #206, #2313
  static WinScreen2 + #207, #2313
  static WinScreen2 + #208, #2313
  static WinScreen2 + #209, #2313
  static WinScreen2 + #210, #265
  static WinScreen2 + #211, #2825
  static WinScreen2 + #212, #2852
  static WinScreen2 + #213, #265
  static WinScreen2 + #214, #265
  static WinScreen2 + #215, #2825
  static WinScreen2 + #216, #2852
  static WinScreen2 + #217, #265
  static WinScreen2 + #218, #2825
  static WinScreen2 + #219, #2852
  static WinScreen2 + #220, #2852
  static WinScreen2 + #221, #2825
  static WinScreen2 + #222, #265
  static WinScreen2 + #223, #265
  static WinScreen2 + #224, #2825
  static WinScreen2 + #225, #2825
  static WinScreen2 + #226, #265
  static WinScreen2 + #227, #2825
  static WinScreen2 + #228, #2825
  static WinScreen2 + #229, #2852
  static WinScreen2 + #230, #2313
  static WinScreen2 + #231, #2313
  static WinScreen2 + #232, #2313
  static WinScreen2 + #233, #2313
  static WinScreen2 + #234, #2313
  static WinScreen2 + #235, #127
  static WinScreen2 + #236, #127
  static WinScreen2 + #237, #127
  static WinScreen2 + #238, #127
  static WinScreen2 + #239, #127

  ;Linha 6
  static WinScreen2 + #240, #127
  static WinScreen2 + #241, #9
  static WinScreen2 + #242, #3967
  static WinScreen2 + #243, #3967
  static WinScreen2 + #244, #9
  static WinScreen2 + #245, #2313
  static WinScreen2 + #246, #2313
  static WinScreen2 + #247, #2313
  static WinScreen2 + #248, #2313
  static WinScreen2 + #249, #2313
  static WinScreen2 + #250, #265
  static WinScreen2 + #251, #2825
  static WinScreen2 + #252, #2852
  static WinScreen2 + #253, #265
  static WinScreen2 + #254, #265
  static WinScreen2 + #255, #2825
  static WinScreen2 + #256, #2852
  static WinScreen2 + #257, #2825
  static WinScreen2 + #258, #2852
  static WinScreen2 + #259, #265
  static WinScreen2 + #260, #265
  static WinScreen2 + #261, #265
  static WinScreen2 + #262, #2825
  static WinScreen2 + #263, #265
  static WinScreen2 + #264, #2825
  static WinScreen2 + #265, #2852
  static WinScreen2 + #266, #265
  static WinScreen2 + #267, #265
  static WinScreen2 + #268, #2825
  static WinScreen2 + #269, #2852
  static WinScreen2 + #270, #2313
  static WinScreen2 + #271, #2313
  static WinScreen2 + #272, #2313
  static WinScreen2 + #273, #2313
  static WinScreen2 + #274, #2313
  static WinScreen2 + #275, #2569
  static WinScreen2 + #276, #2569
  static WinScreen2 + #277, #2569
  static WinScreen2 + #278, #2569
  static WinScreen2 + #279, #3967

  ;Linha 7
  static WinScreen2 + #280, #127
  static WinScreen2 + #281, #9
  static WinScreen2 + #282, #3967
  static WinScreen2 + #283, #3967
  static WinScreen2 + #284, #9
  static WinScreen2 + #285, #2313
  static WinScreen2 + #286, #2313
  static WinScreen2 + #287, #2313
  static WinScreen2 + #288, #2313
  static WinScreen2 + #289, #2313
  static WinScreen2 + #290, #265
  static WinScreen2 + #291, #2825
  static WinScreen2 + #292, #2852
  static WinScreen2 + #293, #265
  static WinScreen2 + #294, #265
  static WinScreen2 + #295, #2825
  static WinScreen2 + #296, #2852
  static WinScreen2 + #297, #2825
  static WinScreen2 + #298, #2852
  static WinScreen2 + #299, #265
  static WinScreen2 + #300, #265
  static WinScreen2 + #301, #265
  static WinScreen2 + #302, #2825
  static WinScreen2 + #303, #265
  static WinScreen2 + #304, #2825
  static WinScreen2 + #305, #2852
  static WinScreen2 + #306, #265
  static WinScreen2 + #307, #265
  static WinScreen2 + #308, #2825
  static WinScreen2 + #309, #2852
  static WinScreen2 + #310, #2313
  static WinScreen2 + #311, #2313
  static WinScreen2 + #312, #2313
  static WinScreen2 + #313, #2313
  static WinScreen2 + #314, #2313
  static WinScreen2 + #315, #2569
  static WinScreen2 + #316, #2569
  static WinScreen2 + #317, #2569
  static WinScreen2 + #318, #2569
  static WinScreen2 + #319, #3967

  ;Linha 8
  static WinScreen2 + #320, #127
  static WinScreen2 + #321, #9
  static WinScreen2 + #322, #3967
  static WinScreen2 + #323, #3967
  static WinScreen2 + #324, #3967
  static WinScreen2 + #325, #2313
  static WinScreen2 + #326, #2313
  static WinScreen2 + #327, #2313
  static WinScreen2 + #328, #2313
  static WinScreen2 + #329, #2313
  static WinScreen2 + #330, #265
  static WinScreen2 + #331, #2825
  static WinScreen2 + #332, #2825
  static WinScreen2 + #333, #2825
  static WinScreen2 + #334, #2825
  static WinScreen2 + #335, #2852
  static WinScreen2 + #336, #2852
  static WinScreen2 + #337, #2825
  static WinScreen2 + #338, #2852
  static WinScreen2 + #339, #265
  static WinScreen2 + #340, #265
  static WinScreen2 + #341, #265
  static WinScreen2 + #342, #2825
  static WinScreen2 + #343, #265
  static WinScreen2 + #344, #2825
  static WinScreen2 + #345, #2852
  static WinScreen2 + #346, #265
  static WinScreen2 + #347, #265
  static WinScreen2 + #348, #2825
  static WinScreen2 + #349, #2852
  static WinScreen2 + #350, #2313
  static WinScreen2 + #351, #2313
  static WinScreen2 + #352, #2313
  static WinScreen2 + #353, #2313
  static WinScreen2 + #354, #2313
  static WinScreen2 + #355, #2569
  static WinScreen2 + #356, #2569
  static WinScreen2 + #357, #2569
  static WinScreen2 + #358, #2569
  static WinScreen2 + #359, #3967

  ;Linha 9
  static WinScreen2 + #360, #127
  static WinScreen2 + #361, #9
  static WinScreen2 + #362, #9
  static WinScreen2 + #363, #9
  static WinScreen2 + #364, #3967
  static WinScreen2 + #365, #2313
  static WinScreen2 + #366, #2313
  static WinScreen2 + #367, #2313
  static WinScreen2 + #368, #2313
  static WinScreen2 + #369, #2313
  static WinScreen2 + #370, #265
  static WinScreen2 + #371, #2825
  static WinScreen2 + #372, #2825
  static WinScreen2 + #373, #2825
  static WinScreen2 + #374, #2825
  static WinScreen2 + #375, #2852
  static WinScreen2 + #376, #2852
  static WinScreen2 + #377, #2825
  static WinScreen2 + #378, #2852
  static WinScreen2 + #379, #265
  static WinScreen2 + #380, #265
  static WinScreen2 + #381, #265
  static WinScreen2 + #382, #2825
  static WinScreen2 + #383, #265
  static WinScreen2 + #384, #2825
  static WinScreen2 + #385, #2852
  static WinScreen2 + #386, #265
  static WinScreen2 + #387, #265
  static WinScreen2 + #388, #2825
  static WinScreen2 + #389, #2852
  static WinScreen2 + #390, #2313
  static WinScreen2 + #391, #2313
  static WinScreen2 + #392, #2313
  static WinScreen2 + #393, #2313
  static WinScreen2 + #394, #2313
  static WinScreen2 + #395, #2569
  static WinScreen2 + #396, #2569
  static WinScreen2 + #397, #2569
  static WinScreen2 + #398, #3967
  static WinScreen2 + #399, #3967

  ;Linha 10
  static WinScreen2 + #400, #127
  static WinScreen2 + #401, #9
  static WinScreen2 + #402, #3967
  static WinScreen2 + #403, #9
  static WinScreen2 + #404, #3967
  static WinScreen2 + #405, #2313
  static WinScreen2 + #406, #2313
  static WinScreen2 + #407, #2313
  static WinScreen2 + #408, #2313
  static WinScreen2 + #409, #2313
  static WinScreen2 + #410, #265
  static WinScreen2 + #411, #2825
  static WinScreen2 + #412, #2852
  static WinScreen2 + #413, #265
  static WinScreen2 + #414, #265
  static WinScreen2 + #415, #2825
  static WinScreen2 + #416, #2852
  static WinScreen2 + #417, #2825
  static WinScreen2 + #418, #2852
  static WinScreen2 + #419, #265
  static WinScreen2 + #420, #265
  static WinScreen2 + #421, #265
  static WinScreen2 + #422, #2825
  static WinScreen2 + #423, #265
  static WinScreen2 + #424, #2825
  static WinScreen2 + #425, #2825
  static WinScreen2 + #426, #2825
  static WinScreen2 + #427, #2825
  static WinScreen2 + #428, #2825
  static WinScreen2 + #429, #2852
  static WinScreen2 + #430, #2313
  static WinScreen2 + #431, #2313
  static WinScreen2 + #432, #2313
  static WinScreen2 + #433, #2313
  static WinScreen2 + #434, #2313
  static WinScreen2 + #435, #2569
  static WinScreen2 + #436, #2569
  static WinScreen2 + #437, #127
  static WinScreen2 + #438, #2569
  static WinScreen2 + #439, #3967

  ;Linha 11
  static WinScreen2 + #440, #127
  static WinScreen2 + #441, #9
  static WinScreen2 + #442, #3967
  static WinScreen2 + #443, #3967
  static WinScreen2 + #444, #3967
  static WinScreen2 + #445, #2313
  static WinScreen2 + #446, #2313
  static WinScreen2 + #447, #2313
  static WinScreen2 + #448, #2313
  static WinScreen2 + #449, #2313
  static WinScreen2 + #450, #265
  static WinScreen2 + #451, #2825
  static WinScreen2 + #452, #2852
  static WinScreen2 + #453, #265
  static WinScreen2 + #454, #265
  static WinScreen2 + #455, #2825
  static WinScreen2 + #456, #2852
  static WinScreen2 + #457, #2825
  static WinScreen2 + #458, #2852
  static WinScreen2 + #459, #265
  static WinScreen2 + #460, #265
  static WinScreen2 + #461, #265
  static WinScreen2 + #462, #2825
  static WinScreen2 + #463, #265
  static WinScreen2 + #464, #2825
  static WinScreen2 + #465, #265
  static WinScreen2 + #466, #265
  static WinScreen2 + #467, #265
  static WinScreen2 + #468, #2825
  static WinScreen2 + #469, #2852
  static WinScreen2 + #470, #2313
  static WinScreen2 + #471, #2313
  static WinScreen2 + #472, #2313
  static WinScreen2 + #473, #2313
  static WinScreen2 + #474, #2313
  static WinScreen2 + #475, #2569
  static WinScreen2 + #476, #127
  static WinScreen2 + #477, #2569
  static WinScreen2 + #478, #2569
  static WinScreen2 + #479, #3967

  ;Linha 12
  static WinScreen2 + #480, #127
  static WinScreen2 + #481, #9
  static WinScreen2 + #482, #9
  static WinScreen2 + #483, #9
  static WinScreen2 + #484, #3967
  static WinScreen2 + #485, #2313
  static WinScreen2 + #486, #2313
  static WinScreen2 + #487, #2313
  static WinScreen2 + #488, #2313
  static WinScreen2 + #489, #2313
  static WinScreen2 + #490, #265
  static WinScreen2 + #491, #2825
  static WinScreen2 + #492, #2852
  static WinScreen2 + #493, #265
  static WinScreen2 + #494, #265
  static WinScreen2 + #495, #2825
  static WinScreen2 + #496, #2852
  static WinScreen2 + #497, #265
  static WinScreen2 + #498, #2825
  static WinScreen2 + #499, #2852
  static WinScreen2 + #500, #2852
  static WinScreen2 + #501, #2825
  static WinScreen2 + #502, #265
  static WinScreen2 + #503, #265
  static WinScreen2 + #504, #2825
  static WinScreen2 + #505, #265
  static WinScreen2 + #506, #265
  static WinScreen2 + #507, #265
  static WinScreen2 + #508, #2825
  static WinScreen2 + #509, #2852
  static WinScreen2 + #510, #2313
  static WinScreen2 + #511, #2313
  static WinScreen2 + #512, #2313
  static WinScreen2 + #513, #2313
  static WinScreen2 + #514, #2313
  static WinScreen2 + #515, #127
  static WinScreen2 + #516, #2569
  static WinScreen2 + #517, #2569
  static WinScreen2 + #518, #2569
  static WinScreen2 + #519, #3967

  ;Linha 13
  static WinScreen2 + #520, #127
  static WinScreen2 + #521, #9
  static WinScreen2 + #522, #3967
  static WinScreen2 + #523, #9
  static WinScreen2 + #524, #9
  static WinScreen2 + #525, #2313
  static WinScreen2 + #526, #2313
  static WinScreen2 + #527, #2313
  static WinScreen2 + #528, #2313
  static WinScreen2 + #529, #2313
  static WinScreen2 + #530, #265
  static WinScreen2 + #531, #2825
  static WinScreen2 + #532, #2825
  static WinScreen2 + #533, #2825
  static WinScreen2 + #534, #2825
  static WinScreen2 + #535, #2852
  static WinScreen2 + #536, #265
  static WinScreen2 + #537, #265
  static WinScreen2 + #538, #265
  static WinScreen2 + #539, #2825
  static WinScreen2 + #540, #2825
  static WinScreen2 + #541, #265
  static WinScreen2 + #542, #265
  static WinScreen2 + #543, #265
  static WinScreen2 + #544, #2825
  static WinScreen2 + #545, #265
  static WinScreen2 + #546, #265
  static WinScreen2 + #547, #265
  static WinScreen2 + #548, #2825
  static WinScreen2 + #549, #2852
  static WinScreen2 + #550, #2313
  static WinScreen2 + #551, #2313
  static WinScreen2 + #552, #2313
  static WinScreen2 + #553, #2313
  static WinScreen2 + #554, #2313
  static WinScreen2 + #555, #2569
  static WinScreen2 + #556, #2569
  static WinScreen2 + #557, #2569
  static WinScreen2 + #558, #3967
  static WinScreen2 + #559, #3967

  ;Linha 14
  static WinScreen2 + #560, #127
  static WinScreen2 + #561, #9
  static WinScreen2 + #562, #127
  static WinScreen2 + #563, #3967
  static WinScreen2 + #564, #3967
  static WinScreen2 + #565, #2313
  static WinScreen2 + #566, #2313
  static WinScreen2 + #567, #2313
  static WinScreen2 + #568, #2313
  static WinScreen2 + #569, #2313
  static WinScreen2 + #570, #265
  static WinScreen2 + #571, #265
  static WinScreen2 + #572, #265
  static WinScreen2 + #573, #265
  static WinScreen2 + #574, #265
  static WinScreen2 + #575, #265
  static WinScreen2 + #576, #265
  static WinScreen2 + #577, #265
  static WinScreen2 + #578, #265
  static WinScreen2 + #579, #265
  static WinScreen2 + #580, #265
  static WinScreen2 + #581, #265
  static WinScreen2 + #582, #265
  static WinScreen2 + #583, #265
  static WinScreen2 + #584, #265
  static WinScreen2 + #585, #265
  static WinScreen2 + #586, #265
  static WinScreen2 + #587, #265
  static WinScreen2 + #588, #265
  static WinScreen2 + #589, #265
  static WinScreen2 + #590, #2313
  static WinScreen2 + #591, #2313
  static WinScreen2 + #592, #2313
  static WinScreen2 + #593, #2313
  static WinScreen2 + #594, #2313
  static WinScreen2 + #595, #2569
  static WinScreen2 + #596, #2569
  static WinScreen2 + #597, #127
  static WinScreen2 + #598, #2569
  static WinScreen2 + #599, #3967

  ;Linha 15
  static WinScreen2 + #600, #127
  static WinScreen2 + #601, #9
  static WinScreen2 + #602, #9
  static WinScreen2 + #603, #9
  static WinScreen2 + #604, #3967
  static WinScreen2 + #605, #2313
  static WinScreen2 + #606, #2313
  static WinScreen2 + #607, #2313
  static WinScreen2 + #608, #2313
  static WinScreen2 + #609, #2313
  static WinScreen2 + #610, #3849
  static WinScreen2 + #611, #3849
  static WinScreen2 + #612, #3849
  static WinScreen2 + #613, #3849
  static WinScreen2 + #614, #3849
  static WinScreen2 + #615, #3849
  static WinScreen2 + #616, #3849
  static WinScreen2 + #617, #3849
  static WinScreen2 + #618, #3849
  static WinScreen2 + #619, #3849
  static WinScreen2 + #620, #3849
  static WinScreen2 + #621, #3849
  static WinScreen2 + #622, #3849
  static WinScreen2 + #623, #3849
  static WinScreen2 + #624, #3849
  static WinScreen2 + #625, #3849
  static WinScreen2 + #626, #3849
  static WinScreen2 + #627, #3849
  static WinScreen2 + #628, #3849
  static WinScreen2 + #629, #3967
  static WinScreen2 + #630, #2313
  static WinScreen2 + #631, #2313
  static WinScreen2 + #632, #2313
  static WinScreen2 + #633, #2313
  static WinScreen2 + #634, #2313
  static WinScreen2 + #635, #2569
  static WinScreen2 + #636, #127
  static WinScreen2 + #637, #2569
  static WinScreen2 + #638, #2569
  static WinScreen2 + #639, #3967

  ;Linha 16
  static WinScreen2 + #640, #127
  static WinScreen2 + #641, #9
  static WinScreen2 + #642, #3967
  static WinScreen2 + #643, #9
  static WinScreen2 + #644, #9
  static WinScreen2 + #645, #2313
  static WinScreen2 + #646, #2313
  static WinScreen2 + #647, #2313
  static WinScreen2 + #648, #2313
  static WinScreen2 + #649, #2313
  static WinScreen2 + #650, #3849
  static WinScreen2 + #651, #335
  static WinScreen2 + #652, #371
  static WinScreen2 + #653, #3849
  static WinScreen2 + #654, #324
  static WinScreen2 + #655, #325
  static WinScreen2 + #656, #342
  static WinScreen2 + #657, #371
  static WinScreen2 + #658, #3849
  static WinScreen2 + #659, #338
  static WinScreen2 + #660, #357
  static WinScreen2 + #661, #355
  static WinScreen2 + #662, #367
  static WinScreen2 + #663, #365
  static WinScreen2 + #664, #357
  static WinScreen2 + #665, #366
  static WinScreen2 + #666, #356
  static WinScreen2 + #667, #353
  static WinScreen2 + #668, #365
  static WinScreen2 + #669, #2362
  static WinScreen2 + #670, #2313
  static WinScreen2 + #671, #2313
  static WinScreen2 + #672, #2313
  static WinScreen2 + #673, #2313
  static WinScreen2 + #674, #2313
  static WinScreen2 + #675, #127
  static WinScreen2 + #676, #2569
  static WinScreen2 + #677, #2569
  static WinScreen2 + #678, #2569
  static WinScreen2 + #679, #127

  ;Linha 17
  static WinScreen2 + #680, #3967
  static WinScreen2 + #681, #9
  static WinScreen2 + #682, #127
  static WinScreen2 + #683, #3967
  static WinScreen2 + #684, #127
  static WinScreen2 + #685, #2313
  static WinScreen2 + #686, #2313
  static WinScreen2 + #687, #2313
  static WinScreen2 + #688, #2313
  static WinScreen2 + #689, #2313
  static WinScreen2 + #690, #3849
  static WinScreen2 + #691, #3849
  static WinScreen2 + #692, #3849
  static WinScreen2 + #693, #3849
  static WinScreen2 + #694, #3849
  static WinScreen2 + #695, #3849
  static WinScreen2 + #696, #3849
  static WinScreen2 + #697, #3849
  static WinScreen2 + #698, #3849
  static WinScreen2 + #699, #3849
  static WinScreen2 + #700, #3849
  static WinScreen2 + #701, #3849
  static WinScreen2 + #702, #3849
  static WinScreen2 + #703, #3849
  static WinScreen2 + #704, #3849
  static WinScreen2 + #705, #3849
  static WinScreen2 + #706, #3849
  static WinScreen2 + #707, #3849
  static WinScreen2 + #708, #3849
  static WinScreen2 + #709, #3849
  static WinScreen2 + #710, #2313
  static WinScreen2 + #711, #2313
  static WinScreen2 + #712, #2313
  static WinScreen2 + #713, #2313
  static WinScreen2 + #714, #2313
  static WinScreen2 + #715, #2569
  static WinScreen2 + #716, #2569
  static WinScreen2 + #717, #2569
  static WinScreen2 + #718, #3967
  static WinScreen2 + #719, #127

  ;Linha 18
  static WinScreen2 + #720, #127
  static WinScreen2 + #721, #127
  static WinScreen2 + #722, #9
  static WinScreen2 + #723, #3967
  static WinScreen2 + #724, #127
  static WinScreen2 + #725, #2313
  static WinScreen2 + #726, #2313
  static WinScreen2 + #727, #2313
  static WinScreen2 + #728, #2313
  static WinScreen2 + #729, #2313
  static WinScreen2 + #730, #265
  static WinScreen2 + #731, #3967
  static WinScreen2 + #732, #3967
  static WinScreen2 + #733, #3967
  static WinScreen2 + #734, #2383
  static WinScreen2 + #735, #2389
  static WinScreen2 + #736, #2388
  static WinScreen2 + #737, #2386
  static WinScreen2 + #738, #2369
  static WinScreen2 + #739, #3967
  static WinScreen2 + #740, #2386
  static WinScreen2 + #741, #2383
  static WinScreen2 + #742, #2372
  static WinScreen2 + #743, #2369
  static WinScreen2 + #744, #2372
  static WinScreen2 + #745, #2369
  static WinScreen2 + #746, #3967
  static WinScreen2 + #747, #3967
  static WinScreen2 + #748, #3967
  static WinScreen2 + #749, #265
  static WinScreen2 + #750, #2313
  static WinScreen2 + #751, #2313
  static WinScreen2 + #752, #2313
  static WinScreen2 + #753, #2313
  static WinScreen2 + #754, #2313
  static WinScreen2 + #755, #2569
  static WinScreen2 + #756, #2569
  static WinScreen2 + #757, #3967
  static WinScreen2 + #758, #2569
  static WinScreen2 + #759, #127

  ;Linha 19
  static WinScreen2 + #760, #127
  static WinScreen2 + #761, #127
  static WinScreen2 + #762, #127
  static WinScreen2 + #763, #9
  static WinScreen2 + #764, #3967
  static WinScreen2 + #765, #2313
  static WinScreen2 + #766, #2313
  static WinScreen2 + #767, #2313
  static WinScreen2 + #768, #2313
  static WinScreen2 + #769, #2313
  static WinScreen2 + #770, #265
  static WinScreen2 + #771, #265
  static WinScreen2 + #772, #3967
  static WinScreen2 + #773, #3967
  static WinScreen2 + #774, #3967
  static WinScreen2 + #775, #3967
  static WinScreen2 + #776, #3967
  static WinScreen2 + #777, #3967
  static WinScreen2 + #778, #3967
  static WinScreen2 + #779, #3967
  static WinScreen2 + #780, #3967
  static WinScreen2 + #781, #3967
  static WinScreen2 + #782, #3967
  static WinScreen2 + #783, #3967
  static WinScreen2 + #784, #3967
  static WinScreen2 + #785, #3967
  static WinScreen2 + #786, #3967
  static WinScreen2 + #787, #3967
  static WinScreen2 + #788, #265
  static WinScreen2 + #789, #265
  static WinScreen2 + #790, #2313
  static WinScreen2 + #791, #2313
  static WinScreen2 + #792, #2313
  static WinScreen2 + #793, #2313
  static WinScreen2 + #794, #2313
  static WinScreen2 + #795, #2569
  static WinScreen2 + #796, #127
  static WinScreen2 + #797, #2569
  static WinScreen2 + #798, #127
  static WinScreen2 + #799, #127

  ;Linha 20
  static WinScreen2 + #800, #127
  static WinScreen2 + #801, #127
  static WinScreen2 + #802, #127
  static WinScreen2 + #803, #127
  static WinScreen2 + #804, #9
  static WinScreen2 + #805, #2313
  static WinScreen2 + #806, #2313
  static WinScreen2 + #807, #2313
  static WinScreen2 + #808, #2313
  static WinScreen2 + #809, #2313
  static WinScreen2 + #810, #265
  static WinScreen2 + #811, #265
  static WinScreen2 + #812, #265
  static WinScreen2 + #813, #265
  static WinScreen2 + #814, #3967
  static WinScreen2 + #815, #2369
  static WinScreen2 + #816, #2380
  static WinScreen2 + #817, #2380
  static WinScreen2 + #818, #2349
  static WinScreen2 + #819, #2391
  static WinScreen2 + #820, #2377
  static WinScreen2 + #821, #2382
  static WinScreen2 + #822, #2337
  static WinScreen2 + #823, #2337
  static WinScreen2 + #824, #2337
  static WinScreen2 + #825, #3967
  static WinScreen2 + #826, #265
  static WinScreen2 + #827, #265
  static WinScreen2 + #828, #265
  static WinScreen2 + #829, #265
  static WinScreen2 + #830, #2313
  static WinScreen2 + #831, #2313
  static WinScreen2 + #832, #2313
  static WinScreen2 + #833, #2313
  static WinScreen2 + #834, #2313
  static WinScreen2 + #835, #127
  static WinScreen2 + #836, #2569
  static WinScreen2 + #837, #127
  static WinScreen2 + #838, #127
  static WinScreen2 + #839, #127

  ;Linha 21
  static WinScreen2 + #840, #127
  static WinScreen2 + #841, #127
  static WinScreen2 + #842, #127
  static WinScreen2 + #843, #127
  static WinScreen2 + #844, #127
  static WinScreen2 + #845, #2313
  static WinScreen2 + #846, #2313
  static WinScreen2 + #847, #2313
  static WinScreen2 + #848, #2313
  static WinScreen2 + #849, #2313
  static WinScreen2 + #850, #265
  static WinScreen2 + #851, #265
  static WinScreen2 + #852, #265
  static WinScreen2 + #853, #265
  static WinScreen2 + #854, #265
  static WinScreen2 + #855, #265
  static WinScreen2 + #856, #265
  static WinScreen2 + #857, #265
  static WinScreen2 + #858, #265
  static WinScreen2 + #859, #265
  static WinScreen2 + #860, #265
  static WinScreen2 + #861, #265
  static WinScreen2 + #862, #265
  static WinScreen2 + #863, #265
  static WinScreen2 + #864, #265
  static WinScreen2 + #865, #265
  static WinScreen2 + #866, #265
  static WinScreen2 + #867, #265
  static WinScreen2 + #868, #265
  static WinScreen2 + #869, #265
  static WinScreen2 + #870, #2313
  static WinScreen2 + #871, #2313
  static WinScreen2 + #872, #2313
  static WinScreen2 + #873, #2313
  static WinScreen2 + #874, #2313
  static WinScreen2 + #875, #2569
  static WinScreen2 + #876, #127
  static WinScreen2 + #877, #127
  static WinScreen2 + #878, #127
  static WinScreen2 + #879, #127

  ;Linha 22
  static WinScreen2 + #880, #127
  static WinScreen2 + #881, #127
  static WinScreen2 + #882, #127
  static WinScreen2 + #883, #127
  static WinScreen2 + #884, #127
  static WinScreen2 + #885, #2313
  static WinScreen2 + #886, #2313
  static WinScreen2 + #887, #2313
  static WinScreen2 + #888, #2313
  static WinScreen2 + #889, #2313
  static WinScreen2 + #890, #127
  static WinScreen2 + #891, #127
  static WinScreen2 + #892, #127
  static WinScreen2 + #893, #127
  static WinScreen2 + #894, #127
  static WinScreen2 + #895, #127
  static WinScreen2 + #896, #127
  static WinScreen2 + #897, #1033
  static WinScreen2 + #898, #127
  static WinScreen2 + #899, #127
  static WinScreen2 + #900, #2569
  static WinScreen2 + #901, #2569
  static WinScreen2 + #902, #2569
  static WinScreen2 + #903, #2569
  static WinScreen2 + #904, #2569
  static WinScreen2 + #905, #2569
  static WinScreen2 + #906, #2569
  static WinScreen2 + #907, #2569
  static WinScreen2 + #908, #2569
  static WinScreen2 + #909, #2569
  static WinScreen2 + #910, #2313
  static WinScreen2 + #911, #2313
  static WinScreen2 + #912, #2313
  static WinScreen2 + #913, #2313
  static WinScreen2 + #914, #2313
  static WinScreen2 + #915, #3967
  static WinScreen2 + #916, #127
  static WinScreen2 + #917, #127
  static WinScreen2 + #918, #127
  static WinScreen2 + #919, #127

  ;Linha 23
  static WinScreen2 + #920, #127
  static WinScreen2 + #921, #127
  static WinScreen2 + #922, #127
  static WinScreen2 + #923, #127
  static WinScreen2 + #924, #3967
  static WinScreen2 + #925, #2313
  static WinScreen2 + #926, #2313
  static WinScreen2 + #927, #2313
  static WinScreen2 + #928, #2313
  static WinScreen2 + #929, #2313
  static WinScreen2 + #930, #127
  static WinScreen2 + #931, #127
  static WinScreen2 + #932, #127
  static WinScreen2 + #933, #127
  static WinScreen2 + #934, #127
  static WinScreen2 + #935, #1033
  static WinScreen2 + #936, #1033
  static WinScreen2 + #937, #3967
  static WinScreen2 + #938, #127
  static WinScreen2 + #939, #127
  static WinScreen2 + #940, #2569
  static WinScreen2 + #941, #2569
  static WinScreen2 + #942, #2569
  static WinScreen2 + #943, #2569
  static WinScreen2 + #944, #2569
  static WinScreen2 + #945, #2569
  static WinScreen2 + #946, #2569
  static WinScreen2 + #947, #2569
  static WinScreen2 + #948, #2569
  static WinScreen2 + #949, #2569
  static WinScreen2 + #950, #2313
  static WinScreen2 + #951, #2313
  static WinScreen2 + #952, #2313
  static WinScreen2 + #953, #2313
  static WinScreen2 + #954, #2313
  static WinScreen2 + #955, #127
  static WinScreen2 + #956, #127
  static WinScreen2 + #957, #127
  static WinScreen2 + #958, #127
  static WinScreen2 + #959, #127

  ;Linha 24
  static WinScreen2 + #960, #127
  static WinScreen2 + #961, #3967
  static WinScreen2 + #962, #3967
  static WinScreen2 + #963, #3967
  static WinScreen2 + #964, #3967
  static WinScreen2 + #965, #2313
  static WinScreen2 + #966, #2313
  static WinScreen2 + #967, #2313
  static WinScreen2 + #968, #2313
  static WinScreen2 + #969, #2313
  static WinScreen2 + #970, #1033
  static WinScreen2 + #971, #1033
  static WinScreen2 + #972, #1033
  static WinScreen2 + #973, #1033
  static WinScreen2 + #974, #1033
  static WinScreen2 + #975, #1033
  static WinScreen2 + #976, #3967
  static WinScreen2 + #977, #3967
  static WinScreen2 + #978, #3967
  static WinScreen2 + #979, #127
  static WinScreen2 + #980, #2569
  static WinScreen2 + #981, #2569
  static WinScreen2 + #982, #2569
  static WinScreen2 + #983, #2569
  static WinScreen2 + #984, #2569
  static WinScreen2 + #985, #2569
  static WinScreen2 + #986, #2569
  static WinScreen2 + #987, #2569
  static WinScreen2 + #988, #2569
  static WinScreen2 + #989, #2569
  static WinScreen2 + #990, #2313
  static WinScreen2 + #991, #2313
  static WinScreen2 + #992, #2313
  static WinScreen2 + #993, #2313
  static WinScreen2 + #994, #2313
  static WinScreen2 + #995, #127
  static WinScreen2 + #996, #127
  static WinScreen2 + #997, #127
  static WinScreen2 + #998, #127
  static WinScreen2 + #999, #127

  ;Linha 25
  static WinScreen2 + #1000, #127
  static WinScreen2 + #1001, #3967
  static WinScreen2 + #1002, #3967
  static WinScreen2 + #1003, #3967
  static WinScreen2 + #1004, #3967
  static WinScreen2 + #1005, #2313
  static WinScreen2 + #1006, #2313
  static WinScreen2 + #1007, #2313
  static WinScreen2 + #1008, #2313
  static WinScreen2 + #1009, #3967
  static WinScreen2 + #1010, #1033
  static WinScreen2 + #1011, #1033
  static WinScreen2 + #1012, #1033
  static WinScreen2 + #1013, #1033
  static WinScreen2 + #1014, #1033
  static WinScreen2 + #1015, #3967
  static WinScreen2 + #1016, #3967
  static WinScreen2 + #1017, #3967
  static WinScreen2 + #1018, #127
  static WinScreen2 + #1019, #127
  static WinScreen2 + #1020, #127
  static WinScreen2 + #1021, #127
  static WinScreen2 + #1022, #127
  static WinScreen2 + #1023, #127
  static WinScreen2 + #1024, #127
  static WinScreen2 + #1025, #127
  static WinScreen2 + #1026, #3967
  static WinScreen2 + #1027, #3967
  static WinScreen2 + #1028, #3967
  static WinScreen2 + #1029, #3967
  static WinScreen2 + #1030, #127
  static WinScreen2 + #1031, #2313
  static WinScreen2 + #1032, #2313
  static WinScreen2 + #1033, #2313
  static WinScreen2 + #1034, #2313
  static WinScreen2 + #1035, #127
  static WinScreen2 + #1036, #127
  static WinScreen2 + #1037, #127
  static WinScreen2 + #1038, #127
  static WinScreen2 + #1039, #127

  ;Linha 26
  static WinScreen2 + #1040, #127
  static WinScreen2 + #1041, #3967
  static WinScreen2 + #1042, #3967
  static WinScreen2 + #1043, #3967
  static WinScreen2 + #1044, #3967
  static WinScreen2 + #1045, #2313
  static WinScreen2 + #1046, #2313
  static WinScreen2 + #1047, #2313
  static WinScreen2 + #1048, #127
  static WinScreen2 + #1049, #127
  static WinScreen2 + #1050, #127
  static WinScreen2 + #1051, #127
  static WinScreen2 + #1052, #127
  static WinScreen2 + #1053, #127
  static WinScreen2 + #1054, #127
  static WinScreen2 + #1055, #127
  static WinScreen2 + #1056, #3967
  static WinScreen2 + #1057, #127
  static WinScreen2 + #1058, #127
  static WinScreen2 + #1059, #127
  static WinScreen2 + #1060, #2569
  static WinScreen2 + #1061, #2569
  static WinScreen2 + #1062, #2569
  static WinScreen2 + #1063, #2569
  static WinScreen2 + #1064, #2569
  static WinScreen2 + #1065, #2569
  static WinScreen2 + #1066, #2569
  static WinScreen2 + #1067, #2569
  static WinScreen2 + #1068, #2569
  static WinScreen2 + #1069, #2569
  static WinScreen2 + #1070, #2569
  static WinScreen2 + #1071, #127
  static WinScreen2 + #1072, #2313
  static WinScreen2 + #1073, #2313
  static WinScreen2 + #1074, #2313
  static WinScreen2 + #1075, #127
  static WinScreen2 + #1076, #127
  static WinScreen2 + #1077, #127
  static WinScreen2 + #1078, #127
  static WinScreen2 + #1079, #127

  ;Linha 27
  static WinScreen2 + #1080, #127
  static WinScreen2 + #1081, #3967
  static WinScreen2 + #1082, #3967
  static WinScreen2 + #1083, #3967
  static WinScreen2 + #1084, #3967
  static WinScreen2 + #1085, #2313
  static WinScreen2 + #1086, #2313
  static WinScreen2 + #1087, #127
  static WinScreen2 + #1088, #127
  static WinScreen2 + #1089, #127
  static WinScreen2 + #1090, #127
  static WinScreen2 + #1091, #127
  static WinScreen2 + #1092, #127
  static WinScreen2 + #1093, #127
  static WinScreen2 + #1094, #127
  static WinScreen2 + #1095, #127
  static WinScreen2 + #1096, #127
  static WinScreen2 + #1097, #127
  static WinScreen2 + #1098, #127
  static WinScreen2 + #1099, #127
  static WinScreen2 + #1100, #127
  static WinScreen2 + #1101, #2569
  static WinScreen2 + #1102, #2569
  static WinScreen2 + #1103, #2569
  static WinScreen2 + #1104, #2569
  static WinScreen2 + #1105, #2569
  static WinScreen2 + #1106, #2569
  static WinScreen2 + #1107, #2569
  static WinScreen2 + #1108, #2569
  static WinScreen2 + #1109, #2569
  static WinScreen2 + #1110, #3967
  static WinScreen2 + #1111, #3967
  static WinScreen2 + #1112, #127
  static WinScreen2 + #1113, #2313
  static WinScreen2 + #1114, #2313
  static WinScreen2 + #1115, #127
  static WinScreen2 + #1116, #127
  static WinScreen2 + #1117, #127
  static WinScreen2 + #1118, #127
  static WinScreen2 + #1119, #127

  ;Linha 28
  static WinScreen2 + #1120, #127
  static WinScreen2 + #1121, #3967
  static WinScreen2 + #1122, #3967
  static WinScreen2 + #1123, #3967
  static WinScreen2 + #1124, #3967
  static WinScreen2 + #1125, #2313
  static WinScreen2 + #1126, #127
  static WinScreen2 + #1127, #127
  static WinScreen2 + #1128, #127
  static WinScreen2 + #1129, #127
  static WinScreen2 + #1130, #127
  static WinScreen2 + #1131, #127
  static WinScreen2 + #1132, #127
  static WinScreen2 + #1133, #127
  static WinScreen2 + #1134, #127
  static WinScreen2 + #1135, #127
  static WinScreen2 + #1136, #127
  static WinScreen2 + #1137, #127
  static WinScreen2 + #1138, #127
  static WinScreen2 + #1139, #127
  static WinScreen2 + #1140, #127
  static WinScreen2 + #1141, #127
  static WinScreen2 + #1142, #127
  static WinScreen2 + #1143, #127
  static WinScreen2 + #1144, #127
  static WinScreen2 + #1145, #127
  static WinScreen2 + #1146, #127
  static WinScreen2 + #1147, #127
  static WinScreen2 + #1148, #3967
  static WinScreen2 + #1149, #3967
  static WinScreen2 + #1150, #3967
  static WinScreen2 + #1151, #127
  static WinScreen2 + #1152, #127
  static WinScreen2 + #1153, #127
  static WinScreen2 + #1154, #2313
  static WinScreen2 + #1155, #127
  static WinScreen2 + #1156, #127
  static WinScreen2 + #1157, #127
  static WinScreen2 + #1158, #127
  static WinScreen2 + #1159, #127

  ;Linha 29
  static WinScreen2 + #1160, #127
  static WinScreen2 + #1161, #127
  static WinScreen2 + #1162, #127
  static WinScreen2 + #1163, #127
  static WinScreen2 + #1164, #127
  static WinScreen2 + #1165, #127
  static WinScreen2 + #1166, #127
  static WinScreen2 + #1167, #127
  static WinScreen2 + #1168, #127
  static WinScreen2 + #1169, #127
  static WinScreen2 + #1170, #127
  static WinScreen2 + #1171, #127
  static WinScreen2 + #1172, #127
  static WinScreen2 + #1173, #127
  static WinScreen2 + #1174, #127
  static WinScreen2 + #1175, #127
  static WinScreen2 + #1176, #127
  static WinScreen2 + #1177, #127
  static WinScreen2 + #1178, #127
  static WinScreen2 + #1179, #127
  static WinScreen2 + #1180, #127
  static WinScreen2 + #1181, #127
  static WinScreen2 + #1182, #127
  static WinScreen2 + #1183, #127
  static WinScreen2 + #1184, #127
  static WinScreen2 + #1185, #127
  static WinScreen2 + #1186, #127
  static WinScreen2 + #1187, #127
  static WinScreen2 + #1188, #3967
  static WinScreen2 + #1189, #3967
  static WinScreen2 + #1190, #3967
  static WinScreen2 + #1191, #127
  static WinScreen2 + #1192, #127
  static WinScreen2 + #1193, #127
  static WinScreen2 + #1194, #127
  static WinScreen2 + #1195, #127
  static WinScreen2 + #1196, #127
  static WinScreen2 + #1197, #127
  static WinScreen2 + #1198, #127
  static WinScreen2 + #1199, #127
;

Tutorial_Screen : string "                                                                                                Tutorial                                                          [w] -                                   [s] -                                   [a] -                                   [d] -                                                                                                                                                           [?] -                                                                           <Enter> -                                                                        Resultados:                                                                     Nada    = 0x                            Duplo   = 1x                            Jackpot = 2x                                                                                                                                                                                                                                                                                                                                                                                                                                         "

; |==================| END |==================|
