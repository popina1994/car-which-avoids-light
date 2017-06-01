_lightDetectorInit:
;lightDetector.c,3 :: 		void lightDetectorInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;lightDetector.c,6 :: 		PIN_IDX_EXP(PIN_RCV_ADC_IDX));
MOVW	R1, #2
;lightDetector.c,5 :: 		GPIO_Analog_Input(&PIN_NAME_EXP(PIN_RCV_ADC_NAME),
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
;lightDetector.c,6 :: 		PIN_IDX_EXP(PIN_RCV_ADC_IDX));
BL	_GPIO_Analog_Input+0
;lightDetector.c,7 :: 		ADC_Set_Input_Channel(ADC_CHANNEL_INTERNAL);
MOVW	R0, #2048
BL	_ADC_Set_Input_Channel+0
;lightDetector.c,8 :: 		ADC_INIT();
BL	_ADC1_Init+0
;lightDetector.c,9 :: 		}
L_end_lightDetectorInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _lightDetectorInit
_getLightVal:
;lightDetector.c,11 :: 		unsigned int getLightVal()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;lightDetector.c,13 :: 		return ADC_GET_SAMPLE(ADC_CHANNEL_NUM);
MOVS	R0, #11
BL	_ADC1_Get_Sample+0
;lightDetector.c,14 :: 		}
L_end_getLightVal:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _getLightVal
