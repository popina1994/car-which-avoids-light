_wheelLeftInit:
;left.c,5 :: 		void wheelLeftInit(const unsigned int maxGears)
; maxGears start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R5, R0
; maxGears end address is: 0 (R0)
; maxGears start address is: 20 (R5)
;left.c,7 :: 		int pwmPeriod = PWM_TIMER_LEFT_INIT(WHEEL_LEFT_FREQUENCY_PERIOD);
MOVW	R0, #33
BL	_PWM_TIM4_Init+0
;left.c,8 :: 		wheelLeftCurrentDuty = pwmPeriod / maxGears;
UXTH	R1, R0
UDIV	R2, R1, R5
; maxGears end address is: 20 (R5)
MOVW	R1, #lo_addr(_wheelLeftCurrentDuty+0)
MOVT	R1, #hi_addr(_wheelLeftCurrentDuty+0)
STRH	R2, [R1, #0]
;left.c,9 :: 		}
L_end_wheelLeftInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelLeftInit
_wheelLeftStart:
;left.c,11 :: 		void wheelLeftStart()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;left.c,14 :: 		wheelLeftCurrentDuty,
MOVW	R0, #lo_addr(_wheelLeftCurrentDuty+0)
MOVT	R0, #hi_addr(_wheelLeftCurrentDuty+0)
LDRSH	R0, [R0, #0]
;left.c,16 :: 		PWM_CHANNEL_LEFT_INTERNAL);
MOVS	R2, #3
;left.c,15 :: 		_PWM_NON_INVERTED,
MOVS	R1, #0
;left.c,14 :: 		wheelLeftCurrentDuty,
;left.c,16 :: 		PWM_CHANNEL_LEFT_INTERNAL);
BL	_PWM_TIM4_Set_Duty+0
;left.c,19 :: 		&PWM_LEFT_MODULE_TIM_CH_PIN);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM4_CH4_PB9+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM4_CH4_PB9+0)
;left.c,18 :: 		PWM_CHANNEL_LEFT_INTERNAL,
MOVS	R0, #3
;left.c,19 :: 		&PWM_LEFT_MODULE_TIM_CH_PIN);
BL	_PWM_TIM4_Start+0
;left.c,20 :: 		}
L_end_wheelLeftStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelLeftStart
_wheelLeftStop:
;left.c,22 :: 		void wheelLeftStop()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;left.c,24 :: 		PWM_TIMER_LEFT_STOP(PWM_CHANNEL_LEFT_INTERNAL);
MOVS	R0, #3
BL	_PWM_TIM4_Stop+0
;left.c,25 :: 		}
L_end_wheelLeftStop:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelLeftStop
