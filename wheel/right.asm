_wheelRightInit:
;right.c,5 :: 		void wheelRightInit(const unsigned int maxGears)
; maxGears start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R5, R0
; maxGears end address is: 0 (R0)
; maxGears start address is: 20 (R5)
;right.c,7 :: 		int pwmPeriod = PWM_TIMER_RIGHT_INIT(WHEEL_RIGHT_FREQUENCY_PERIOD);
MOVW	R0, #50
BL	_PWM_TIM2_Init+0
;right.c,8 :: 		wheelRightCurrentDuty = pwmPeriod / maxGears;
UXTH	R1, R0
UDIV	R2, R1, R5
; maxGears end address is: 20 (R5)
MOVW	R1, #lo_addr(_wheelRightCurrentDuty+0)
MOVT	R1, #hi_addr(_wheelRightCurrentDuty+0)
STRH	R2, [R1, #0]
;right.c,9 :: 		}
L_end_wheelRightInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelRightInit
_wheelRightStart:
;right.c,11 :: 		void wheelRightStart()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;right.c,13 :: 		PWM_TIMER_RIGHT_SET_DUTY(wheelRightCurrentDuty, _PWM_NON_INVERTED, PWM_CHANNEL_RIGHT_INTERNAL);
MOVW	R0, #lo_addr(_wheelRightCurrentDuty+0)
MOVT	R0, #hi_addr(_wheelRightCurrentDuty+0)
LDRSH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;right.c,14 :: 		PWM_TIMER_RIGHT_START(PWM_CHANNEL_RIGHT_INTERNAL, &PWM_RIGHT_MODULE_TIM_CH_PIN);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;right.c,15 :: 		}
L_end_wheelRightStart:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelRightStart
_wheelRightStop:
;right.c,17 :: 		void wheelRightStop()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;right.c,19 :: 		PWM_TIMER_RIGHT_STOP(PWM_CHANNEL_RIGHT_INTERNAL);
MOVS	R0, #1
BL	_PWM_TIM2_Stop+0
;right.c,20 :: 		}
L_end_wheelRightStop:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _wheelRightStop
