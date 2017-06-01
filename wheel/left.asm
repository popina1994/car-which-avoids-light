_wheelLeftInit:
;left.c,6 :: 		void wheelLeftInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;left.c,8 :: 		int pwmPeriod = PWM_TIM4_Init(WHEEL_LEFT_FREQUENCY_PERIOD);
MOVW	R0, #33
BL	_PWM_TIM4_Init+0
;left.c,9 :: 		wheelLeftCurrentDuty = pwmPeriod / MAX_GEARS;
SXTH	R1, R0
MOVW	R0, #9
SXTH	R0, R0
SDIV	R1, R1, R0
MOVW	R0, #lo_addr(_wheelLeftCurrentDuty+0)
MOVT	R0, #hi_addr(_wheelLeftCurrentDuty+0)
STRH	R1, [R0, #0]
;left.c,10 :: 		}
L_end_wheelLeftInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelLeftInit
_wheelLeftStart:
;left.c,12 :: 		void wheelLeftStart()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;left.c,14 :: 		PWM_TIM4_Set_Duty(wheelLeftCurrentDuty,  _PWM_NON_INVERTED, _PWM_CHANNEL4);
MOVW	R0, #lo_addr(_wheelLeftCurrentDuty+0)
MOVT	R0, #hi_addr(_wheelLeftCurrentDuty+0)
LDRSH	R0, [R0, #0]
MOVS	R2, #3
MOVS	R1, #0
BL	_PWM_TIM4_Set_Duty+0
;left.c,15 :: 		PWM_TIM4_Start(_PWM_CHANNEL4, &_GPIO_MODULE_TIM4_CH4_PB9);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM4_CH4_PB9+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM4_CH4_PB9+0)
MOVS	R0, #3
BL	_PWM_TIM4_Start+0
;left.c,16 :: 		}
L_end_wheelLeftStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelLeftStart
_wheelLeftStop:
;left.c,18 :: 		void wheelLeftStop()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;left.c,20 :: 		PWM_TIM4_Stop(_PWM_CHANNEL4);
MOVS	R0, #3
BL	_PWM_TIM4_Stop+0
;left.c,21 :: 		}
L_end_wheelLeftStop:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelLeftStop
