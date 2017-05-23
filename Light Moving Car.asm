_startRightWheel:
;Light Moving Car.c,54 :: 		void startRightWheel()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,56 :: 		PWM_TIM2_Set_Duty(currentDuty2,  _PWM_NON_INVERTED, _PWM_CHANNEL2);
MOVW	R0, #lo_addr(_currentDuty2+0)
MOVT	R0, #hi_addr(_currentDuty2+0)
LDRH	R0, [R0, #0]
MOVS	R2, #1
MOVS	R1, #0
BL	_PWM_TIM2_Set_Duty+0
;Light Moving Car.c,57 :: 		PWM_TIM2_Start(_PWM_CHANNEL2, &_GPIO_MODULE_TIM2_CH2_PA1);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM2_CH2_PA1+0)
MOVS	R0, #1
BL	_PWM_TIM2_Start+0
;Light Moving Car.c,58 :: 		}
L_end_startRightWheel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _startRightWheel
_stopRightWheel:
;Light Moving Car.c,60 :: 		void stopRightWheel()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,62 :: 		PWM_TIM2_Stop(_PWM_CHANNEL2);
MOVS	R0, #1
BL	_PWM_TIM2_Stop+0
;Light Moving Car.c,63 :: 		}
L_end_stopRightWheel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _stopRightWheel
_startLeftWheel:
;Light Moving Car.c,65 :: 		void startLeftWheel()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,67 :: 		PWM_TIM4_Set_Duty(currentDuty1,  _PWM_NON_INVERTED, _PWM_CHANNEL4);
MOVW	R0, #lo_addr(_currentDuty1+0)
MOVT	R0, #hi_addr(_currentDuty1+0)
LDRH	R0, [R0, #0]
MOVS	R2, #3
MOVS	R1, #0
BL	_PWM_TIM4_Set_Duty+0
;Light Moving Car.c,68 :: 		PWM_TIM4_Start(_PWM_CHANNEL4, &_GPIO_MODULE_TIM4_CH4_PB9);
MOVW	R1, #lo_addr(__GPIO_MODULE_TIM4_CH4_PB9+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_TIM4_CH4_PB9+0)
MOVS	R0, #3
BL	_PWM_TIM4_Start+0
;Light Moving Car.c,69 :: 		}
L_end_startLeftWheel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _startLeftWheel
_stopLeftWheel:
;Light Moving Car.c,71 :: 		void stopLeftWheel()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,73 :: 		PWM_TIM4_Stop(_PWM_CHANNEL4);
MOVS	R0, #3
BL	_PWM_TIM4_Stop+0
;Light Moving Car.c,74 :: 		}
L_end_stopLeftWheel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _stopLeftWheel
_resetLightMaxPar:
;Light Moving Car.c,76 :: 		void resetLightMaxPar()
;Light Moving Car.c,78 :: 		curMaxLightValue = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,79 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
; idx start address is: 8 (R2)
MOVS	R2, #0
SXTH	R2, R2
; idx end address is: 8 (R2)
L_resetLightMaxPar0:
; idx start address is: 8 (R2)
CMP	R2, #3
IT	GE
BGE	L_resetLightMaxPar1
;Light Moving Car.c,81 :: 		lightValueArr[idx] = 0;
LSLS	R1, R2, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R1, R0, R1
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [R1, #0]
;Light Moving Car.c,79 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
ADDS	R2, R2, #1
SXTH	R2, R2
;Light Moving Car.c,82 :: 		}
; idx end address is: 8 (R2)
IT	AL
BAL	L_resetLightMaxPar0
L_resetLightMaxPar1:
;Light Moving Car.c,83 :: 		}
L_end_resetLightMaxPar:
BX	LR
; end of _resetLightMaxPar
_changeMode:
;Light Moving Car.c,85 :: 		void changeMode(int newMode)
; newMode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; newMode end address is: 0 (R0)
; newMode start address is: 0 (R0)
;Light Moving Car.c,87 :: 		moveMode = newMode;
MOVW	R1, #lo_addr(_moveMode+0)
MOVT	R1, #hi_addr(_moveMode+0)
STRH	R0, [R1, #0]
;Light Moving Car.c,88 :: 		isStarted = 0;
MOVS	R2, #0
SXTH	R2, R2
MOVW	R1, #lo_addr(_isStarted+0)
MOVT	R1, #hi_addr(_isStarted+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,89 :: 		switch (newMode)
IT	AL
BAL	L_changeMode3
; newMode end address is: 0 (R0)
;Light Moving Car.c,91 :: 		case MOVE_MODE_FORWARD:
L_changeMode5:
;Light Moving Car.c,92 :: 		cnt = MAX_MOVE_BACK;
MOVW	R2, #50
SXTH	R2, R2
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,93 :: 		break;
IT	AL
BAL	L_changeMode4
;Light Moving Car.c,94 :: 		case MOVE_MODE_CIRCLE:
L_changeMode6:
;Light Moving Car.c,95 :: 		cnt = MAX_MOVE_CIRCLE;
MOVW	R2, #440
SXTH	R2, R2
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,96 :: 		resetLightMaxPar();
BL	_resetLightMaxPar+0
;Light Moving Car.c,97 :: 		maxLightValue = 0;
MOVS	R2, #0
SXTH	R2, R2
MOVW	R1, #lo_addr(_maxLightValue+0)
MOVT	R1, #hi_addr(_maxLightValue+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,98 :: 		break;
IT	AL
BAL	L_changeMode4
;Light Moving Car.c,99 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_changeMode7:
;Light Moving Car.c,101 :: 		cntFound = MAX_MOVE_CIRCLE - cntFound;
MOVW	R2, #lo_addr(_cntFound+0)
MOVT	R2, #hi_addr(_cntFound+0)
LDRSH	R1, [R2, #0]
RSB	R1, R1, #440
SXTH	R1, R1
STRH	R1, [R2, #0]
;Light Moving Car.c,103 :: 		if ( (double)(cntFound) / MAX_MOVE_CIRCLE <= 0.5f)
VMOV	S1, R1
VCVT.F32	#1, S1, S1
MOVW	R1, #0
MOVT	R1, #17372
VMOV	S0, R1
VDIV.F32	S1, S1, S0
VMOV.F32	S0, #0.5
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_changeMode8
;Light Moving Car.c,105 :: 		cnt = MAX_MOVE_CIRCLE_HALF + cntFound;
MOVW	R1, #lo_addr(_cntFound+0)
MOVT	R1, #hi_addr(_cntFound+0)
LDRSH	R1, [R1, #0]
ADDW	R2, R1, #220
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,106 :: 		}
IT	AL
BAL	L_changeMode9
L_changeMode8:
;Light Moving Car.c,107 :: 		else if ((double)(cntFound) / MAX_MOVE_CIRCLE <= 1f)
MOVW	R1, #lo_addr(_cntFound+0)
MOVT	R1, #hi_addr(_cntFound+0)
LDRSH	R1, [R1, #0]
VMOV	S1, R1
VCVT.F32	#1, S1, S1
MOVW	R1, #0
MOVT	R1, #17372
VMOV	S0, R1
VDIV.F32	S1, S1, S0
VMOV.F32	S0, #1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_changeMode10
;Light Moving Car.c,109 :: 		cnt = cntFound - MAX_MOVE_CIRCLE_HALF;
MOVW	R1, #lo_addr(_cntFound+0)
MOVT	R1, #hi_addr(_cntFound+0)
LDRSH	R1, [R1, #0]
SUBW	R2, R1, #220
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,110 :: 		}
L_changeMode10:
L_changeMode9:
;Light Moving Car.c,111 :: 		break;
IT	AL
BAL	L_changeMode4
;Light Moving Car.c,112 :: 		}
L_changeMode3:
; newMode start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_changeMode5
CMP	R0, #1
IT	EQ
BEQ	L_changeMode6
CMP	R0, #2
IT	EQ
BEQ	L_changeMode7
; newMode end address is: 0 (R0)
L_changeMode4:
;Light Moving Car.c,113 :: 		}
L_end_changeMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _changeMode
_startMode:
;Light Moving Car.c,115 :: 		void startMode()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,117 :: 		isStarted = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,118 :: 		switch (moveMode)
IT	AL
BAL	L_startMode11
;Light Moving Car.c,120 :: 		case MOVE_MODE_FORWARD:
L_startMode13:
;Light Moving Car.c,121 :: 		startRightWheel();
BL	_startRightWheel+0
;Light Moving Car.c,122 :: 		startLeftWheel();
BL	_startLeftWheel+0
;Light Moving Car.c,123 :: 		break;
IT	AL
BAL	L_startMode12
;Light Moving Car.c,124 :: 		case MOVE_MODE_CIRCLE:
L_startMode14:
;Light Moving Car.c,125 :: 		stopLeftWheel();
BL	_stopLeftWheel+0
;Light Moving Car.c,126 :: 		startRightWheel();
BL	_startRightWheel+0
;Light Moving Car.c,127 :: 		break;
IT	AL
BAL	L_startMode12
;Light Moving Car.c,128 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_startMode15:
;Light Moving Car.c,130 :: 		startRightWheel();
BL	_startRightWheel+0
;Light Moving Car.c,131 :: 		stopLeftWheel();
BL	_stopLeftWheel+0
;Light Moving Car.c,132 :: 		break;
IT	AL
BAL	L_startMode12
;Light Moving Car.c,133 :: 		}
L_startMode11:
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_startMode13
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_startMode14
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_startMode15
L_startMode12:
;Light Moving Car.c,134 :: 		}
L_end_startMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _startMode
_calcLightVal:
;Light Moving Car.c,136 :: 		int calcLightVal()
;Light Moving Car.c,139 :: 		int min = 30000;
; min start address is: 28 (R7)
MOVW	R7, #30000
SXTH	R7, R7
;Light Moving Car.c,140 :: 		int max = -1;
; max start address is: 32 (R8)
MOVW	R8, #65535
SXTH	R8, R8
;Light Moving Car.c,141 :: 		int minIdx = -1;
; minIdx start address is: 24 (R6)
MOVW	R6, #65535
SXTH	R6, R6
;Light Moving Car.c,142 :: 		int maxIdx = -1;
; maxIdx start address is: 20 (R5)
MOVW	R5, #65535
SXTH	R5, R5
;Light Moving Car.c,143 :: 		int cnt = 0;
; cnt start address is: 12 (R3)
MOVW	R3, #0
SXTH	R3, R3
;Light Moving Car.c,144 :: 		int avg = 0;
; avg start address is: 8 (R2)
MOVW	R2, #0
SXTH	R2, R2
;Light Moving Car.c,145 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; idx start address is: 16 (R4)
MOVS	R4, #0
SXTH	R4, R4
; avg end address is: 8 (R2)
; cnt end address is: 12 (R3)
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
; idx end address is: 16 (R4)
L_calcLightVal16:
; idx start address is: 16 (R4)
; avg start address is: 8 (R2)
; cnt start address is: 12 (R3)
; maxIdx start address is: 20 (R5)
; minIdx start address is: 24 (R6)
; max start address is: 32 (R8)
; min start address is: 28 (R7)
CMP	R4, #3
IT	GE
BGE	L_calcLightVal17
;Light Moving Car.c,147 :: 		if (lightValueArr[idx] > max)
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, R8
IT	LE
BLE	L__calcLightVal61
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
;Light Moving Car.c,149 :: 		max = lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R8, [R0, #0]
; max start address is: 32 (R8)
;Light Moving Car.c,150 :: 		maxIdx = idx;
; maxIdx start address is: 20 (R5)
SXTH	R5, R4
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
;Light Moving Car.c,151 :: 		}
IT	AL
BAL	L_calcLightVal19
L__calcLightVal61:
;Light Moving Car.c,147 :: 		if (lightValueArr[idx] > max)
;Light Moving Car.c,151 :: 		}
L_calcLightVal19:
;Light Moving Car.c,153 :: 		if (lightValueArr[idx] < min)
; maxIdx start address is: 20 (R5)
; max start address is: 32 (R8)
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, R7
IT	GE
BGE	L__calcLightVal62
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
;Light Moving Car.c,155 :: 		min = lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R7, [R0, #0]
; min start address is: 28 (R7)
;Light Moving Car.c,156 :: 		minIdx = idx;
; minIdx start address is: 24 (R6)
SXTH	R6, R4
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
;Light Moving Car.c,157 :: 		}
IT	AL
BAL	L_calcLightVal20
L__calcLightVal62:
;Light Moving Car.c,153 :: 		if (lightValueArr[idx] < min)
;Light Moving Car.c,157 :: 		}
L_calcLightVal20:
;Light Moving Car.c,145 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; minIdx start address is: 24 (R6)
; min start address is: 28 (R7)
ADDS	R4, R4, #1
SXTH	R4, R4
;Light Moving Car.c,158 :: 		}
; max end address is: 32 (R8)
; min end address is: 28 (R7)
; idx end address is: 16 (R4)
IT	AL
BAL	L_calcLightVal16
L_calcLightVal17:
;Light Moving Car.c,161 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; idx start address is: 16 (R4)
MOVS	R4, #0
SXTH	R4, R4
; avg end address is: 8 (R2)
; cnt end address is: 12 (R3)
; maxIdx end address is: 20 (R5)
; minIdx end address is: 24 (R6)
; idx end address is: 16 (R4)
SXTH	R1, R3
SXTH	R3, R5
SXTH	R5, R2
SXTH	R2, R6
L_calcLightVal21:
; idx start address is: 16 (R4)
; maxIdx start address is: 12 (R3)
; minIdx start address is: 8 (R2)
; minIdx start address is: 8 (R2)
; minIdx end address is: 8 (R2)
; maxIdx start address is: 12 (R3)
; maxIdx end address is: 12 (R3)
; cnt start address is: 4 (R1)
; avg start address is: 20 (R5)
CMP	R4, #3
IT	GE
BGE	L_calcLightVal22
; minIdx end address is: 8 (R2)
; maxIdx end address is: 12 (R3)
;Light Moving Car.c,163 :: 		if ( (idx != minIdx) && (idx != maxIdx))
; maxIdx start address is: 12 (R3)
; minIdx start address is: 8 (R2)
CMP	R4, R2
IT	EQ
BEQ	L__calcLightVal63
CMP	R4, R3
IT	EQ
BEQ	L__calcLightVal64
L__calcLightVal58:
;Light Moving Car.c,165 :: 		cnt ++;
ADDS	R0, R1, #1
; cnt end address is: 4 (R1)
; cnt start address is: 24 (R6)
SXTH	R6, R0
;Light Moving Car.c,166 :: 		avg += lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R0, [R0, #0]
ADDS	R0, R5, R0
; avg end address is: 20 (R5)
; avg start address is: 4 (R1)
SXTH	R1, R0
; cnt end address is: 24 (R6)
; avg end address is: 4 (R1)
SXTH	R5, R1
SXTH	R1, R6
;Light Moving Car.c,163 :: 		if ( (idx != minIdx) && (idx != maxIdx))
IT	AL
BAL	L__calcLightVal60
L__calcLightVal63:
L__calcLightVal60:
; avg start address is: 20 (R5)
; cnt start address is: 4 (R1)
; cnt end address is: 4 (R1)
; avg end address is: 20 (R5)
IT	AL
BAL	L__calcLightVal59
L__calcLightVal64:
L__calcLightVal59:
;Light Moving Car.c,161 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; cnt start address is: 4 (R1)
; avg start address is: 20 (R5)
ADDS	R4, R4, #1
SXTH	R4, R4
;Light Moving Car.c,168 :: 		}
; minIdx end address is: 8 (R2)
; maxIdx end address is: 12 (R3)
; idx end address is: 16 (R4)
IT	AL
BAL	L_calcLightVal21
L_calcLightVal22:
;Light Moving Car.c,169 :: 		avg /= cnt;
SDIV	R0, R5, R1
; cnt end address is: 4 (R1)
; avg end address is: 20 (R5)
;Light Moving Car.c,170 :: 		return avg;
;Light Moving Car.c,171 :: 		}
L_end_calcLightVal:
BX	LR
; end of _calcLightVal
_updateLightArray:
;Light Moving Car.c,173 :: 		void updateLightArray()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,176 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
; idx start address is: 12 (R3)
MOVS	R3, #0
SXTH	R3, R3
; idx end address is: 12 (R3)
L_updateLightArray27:
; idx start address is: 12 (R3)
CMP	R3, #2
IT	GE
BGE	L_updateLightArray28
;Light Moving Car.c,178 :: 		lightValueArr[idx] = lightValueArr[idx + 1];
LSLS	R1, R3, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R2, R0, R1
ADDS	R0, R3, #1
SXTH	R0, R0
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R0, [R0, #0]
STRH	R0, [R2, #0]
;Light Moving Car.c,176 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
ADDS	R3, R3, #1
SXTH	R3, R3
;Light Moving Car.c,179 :: 		}
; idx end address is: 12 (R3)
IT	AL
BAL	L_updateLightArray27
L_updateLightArray28:
;Light Moving Car.c,180 :: 		lightValDetected = ADC1_Get_Sample(11);
MOVS	R0, #11
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_lightValDetected+0)
MOVT	R1, #hi_addr(_lightValDetected+0)
STRH	R0, [R1, #0]
;Light Moving Car.c,181 :: 		lightValueArr[MAX_ARR_LEN_LIGHT_VAL - 1]= lightValDetected;
SXTH	R1, R0
MOVW	R0, #lo_addr(_lightValueArr+4)
MOVT	R0, #hi_addr(_lightValueArr+4)
STRH	R1, [R0, #0]
;Light Moving Car.c,182 :: 		}
L_end_updateLightArray:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _updateLightArray
_interruptTimer3:
;Light Moving Car.c,184 :: 		void interruptTimer3() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,186 :: 		TIM3_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,188 :: 		if (pwmInitialized)
MOVW	R0, #lo_addr(_pwmInitialized+0)
MOVT	R0, #hi_addr(_pwmInitialized+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer330
;Light Moving Car.c,190 :: 		if (!isStarted)
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer331
;Light Moving Car.c,192 :: 		startMode();
BL	_startMode+0
;Light Moving Car.c,193 :: 		}
L_interruptTimer331:
;Light Moving Car.c,194 :: 		if (MOVE_MODE_CIRCLE == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_interruptTimer332
;Light Moving Car.c,196 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer333
;Light Moving Car.c,198 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;Light Moving Car.c,199 :: 		updateLightArray();
BL	_updateLightArray+0
;Light Moving Car.c,200 :: 		curMaxLightValue = calcLightVal();
BL	_calcLightVal+0
MOVW	R1, #lo_addr(_curMaxLightValue+0)
MOVT	R1, #hi_addr(_curMaxLightValue+0)
STRH	R0, [R1, #0]
;Light Moving Car.c,201 :: 		if (curMaxLightValue > maxLightValue)
MOVW	R1, #lo_addr(_maxLightValue+0)
MOVT	R1, #hi_addr(_maxLightValue+0)
LDRSH	R1, [R1, #0]
CMP	R0, R1
IT	LE
BLE	L_interruptTimer334
;Light Moving Car.c,203 :: 		maxLightValue = curMaxLightValue;
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_maxLightValue+0)
MOVT	R0, #hi_addr(_maxLightValue+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,204 :: 		cntFound = cnt;
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_cntFound+0)
MOVT	R0, #hi_addr(_cntFound+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,205 :: 		}
L_interruptTimer334:
;Light Moving Car.c,206 :: 		}
IT	AL
BAL	L_interruptTimer335
L_interruptTimer333:
;Light Moving Car.c,209 :: 		changeMode(MOVE_MODE_SEARCH_LIGHT);
MOVW	R0, #2
SXTH	R0, R0
BL	_changeMode+0
;Light Moving Car.c,210 :: 		}
L_interruptTimer335:
;Light Moving Car.c,211 :: 		}
IT	AL
BAL	L_interruptTimer336
L_interruptTimer332:
;Light Moving Car.c,212 :: 		else if (MOVE_MODE_FORWARD == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer337
;Light Moving Car.c,214 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer338
;Light Moving Car.c,216 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;Light Moving Car.c,218 :: 		}
IT	AL
BAL	L_interruptTimer339
L_interruptTimer338:
;Light Moving Car.c,221 :: 		changeMode(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_changeMode+0
;Light Moving Car.c,222 :: 		}
L_interruptTimer339:
;Light Moving Car.c,223 :: 		}
IT	AL
BAL	L_interruptTimer340
L_interruptTimer337:
;Light Moving Car.c,224 :: 		else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_interruptTimer341
;Light Moving Car.c,226 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer342
;Light Moving Car.c,228 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;Light Moving Car.c,229 :: 		}
IT	AL
BAL	L_interruptTimer343
L_interruptTimer342:
;Light Moving Car.c,232 :: 		changeMode(MOVE_MODE_FORWARD);
MOVW	R0, #0
SXTH	R0, R0
BL	_changeMode+0
;Light Moving Car.c,233 :: 		}
L_interruptTimer343:
;Light Moving Car.c,234 :: 		}
L_interruptTimer341:
L_interruptTimer340:
L_interruptTimer336:
;Light Moving Car.c,235 :: 		}
L_interruptTimer330:
;Light Moving Car.c,237 :: 		if (UART3_Tx_Idle() == 1) //If data has been transmitted, send new data
BL	_UART3_Tx_Idle+0
CMP	R0, #1
IT	NE
BNE	L_interruptTimer344
;Light Moving Car.c,239 :: 		UART3_Write_Text("\n\rLightValDetected: ");
MOVW	R0, #lo_addr(?lstr1_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr1_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,240 :: 		IntToStr(lightValDetected, output);
MOVW	R0, #lo_addr(_lightValDetected+0)
MOVT	R0, #hi_addr(_lightValDetected+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,241 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,243 :: 		UART3_Write_Text("CurLightValue: ");
MOVW	R0, #lo_addr(?lstr2_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr2_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,244 :: 		IntToStr(curMaxLightValue, output);
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,245 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,247 :: 		UART3_Write_Text("MaxLightValue: ");
MOVW	R0, #lo_addr(?lstr3_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr3_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,248 :: 		IntToStr(maxLightValue, output);
MOVW	R0, #lo_addr(_maxLightValue+0)
MOVT	R0, #hi_addr(_maxLightValue+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,249 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,251 :: 		UART3_Write_Text("Cnt: ");
MOVW	R0, #lo_addr(?lstr4_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr4_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,252 :: 		IntToStr(cnt, output);
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,253 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,255 :: 		UART3_Write_Text("CntFound: ");
MOVW	R0, #lo_addr(?lstr5_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr5_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,256 :: 		IntToStr(cntFound, output);
MOVW	R0, #lo_addr(_cntFound+0)
MOVT	R0, #hi_addr(_cntFound+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;Light Moving Car.c,257 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,259 :: 		UART3_Write_Text("Move:");
MOVW	R0, #lo_addr(?lstr6_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr6_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,260 :: 		if (moveMode == MOVE_MODE_FORWARD)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer345
;Light Moving Car.c,262 :: 		UART3_Write_Text("FORWARD");
MOVW	R0, #lo_addr(?lstr7_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr7_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,263 :: 		}
IT	AL
BAL	L_interruptTimer346
L_interruptTimer345:
;Light Moving Car.c,264 :: 		else if (moveMode == MOVE_MODE_CIRCLE)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_interruptTimer347
;Light Moving Car.c,266 :: 		UART3_Write_Text("CIRCLE");
MOVW	R0, #lo_addr(?lstr8_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr8_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,267 :: 		}
IT	AL
BAL	L_interruptTimer348
L_interruptTimer347:
;Light Moving Car.c,268 :: 		else if (moveMode  == MOVE_MODE_SEARCH_LIGHT)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_interruptTimer349
;Light Moving Car.c,270 :: 		UART3_Write_Text("SEARCH LIGHT");
MOVW	R0, #lo_addr(?lstr9_Light_32Moving_32Car+0)
MOVT	R0, #hi_addr(?lstr9_Light_32Moving_32Car+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,271 :: 		}
L_interruptTimer349:
L_interruptTimer348:
L_interruptTimer346:
;Light Moving Car.c,273 :: 		IntToStr(-1, output);
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
MOVW	R0, #65535
SXTH	R0, R0
BL	_IntToStr+0
;Light Moving Car.c,274 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;Light Moving Car.c,275 :: 		}
L_interruptTimer344:
;Light Moving Car.c,278 :: 		}
L_end_interruptTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interruptTimer3
_initTimer3:
;Light Moving Car.c,281 :: 		void initTimer3(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,282 :: 		RCC_APB1ENR.TIM3EN = 1;  // Enable clock gating for timer module 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,283 :: 		TIM3_CR1.CEN = 0;// Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;Light Moving Car.c,284 :: 		TIM3_PSC = timer_psc[TIMER_INTERRUPT_MODE];  // Set timer prescaler.
MOVW	R0, #lo_addr(_timer_psc+4)
MOVT	R0, #hi_addr(_timer_psc+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;Light Moving Car.c,285 :: 		TIM3_ARR = timer_arr[TIMER_INTERRUPT_MODE]; //
MOVW	R0, #lo_addr(_timer_arr+4)
MOVT	R0, #hi_addr(_timer_arr+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;Light Moving Car.c,286 :: 		NVIC_IntEnable(IVT_INT_TIM3);  // Enable timer interrupt
MOVW	R0, #45
BL	_NVIC_IntEnable+0
;Light Moving Car.c,287 :: 		TIM3_DIER.UIE = 1; // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;Light Moving Car.c,288 :: 		TIM3_CR1.CEN = 1; // Enable timer
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;Light Moving Car.c,289 :: 		}
L_end_initTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initTimer3
_initDebugMode:
;Light Moving Car.c,292 :: 		void initDebugMode ()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,295 :: 		UART3_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART3_PD89+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART3_PD89+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART3_Init_Advanced+0
ADD	SP, SP, #4
;Light Moving Car.c,296 :: 		Delay_ms(1000);
MOVW	R7, #23038
MOVT	R7, #610
NOP
NOP
L_initDebugMode50:
SUBS	R7, R7, #1
BNE	L_initDebugMode50
NOP
NOP
NOP
;Light Moving Car.c,297 :: 		UART3_Enable();
BL	_UART3_Enable+0
;Light Moving Car.c,298 :: 		}
L_end_initDebugMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initDebugMode
_initADC:
;Light Moving Car.c,300 :: 		void initADC()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Light Moving Car.c,303 :: 		GPIO_Analog_Input(&GPIOC_BASE, _GPIO_PINMASK_1);
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Analog_Input+0
;Light Moving Car.c,304 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_11);
MOVW	R0, #2048
BL	_ADC_Set_Input_Channel+0
;Light Moving Car.c,305 :: 		ADC1_Init();
BL	_ADC1_Init+0
;Light Moving Car.c,306 :: 		}
L_end_initADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initADC
_initPWM:
;Light Moving Car.c,308 :: 		void initPWM()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Light Moving Car.c,310 :: 		pwmPeriod1 = PWM_TIM4_Init(PERIOD_FREQUENCY1);
MOVW	R0, #33
BL	_PWM_TIM4_Init+0
MOVW	R1, #lo_addr(_pwmPeriod1+0)
MOVT	R1, #hi_addr(_pwmPeriod1+0)
STR	R1, [SP, #4]
STRH	R0, [R1, #0]
;Light Moving Car.c,311 :: 		pwmPeriod2 = PWM_TIM2_Init(PERIOD_FREQUENCY2);
MOVW	R0, #50
BL	_PWM_TIM2_Init+0
MOVW	R1, #lo_addr(_pwmPeriod2+0)
MOVT	R1, #hi_addr(_pwmPeriod2+0)
STRH	R0, [R1, #0]
;Light Moving Car.c,313 :: 		currentDuty1 =   pwmPeriod1 / MAX_GEARS;
LDR	R1, [SP, #4]
LDRH	R2, [R1, #0]
MOVW	R1, #9
UDIV	R2, R2, R1
MOVW	R1, #lo_addr(_currentDuty1+0)
MOVT	R1, #hi_addr(_currentDuty1+0)
STRH	R2, [R1, #0]
;Light Moving Car.c,314 :: 		currentDuty2 = pwmPeriod2 / MAX_GEARS;
MOVW	R1, #9
UDIV	R1, R0, R1
MOVW	R0, #lo_addr(_currentDuty2+0)
MOVT	R0, #hi_addr(_currentDuty2+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,320 :: 		changeMode(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_changeMode+0
;Light Moving Car.c,321 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_initPWM52:
SUBS	R7, R7, #1
BNE	L_initPWM52
NOP
NOP
NOP
;Light Moving Car.c,322 :: 		pwmInitialized = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_pwmInitialized+0)
MOVT	R0, #hi_addr(_pwmInitialized+0)
STRH	R1, [R0, #0]
;Light Moving Car.c,324 :: 		}
L_end_initPWM:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _initPWM
_main:
;Light Moving Car.c,327 :: 		void main() {
;Light Moving Car.c,329 :: 		initDebugMode();
BL	_initDebugMode+0
;Light Moving Car.c,330 :: 		initTimer3();
BL	_initTimer3+0
;Light Moving Car.c,331 :: 		initADC();
BL	_initADC+0
;Light Moving Car.c,332 :: 		initPWM();
BL	_initPWM+0
;Light Moving Car.c,334 :: 		while(1) {
L_main54:
;Light Moving Car.c,335 :: 		asm wfi;
WFI
;Light Moving Car.c,336 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_main56:
SUBS	R7, R7, #1
BNE	L_main56
NOP
NOP
NOP
;Light Moving Car.c,337 :: 		}
IT	AL
BAL	L_main54
;Light Moving Car.c,338 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
