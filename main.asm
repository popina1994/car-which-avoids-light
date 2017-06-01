_resetLightMaxPar:
;main.c,36 :: 		void resetLightMaxPar()
;main.c,38 :: 		curMaxLightValue = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
STRH	R1, [R0, #0]
;main.c,39 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
; idx start address is: 8 (R2)
MOVS	R2, #0
SXTH	R2, R2
; idx end address is: 8 (R2)
L_resetLightMaxPar0:
; idx start address is: 8 (R2)
CMP	R2, #3
IT	GE
BGE	L_resetLightMaxPar1
;main.c,41 :: 		lightValueArr[idx] = 0;
LSLS	R1, R2, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R1, R0, R1
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [R1, #0]
;main.c,39 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
ADDS	R2, R2, #1
SXTH	R2, R2
;main.c,42 :: 		}
; idx end address is: 8 (R2)
IT	AL
BAL	L_resetLightMaxPar0
L_resetLightMaxPar1:
;main.c,43 :: 		}
L_end_resetLightMaxPar:
BX	LR
; end of _resetLightMaxPar
_changeMode:
;main.c,45 :: 		void changeMode(int newMode)
; newMode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; newMode end address is: 0 (R0)
; newMode start address is: 0 (R0)
;main.c,47 :: 		moveMode = newMode;
MOVW	R1, #lo_addr(_moveMode+0)
MOVT	R1, #hi_addr(_moveMode+0)
STRH	R0, [R1, #0]
;main.c,48 :: 		isStarted = 0;
MOVS	R2, #0
SXTH	R2, R2
MOVW	R1, #lo_addr(_isStarted+0)
MOVT	R1, #hi_addr(_isStarted+0)
STRH	R2, [R1, #0]
;main.c,49 :: 		switch (newMode)
IT	AL
BAL	L_changeMode3
; newMode end address is: 0 (R0)
;main.c,51 :: 		case MOVE_MODE_FORWARD:
L_changeMode5:
;main.c,52 :: 		cnt = MAX_MOVE_BACK;
MOVW	R2, #50
SXTH	R2, R2
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;main.c,53 :: 		break;
IT	AL
BAL	L_changeMode4
;main.c,54 :: 		case MOVE_MODE_CIRCLE:
L_changeMode6:
;main.c,55 :: 		cnt = MAX_MOVE_CIRCLE;
MOVW	R2, #440
SXTH	R2, R2
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;main.c,56 :: 		resetLightMaxPar();
BL	_resetLightMaxPar+0
;main.c,57 :: 		maxLightValue = 0;
MOVS	R2, #0
SXTH	R2, R2
MOVW	R1, #lo_addr(_maxLightValue+0)
MOVT	R1, #hi_addr(_maxLightValue+0)
STRH	R2, [R1, #0]
;main.c,58 :: 		break;
IT	AL
BAL	L_changeMode4
;main.c,59 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_changeMode7:
;main.c,61 :: 		cntFound = MAX_MOVE_CIRCLE - cntFound;
MOVW	R2, #lo_addr(_cntFound+0)
MOVT	R2, #hi_addr(_cntFound+0)
LDRSH	R1, [R2, #0]
RSB	R1, R1, #440
SXTH	R1, R1
STRH	R1, [R2, #0]
;main.c,63 :: 		if ( (double)(cntFound) / MAX_MOVE_CIRCLE <= 0.5f)
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
;main.c,65 :: 		cnt = MAX_MOVE_CIRCLE_HALF + cntFound;
MOVW	R1, #lo_addr(_cntFound+0)
MOVT	R1, #hi_addr(_cntFound+0)
LDRSH	R1, [R1, #0]
ADDW	R2, R1, #220
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;main.c,66 :: 		}
IT	AL
BAL	L_changeMode9
L_changeMode8:
;main.c,67 :: 		else if ((double)(cntFound) / MAX_MOVE_CIRCLE <= 1f)
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
;main.c,69 :: 		cnt = cntFound - MAX_MOVE_CIRCLE_HALF;
MOVW	R1, #lo_addr(_cntFound+0)
MOVT	R1, #hi_addr(_cntFound+0)
LDRSH	R1, [R1, #0]
SUBW	R2, R1, #220
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;main.c,70 :: 		}
L_changeMode10:
L_changeMode9:
;main.c,71 :: 		break;
IT	AL
BAL	L_changeMode4
;main.c,72 :: 		}
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
;main.c,73 :: 		}
L_end_changeMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _changeMode
_startMode:
;main.c,75 :: 		void startMode()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,77 :: 		isStarted = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
STRH	R1, [R0, #0]
;main.c,78 :: 		switch (moveMode)
IT	AL
BAL	L_startMode11
;main.c,80 :: 		case MOVE_MODE_FORWARD:
L_startMode13:
;main.c,81 :: 		wheelRightStart();
BL	_wheelRightStart+0
;main.c,82 :: 		wheelLeftStart();
BL	_wheelLeftStart+0
;main.c,83 :: 		break;
IT	AL
BAL	L_startMode12
;main.c,84 :: 		case MOVE_MODE_CIRCLE:
L_startMode14:
;main.c,85 :: 		wheelLeftStop();
BL	_wheelLeftStop+0
;main.c,86 :: 		wheelRightStart();
BL	_wheelRightStart+0
;main.c,87 :: 		break;
IT	AL
BAL	L_startMode12
;main.c,88 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_startMode15:
;main.c,90 :: 		wheelRightStart();
BL	_wheelRightStart+0
;main.c,91 :: 		wheelLeftStop();
BL	_wheelLeftStop+0
;main.c,92 :: 		break;
IT	AL
BAL	L_startMode12
;main.c,93 :: 		}
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
;main.c,94 :: 		}
L_end_startMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _startMode
_calcLightVal:
;main.c,96 :: 		int calcLightVal()
;main.c,99 :: 		int min = 30000;
; min start address is: 28 (R7)
MOVW	R7, #30000
SXTH	R7, R7
;main.c,100 :: 		int max = -1;
; max start address is: 32 (R8)
MOVW	R8, #65535
SXTH	R8, R8
;main.c,101 :: 		int minIdx = -1;
; minIdx start address is: 24 (R6)
MOVW	R6, #65535
SXTH	R6, R6
;main.c,102 :: 		int maxIdx = -1;
; maxIdx start address is: 20 (R5)
MOVW	R5, #65535
SXTH	R5, R5
;main.c,103 :: 		int cnt = 0;
; cnt start address is: 12 (R3)
MOVW	R3, #0
SXTH	R3, R3
;main.c,104 :: 		int avg = 0;
; avg start address is: 8 (R2)
MOVW	R2, #0
SXTH	R2, R2
;main.c,105 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
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
;main.c,107 :: 		if (lightValueArr[idx] > max)
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, R8
IT	LE
BLE	L__calcLightVal57
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
;main.c,109 :: 		max = lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R8, [R0, #0]
; max start address is: 32 (R8)
;main.c,110 :: 		maxIdx = idx;
; maxIdx start address is: 20 (R5)
SXTH	R5, R4
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
;main.c,111 :: 		}
IT	AL
BAL	L_calcLightVal19
L__calcLightVal57:
;main.c,107 :: 		if (lightValueArr[idx] > max)
;main.c,111 :: 		}
L_calcLightVal19:
;main.c,113 :: 		if (lightValueArr[idx] < min)
; maxIdx start address is: 20 (R5)
; max start address is: 32 (R8)
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, R7
IT	GE
BGE	L__calcLightVal58
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
;main.c,115 :: 		min = lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R7, [R0, #0]
; min start address is: 28 (R7)
;main.c,116 :: 		minIdx = idx;
; minIdx start address is: 24 (R6)
SXTH	R6, R4
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
;main.c,117 :: 		}
IT	AL
BAL	L_calcLightVal20
L__calcLightVal58:
;main.c,113 :: 		if (lightValueArr[idx] < min)
;main.c,117 :: 		}
L_calcLightVal20:
;main.c,105 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; minIdx start address is: 24 (R6)
; min start address is: 28 (R7)
ADDS	R4, R4, #1
SXTH	R4, R4
;main.c,118 :: 		}
; max end address is: 32 (R8)
; min end address is: 28 (R7)
; idx end address is: 16 (R4)
IT	AL
BAL	L_calcLightVal16
L_calcLightVal17:
;main.c,121 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
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
;main.c,123 :: 		if ( (idx != minIdx) && (idx != maxIdx))
; maxIdx start address is: 12 (R3)
; minIdx start address is: 8 (R2)
CMP	R4, R2
IT	EQ
BEQ	L__calcLightVal59
CMP	R4, R3
IT	EQ
BEQ	L__calcLightVal60
L__calcLightVal54:
;main.c,125 :: 		cnt ++;
ADDS	R0, R1, #1
; cnt end address is: 4 (R1)
; cnt start address is: 24 (R6)
SXTH	R6, R0
;main.c,126 :: 		avg += lightValueArr[idx];
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
;main.c,123 :: 		if ( (idx != minIdx) && (idx != maxIdx))
IT	AL
BAL	L__calcLightVal56
L__calcLightVal59:
L__calcLightVal56:
; avg start address is: 20 (R5)
; cnt start address is: 4 (R1)
; cnt end address is: 4 (R1)
; avg end address is: 20 (R5)
IT	AL
BAL	L__calcLightVal55
L__calcLightVal60:
L__calcLightVal55:
;main.c,121 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; cnt start address is: 4 (R1)
; avg start address is: 20 (R5)
ADDS	R4, R4, #1
SXTH	R4, R4
;main.c,128 :: 		}
; minIdx end address is: 8 (R2)
; maxIdx end address is: 12 (R3)
; idx end address is: 16 (R4)
IT	AL
BAL	L_calcLightVal21
L_calcLightVal22:
;main.c,129 :: 		avg /= cnt;
SDIV	R0, R5, R1
; cnt end address is: 4 (R1)
; avg end address is: 20 (R5)
;main.c,130 :: 		return avg;
;main.c,131 :: 		}
L_end_calcLightVal:
BX	LR
; end of _calcLightVal
_updateLightArray:
;main.c,133 :: 		void updateLightArray()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,136 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
; idx start address is: 12 (R3)
MOVS	R3, #0
SXTH	R3, R3
; idx end address is: 12 (R3)
L_updateLightArray27:
; idx start address is: 12 (R3)
CMP	R3, #2
IT	GE
BGE	L_updateLightArray28
;main.c,138 :: 		lightValueArr[idx] = lightValueArr[idx + 1];
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
;main.c,136 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
ADDS	R3, R3, #1
SXTH	R3, R3
;main.c,139 :: 		}
; idx end address is: 12 (R3)
IT	AL
BAL	L_updateLightArray27
L_updateLightArray28:
;main.c,140 :: 		lightValDetected = ADC1_Get_Sample(11);
MOVS	R0, #11
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_lightValDetected+0)
MOVT	R1, #hi_addr(_lightValDetected+0)
STRH	R0, [R1, #0]
;main.c,141 :: 		lightValueArr[MAX_ARR_LEN_LIGHT_VAL - 1]= lightValDetected;
SXTH	R1, R0
MOVW	R0, #lo_addr(_lightValueArr+4)
MOVT	R0, #hi_addr(_lightValueArr+4)
STRH	R1, [R0, #0]
;main.c,142 :: 		}
L_end_updateLightArray:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _updateLightArray
_interruptTimer3:
;main.c,144 :: 		void interruptTimer3() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,146 :: 		TIM3_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;main.c,148 :: 		if (pwmInitialized)
MOVW	R0, #lo_addr(_pwmInitialized+0)
MOVT	R0, #hi_addr(_pwmInitialized+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer330
;main.c,150 :: 		if (!isStarted)
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer331
;main.c,152 :: 		startMode();
BL	_startMode+0
;main.c,153 :: 		}
L_interruptTimer331:
;main.c,154 :: 		if (MOVE_MODE_CIRCLE == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_interruptTimer332
;main.c,156 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer333
;main.c,158 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;main.c,159 :: 		updateLightArray();
BL	_updateLightArray+0
;main.c,160 :: 		curMaxLightValue = calcLightVal();
BL	_calcLightVal+0
MOVW	R1, #lo_addr(_curMaxLightValue+0)
MOVT	R1, #hi_addr(_curMaxLightValue+0)
STRH	R0, [R1, #0]
;main.c,161 :: 		if (curMaxLightValue > maxLightValue)
MOVW	R1, #lo_addr(_maxLightValue+0)
MOVT	R1, #hi_addr(_maxLightValue+0)
LDRSH	R1, [R1, #0]
CMP	R0, R1
IT	LE
BLE	L_interruptTimer334
;main.c,163 :: 		maxLightValue = curMaxLightValue;
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_maxLightValue+0)
MOVT	R0, #hi_addr(_maxLightValue+0)
STRH	R1, [R0, #0]
;main.c,164 :: 		cntFound = cnt;
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_cntFound+0)
MOVT	R0, #hi_addr(_cntFound+0)
STRH	R1, [R0, #0]
;main.c,165 :: 		}
L_interruptTimer334:
;main.c,166 :: 		}
IT	AL
BAL	L_interruptTimer335
L_interruptTimer333:
;main.c,169 :: 		changeMode(MOVE_MODE_SEARCH_LIGHT);
MOVW	R0, #2
SXTH	R0, R0
BL	_changeMode+0
;main.c,170 :: 		}
L_interruptTimer335:
;main.c,171 :: 		}
IT	AL
BAL	L_interruptTimer336
L_interruptTimer332:
;main.c,172 :: 		else if (MOVE_MODE_FORWARD == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer337
;main.c,174 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer338
;main.c,176 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;main.c,178 :: 		}
IT	AL
BAL	L_interruptTimer339
L_interruptTimer338:
;main.c,181 :: 		changeMode(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_changeMode+0
;main.c,182 :: 		}
L_interruptTimer339:
;main.c,183 :: 		}
IT	AL
BAL	L_interruptTimer340
L_interruptTimer337:
;main.c,184 :: 		else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_interruptTimer341
;main.c,186 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer342
;main.c,188 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;main.c,189 :: 		}
IT	AL
BAL	L_interruptTimer343
L_interruptTimer342:
;main.c,192 :: 		changeMode(MOVE_MODE_FORWARD);
MOVW	R0, #0
SXTH	R0, R0
BL	_changeMode+0
;main.c,193 :: 		}
L_interruptTimer343:
;main.c,194 :: 		}
L_interruptTimer341:
L_interruptTimer340:
L_interruptTimer336:
;main.c,195 :: 		}
L_interruptTimer330:
;main.c,197 :: 		if (UART3_Tx_Idle() == 1) //If data has been transmitted, send new data
BL	_UART3_Tx_Idle+0
CMP	R0, #1
IT	NE
BNE	L_interruptTimer344
;main.c,199 :: 		stringSendViaBluetooth("\n\rLightValDetected: ");
MOVW	R0, #lo_addr(?lstr_1_main+0)
MOVT	R0, #hi_addr(?lstr_1_main+0)
BL	_stringSendViaBluetooth+0
;main.c,200 :: 		intSendIntViaBluetooth(lightValDetected);
MOVW	R0, #lo_addr(_lightValDetected+0)
MOVT	R0, #hi_addr(_lightValDetected+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;main.c,205 :: 		UART3_Write_Text("CurLightValue: ");
MOVW	R0, #lo_addr(?lstr2_main+0)
MOVT	R0, #hi_addr(?lstr2_main+0)
BL	_UART3_Write_Text+0
;main.c,206 :: 		IntToStr(curMaxLightValue, output);
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;main.c,207 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;main.c,209 :: 		UART3_Write_Text("MaxLightValue: ");
MOVW	R0, #lo_addr(?lstr3_main+0)
MOVT	R0, #hi_addr(?lstr3_main+0)
BL	_UART3_Write_Text+0
;main.c,210 :: 		IntToStr(maxLightValue, output);
MOVW	R0, #lo_addr(_maxLightValue+0)
MOVT	R0, #hi_addr(_maxLightValue+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;main.c,211 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;main.c,213 :: 		UART3_Write_Text("Cnt: ");
MOVW	R0, #lo_addr(?lstr4_main+0)
MOVT	R0, #hi_addr(?lstr4_main+0)
BL	_UART3_Write_Text+0
;main.c,214 :: 		IntToStr(cnt, output);
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;main.c,215 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;main.c,217 :: 		UART3_Write_Text("CntFound: ");
MOVW	R0, #lo_addr(?lstr5_main+0)
MOVT	R0, #hi_addr(?lstr5_main+0)
BL	_UART3_Write_Text+0
;main.c,218 :: 		IntToStr(cntFound, output);
MOVW	R0, #lo_addr(_cntFound+0)
MOVT	R0, #hi_addr(_cntFound+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
BL	_IntToStr+0
;main.c,219 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;main.c,221 :: 		UART3_Write_Text("Move:");
MOVW	R0, #lo_addr(?lstr6_main+0)
MOVT	R0, #hi_addr(?lstr6_main+0)
BL	_UART3_Write_Text+0
;main.c,222 :: 		if (moveMode == MOVE_MODE_FORWARD)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer345
;main.c,224 :: 		UART3_Write_Text("FORWARD");
MOVW	R0, #lo_addr(?lstr7_main+0)
MOVT	R0, #hi_addr(?lstr7_main+0)
BL	_UART3_Write_Text+0
;main.c,225 :: 		}
IT	AL
BAL	L_interruptTimer346
L_interruptTimer345:
;main.c,226 :: 		else if (moveMode == MOVE_MODE_CIRCLE)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_interruptTimer347
;main.c,228 :: 		UART3_Write_Text("CIRCLE");
MOVW	R0, #lo_addr(?lstr8_main+0)
MOVT	R0, #hi_addr(?lstr8_main+0)
BL	_UART3_Write_Text+0
;main.c,229 :: 		}
IT	AL
BAL	L_interruptTimer348
L_interruptTimer347:
;main.c,230 :: 		else if (moveMode  == MOVE_MODE_SEARCH_LIGHT)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_interruptTimer349
;main.c,232 :: 		UART3_Write_Text("SEARCH LIGHT");
MOVW	R0, #lo_addr(?lstr9_main+0)
MOVT	R0, #hi_addr(?lstr9_main+0)
BL	_UART3_Write_Text+0
;main.c,233 :: 		}
L_interruptTimer349:
L_interruptTimer348:
L_interruptTimer346:
;main.c,235 :: 		IntToStr(-1, output);
MOVW	R1, #lo_addr(_output+0)
MOVT	R1, #hi_addr(_output+0)
MOVW	R0, #65535
SXTH	R0, R0
BL	_IntToStr+0
;main.c,236 :: 		UART3_Write_Text(output);
MOVW	R0, #lo_addr(_output+0)
MOVT	R0, #hi_addr(_output+0)
BL	_UART3_Write_Text+0
;main.c,237 :: 		}
L_interruptTimer344:
;main.c,240 :: 		}
L_end_interruptTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interruptTimer3
_initTimer3:
;main.c,243 :: 		void initTimer3(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,244 :: 		RCC_APB1ENR.TIM3EN = 1;  // Enable clock gating for timer module 3
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;main.c,245 :: 		TIM3_CR1.CEN = 0;// Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;main.c,246 :: 		TIM3_PSC = timer_psc[TIMER_INTERRUPT_MODE];  // Set timer prescaler.
MOVW	R0, #lo_addr(_timer_psc+4)
MOVT	R0, #hi_addr(_timer_psc+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;main.c,247 :: 		TIM3_ARR = timer_arr[TIMER_INTERRUPT_MODE]; //
MOVW	R0, #lo_addr(_timer_arr+4)
MOVT	R0, #hi_addr(_timer_arr+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;main.c,248 :: 		NVIC_IntEnable(IVT_INT_TIM3);  // Enable timer interrupt
MOVW	R0, #45
BL	_NVIC_IntEnable+0
;main.c,249 :: 		TIM3_DIER.UIE = 1; // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;main.c,250 :: 		TIM3_CR1.CEN = 1; // Enable timer
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;main.c,251 :: 		}
L_end_initTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initTimer3
_initADC:
;main.c,254 :: 		void initADC()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,257 :: 		GPIO_Analog_Input(&GPIOC_BASE, _GPIO_PINMASK_1);
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Analog_Input+0
;main.c,258 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_11);
MOVW	R0, #2048
BL	_ADC_Set_Input_Channel+0
;main.c,259 :: 		ADC1_Init();
BL	_ADC1_Init+0
;main.c,260 :: 		}
L_end_initADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initADC
_initPWMLog:
;main.c,262 :: 		void initPWMLog()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,264 :: 		pwmInit();
BL	_pwmInit+0
;main.c,265 :: 		changeMode(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_changeMode+0
;main.c,267 :: 		pwmInitialized = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_pwmInitialized+0)
MOVT	R0, #hi_addr(_pwmInitialized+0)
STRH	R1, [R0, #0]
;main.c,269 :: 		}
L_end_initPWMLog:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initPWMLog
_main:
;main.c,271 :: 		void main() {
;main.c,273 :: 		bluetoothInit();
BL	_bluetoothInit+0
;main.c,274 :: 		initTimer3();
BL	_initTimer3+0
;main.c,275 :: 		initADC();
BL	_initADC+0
;main.c,276 :: 		initPWMLog();
BL	_initPWMLog+0
;main.c,278 :: 		while(1) {
L_main50:
;main.c,279 :: 		asm wfi;
WFI
;main.c,280 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_main52:
SUBS	R7, R7, #1
BNE	L_main52
NOP
NOP
NOP
;main.c,281 :: 		}
IT	AL
BAL	L_main50
;main.c,282 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
