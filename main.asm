_resetLightMaxPar:
;main.c,34 :: 		void resetLightMaxPar()
;main.c,36 :: 		curMaxLightValue = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
STRH	R1, [R0, #0]
;main.c,37 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
; idx start address is: 8 (R2)
MOVS	R2, #0
SXTH	R2, R2
; idx end address is: 8 (R2)
L_resetLightMaxPar0:
; idx start address is: 8 (R2)
CMP	R2, #3
IT	GE
BGE	L_resetLightMaxPar1
;main.c,39 :: 		lightValueArr[idx] = 0;
LSLS	R1, R2, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R1, R0, R1
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [R1, #0]
;main.c,37 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++ )
ADDS	R2, R2, #1
SXTH	R2, R2
;main.c,40 :: 		}
; idx end address is: 8 (R2)
IT	AL
BAL	L_resetLightMaxPar0
L_resetLightMaxPar1:
;main.c,41 :: 		}
L_end_resetLightMaxPar:
BX	LR
; end of _resetLightMaxPar
_changeMode:
;main.c,43 :: 		void changeMode(int newMode)
; newMode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; newMode end address is: 0 (R0)
; newMode start address is: 0 (R0)
;main.c,45 :: 		moveMode = newMode;
MOVW	R1, #lo_addr(_moveMode+0)
MOVT	R1, #hi_addr(_moveMode+0)
STRH	R0, [R1, #0]
;main.c,46 :: 		isStarted = 0;
MOVS	R2, #0
SXTH	R2, R2
MOVW	R1, #lo_addr(_isStarted+0)
MOVT	R1, #hi_addr(_isStarted+0)
STRH	R2, [R1, #0]
;main.c,47 :: 		switch (newMode)
IT	AL
BAL	L_changeMode3
; newMode end address is: 0 (R0)
;main.c,49 :: 		case MOVE_MODE_FORWARD:
L_changeMode5:
;main.c,50 :: 		cnt = MAX_MOVE_BACK;
MOVW	R2, #50
SXTH	R2, R2
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;main.c,51 :: 		break;
IT	AL
BAL	L_changeMode4
;main.c,52 :: 		case MOVE_MODE_CIRCLE:
L_changeMode6:
;main.c,53 :: 		cnt = MAX_MOVE_CIRCLE;
MOVW	R2, #440
SXTH	R2, R2
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;main.c,54 :: 		resetLightMaxPar();
BL	_resetLightMaxPar+0
;main.c,55 :: 		maxLightValue = 0;
MOVS	R2, #0
SXTH	R2, R2
MOVW	R1, #lo_addr(_maxLightValue+0)
MOVT	R1, #hi_addr(_maxLightValue+0)
STRH	R2, [R1, #0]
;main.c,56 :: 		break;
IT	AL
BAL	L_changeMode4
;main.c,57 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_changeMode7:
;main.c,59 :: 		cntFound = MAX_MOVE_CIRCLE - cntFound;
MOVW	R2, #lo_addr(_cntFound+0)
MOVT	R2, #hi_addr(_cntFound+0)
LDRSH	R1, [R2, #0]
RSB	R1, R1, #440
SXTH	R1, R1
STRH	R1, [R2, #0]
;main.c,61 :: 		if ( (double)(cntFound) / MAX_MOVE_CIRCLE <= 0.5f)
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
;main.c,63 :: 		cnt = MAX_MOVE_CIRCLE_HALF + cntFound;
MOVW	R1, #lo_addr(_cntFound+0)
MOVT	R1, #hi_addr(_cntFound+0)
LDRSH	R1, [R1, #0]
ADDW	R2, R1, #220
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;main.c,64 :: 		}
IT	AL
BAL	L_changeMode9
L_changeMode8:
;main.c,65 :: 		else if ((double)(cntFound) / MAX_MOVE_CIRCLE <= 1f)
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
;main.c,67 :: 		cnt = cntFound - MAX_MOVE_CIRCLE_HALF;
MOVW	R1, #lo_addr(_cntFound+0)
MOVT	R1, #hi_addr(_cntFound+0)
LDRSH	R1, [R1, #0]
SUBW	R2, R1, #220
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
STRH	R2, [R1, #0]
;main.c,68 :: 		}
L_changeMode10:
L_changeMode9:
;main.c,69 :: 		break;
IT	AL
BAL	L_changeMode4
;main.c,70 :: 		}
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
;main.c,71 :: 		}
L_end_changeMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _changeMode
_startMode:
;main.c,73 :: 		void startMode()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,75 :: 		isStarted = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
STRH	R1, [R0, #0]
;main.c,76 :: 		switch (moveMode)
IT	AL
BAL	L_startMode11
;main.c,78 :: 		case MOVE_MODE_FORWARD:
L_startMode13:
;main.c,79 :: 		wheelRightStart();
BL	_wheelRightStart+0
;main.c,80 :: 		wheelLeftStart();
BL	_wheelLeftStart+0
;main.c,81 :: 		break;
IT	AL
BAL	L_startMode12
;main.c,82 :: 		case MOVE_MODE_CIRCLE:
L_startMode14:
;main.c,83 :: 		wheelLeftStop();
BL	_wheelLeftStop+0
;main.c,84 :: 		wheelRightStart();
BL	_wheelRightStart+0
;main.c,85 :: 		break;
IT	AL
BAL	L_startMode12
;main.c,86 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_startMode15:
;main.c,88 :: 		wheelRightStart();
BL	_wheelRightStart+0
;main.c,89 :: 		wheelLeftStop();
BL	_wheelLeftStop+0
;main.c,90 :: 		break;
IT	AL
BAL	L_startMode12
;main.c,91 :: 		}
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
;main.c,92 :: 		}
L_end_startMode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _startMode
_calcLightVal:
;main.c,94 :: 		int calcLightVal()
;main.c,97 :: 		int min = 30000;
; min start address is: 28 (R7)
MOVW	R7, #30000
SXTH	R7, R7
;main.c,98 :: 		int max = -1;
; max start address is: 32 (R8)
MOVW	R8, #65535
SXTH	R8, R8
;main.c,99 :: 		int minIdx = -1;
; minIdx start address is: 24 (R6)
MOVW	R6, #65535
SXTH	R6, R6
;main.c,100 :: 		int maxIdx = -1;
; maxIdx start address is: 20 (R5)
MOVW	R5, #65535
SXTH	R5, R5
;main.c,101 :: 		int cnt = 0;
; cnt start address is: 12 (R3)
MOVW	R3, #0
SXTH	R3, R3
;main.c,102 :: 		int avg = 0;
; avg start address is: 8 (R2)
MOVW	R2, #0
SXTH	R2, R2
;main.c,103 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
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
;main.c,105 :: 		if (lightValueArr[idx] > max)
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, R8
IT	LE
BLE	L__calcLightVal58
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
;main.c,107 :: 		max = lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R8, [R0, #0]
; max start address is: 32 (R8)
;main.c,108 :: 		maxIdx = idx;
; maxIdx start address is: 20 (R5)
SXTH	R5, R4
; maxIdx end address is: 20 (R5)
; max end address is: 32 (R8)
;main.c,109 :: 		}
IT	AL
BAL	L_calcLightVal19
L__calcLightVal58:
;main.c,105 :: 		if (lightValueArr[idx] > max)
;main.c,109 :: 		}
L_calcLightVal19:
;main.c,111 :: 		if (lightValueArr[idx] < min)
; maxIdx start address is: 20 (R5)
; max start address is: 32 (R8)
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R0, [R0, #0]
CMP	R0, R7
IT	GE
BGE	L__calcLightVal59
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
;main.c,113 :: 		min = lightValueArr[idx];
LSLS	R1, R4, #1
MOVW	R0, #lo_addr(_lightValueArr+0)
MOVT	R0, #hi_addr(_lightValueArr+0)
ADDS	R0, R0, R1
LDRSH	R7, [R0, #0]
; min start address is: 28 (R7)
;main.c,114 :: 		minIdx = idx;
; minIdx start address is: 24 (R6)
SXTH	R6, R4
; minIdx end address is: 24 (R6)
; min end address is: 28 (R7)
;main.c,115 :: 		}
IT	AL
BAL	L_calcLightVal20
L__calcLightVal59:
;main.c,111 :: 		if (lightValueArr[idx] < min)
;main.c,115 :: 		}
L_calcLightVal20:
;main.c,103 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; minIdx start address is: 24 (R6)
; min start address is: 28 (R7)
ADDS	R4, R4, #1
SXTH	R4, R4
;main.c,116 :: 		}
; max end address is: 32 (R8)
; min end address is: 28 (R7)
; idx end address is: 16 (R4)
IT	AL
BAL	L_calcLightVal16
L_calcLightVal17:
;main.c,119 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
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
;main.c,121 :: 		if ( (idx != minIdx) && (idx != maxIdx))
; maxIdx start address is: 12 (R3)
; minIdx start address is: 8 (R2)
CMP	R4, R2
IT	EQ
BEQ	L__calcLightVal60
CMP	R4, R3
IT	EQ
BEQ	L__calcLightVal61
L__calcLightVal55:
;main.c,123 :: 		cnt ++;
ADDS	R0, R1, #1
; cnt end address is: 4 (R1)
; cnt start address is: 24 (R6)
SXTH	R6, R0
;main.c,124 :: 		avg += lightValueArr[idx];
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
;main.c,121 :: 		if ( (idx != minIdx) && (idx != maxIdx))
IT	AL
BAL	L__calcLightVal57
L__calcLightVal60:
L__calcLightVal57:
; avg start address is: 20 (R5)
; cnt start address is: 4 (R1)
; cnt end address is: 4 (R1)
; avg end address is: 20 (R5)
IT	AL
BAL	L__calcLightVal56
L__calcLightVal61:
L__calcLightVal56:
;main.c,119 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL; idx ++)
; cnt start address is: 4 (R1)
; avg start address is: 20 (R5)
ADDS	R4, R4, #1
SXTH	R4, R4
;main.c,126 :: 		}
; minIdx end address is: 8 (R2)
; maxIdx end address is: 12 (R3)
; idx end address is: 16 (R4)
IT	AL
BAL	L_calcLightVal21
L_calcLightVal22:
;main.c,127 :: 		avg /= cnt;
SDIV	R0, R5, R1
; cnt end address is: 4 (R1)
; avg end address is: 20 (R5)
;main.c,128 :: 		return avg;
;main.c,129 :: 		}
L_end_calcLightVal:
BX	LR
; end of _calcLightVal
_updateLightArray:
;main.c,131 :: 		void updateLightArray()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,134 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
; idx start address is: 12 (R3)
MOVS	R3, #0
SXTH	R3, R3
; idx end address is: 12 (R3)
L_updateLightArray27:
; idx start address is: 12 (R3)
CMP	R3, #2
IT	GE
BGE	L_updateLightArray28
;main.c,136 :: 		lightValueArr[idx] = lightValueArr[idx + 1];
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
;main.c,134 :: 		for (idx = 0; idx < MAX_ARR_LEN_LIGHT_VAL - 1; idx ++)
ADDS	R3, R3, #1
SXTH	R3, R3
;main.c,137 :: 		}
; idx end address is: 12 (R3)
IT	AL
BAL	L_updateLightArray27
L_updateLightArray28:
;main.c,138 :: 		lightValDetected = getLightVal();
BL	_getLightVal+0
MOVW	R1, #lo_addr(_lightValDetected+0)
MOVT	R1, #hi_addr(_lightValDetected+0)
STRH	R0, [R1, #0]
;main.c,139 :: 		lightValueArr[MAX_ARR_LEN_LIGHT_VAL - 1]= lightValDetected;
SXTH	R1, R0
MOVW	R0, #lo_addr(_lightValueArr+4)
MOVT	R0, #hi_addr(_lightValueArr+4)
STRH	R1, [R0, #0]
;main.c,140 :: 		}
L_end_updateLightArray:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _updateLightArray
_interruptTimer3:
;main.c,142 :: 		void interruptTimer3() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,144 :: 		TIM3_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;main.c,146 :: 		if (pwmInitialized)
MOVW	R0, #lo_addr(_pwmInitialized+0)
MOVT	R0, #hi_addr(_pwmInitialized+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer330
;main.c,148 :: 		if (!isStarted)
MOVW	R0, #lo_addr(_isStarted+0)
MOVT	R0, #hi_addr(_isStarted+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer331
;main.c,150 :: 		startMode();
BL	_startMode+0
;main.c,151 :: 		}
L_interruptTimer331:
;main.c,152 :: 		if (MOVE_MODE_CIRCLE == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_interruptTimer332
;main.c,154 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer333
;main.c,156 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;main.c,157 :: 		updateLightArray();
BL	_updateLightArray+0
;main.c,158 :: 		curMaxLightValue = calcLightVal();
BL	_calcLightVal+0
MOVW	R1, #lo_addr(_curMaxLightValue+0)
MOVT	R1, #hi_addr(_curMaxLightValue+0)
STRH	R0, [R1, #0]
;main.c,159 :: 		if (curMaxLightValue > maxLightValue)
MOVW	R1, #lo_addr(_maxLightValue+0)
MOVT	R1, #hi_addr(_maxLightValue+0)
LDRSH	R1, [R1, #0]
CMP	R0, R1
IT	LE
BLE	L_interruptTimer334
;main.c,161 :: 		maxLightValue = curMaxLightValue;
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_maxLightValue+0)
MOVT	R0, #hi_addr(_maxLightValue+0)
STRH	R1, [R0, #0]
;main.c,162 :: 		cntFound = cnt;
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_cntFound+0)
MOVT	R0, #hi_addr(_cntFound+0)
STRH	R1, [R0, #0]
;main.c,163 :: 		}
L_interruptTimer334:
;main.c,164 :: 		}
IT	AL
BAL	L_interruptTimer335
L_interruptTimer333:
;main.c,167 :: 		changeMode(MOVE_MODE_SEARCH_LIGHT);
MOVW	R0, #2
SXTH	R0, R0
BL	_changeMode+0
;main.c,168 :: 		}
L_interruptTimer335:
;main.c,169 :: 		}
IT	AL
BAL	L_interruptTimer336
L_interruptTimer332:
;main.c,170 :: 		else if (MOVE_MODE_FORWARD == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_interruptTimer337
;main.c,172 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer338
;main.c,174 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;main.c,176 :: 		}
IT	AL
BAL	L_interruptTimer339
L_interruptTimer338:
;main.c,179 :: 		changeMode(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_changeMode+0
;main.c,180 :: 		}
L_interruptTimer339:
;main.c,181 :: 		}
IT	AL
BAL	L_interruptTimer340
L_interruptTimer337:
;main.c,182 :: 		else if (MOVE_MODE_SEARCH_LIGHT == moveMode)
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_interruptTimer341
;main.c,184 :: 		if (cnt > 0)
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_interruptTimer342
;main.c,186 :: 		cnt --;
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRSH	R0, [R1, #0]
SUBS	R0, R0, #1
STRH	R0, [R1, #0]
;main.c,187 :: 		}
IT	AL
BAL	L_interruptTimer343
L_interruptTimer342:
;main.c,190 :: 		changeMode(MOVE_MODE_FORWARD);
MOVW	R0, #0
SXTH	R0, R0
BL	_changeMode+0
;main.c,191 :: 		}
L_interruptTimer343:
;main.c,192 :: 		}
L_interruptTimer341:
L_interruptTimer340:
L_interruptTimer336:
;main.c,193 :: 		}
L_interruptTimer330:
;main.c,195 :: 		if (isBluetoothReadyForTransmission() ) //If data has been transmitted, send new data
BL	_isBluetoothReadyForTransmission+0
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer344
;main.c,197 :: 		stringSendViaBluetooth("\n\rLightValDetected: ");
MOVW	R0, #lo_addr(?lstr_1_main+0)
MOVT	R0, #hi_addr(?lstr_1_main+0)
BL	_stringSendViaBluetooth+0
;main.c,198 :: 		intSendIntViaBluetooth(lightValDetected);
MOVW	R0, #lo_addr(_lightValDetected+0)
MOVT	R0, #hi_addr(_lightValDetected+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;main.c,200 :: 		stringSendViaBluetooth("CurLightValue: ");
MOVW	R0, #lo_addr(?lstr_2_main+0)
MOVT	R0, #hi_addr(?lstr_2_main+0)
BL	_stringSendViaBluetooth+0
;main.c,201 :: 		intSendIntViaBluetooth(curMaxLightValue);
MOVW	R0, #lo_addr(_curMaxLightValue+0)
MOVT	R0, #hi_addr(_curMaxLightValue+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;main.c,203 :: 		stringSendViaBluetooth("MaxLightValue: ");
MOVW	R0, #lo_addr(?lstr_3_main+0)
MOVT	R0, #hi_addr(?lstr_3_main+0)
BL	_stringSendViaBluetooth+0
;main.c,204 :: 		intSendIntViaBluetooth(maxLightValue);
MOVW	R0, #lo_addr(_maxLightValue+0)
MOVT	R0, #hi_addr(_maxLightValue+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;main.c,206 :: 		stringSendViaBluetooth("Cnt: ");
MOVW	R0, #lo_addr(?lstr_4_main+0)
MOVT	R0, #hi_addr(?lstr_4_main+0)
BL	_stringSendViaBluetooth+0
;main.c,207 :: 		intSendIntViaBluetooth(cnt);
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;main.c,209 :: 		stringSendViaBluetooth("CntFound: ");
MOVW	R0, #lo_addr(?lstr_5_main+0)
MOVT	R0, #hi_addr(?lstr_5_main+0)
BL	_stringSendViaBluetooth+0
;main.c,210 :: 		intSendIntViaBluetooth(cntFound);
MOVW	R0, #lo_addr(_cntFound+0)
MOVT	R0, #hi_addr(_cntFound+0)
LDRSH	R0, [R0, #0]
BL	_intSendIntViaBluetooth+0
;main.c,212 :: 		stringSendViaBluetooth("Move:");
MOVW	R0, #lo_addr(?lstr_6_main+0)
MOVT	R0, #hi_addr(?lstr_6_main+0)
BL	_stringSendViaBluetooth+0
;main.c,213 :: 		switch (moveMode)
IT	AL
BAL	L_interruptTimer345
;main.c,215 :: 		case MOVE_MODE_FORWARD:
L_interruptTimer347:
;main.c,216 :: 		stringSendViaBluetooth("FORWARD");
MOVW	R0, #lo_addr(?lstr_7_main+0)
MOVT	R0, #hi_addr(?lstr_7_main+0)
BL	_stringSendViaBluetooth+0
;main.c,217 :: 		break;
IT	AL
BAL	L_interruptTimer346
;main.c,218 :: 		case MOVE_MODE_CIRCLE:
L_interruptTimer348:
;main.c,219 :: 		stringSendViaBluetooth("CIRCLE");
MOVW	R0, #lo_addr(?lstr_8_main+0)
MOVT	R0, #hi_addr(?lstr_8_main+0)
BL	_stringSendViaBluetooth+0
;main.c,220 :: 		break;
IT	AL
BAL	L_interruptTimer346
;main.c,221 :: 		case MOVE_MODE_SEARCH_LIGHT:
L_interruptTimer349:
;main.c,222 :: 		stringSendViaBluetooth("SEARCH_LIGHT");
MOVW	R0, #lo_addr(?lstr_9_main+0)
MOVT	R0, #hi_addr(?lstr_9_main+0)
BL	_stringSendViaBluetooth+0
;main.c,223 :: 		break;
IT	AL
BAL	L_interruptTimer346
;main.c,224 :: 		default:
L_interruptTimer350:
;main.c,225 :: 		stringSendViaBluetooth("UNINITIALIZED");
MOVW	R0, #lo_addr(?lstr_10_main+0)
MOVT	R0, #hi_addr(?lstr_10_main+0)
BL	_stringSendViaBluetooth+0
;main.c,226 :: 		}
IT	AL
BAL	L_interruptTimer346
L_interruptTimer345:
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interruptTimer347
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_interruptTimer348
MOVW	R0, #lo_addr(_moveMode+0)
MOVT	R0, #hi_addr(_moveMode+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_interruptTimer349
IT	AL
BAL	L_interruptTimer350
L_interruptTimer346:
;main.c,227 :: 		intSendIntViaBluetooth(-1);
MOVW	R0, #65535
SXTH	R0, R0
BL	_intSendIntViaBluetooth+0
;main.c,228 :: 		}
L_interruptTimer344:
;main.c,230 :: 		}
L_end_interruptTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interruptTimer3
_initTimer3:
;main.c,232 :: 		void initTimer3(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,233 :: 		RCC_APB1ENR.TIM3EN = 1;  // Enable clock gating for timer module 3
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;main.c,234 :: 		TIM3_CR1.CEN = 0;// Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;main.c,235 :: 		TIM3_PSC = timer_psc[TIMER_INTERRUPT_MODE];  // Set timer prescaler.
MOVW	R0, #lo_addr(_timer_psc+4)
MOVT	R0, #hi_addr(_timer_psc+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;main.c,236 :: 		TIM3_ARR = timer_arr[TIMER_INTERRUPT_MODE]; //
MOVW	R0, #lo_addr(_timer_arr+4)
MOVT	R0, #hi_addr(_timer_arr+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;main.c,237 :: 		NVIC_IntEnable(IVT_INT_TIM3);  // Enable timer interrupt
MOVW	R0, #45
BL	_NVIC_IntEnable+0
;main.c,238 :: 		TIM3_DIER.UIE = 1; // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;main.c,239 :: 		TIM3_CR1.CEN = 1; // Enable timer
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;main.c,240 :: 		}
L_end_initTimer3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initTimer3
_initPWMLog:
;main.c,242 :: 		void initPWMLog()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,244 :: 		pwmInit();
BL	_pwmInit+0
;main.c,245 :: 		changeMode(MOVE_MODE_CIRCLE);
MOVW	R0, #1
SXTH	R0, R0
BL	_changeMode+0
;main.c,247 :: 		pwmInitialized = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_pwmInitialized+0)
MOVT	R0, #hi_addr(_pwmInitialized+0)
STRH	R1, [R0, #0]
;main.c,248 :: 		}
L_end_initPWMLog:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initPWMLog
_main:
;main.c,250 :: 		void main() {
;main.c,252 :: 		bluetoothInit();
BL	_bluetoothInit+0
;main.c,253 :: 		initTimer3();
BL	_initTimer3+0
;main.c,254 :: 		lightDetectorInit();
BL	_lightDetectorInit+0
;main.c,255 :: 		initPWMLog();
BL	_initPWMLog+0
;main.c,257 :: 		while(1) {
L_main51:
;main.c,258 :: 		asm wfi;
WFI
;main.c,259 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_main53:
SUBS	R7, R7, #1
BNE	L_main53
NOP
NOP
NOP
;main.c,260 :: 		}
IT	AL
BAL	L_main51
;main.c,261 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
