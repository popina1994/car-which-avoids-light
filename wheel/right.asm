_wheelRightInit:
;right.c,6 :: 		void wheelRightInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;right.c,8 :: 		int pwmPeriod = PWM_TIM4_Init(WHEEL_RIGHT_FREQUENCY_PERIOD);
MOVW	R0, #50
BL	_PWM_TIM4_Init+0
;right.c,9 :: 		wheelRightCurrentDuty = pwmPeriod / MAX_GEARS;
SXTH	R1, R0
MOVW	R0, #9
SXTH	R0, R0
SDIV	R1, R1, R0
MOVW	R0, #lo_addr(_wheelRightCurrentDuty+0)
MOVT	R0, #hi_addr(_wheelRightCurrentDuty+0)
STRH	R1, [R0, #0]
;right.c,10 :: 		}
L_end_wheelRightInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelRightInit
_wheelRightStart:
;right.c,12 :: 		void wheelRightStart()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;right.c,14 :: 		PWM_TIM2_Set_Duty(wheelRightCurrentDuty,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #lo_addr(_wheelRightCurrentDuty+0)
MOVT	R0, #hi_addr(_wheelRightCurrentDuty+0)
LDRSH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;right.c,15 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;right.c,16 :: 		}
L_end_wheelRightStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelRightStart
_wheelRightStop:
;right.c,18 :: 		void wheelRightStop()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;right.c,20 :: 		PWM_TIM2_Stop(_PWM_CHANNEL2);
MOVS	R0, #1
BL	_PWM_TIM2_Stop+0
;right.c,21 :: 		}
L_end_wheelRightStop:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelRightStop
