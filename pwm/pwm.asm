_pwmInit:
;pwm.c,5 :: 		void pwmInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;pwm.c,7 :: 		wheelLeftInit(MAX_GEARS);
MOVW	R0, #9
BL	_wheelLeftInit+0
;pwm.c,8 :: 		wheelRightInit(MAX_GEARS);
MOVW	R0, #9
BL	_wheelRightInit+0
;pwm.c,9 :: 		Delay_ms(PWM_TIME_DELAY_MS);
MOVW	R7, #23038
MOVT	R7, #610
NOP
NOP
L_pwmInit0:
SUBS	R7, R7, #1
BNE	L_pwmInit0
NOP
NOP
NOP
;pwm.c,10 :: 		}
L_end_pwmInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _pwmInit
